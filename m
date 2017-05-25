From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 25 May 2017 14:36:43 +0200
Subject: [LTP] [PATCH 1/2] docs: Add running the tests section
In-Reply-To: <20170525115744.21720-1-rpalethorpe@suse.com>
References: <20170525115744.21720-1-rpalethorpe@suse.com>
Message-ID: <20170525123508.GC13101@rei.suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> The simplest/shortest possible guide to installing from source and running the tests.

This is a great addition, thanks for writing it, a few comments below.

> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> ---
> 
> In the common case, LTP is now easy to install and use. The documentation is
> also thorough. However I have had feedback from a few developers that they
> find installing the LTP and running a single test very difficult.
> 
> I think the reason for this is that the documentation is too spread out and
> difficult to navigate. Even while writing this I discovered new things which I
> have not seen before.
> 
> This guide is aimed at the casual LTP user, who just wants to fix some failing
> test case (usually from syscalls), so their work flow will be:
> 
> * Patch Kernel
> * Install it in VM
> * Install LTP in VM
> * Run test to see if it still fails
> 
> Users who are just curious will probably just want to run syscalls as well.
> 
> I think it is best to have a short end-to-end guide as the first thing people
> see when coming to the project. Then link off into more detailed documentation
> for people who fall off the happy path.
> 
>  README | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
> 
> diff --git a/README b/README
> index bf0061c41..5c3236783 100644
> --- a/README
> +++ b/README
> @@ -30,6 +30,62 @@ Don't run them on production systems. Growfiles, doio, and iogen in particular
>  stress the I/O capabilities of systems and while they should not cause problems
>  on properly functioning systems, they are intended to find (or cause) problems.
>  
> +Quick guide to running the tests
> +--------------------------------
> +
> +If you have Git, autoconf, automake, m4, the linux headers and the common
> +developer packages installed, the chances are the following will
> +work.
> +
> +$ git clone https://github.com/the-linux-test-project/ltp.git
> +$ cd ltp
> +$ make autotools
> +$ ./configure
> +$ make
> +$ make install
> +
> +This will install LTP to /opt/ltp.
> +- If you have a problem see doc/mini-howto-building-ltp-from-git.txt.
> +- If you still have a problem see INSTALL and './configure --help'.
> +- Failing that, ask for help on the mailing list or Github.
> +
> +Some tests will be disabled if the configure script can not find their build
> +dependencies.
> +- If a test fails due to a missing component, check the ./configure output.
               ^
	  Common case here is that test is skipped these days, i.e.
	  reports TCONF.

> +- If a tests fails due to a missing user or group, see the Quick Start section
> +  of INSTALL.
> +
> +To run all the test suites
> +
> +$ cd /opt/ltp
> +$ ./runltp
> +
> +Note that many test cases have to be executed as root.
> +
> +To run a particular test suite
> +
> +$ ./runltp -f syscalls
> +
> +To run all tests with 'madvise' in the name
> +
> +$ ./runltp -f syscalls -s madvise
> +
> +Also see
> +
> +$ ./runltp --help
> +
> +Test suites (e.g. syscalls) are defined in the runtest directory. Each file
> +contains a list of test cases in a simple format, see doc/ltp-run-files.txt.
> +
> +Each test case has its own executable or script, these can be executed
> +directly
> +
> +$ testcases/bin/abort01
> +
> +Some have arguments
> +
> +$ testcases/bin/fork13 -i 37

Quite a lot of the C tests and all shell tests needs at least
/opt/ltp/testcases/bin in the $PATH in order to source scripts and/or
execute helper binaries. Some tests needs LTPROOT (in order to locate
datafiles) as well.

So safest example here is:

LTPROOT=/opt/ltp/ PATH="$PATH:$LTPROOT/testcases/bin" testcases/bin/test_name

Also 99% of the test has help that is printed when -h is passed in
arguments.

>  Developers corner
>  -----------------
>  
> -- 
> 2.12.2
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
