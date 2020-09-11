From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 11 Sep 2020 11:53:14 +0200
Subject: [LTP] [PATCH 00/16] syscalls: Use common variants structure
In-Reply-To: <cover.1599545766.git.viresh.kumar@linaro.org>
References: <cover.1599545766.git.viresh.kumar@linaro.org>
Message-ID: <20200911095314.GA9505@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Viresh,

> Hi Cyril,

> As you suggested earlier, here is an attempt to use a common structure
> prototype at most of the places.

> futex, clock_adjtime() and clock_getres() tests are left with their own
> implementations due to compatibility issues.

> Viresh Kumar (16):
>   syscalls: Add common time64 variants structure
>   syscalls: clock_gettime: Reuse struct time64_variants
>   syscalls: clock_nanosleep: Reuse struct time64_variants
>   syscalls: clock_settime: Reuse struct time64_variants
>   syscalls: io_pgetevents: Reuse struct time64_variants
>   syscalls: semop: Reuse struct time64_variants
>   syscalls: mq_timed: Reuse struct time64_variants
>   syscalls: ppoll: Reuse struct time64_variants
>   syscalls: rt_sigtimedwait: Reuse struct time64_variants
>   syscalls: sched_rr_get_interval: Reuse struct time64_variants
>   syscalls: sendmmsg: Reuse struct time64_variants
>   syscalls: timer_settime: Reuse struct time64_variants
>   syscalls: timer_gettime: Reuse struct time64_variants
>   syscalls: timerfd: Reuse struct time64_variants
>   syscalls: utimensat: Reuse struct time64_variants
>   futex: Move variants struct definition to common header
One of the commits fails on various tests [1].

Some failures (I haven't checked all):

* missing nfds_t (<poll.h> is probably from old commits) [2]:

CC testcases/kernel/syscalls/mq_open/mq_open01
In file included from ../../../../include/time64_variants.h:13,
                 from /usr/src/ltp/testcases/kernel/syscalls/mq_timedreceive/../utils/mq_timed.h:10,
                 from mq_timedreceive01.c:17:
/usr/include/sys/poll.h:1:2: warning: #warning redirecting incorrect #include <sys/poll.h> to <poll.h> [-Wcpp]
    1 | #warning redirecting incorrect #include <sys/poll.h> to <poll.h>
      |  ^~~~~~~
In file included from /usr/src/ltp/testcases/kernel/syscalls/mq_timedreceive/../utils/mq_timed.h:10,
                 from mq_timedreceive01.c:17:
../../../../include/time64_variants.h:41:35: error: unknown type name 'nfds_t'
41 |  int (*ppoll)(struct pollfd *fds, nfds_t nfds, void *tmo_p,

* <libaio.h> not found [3]:
BUILD libltpnewipc.a
make[6]: Nothing to be done for 'all'.
In file included from /usr/src/ltp/testcases/kernel/syscalls/ipc/semop/semop02.c:29:
In file included from In file included from /usr/src/ltp/testcases/kernel/syscalls/ipc/semop/semop01.c:15:
In file included from /usr/src/ltp/testcases/kernel/syscalls/ipc/semop/semop.h:7:
/usr/src/ltp/include/time64_variants.h:10:10: fatal error: /usr/src/ltp/testcases/kernel/syscalls/ipc/semop/semop.h'libaio.h' file not
      found
:7:
/usr/src/ltp/include/time64_variants.h:10:10: fatal error: 'libaio.h' file#include <libaio.h>
         ^~~~~~~~~~
 not
      found
#include <libaio.h>

[1] https://travis-ci.org/github/pevik/ltp/builds/726197434
[2] https://travis-ci.org/github/pevik/ltp/jobs/726197439#L5295
[3] https://travis-ci.org/github/pevik/ltp/jobs/726197440#L6649

Kind regards,
Petr
