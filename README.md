# stack-nix-static-linking

A simple haskell project to investigate static linking on linux using
Nix.

**THIS IS STILL A WORK IN PROGRESS**

## Motivation

IMHO, the main reason to statically link an haskell executable is to
be able to deploy without to much headache in environment managed by a
third party.  In my case such environment is AWS Lambda.


## Static linking with stack/cabal

In order to link an executable statically you must add the `-fPIC`
flag to ghc in `stack.yaml`:

```
ghc-options:
	'$locals': '-fPIC'
	'$everything': '-fPIC'
```

If you are using stack version 1.5.1 or previous replace the following
fragment with:

```
ghc-options:
	'*': '-fPIC'
```

In yout `.cabal` file:

```
executable your-executable
  ld-options:	-static
```

## Static linking with Nix

You must add the `-pthread` flag to ghc, so the previous `stack.yaml`
fragment becomes:

```
ghc-options:
	'$locals': '-fPIC -optl-pthread'
	'$everything': '-fPIC'
```

As of version 1.6.1 you need to add a `shell.nix` file to your project.

You can find an exemple included in this simple project.  The
important points are:

1. by default ghc produce executables that are dynamically linked with
libgmp.  To avoid this behaviour a ghc variant with support for
integer-simple must be used.

2. the *shared* variant of glibc is required at compile time, since
one of the program used by stack is dinamically linked.

3. the *static* variant of glibc is required to produce a statically
linked executable.
