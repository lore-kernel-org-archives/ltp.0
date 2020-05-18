From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Mon, 18 May 2020 14:42:53 +0530
Subject: [LTP] [PATCH V3 00/17] Syscalls: Add support for time64 variants
In-Reply-To: <CAK8P3a3aP5S_w_FFv=UvJRSRTjcoNVy_W6ycm4OTct-7Q_5_xg@mail.gmail.com>
References: <cover.1589789487.git.viresh.kumar@linaro.org>
 <CAK8P3a3aP5S_w_FFv=UvJRSRTjcoNVy_W6ycm4OTct-7Q_5_xg@mail.gmail.com>
Message-ID: <20200518091253.qmvqo7xub7hpeovm@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 18-05-20, 11:02, Arnd Bergmann wrote:
> These all look good to me.
> 
> I cross-referenced it with my list of syscall changes, and found that this
> set of patches does not contain
> clock_{gettime,settime,adjtime,getres,nanosleep},

These are already already merged.

> waitid, statx and msgctl/semctl/shmctl

Hmm, I didn't see them in the list of time64 calls somehow. Nor is
there a _time64 syscall number available for them. What did I miss ?
Or the original syscalls only support the 64bit timespec and there is
no separate time64 variant ?

> There is also a list of syscalls that may need to get updates to their tests
> because passing a timeval/timespec into them is now broken and they need
> to receive the __kernel_old_* variants:

Ahh, if I understand correct you are only talking about the cases
where the syscall is called directly without the libc wrapper, right ?
We can't use timeval/timespec there anymore.

> time, stime, gettimeofday, settimeofday, adjtimex, nanosleep,
> alarm, select, old_select, io_getevents, utime, utimes, futimesat,
> oldstat/oldlstat/oldfstat, newstat/newlstat/newfstat/newfstatat,
> stat64/lstat64/fstat64/fstatat64, and wait4/waitid/getrusage.

Okay, will have a look at them as well.

Thanks for the information.

-- 
viresh
