From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 18 May 2020 11:21:10 +0200
Subject: [LTP] [PATCH V3 00/17] Syscalls: Add support for time64 variants
In-Reply-To: <20200518091253.qmvqo7xub7hpeovm@vireshk-i7>
References: <cover.1589789487.git.viresh.kumar@linaro.org>
 <CAK8P3a3aP5S_w_FFv=UvJRSRTjcoNVy_W6ycm4OTct-7Q_5_xg@mail.gmail.com>
 <20200518091253.qmvqo7xub7hpeovm@vireshk-i7>
Message-ID: <CAK8P3a3_dGzoGPckBByySvLYGC3FyiCSwCdfzxG8xjJsY0oXrg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, May 18, 2020 at 11:12 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 18-05-20, 11:02, Arnd Bergmann wrote:
> > These all look good to me.
> >
> > I cross-referenced it with my list of syscall changes, and found that this
> > set of patches does not contain
> > clock_{gettime,settime,adjtime,getres,nanosleep},
>
> These are already already merged.
>
> > waitid, statx and msgctl/semctl/shmctl
>
> Hmm, I didn't see them in the list of time64 calls somehow. Nor is
> there a _time64 syscall number available for them. What did I miss ?
> Or the original syscalls only support the 64bit timespec and there is
> no separate time64 variant ?

I was mistaken about waitid, we never added a time64 syscall
for that since the arguments do not overflow and it takes a
timeval rather than a timespec. In this case you just have to make
sure to pass the correct rusage structure based on __kernel_old_timeval
instead of the glibc timeval.

For msgctl/semctl/shmctl, the existing syscalls were extended in a
compatible way, using an extended 'high' field for each 32-bit
seconds value. I later learned that on some architectures, the
'compat' version of that failed to zero-initialize those fields, so I
guess all we need is a test that ensures this was fixed correctly,
by initializing the '*_high' to something nonzero before calling
the syscall, and checking that it gets zero-filled by the syscall.

Ideally one would also check that they contain the correct values
after y2038 (same as we'd like for sys_clock_gettime and the
syscall wrappers based on that), but I don't know if that can
easily be done in ltp now because setting the system time may
have undesired side-effects.

> > There is also a list of syscalls that may need to get updates to their tests
> > because passing a timeval/timespec into them is now broken and they need
> > to receive the __kernel_old_* variants:
>
> Ahh, if I understand correct you are only talking about the cases
> where the syscall is called directly without the libc wrapper, right ?
> We can't use timeval/timespec there anymore.

Exactly. There are probably also ioctls with the same problem, but
I don't know which ioctl commands are actually tested by ltp.

I would guess that the socket timestamps (both ioctl and
setsockopt based ones) do have some tests that need to be
updated.

       Arnd
