From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 18 Sep 2020 16:57:52 +0200
Subject: [LTP] LTP release
In-Reply-To: <CY4PR13MB117529F882F68FED2C60AD09FD230@CY4PR13MB1175.namprd13.prod.outlook.com>
References: <20200908073138.GB2475@yuki.lan> <20200910084554.GA21741@dell5510>
 <20200914111543.GE5524@yuki.lan>
 <CY4PR13MB117529F882F68FED2C60AD09FD230@CY4PR13MB1175.namprd13.prod.outlook.com>
Message-ID: <20200918145752.GA16897@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I don't think that it should be very many.  Otherwise, people will get
> the idea that it is useful for actual device testing. ;-)
> 
> The current 'quickhit' runtest file has 107 tests.  With the exception of
> qmm01 (which calls mmap001 with '-n 1') and a bunch of tests that do sub-tests
> of symlink01 (12 of them), the remaining test definitions
> just consist of the test name and the test executable (with the same names).
> I only see binary programs - no tests using shell scripts.  So there's really not much variety
> here.
> 
> Apparently a pipe is allowed in the command invocation line for a test, but there's only
> one example of this in all of the runtests, in syscalls:
> splice02 seq 1 2000 | splice02

Actually the logic in LTP pan is:

* If the command part is single string the test is executed by execve()

* Otherwise it's passed as a command to run to /bin/sh

I'm not sure it we would want to retain that behaivor for a future
though.

> Really, as an infrastructure test, I only need to run a few testcases to validate that Fuego's
> plumbing around runltp (and ltp-pan) works properly.  And it would be nice if
> the run was very short, so I could do the check quickly.
> 
> Do you want me to create a runtest for a framework/LTP integration test, by picking a
> few different "representative" tests, as a replacement for quickhit?
> 
> IMHO, the selected tests should behave the same on all possible systems, to avoid
> getting results that are inconsistent due to the system under test, rather than a
> problem with the integration between the framework and LTP.
> 
> Should I add some outlier cases:
>  - something that times out
>  - something that always fails
>  - tests that return TBROK, TCONF, TWARN, etc.
>  - something where the command doesn't exist
> 
> This would be helpful for checking that my parsing for different results works.
> 
> Do you have a preferred name for the runtest file?  My proposal, just off the top
> of my head, is: "ltp-selftest-quick", but I'm open to other suggestions.

Maybe we should call it smoketest, but I'm okay selftest as well.

> I'm also open to suggestions for possible tests.  I'd like a shell script command
> to add to the list of binary programs.  Here is what I've chosen so far:
> access01 access01
> chdir01 chdir01
> fork01 fork01
> time01 time01
> wait02 wait02
> write01 write01
> symlink01 symlink01
> stat04 symlink01 -T stat04
> utime01A symlink01 -T utime01
> rename01A symlink01 -T rename01
> splice02 seq 1 20 | splice02
> 
> This takes about 5 seconds on one of my test machines.

So I will add a network test to the set and push that before a patch
that removes quickhit.

It would be nice to have the outliners, but that is a bit more
complicated change, so I would like to add these after a release, is
that okay?

> P.S. Maybe, if you're moving away from runltp and ltp-pan, it's a little late to be
> adding some selftests to make sure they work correctly.  But Fuego is using them.
> I don't know what other frameworks use when they invoke LTP to perform
> tests.

I do expect that we will have ltp-pan included for compatibility reasons
at least for a year or two once the replacement would be in place
anyways, so having a smoketest wouldn't harm at all.

-- 
Cyril Hrubis
chrubis@suse.cz
