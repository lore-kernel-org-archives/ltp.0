From: Eric Biggers <ebiggers@kernel.org>
Date: Thu, 14 Mar 2019 17:11:51 -0700
Subject: [LTP] [PATCH 0/6] ltp: AF_ALG test helpers and a few regression
	tests
In-Reply-To: <20190221053026.18489-1-ebiggers@kernel.org>
References: <20190221053026.18489-1-ebiggers@kernel.org>
Message-ID: <20190315001150.GC30026@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Feb 20, 2019 at 09:30:20PM -0800, Eric Biggers wrote:
> Hello,
> 
> This series adds helper functions for testing AF_ALG (the userspace
> interface to algorithms in the Linux kernel's crypto API) to the
> Linux Test Project.  It then adds a few sample regression tests.
> 
> I've had these patches sitting around for a while with the goal of also
> writing some "real" tests that test for more than these specific bugs,
> but haven't gotten around to it yet.  And I now consider further
> improving the in-kernel crypto self-tests to be a higher priority.  But
> I figured I'd send this out as-is in case people are interested in
> having this merged, e.g. maybe other people want to add AF_ALG tests to
> LTP too and the 'tst_af_alg' lib would be a good starting point.
> 
> Eric Biggers (6):
>   lib: add tst_af_alg lib
>   crypto/af_alg01: new regression test for hmac nesting bug
>   crypto/af_alg02: new regression test for salsa20 empty message bug
>   crypto/af_alg03: new regression test for rfc7539 hash alg validation
>   crypto/af_alg04: new regression test for vmac race conditions
>   crypto/af_alg05: new regression test for skcipher_walk error bug
> 
>  configure.ac                       |   1 +
>  include/lapi/if_alg.h              |  40 ++++++++
>  include/tst_af_alg.h               | 136 ++++++++++++++++++++++++++
>  lib/tst_af_alg.c                   | 147 +++++++++++++++++++++++++++++
>  runtest/cve                        |   2 +
>  testcases/kernel/crypto/.gitignore |   5 +
>  testcases/kernel/crypto/af_alg01.c |  79 ++++++++++++++++
>  testcases/kernel/crypto/af_alg02.c |  29 ++++++
>  testcases/kernel/crypto/af_alg03.c |  31 ++++++
>  testcases/kernel/crypto/af_alg04.c |  56 +++++++++++
>  testcases/kernel/crypto/af_alg05.c |  43 +++++++++
>  11 files changed, 569 insertions(+)
>  create mode 100644 include/lapi/if_alg.h
>  create mode 100644 include/tst_af_alg.h
>  create mode 100644 lib/tst_af_alg.c
>  create mode 100644 testcases/kernel/crypto/af_alg01.c
>  create mode 100644 testcases/kernel/crypto/af_alg02.c
>  create mode 100644 testcases/kernel/crypto/af_alg03.c
>  create mode 100644 testcases/kernel/crypto/af_alg04.c
>  create mode 100644 testcases/kernel/crypto/af_alg05.c
> 
> -- 
> 2.20.1
> 

Any comment on this from the LTP maintainers?

- Eric
