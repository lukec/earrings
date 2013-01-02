use Plack::Builder;
use FindBin;

builder {
    enable 'Plack::Middleware::Compile' => (
        pattern => qr{\.coffee$},
        lib => 'coffee',
        blib => 'js',
        mime => 'application/javascript',
        map => sub {
            my $fn = shift;
            $fn =~ s/coffee$/js/;
            return $fn;
        },
        compile => sub {
            my ($in, $out) = @_;
            warn "Compiling $in to $out";
            system("coffee --compile --stdio < $in > $out");
        },
    );
    enable 'Plack::Middleware::Static' => (
        path => '/', root => "static/", pass_through => 1,
    );

    sub {
        return [ 301, [Location => '/index.html'], [''] ];
    };
}
