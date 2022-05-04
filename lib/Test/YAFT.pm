
use v5.14;
use warnings;

use Syntax::Construct 'package-version', 'package-block';

package Test::YAFT {
	use parent 'Exporter::Tiny';

	use Context::Singleton;

	use Test::YAFT::Attributes;

	sub test_frame (&)          :Exportable(all,plumbings);

	sub test_frame (&) {
		my ($code) = @_;

		# 1 - caller sub context
		# 2 - this sub context
		# 3 - frame
		# 4 - code arg context
		local $Test::Builder::Level = $Test::Builder::Level + 4;

		&frame ($code);
	}

	1;
};

__END__

=pod

=encoding utf-8

=head1 NAME

Test::YAFT - Yet another testing framework

=head1 SYNOPSIS

=head1 DESCRIPTION

This module combines features of multiple test libraries providing
its own, BDD inspired, Context oriented, testing approach.

=head1 GLOSSARY

=over

=item assert

Assert function performs actual value comparison.

=item expectation

Expectation function provides object (L<Test::Deep::Cmp>) describing
compared value.

=item plumbing

Similar concept to git, plumbing functions are used to build
higher level asserts, expectations, and/or tools.

=back

=head1 EXPORTED SYMBOLS

This module exports symbols using L<Exporter::Tiny>.

=head2 Asserts

	use Test::YAFT qw[ :asserts ];

Assert functions are exported by default.

Every assert accepts (if any) test message as a first (positional) parameter,
with restof parameters using named approach.

When assert performs multiple expectations internally, it always reports
as one, using provided test message, failing early.

Named parameters are provided either via key/value pairs

	ok "test title"
		=> got => $value
		;

or via builder functions

	ok "test title"
		=> got { build got }
		;

Coding style note: I suggest to use coding style as presented in all examples,
with one parameter per line, leading with fat comma.

=head2 Helper Functions

	use Test::YAFT qw[ :helpers ];

Helper functions are exported by default.

Functions helping to organize your tests.

=head2 Plumbing Functions

	use Test::YAFT qw[ :plumbings ];

Functions helping writing your custom asserts, expectations, and/or tools.

Plumbing functions are not exported by default.

=head3 test_frame (&)

	use Test::YAFT qw[ test_frame ];
	sub my_assert {
		test_frame {
			...
		};
	}

Utility function to populate required boring details like

=over

=item adjusting L<Test::Builder/level>

=item create L<Context::Singleton/frame>

=back

=head1 AUTHOR

Branislav Zahradník <barney@cpan.org>

=head1 COPYRIGHT AND LICENCE

Test::YAFT distribution is distributed under Artistic Licence 2.0.

=cut

