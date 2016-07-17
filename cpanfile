requires 'perl', '5.14.0';
requires 'Dist::Zilla', '6.000';
requires 'Moose';
requires 'Dist::Zilla::Plugin::ReadmeAnyFromPod';
requires 'Pod::Markdown';

on test => sub {
    requires 'Test::More', '0.98';
};
