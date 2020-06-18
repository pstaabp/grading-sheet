package Schema::Result::UserCourse;

use warnings;
use strict;

use base qw( DBIx::Class::Core );

__PACKAGE__->table('user_course');

__PACKAGE__->add_columns(
  user_course_id => {
    data_type => 'integer',
    is_auto_increment => 1
  },
  user_id => {
    data_type => 'integer',
  },
  course_id => {
    data_type => 'integer',
  },
  role => {
    data_type => 'text'
  }
);

__PACKAGE__->set_primary_key('user_course_id');

__PACKAGE__->belongs_to('user','Schema::Result::User','user_id');
__PACKAGE__->belongs_to('course','Schema::Result::Course','course_id');

1;
