From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 18 May 2020 11:02:44 +0200
Subject: [LTP] [PATCH V3 00/17] Syscalls: Add support for time64 variants
In-Reply-To: <cover.1589789487.git.viresh.kumar@linaro.org>
References: <cover.1589789487.git.viresh.kumar@linaro.org>
Message-ID: <CAK8P3a3aP5S_w_FFv=UvJRSRTjcoNVy_W6ycm4OTct-7Q_5_xg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, May 18, 2020 at 10:15 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Hi,
>
> This updates the pending syscall tests that lacked the time64 updates.
>
> V3:
> - Fix issues related to passing incorrect timespec type to syscalls.
> - Take care of futex and semtimedop tests where the architecture
>   provides the syscall number, but doesn't implement it.
> - Other improvements and cleanups.

Hi Viresh,

These all look good to me.

I cross-referenced it with my list of syscall changes, and found that this
set of patches does not contain
clock_{gettime,settime,adjtime,getres,nanosleep},
waitid, statx and msgctl/semctl/shmctl. Did you cover all of those in a previous
patches, or are they planned for a follow-up?

There is also a list of syscalls that may need to get updates to their tests
because passing a timeval/timespec into them is now broken and they need
to receive the __kernel_old_* variants:

time, stime, gettimeofday, settimeofday, adjtimex, nanosleep,
alarm, select, old_select, io_getevents, utime, utimes, futimesat,
oldstat/oldlstat/oldfstat, newstat/newlstat/newfstat/newfstatat,
stat64/lstat64/fstat64/fstatat64, and wait4/waitid/getrusage.

      Arnd
