package Schema::Result::CourseGradeCategory;

use warnings;
use strict;

use base qw( DBIx::Class::Core );

__PACKAGE__->table('course_grade_category');

__PACKAGE__->add_columns(
  course_grade_category_id => {
    data_type => 'integer',
    is_auto_increment => 1
  },
  ## the course_id for the course this is part of
  course_id => {
    data_type => 'integer',
  },
  category => {
    data_type => 'text',
  },
  category_description => {
    data_type => 'text'
  }
);

__PACKAGE__->set_primary_key('course_grade_category_id');

__PACKAGE__->belongs_to(course => "Schema::Result::Course","course_id");

__PACKAGE__->has_many(course_grade_subcategory => 'Schema::Result::CourseGradeSubcategory','course_grade_subcategory_id');

1;
