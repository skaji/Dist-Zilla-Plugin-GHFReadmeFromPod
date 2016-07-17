package Dist::Zilla::Plugin::GHFReadmeFromPod 0.001;
use 5.14.0;

package Pod::Markdown::GHF {
    use parent 'Pod::Markdown';
    sub _indent_verbatim {
        my ($self, $paragraph) = @_;
        my @lines = split /\n/, $paragraph;
        my $smallest;
        foreach my $line (@lines) {
            next unless $line =~ m/^( +)/;
            if (!defined $smallest or length($1) < length($smallest)) {
                $smallest = $1;
            }
        }
        s/^$smallest//g for @lines;
        join "\n", '```perl', @lines, '```';
    }
}

use Moose;
extends 'Dist::Zilla::Plugin::ReadmeAnyFromPod';

has type     => (is => 'ro', default => 'markdown');
has filename => (is => 'ro', default => 'README.md');
has location => (is => 'ro', default => 'root');

sub get_readme_content {
    my $self = shift;
    my $pod = $self->_get_source_pod;
    my $parser = Pod::Markdown::GHF->new;
    $parser->output_string(\my $content);
    $parser->parse_characters(1);
    $parser->parse_string_document($pod);
    $content;
}

__PACKAGE__->meta->make_immutable;

1;
__END__

=encoding utf-8

=head1 NAME

Dist::Zilla::Plugin::GHFReadmeFromPod - Create GitHub Flavored README.md from pod

=head1 SYNOPSIS

In your dist.ini:

  [GHFReadmeFromPod]

Then:

  $ dzil build

=head1 DESCRIPTION

Dist::Zilla::Plugin::GHFReadmeFromPod creates a GitHub Flavored README.md from pod.

Here B<GitHub Flavored> means that any code blocks are converted to
code blocks with syntax highlighting:

  ```perl
  # your code block
  my $app = Your::App->new;
  $app->run;
  ```

See L<this gist|https://gist.github.com/skaji/821ea04a28813f575067c05b4223757c>.

=head1 TIPS

=head2 How do I use this plugin with Dist::Milla?

L<Dist::Milla> uses L<Dist::Zilla::Plugin::ReadmeAnyFromPod>,
which literally conflicts this plugin:)

Fortunately, we can disable any plugins with C<-remove> syntax:

  # dist.ini
  [@Milla]
  -remove = ReadmeAnyFromPod

  [GHFReadmeFromPod]

=head1 SEE ALSO

L<Dist::Zilla::Plugin::ReadmeAnyFromPod>

L<Pod::Markdonw>

=head1 AUTHOR

Shoichi Kaji <skaji@cpan.org>

=head1 COPYRIGHT AND LICENSE

Copyright 2016 Shoichi Kaji <skaji@cpan.org>

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
