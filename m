From: Li Wang <liwang@redhat.com>
Date: Mon, 8 Mar 2021 19:24:49 +0800
Subject: [LTP] [PATCH] clock_gettime04: print more info to help debugging
In-Reply-To: <20210308111447.h3l2a5yep3n4n5qs@vireshk-i7>
References: <20210308065329.25824-1-liwang@redhat.com>
 <20210308101732.lzkjql3t7aoscruk@vireshk-i7>
 <CAEemH2d45hFqhB-++xgswYoOh4HGFtFZxXCKGhLhDdt9oXFbfA@mail.gmail.com>
 <20210308111447.h3l2a5yep3n4n5qs@vireshk-i7>
Message-ID: <CAEemH2eKkGokVY2ZBs=U9eqDrDZVB5qKBVUApULrdL65tfnmLQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Mar 8, 2021 at 7:14 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:

> On 08-03-21, 18:59, Li Wang wrote:
> > Yes, but that's not harmful.
>
> But is useless.
>
> > If you remove all entries of varaints[] you can
> > still get PASS from the test, that's something strange to us. So I just
> add
> > this check there.
>
> Yes, that would happen because we will not run the inner loop in that
> case and even the condition you are adding will not run at all.
>
> This wasn't designed to run with empty variants list and so we don't
> verify that variants structure is empty or not and so it passes.
>

Indeed. I agree to remove 'tv->clock_gettime' check.


>
> > No, that will only print the first entry instruct variants because you're
> > using two iterations in the run(), the second loop 'j' is to traverse the
> > variants[] actually.
>
> Ahh, my bad. I didn't read the code properly. Sorry about that.
>
> Now that I had a look again, with what you are adding here we will
> start printing another line for each variant and it will be printed
> just once at the beginning of the loop of 10000 iterations. Right ?
>

Right.



>
> I am not sure how that will help you get more info out, to me it is
> still very much unreadable. Can you show the final output as well ?
>

# ./clock_gettime04
tst_test.c:1288: TINFO: Timeout per run is 0h 05m 00s
clock_gettime04.c:84: TINFO: Running in a virtual machine, multiply the
delta by 10.
vdso_helpers.c:76: TINFO: Couldn't find vdso_gettime64()
clock_gettime04.c:158: TPASS: CLOCK_REALTIME: Difference between successive
readings is reasonable
clock_gettime04.c:158: TPASS: CLOCK_REALTIME_COARSE: Difference between
successive readings is reasonable
clock_gettime04.c:158: TPASS: CLOCK_MONOTONIC: Difference between
successive readings is reasonable
clock_gettime04.c:158: TPASS: CLOCK_MONOTONIC_COARSE: Difference between
successive readings is reasonable
clock_gettime04.c:158: TPASS: CLOCK_MONOTONIC_RAW: Difference between
successive readings is reasonable
clock_gettime04.c:158: TPASS: CLOCK_BOOTTIME: Difference between successive
readings is reasonable


After my patch:

# ./clock_gettime04
tst_test.c:1288: TINFO: Timeout per run is 0h 05m 00s
clock_gettime04.c:84: TINFO: Running in a virtual machine, multiply the
delta by 10.
vdso_helpers.c:76: TINFO: Couldn't find vdso_gettime64()
clock_gettime04.c:112: TINFO: vDSO or syscall with libc spec
clock_gettime04.c:112: TINFO: syscall with old kernel spec
clock_gettime04.c:112: TINFO: vDSO with old kernel spec
clock_gettime04.c:112: TINFO: gettimeofday
clock_gettime04.c:160: TPASS: CLOCK_REALTIME: Difference between successive
readings is reasonable
clock_gettime04.c:112: TINFO: vDSO or syscall with libc spec
clock_gettime04.c:112: TINFO: syscall with old kernel spec
clock_gettime04.c:112: TINFO: vDSO with old kernel spec
clock_gettime04.c:160: TPASS: CLOCK_REALTIME_COARSE: Difference between
successive readings is reasonable
clock_gettime04.c:112: TINFO: vDSO or syscall with libc spec
clock_gettime04.c:112: TINFO: syscall with old kernel spec
clock_gettime04.c:112: TINFO: vDSO with old kernel spec
clock_gettime04.c:160: TPASS: CLOCK_MONOTONIC: Difference between
successive readings is reasonable
clock_gettime04.c:112: TINFO: vDSO or syscall with libc spec
clock_gettime04.c:112: TINFO: syscall with old kernel spec
clock_gettime04.c:112: TINFO: vDSO with old kernel spec
clock_gettime04.c:160: TPASS: CLOCK_MONOTONIC_COARSE: Difference between
successive readings is reasonable
clock_gettime04.c:112: TINFO: vDSO or syscall with libc spec
clock_gettime04.c:112: TINFO: syscall with old kernel spec
clock_gettime04.c:112: TINFO: vDSO with old kernel spec
clock_gettime04.c:160: TPASS: CLOCK_MONOTONIC_RAW: Difference between
successive readings is reasonable
clock_gettime04.c:112: TINFO: vDSO or syscall with libc spec
clock_gettime04.c:112: TINFO: syscall with old kernel spec
clock_gettime04.c:112: TINFO: vDSO with old kernel spec
clock_gettime04.c:160: TPASS: CLOCK_BOOTTIME: Difference between successive
readings is reasonable



>
> What about adding tv->desc to all the existing print messages instead
> ? Or maybe just the TFAIL ones? So we print everything in a single
> line only ?
>

But that still not good enough.
e.g
In PASS status, we missing some details.



>
> --
> viresh
>
>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210308/aae2314a/attachment.htm>
