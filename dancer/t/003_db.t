use strict; use warnings; use 5.014;

use Data::Dump qw/dd/;

use lib "../lib";
use Schema;

my $dsn = "dbi:SQLite:/Users/pstaab/code/standards-grading/app.sqlite";
my $schema = Schema->connect($dsn);


my $rs = $schema->resultset('Course')->search({}, {
  join      => 'user_course',
  result_class => 'DBIx::Class::ResultClass::HashRefInflator',
});


while (my $hashref = $rs->next) {
  dd $hashref;
}

# while(my $user = $users_rs->next) {
#   say $user->first_name;
# }
dd $schema->sources;
dd $schema->source('Course')->relationships;


my @new_result = $schema->resultset('Course')->search({},{result_class => 'DBIx::Class::ResultClass::HashRefInflator'})->all;

dd \@new_result;

## add a user to a course:

my $rs_course = $schema->resultset("Course")->search({name => 'Demo'})->first;

# my $new_user = $schema->resultset("User")->create({
#   login_name => "maggie",
#   first_name => "Maggie",
#   last_name => "Simpson",
#   email => "",
#   is_admin => ""
# });

# $rs_course->add_to_users($new_user,{role=>"student"});

my @result1 = $schema->resultset("UserCourse")->search({'user.login_name' => 'peter'},{
  join => ['user','course'],
  select => ['user.login_name', 'role', 'course.name','course.year','course.semester'],
  as => [qw/login_name role course_name course_year course_semester/],
  result_class => 'DBIx::Class::ResultClass::HashRefInflator'
})->all;


dd @result1;

## find a member of UserCourse

my $user = $schema->resultset("UserCourse")->find_or_new(
  {
    user_id => 5,
    course_id => 2,
  }
);

$user->set_column('role', 'student');
if( !$user->in_storage ) {
    $user->insert;
} else {
    $user->update;
}





my @result3 = $schema->resultset('UserCourse')->search(
  {
    user_id => 1,
    course_id => 2,
  }
  ,
  {
    result_class => 'DBIx::Class::ResultClass::HashRefInflator'
  })->all;

dd @result3;



##
