package Schema::Result::Course;

use warnings;
use strict;

use base qw( DBIx::Class::Core );

__PACKAGE__->table('courses');

__PACKAGE__->add_columns(
  course_id => {
    data_type => 'integer',
    is_auto_increment => 1
  },
  name => {
    data_type => 'text',
  },
  year => {
    data_type => 'integer',
  },
  semester => {
    data_type => 'text'
  }
);

__PACKAGE__->set_primary_key('course_id');

__PACKAGE__->has_many(user_course => 'Schema::Result::UserCourse','course_id');

__PACKAGE__->many_to_many(users => 'user_course', 'user_id');

__PACKAGE__->has_many(course_grade_category => 'Schema::Result::CourseGradeCategory','course_id');

1;
