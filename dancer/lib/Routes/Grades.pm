use Dancer2 appname => "API";

use Data::Dump qw/dump/;

get '/courses/:course_id/grades/categories' => sub {
  my @categories = vars->{schema}->resultset('CourseGradeCategory')->search(
    {
      'course_id' => route_parameters->get('course_id'),
    },
    {
      result_class => 'DBIx::Class::ResultClass::HashRefInflator',
    })->all;
  return \@categories;
};

get '/courses/:course_id/grades/subcategories' => sub {
  my @subcategories = vars->{schema}->resultset('CourseGradeSubcategory')->search(
    {
      'course_id' => route_parameters->get('course_id'),
    },
    {
      result_class => 'DBIx::Class::ResultClass::HashRefInflator',
    })->all;
  return \@subcategories;
};

post '/courses/:course_id/grades/categories' => sub {
  my $category = body_parameters->get('category');
  $category->{course_id} = route_parameters->get('course_id');

  debug dump $category;

  ## see if the category is in the database
  my $cat = vars->{schema}->resultset('CourseGradeCategory')->find_or_new({
      course_id => $category->{course_id},
      category => $category->{category},
    });

  if (! $cat->in_storage){
    $cat->{category_description} = $category->{category_description};
    $cat->insert;
  }

  my $cat_from_db = vars->{schema}->resultset('CourseGradeCategory')->search(
    {
      course_id => $category->{course_id},
      category => $category->{category},
    },
    {
      result_class => 'DBIx::Class::ResultClass::HashRefInflator',
    }
  )->first;

  return $cat_from_db;
};


post '/courses/:course_id/grades/subcategories' => sub {
  my $subcategory = body_parameters->get('subcategory');
  $subcategory->{course_id} = route_parameters->get('course_id');

  # debug dump $subcategory;

  ## see if the category is in the database
  my $sub = vars->{schema}->resultset('CourseGradeSubcategory')->find_or_new({
      course_grade_category_id => $subcategory->{course_grade_category_id},
      course_id => $subcategory->{course_id},
      subcategory => $subcategory->{subcategory},
      subcategory_description => $subcategory->{subcategory_description},
    });


  if (! $sub->in_storage){
    $sub->insert;
  }

  my $cat_from_db = vars->{schema}->resultset('CourseGradeSubcategory')->search(
    {
      course_id => $sub->course_id,
      subcategory => $sub->subcategory,
    },
    {
      result_class => 'DBIx::Class::ResultClass::HashRefInflator',
    }
  )->first;

  debug $cat_from_db;

  return $cat_from_db;
};

put '/courses/:course_id/grades/subcategories' => sub {
  my $subcategory = body_parameters->get('subcategory');
  $subcategory->{course_id} = route_parameters->get('course_id');

  debug dump $subcategory;

  ## see if the category is in the database
  my $sub = vars->{schema}->resultset('CourseGradeSubcategory')->find($subcategory->{course_grade_subcategory_id});
  $sub->subcategory_description($subcategory->{subcategory_description});
  $sub->update;

  my $sub_from_db = vars->{schema}
      ->resultset('CourseGradeSubcategory')
      ->search({ course_grade_subcategory_id => $subcategory->{course_grade_subcategory_id}},
        {
          result_class => 'DBIx::Class::ResultClass::HashRefInflator',
        }
      )->first;

  return $sub_from_db;
};

1;
