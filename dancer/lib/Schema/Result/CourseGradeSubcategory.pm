package Schema::Result::CourseGradeSubcategory;

use warnings;
use strict;

use base qw( DBIx::Class::Core );

__PACKAGE__->table('course_grade_subcategory');

__PACKAGE__->add_columns(
  course_grade_subcategory_id => {
    data_type => 'integer',
    is_auto_increment => 1
  },
  ## the course_id for the course this is part of
  course_id => {
    data_type => 'integer',
  },
  ## this is the category the current subcategory is part of
  course_grade_category_id => {
    data_type => 'integer',
  },
  ## the name of the subcategory
  subcategory => {
    data_type => 'text',
  },
  subcategory_description=> {
    data_type => 'text'
  }
);

__PACKAGE__->set_primary_key('course_grade_subcategory_id');

__PACKAGE__->belongs_to('course_grade_category' => 'Schema::Result::CourseGradeCategory','course_grade_category_id');

__PACKAGE__->belongs_to('course' => 'Schema::Result::Course','course_id');

__PACKAGE__->has_many('user_grade' => 'Schema::Result::UserGrade', 'user_grade_id');

1;
