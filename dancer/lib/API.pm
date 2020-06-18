package API;

use Data::Dump qw/dump/;
use Dancer2;
use Schema;
use Routes::Grades; 
set serializer => 'JSON';

hook before => sub {
  my $dsn = "dbi:SQLite:/Users/pstaab/code/standards-grading/app.sqlite";
  vars->{schema} = Schema->connect($dsn);
};


post '/login' => sub {
  my $user_id = body_parameters->get('user_id');
  my $password = body_parameters->get('password');

  if ($user_id eq 'peter' && $password eq 'peter') {
    return {
      logged_in => true,
    }
  } else {
    return {
      logged_in => false
    }
  }
};


get '/users' => sub {
  my @users = vars->{schema}->resultset('User')
      ->search({},{result_class => 'DBIx::Class::ResultClass::HashRefInflator'})
      ->all;
  return \@users;
};

get '/users/:user_id' => sub {
  my $user = vars->{schema}->resultset('User')
      ->find({user_id => route_parameters->get('user_id')},{result_class => 'DBIx::Class::ResultClass::HashRefInflator'});

  return $user;
};

# sub parseUser {  # change booleans to proper type
#   my $user = shift;
#   $user->{is_admin} = $user->{is_admin} ? true : false;
#   debug $user;
#   return $user;
# }

## this returns only the courses that the logged in user is enrolled in
## or all courses if the user is an admin.

get '/courses' => sub {
  my @courses =vars->{schema}->resultset('Course')
      ->search({},{
        select => ['course_id', 'name', 'year', 'semester'],
        as => [qw/course_id course_name year semester/],
        result_class => 'DBIx::Class::ResultClass::HashRefInflator'})
      ->all;

  return \@courses;
};

## returns all courses that user (login_name) is enrolled in.

get '/users/:login_name/courses' => sub {
    my @courses = vars->{schema}->resultset("UserCourse")
        ->search({'user.login_name' => route_parameters->get('login_name')},{
            join => ['user','course'],
            select => ['user.login_name', 'role', 'course.course_id', 'course.name','course.year','course.semester'],
            as => [qw/login_name role course_id course_name course_year course_semester/],
            result_class => 'DBIx::Class::ResultClass::HashRefInflator'
          })->all;

  return \@courses;
};

## returns all users for a given course_id

get '/courses/:course_id/users' => sub {
  my @courses = vars->{schema}->resultset("UserCourse")
      ->search({'course.course_id' => route_parameters->get('course_id')},{
          join => ['user','course'],
          select => ['user.login_name', 'role', 'course.course_id', 'course.name','course.year','course.semester'],
          as => [qw/login_name role course_id course_name course_year course_semester/],
          result_class => 'DBIx::Class::ResultClass::HashRefInflator'
        })->all;
  return \@courses;
};

## update a course users

put '/courses/:course_id/users/:user_id' => sub {
  my $course_user = body_parameters->get('course_user');
  ## check to see if the user is in the UserCourse table:

  my $user = vars->{schema}->resultset("UserCourse")->find_or_new(
    {
      user_id => route_parameters->get("user_id"),
      course_id => route_parameters->get('course_id')
    }
  );

  $user->set_column('role', 'student');
  if( !$user->in_storage ) { ## if not in the dataset, create new.
      $user->insert;
  } else {                   # else updae
      $user->update;
  }


  my $user_result = vars->{schema}->resultset("UserCourse")->search(
    {
      'course.course_id' => route_parameters->get('course_id'),
      'user.user_id' => route_parameters->get('user_id')
    },{
        join => ['user','course'],
        select => ['user.user_id','user.login_name', 'role', 'user.first_name', 'user.last_name', 'user.email'],
        as => [qw/user_id login_name role first_name last_name email/],
        result_class => 'DBIx::Class::ResultClass::HashRefInflator'
      })->first;
  return $user_result;
};

## create a new user
post '/users' => sub {
  my $user = body_parameters->get('user');
  delete $user->{role} if (defined($user->{role}));
  delete $user->{user_id} if (defined($user->{user_id}));
  delete $user->{course_id} if (defined($user->{course_id}));
  vars->{schema}->resultset('User')->create($user);
  my $user_result = vars->{schema}->resultset("User")->search({'login_name' => $user->{login_name}},
    {result_class => 'DBIx::Class::ResultClass::HashRefInflator'})->first;
  return $user_result;
};

true;
