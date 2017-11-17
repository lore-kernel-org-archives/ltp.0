From: Tom Gall <tom.gall@linaro.org>
Date: Thu, 16 Nov 2017 22:50:23 -0600
Subject: [LTP] Towards 4.14 LTS
Message-ID: <5E1947BC-9D22-42EB-BA29-96EA15A9C817@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

At Linaro we’ve been putting effort into regularly running kernel tests over 
arm, arm64 and x86_64 targets. On those targets we’re running mainline, -next, 
4.4, and 4.9 kernels and yes we are adding to this list as the hardware 
capacity grows.

For test buckets we’re using just LTP, kselftest and libhugetlbfs and
like kernels we will add to this list. 

With the 4.14 cycle being a little ‘different’ in so much as the goal to 
have it be an LTS kernel I think it’s important to take a look at some 
4.14 test results. 

Grab a beverage, this is a bit of a long post. But quick summery 4.14 as 
released looks just as good as 4.13, for the test buckets I named above.

I’ve enclosed our short form report. We break down the boards/arch combos for
each bucket pass/skip or potentially fails. Pretty straight forward. Skips
generally happen for a few reasons
1) crappy test cases
2) test isn’t appropriate (x86 specific tests so don’t run elsewhere)

With this, we have a decent baseline for 4.14 and other kernels going
forward. 

Summary
------------------------------------------------------------------------

kernel: 4.14.0
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
git branch: master
git commit: bebc6082da0a9f5d47a1ea2edc099bf671058bd4
git describe: v4.14
Test details: https://qa-reports.linaro.org/lkft/linux-mainline-oe/build/v4.14


No regressions (compared to build v4.14-rc8)

Boards, architectures and test suites:
-------------------------------------

hi6220-hikey - arm64
* boot - pass: 20
* kselftest - skip: 16, pass: 38
* libhugetlbfs - skip: 1, pass: 90
* ltp-cap_bounds-tests - pass: 2
* ltp-containers-tests - pass: 76
* ltp-fcntl-locktests-tests - pass: 2
* ltp-filecaps-tests - pass: 2
* ltp-fs-tests - pass: 60
* ltp-fs_bind-tests - pass: 2
* ltp-fs_perms_simple-tests - pass: 19
* ltp-fsx-tests - pass: 2
* ltp-hugetlb-tests - skip: 1, pass: 21
* ltp-io-tests - pass: 3
* ltp-ipc-tests - pass: 9
* ltp-math-tests - pass: 11
* ltp-nptl-tests - pass: 2
* ltp-pty-tests - pass: 4
* ltp-sched-tests - pass: 14
* ltp-securebits-tests - pass: 4
* ltp-syscalls-tests - skip: 122, pass: 983
* ltp-timers-tests - pass: 12

juno-r2 - arm64
* boot - pass: 20
* kselftest - skip: 15, pass: 38
* libhugetlbfs - skip: 1, pass: 90
* ltp-cap_bounds-tests - pass: 2
* ltp-containers-tests - pass: 76
* ltp-fcntl-locktests-tests - pass: 2
* ltp-filecaps-tests - pass: 2
* ltp-fs-tests - pass: 60
* ltp-fs_bind-tests - pass: 2
* ltp-fs_perms_simple-tests - pass: 19
* ltp-fsx-tests - pass: 2
* ltp-hugetlb-tests - pass: 22
* ltp-io-tests - pass: 3
* ltp-ipc-tests - pass: 9
* ltp-math-tests - pass: 11
* ltp-nptl-tests - pass: 2
* ltp-pty-tests - pass: 4
* ltp-sched-tests - pass: 10
* ltp-securebits-tests - pass: 4
* ltp-syscalls-tests - skip: 156, pass: 943
* ltp-timers-tests - pass: 12

x15 - arm
* boot - pass: 20
* kselftest - skip: 17, pass: 36
* libhugetlbfs - skip: 1, pass: 87
* ltp-cap_bounds-tests - pass: 2
* ltp-containers-tests - pass: 64
* ltp-fcntl-locktests-tests - pass: 2
* ltp-filecaps-tests - pass: 2
* ltp-fs-tests - pass: 60
* ltp-fs_bind-tests - pass: 2
* ltp-fs_perms_simple-tests - pass: 19
* ltp-fsx-tests - pass: 2
* ltp-hugetlb-tests - skip: 2, pass: 20
* ltp-io-tests - pass: 3
* ltp-ipc-tests - pass: 9
* ltp-math-tests - pass: 11
* ltp-nptl-tests - pass: 2
* ltp-pty-tests - pass: 4
* ltp-sched-tests - skip: 1, pass: 13
* ltp-securebits-tests - pass: 4
* ltp-syscalls-tests - skip: 66, pass: 1040
* ltp-timers-tests - pass: 12

dell-poweredge-r200 - x86_64
* boot - pass: 19
* kselftest - skip: 11, pass: 54
* libhugetlbfs - skip: 1, pass: 76
* ltp-cap_bounds-tests - pass: 1
* ltp-containers-tests - pass: 64
* ltp-fcntl-locktests-tests - pass: 2
* ltp-filecaps-tests - pass: 2
* ltp-fs-tests - skip: 1, pass: 61
* ltp-fs_bind-tests - pass: 1
* ltp-fs_perms_simple-tests - pass: 19
* ltp-fsx-tests - pass: 2
* ltp-hugetlb-tests - pass: 22
* ltp-io-tests - pass: 3
* ltp-ipc-tests - pass: 8
* ltp-math-tests - pass: 11
* ltp-nptl-tests - pass: 2
* ltp-pty-tests - pass: 4
* ltp-sched-tests - pass: 9
* ltp-securebits-tests - pass: 3
* ltp-syscalls-tests - skip: 163, pass: 962

Lots of green.


Let’s now talk about coverage, the pandora’s box of validation. It’s never
perfect. There’s a bazillion different build combos. Even tools can
make a difference. We’ve seen a case where the dhcp client from open embedded 
didn’t trigger a network regression in one of the LTS RCs but Debian’s dhclient
did.

Of no surprise between what we and others have, it’s not perfect coverage,
and there are only so many build, boot and run cycles to execute the test 
buckets with various combinations so we need to stay sensible as far as 
kernel configs go. 

Does this kind of system actually FIND anything and is it useful for 
watching for 4.14 regressions as fixes are introduced?

I would assert the answer is yes. We do have data for a couple of kernel
cycles but it’s also somewhat dirty as we have been in the process of 
detecting and tossing out dodgy test cases. 

Take 4.14-RC7, there was one failure that is no longer there.
ltp-syscalls-tests : perf_event_open02 (arm64)

As things are getting merged post 4.14 there are some failures
cropping up. Here’s an example:
https://qa-reports.linaro.org/lkft/linux-mainline-oe/tests/ltp-fs-tests/proc01

Note the Build column, the kernels are identified by their git describe. 
Don’t be alarmed if you see n/a in some columns, the queues are catching up
so data will be filling in.


So why didn’t we report these? As mentioned we’ve been tossing out dodgy
test cases to get to a clean baseline. We don’t need or want noise. 

For LTS, I want the system when it detects a failure to enable a quick 
bisect involving the affected test bucket. Given the nature of kernel 
bugs tho, there is that class of bug which only happens occasionally.

This brings up a conundrum when you have a system like this. A failure
turns up, it’s not consistently failing and a path forward isn’t 
necessarily obvious. Remember for an LTS RC, there’s a defined window 
to comment.

I’ve been flamed for reporting a LTS RC test failure which didn't include 
a fix, just a ‘this fails, and we’re looking at it.’ I’ve been flamed 
for not reporting a failure that had been detected but not raised to the 
list since it was still being debugged after the RC comment window had
closed.

My 1990s vintage asbestos underwear thankfully is functional.

There is probably a case to be made either way. It boils down to
either:  

Red Pill) Be fully open reporting early and often
Blue Pill) Be closed and only pass up failures that include a patch to fix a bug.

Red Pill does expose drama yet it also creates an opportunity for others to
get involved.

Blue Pill protects the community from noise and the creation of frustration
that the system has cried wolf for perhaps a stupid test case. 

Likewise from a maintainer or dev perspective, there’s a sea of data. 
Time is precious, and who wants to waste it on some snipe hunt?

I’m personally in the Red Pill camp. I like being open.

Be it 0day, LKFT or whatever I think the responsibility is on us
running these projects to be open and give full guidance. Yes there 
will be noise. Noise can suggest dodgy test cases or bugs that are
hard to trigger. Either way they warrant a look. Take Arnd Bergman’s 
work to get rid of kernel warnings. Same concept in my opinion.

Dodgy test cases can easily be put onto skip lists. As we’ve been
running for a number of months now, data and ol fashioned code 
review has been our guide to banish dodgy test cases to skip lists.
Going forward new test cases will pop up. Some of them will be dodgy. 

There’s lots of room for collaboration in improving test cases. 

In summary I think for mainline, LTS kernels etc, we have a good 
warning system to detect regressions as patches flow in. It will evolve 
and improve as is the nature of our open community. From kernelci, 
LKFT, 0day, etc, that’s a good set of automated systems to ferret out 
problems introduced by patches.

Tom
