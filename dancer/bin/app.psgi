#!/usr/bin/env perl

use strict;
use warnings;
use FindBin;
use Plack::Builder;
use lib "$FindBin::Bin/../lib";

# use this block if you want to mount several applications on different path

use Dancer2;
use dancer;
use API;
# use Routes::ProblemSets;

builder {
    mount '/'    => dancer->to_app;
    mount '/api' => API->to_app;
};
