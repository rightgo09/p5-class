package class;
use strict;
use warnings;

our $VERSION = '0.01';

sub import {
	my $pkg = caller;

	no strict 'refs';

	# Export "parent" subroutine.
	*{"$pkg\::parent"} = \&_parent;

	*{"$pkg\::class"} = sub {
		my $klass = shift(@_);
		my @isa;

		# If class name contains "<",
		$klass =~ s/(\w+)(?:\s*<\s*(\w+))?/$1/;
		# inherited.
		push @{"$klass\::ISA"}, $2 if $2;

		# All class created by class.pm is child of "class" Class.
		unshift @{"$klass\::ISA"}, "class";

		# "new" method will create by default.
		*{"$klass\::new"} = \&_new;

		while (@_) {
			my $key = shift(@_) || last;
			my $val = shift(@_) || last;

			# Require perl-module.
			if ($key eq 'require') {
				$val =~ s!::!/!g;
				require $val.'.pm';
			}

			# Set parent class.
			elsif ($key eq 'parent') {
				push @{"$klass\::ISA"}, $val;
			}

			# Set property method.
			elsif ($key eq 'property') {
				if (ref($val) eq 'ARRAY') {
					for my $property (@$val) {
						*{"$klass\::$property"} = sub { _property($property, @_) };
					}
				}
				else {
					*{"$klass\::$val"} = sub { _property($val, @_) };
				}
			}

			# Normal method.
			elsif (ref($val) eq 'CODE') {
				*{"$klass\::$key"} = $val;
			}
		}

		return 1;
	};
}

sub _parent {
	my $parent_class = shift(@_);
	return('parent' => $parent_class);
}
sub _new {
	my $class = shift(@_);
	return bless { ref($_[0]) ? %{$_[0]} : @_ }, $class;
};
sub _property {
	my $property = shift(@_);
	my $self     = shift(@_);
	$self->{$property} = shift(@_) if @_;
	return $self->{$property};
}

sub super {
	my ($self, $method, @args) = @_;

	my $klass = ref($self) || $self;

	{
		no strict 'refs';
		for my $parent (grep $_ ne 'class', @{"$klass\::ISA"}) {
			if ($parent->can($method)) {
				return $parent->$method(@args);
			}
		}
	}

	return;
}

1;
