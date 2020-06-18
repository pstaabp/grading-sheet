package Schema::Result::UserGrade;

use warnings;
use strict;

use base qw( DBIx::Class::Core );

__PACKAGE__->table('user_grade');

__PACKAGE__->add_columns(
  user_grade_id => {
    data_type => 'integer',
    is_auto_increment => 1
  },
  ## the course_grade_id this grade is associated with
  course_grade_subcategory_id => {
    data_type => 'integer',
  },
  user_id => {
    data_type => 'integer',
  },
  grade => {
    data_type => 'text'
  },
  # date of the assessment (YYYY-MM-DD)
  date => {
    data_type => 'text'
  }
);

__PACKAGE__->set_primary_key('user_grade_id');

__PACKAGE__->belongs_to('course_grade_subcategory',"Schema::Result::CourseGradeSubcategory","course_grade_subcategory_id");
__PACKAGE__->belongs_to('user',"Schema::Result::User","user_id");

1;
