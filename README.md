# NAME

Dist::Zilla::Plugin::GHFReadmeFromPod - Create GitHub Flavored README.md from pod

# SYNOPSIS

In your dist.ini:

    [GHFReadmeFromPod]

Then:

    $ dzil build

# DESCRIPTION

Dist::Zilla::Plugin::GHFReadmeFromPod creates a GitHub Flavored README.md from pod.

Here **GitHub Flavored** means that any code blocks are converted to
code blocks with syntax highlighting:

    ```perl
    # your code block
    my $app = Your::App->new;
    $app->run;
    ```

See [this gist](https://gist.github.com/skaji/821ea04a28813f575067c05b4223757c).

# TIPS

## How do I use this plugin with Dist::Milla?

[Dist::Milla](https://metacpan.org/pod/Dist::Milla) uses [Dist::Zilla::Plugin::ReadmeAnyFromPod](https://metacpan.org/pod/Dist::Zilla::Plugin::ReadmeAnyFromPod),
which literally conflicts this plugin:)

Fortunately, we can disable any plugins with `-remove` syntax:

    # dist.ini
    [@Milla]
    -remove = ReadmeAnyFromPod

    [GHFReadmeFromPod]

# SEE ALSO

[Dist::Zilla::Plugin::ReadmeAnyFromPod](https://metacpan.org/pod/Dist::Zilla::Plugin::ReadmeAnyFromPod)

[Pod::Markdonw](https://metacpan.org/pod/Pod::Markdonw)

# AUTHOR

Shoichi Kaji <skaji@cpan.org>

# COPYRIGHT AND LICENSE

Copyright 2016 Shoichi Kaji <skaji@cpan.org>

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.
