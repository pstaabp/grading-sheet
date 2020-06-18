package Schema::Result::User;

use warnings;
use strict;

use base qw( DBIx::Class::Core );

__PACKAGE__->table('users');

__PACKAGE__->add_columns(
  user_id => {
    data_type => 'integer',
    is_auto_increment => 1
  },
  login_name => {
    data_type => 'text',
  },
  first_name => {
    data_type => 'text',
  },
  last_name => {
    data_type => 'text',
  },
  email => {
    data_type => 'text'
  },
  is_admin => {
    data_type => 'boolean'
  }
);

__PACKAGE__->add_unique_constraint(
  constraint_name => [ qw/login_name/ ],
);

__PACKAGE__->set_primary_key('user_id');

__PACKAGE__->has_many(user_course => 'Schema::Result::UserCourse','user_id');

__PACKAGE__->many_to_many(courses => 'user_course', 'course_id');

1;
