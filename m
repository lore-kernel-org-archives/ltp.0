From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Mon, 8 Mar 2021 17:18:59 +0530
Subject: [LTP] [PATCH] clock_gettime04: print more info to help debugging
In-Reply-To: <CAEemH2eKkGokVY2ZBs=U9eqDrDZVB5qKBVUApULrdL65tfnmLQ@mail.gmail.com>
References: <20210308065329.25824-1-liwang@redhat.com>
 <20210308101732.lzkjql3t7aoscruk@vireshk-i7>
 <CAEemH2d45hFqhB-++xgswYoOh4HGFtFZxXCKGhLhDdt9oXFbfA@mail.gmail.com>
 <20210308111447.h3l2a5yep3n4n5qs@vireshk-i7>
 <CAEemH2eKkGokVY2ZBs=U9eqDrDZVB5qKBVUApULrdL65tfnmLQ@mail.gmail.com>
Message-ID: <20210308114859.tskerybpt6xtyffa@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 08-03-21, 19:24, Li Wang wrote:
> # ./clock_gettime04
> tst_test.c:1288: TINFO: Timeout per run is 0h 05m 00s
> clock_gettime04.c:84: TINFO: Running in a virtual machine, multiply the
> delta by 10.
> vdso_helpers.c:76: TINFO: Couldn't find vdso_gettime64()
> clock_gettime04.c:158: TPASS: CLOCK_REALTIME: Difference between successive
> readings is reasonable
> clock_gettime04.c:158: TPASS: CLOCK_REALTIME_COARSE: Difference between
> successive readings is reasonable
> clock_gettime04.c:158: TPASS: CLOCK_MONOTONIC: Difference between
> successive readings is reasonable
> clock_gettime04.c:158: TPASS: CLOCK_MONOTONIC_COARSE: Difference between
> successive readings is reasonable
> clock_gettime04.c:158: TPASS: CLOCK_MONOTONIC_RAW: Difference between
> successive readings is reasonable
> clock_gettime04.c:158: TPASS: CLOCK_BOOTTIME: Difference between successive
> readings is reasonable
> 
> 
> After my patch:
> 
> # ./clock_gettime04
> tst_test.c:1288: TINFO: Timeout per run is 0h 05m 00s
> clock_gettime04.c:84: TINFO: Running in a virtual machine, multiply the
> delta by 10.
> vdso_helpers.c:76: TINFO: Couldn't find vdso_gettime64()
> clock_gettime04.c:112: TINFO: vDSO or syscall with libc spec
> clock_gettime04.c:112: TINFO: syscall with old kernel spec
> clock_gettime04.c:112: TINFO: vDSO with old kernel spec
> clock_gettime04.c:112: TINFO: gettimeofday

The above doesn't look nice TBH.

> clock_gettime04.c:160: TPASS: CLOCK_REALTIME: Difference between successive
> readings is reasonable
> 
> >
> > What about adding tv->desc to all the existing print messages instead
> > ? Or maybe just the TFAIL ones? So we print everything in a single
> > line only ?
> >
> 
> But that still not good enough.
> e.g
> In PASS status, we missing some details.

Hmm, so there are two loops we are running here. One is for each CLOCK
and one for each variant. And the final PASS message only talks about
the CLOCK type and there is nothing about variants..

Lets decide how we want the output message to look and then code can
be changed accordingly.

Option 1: Just like what we have right now.

clock_gettime04.c:158: TPASS: CLOCK_MONOTONIC: Difference between
successive readings is reasonable

Option 2: Separate line for each variant.

clock_gettime04.c:158: TPASS: vDSO or syscall with libc spec: CLOCK_MONOTONIC: Difference between successive readings is reasonable
clock_gettime04.c:158: TPASS: syscall with old kernel spec  : CLOCK_MONOTONIC: Difference between successive readings is reasonable
clock_gettime04.c:158: TPASS: vDSO with old kernel spec     : CLOCK_MONOTONIC: Difference between successive readings is reasonable
clock_gettime04.c:158: TPASS: gettimeofday                  : CLOCK_MONOTONIC: Difference between successive readings is reasonable

Option 3: Same as option 2 but different formatting

clock_gettime04.c:158: TPASS: CLOCK_MONOTONIC: Difference between successive readings is reasonable for following variants:
        - vDSO or syscall with libc spec
        - syscall with old kernel spec
        - vDSO with old kernel spec
        - gettimeofday

Any other option here ?

For the FAIL messages, I think just adding tv->desc is good enough.

-- 
viresh
