package Acme::NyanDoku;
use strict;
use warnings;
our $VERSION = '0.01';

my $hex_to_nyan = {
    "0" => "nyan", "1" => "nyaN",
    "2" => "nyAn", "3" => "nyAN",
    "4" => "nYan", "5" => "nYaN",
    "6" => "nYAn", "7" => "nYAN",
    "8" => "Nyan", "9" => "NyaN",
    "a" => "NyAn", "b" => "NyAN",
    "c" => "NYan", "d" => "NYaN",
    "e" => "NYAn", "f" => "NYAN",
};

my $nyan_to_hex = {
    "nyan" => "0", "nyaN" => "1",
    "nyAn" => "2", "nyAN" => "3",
    "nYan" => "4", "nYaN" => "5",
    "nYAn" => "6", "nYAN" => "7",
    "Nyan" => "8", "NyaN" => "9",
    "NyAn" => "a", "NyAN" => "b",
    "NYan" => "c", "NYaN" => "d",
    "NYAn" => "e", "NYAN" => "f",
};

sub nyandoku{
    my $original_code = shift;
    my $hex_string = unpack "h*", $original_code;
    my @hexes = split "", $hex_string;
    use Data::Dumper;

    my @nyans = map {$hex_to_nyan->{$_}} @hexes;

    return join " ", @nyans;
}
sub to_original{
    my $nyan_code = shift;
    my @nyans = split " ", $nyan_code;
    my @hexes = map { $_ ? $nyan_to_hex->{$_} : ""} @nyans;
    my $code = pack("h*",join "", @hexes);
}

open(my $fp, "<", $0) or die "nyaaaaaan....";
my $code = join "", <$fp>;
close $fp;

$code =~ s{use\s+Acme::NyanDoku\s*;}{}smx;

if ($code =~ m{[^\s\nnyanNYAN]}msx) {
    $code = nyandoku($code);
}

eval to_original($code);

open (my $wfp, ">", $0);
print $wfp "use Acme::NyanDoku;\n".$code;
close $wfp;

exit;

1;
__END__

=head1 NAME

Acme::NyanDoku -

=head1 SYNOPSIS

  use Acme::NyanDoku;

=head1 DESCRIPTION

Acme::NyanDoku is

=head1 AUTHOR

Shinpei Maruyama E<lt>shinpeim {at} gmail.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
