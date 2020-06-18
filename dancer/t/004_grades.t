use strict; use warnings; use 5.014;

use Data::Dump qw/dd/;

use lib "../lib";
use Schema;

my $dsn = "dbi:SQLite:/Users/pstaab/code/standards-grading/app.sqlite";
my $schema = Schema->connect($dsn);

my $cat = $schema->resultset('CourseGradeCategory')->find_or_new(
  {
    course_id => 2,
    category => "F",
    category_description => "Functions"
  });

if( !$cat->in_storage ) {
  $cat->insert;
}


my @results = $schema->resultset('CourseGradeCategory')->search({}, {
  result_class => 'DBIx::Class::ResultClass::HashRefInflator',
})->all;

dd \@results;

# my @results2 = $schema->resultset('CourseGradeCategory')->search({}, {
#   join => 'course',
#   '+select' => ['course.name'],
#   '+as'     => ['course_name'],
#   result_class => 'DBIx::Class::ResultClass::HashRefInflator',
# })->all;
#
# # dd @results2;
#
#
# my @results3 = $schema->resultset('CourseGrade')->search({},{
#   join => ['course', 'course_grade_category'],
#   '+select' => ['course.name', 'course_grade_category.grade_category'],
#   '+as'     => ['course_name', 'grade_category'],
#   result_class => 'DBIx::Class::ResultClass::HashRefInflator',
# })->all;
#
# dd \@results3;
#
# my @results4 = $schema->resultset('UserGrade')->search({},{
#   join => ['course_grade','user'],
#   '+select' => ['course_grade.grade_subcategory','user.first_name','user.last_name'],
#   '+as' => ['grade_subcategory','first_name','last_name'],
#   result_class => 'DBIx::Class::ResultClass::HashRefInflator',
# })->all;
#
# dd \@results4;
#

1;
