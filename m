From: Li Wang <liwang@redhat.com>
Date: Sat, 9 May 2020 17:02:35 +0800
Subject: [LTP] [PATCH V2 06/17] syscalls/futex: Add support for time64
 tests
In-Reply-To: <5432ab11234b37bf7f46db7c1a624a432c8aedf3.1588911607.git.viresh.kumar@linaro.org>
References: <cover.1588911607.git.viresh.kumar@linaro.org>
 <5432ab11234b37bf7f46db7c1a624a432c8aedf3.1588911607.git.viresh.kumar@linaro.org>
Message-ID: <CAEemH2f8fQ58f_sJBkF4j2gnRORYm28g5Bzy21TF_M_wKuANUg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, May 8, 2020 at 12:27 PM Viresh Kumar <viresh.kumar@linaro.org>
wrote:

> This adds support for time64 tests to the existing futex() syscall
> tests.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> ---
>  include/tst_timer.h                           |  12 ++
>  .../syscalls/futex/futex_cmp_requeue01.c      |  35 +++-
>  .../syscalls/futex/futex_cmp_requeue02.c      |  25 ++-
>  testcases/kernel/syscalls/futex/futex_utils.h |  52 ++++--
>  .../kernel/syscalls/futex/futex_wait01.c      |  83 +++++-----
>  .../kernel/syscalls/futex/futex_wait02.c      | 104 ++++++------
>  .../kernel/syscalls/futex/futex_wait03.c      |  91 +++++------
>  .../kernel/syscalls/futex/futex_wait04.c      |  85 +++++-----
>  .../kernel/syscalls/futex/futex_wait05.c      |   2 +-
>  .../syscalls/futex/futex_wait_bitset01.c      |  50 ++++--
>  .../kernel/syscalls/futex/futex_wake01.c      |  71 ++++-----
>  .../kernel/syscalls/futex/futex_wake02.c      |  99 ++++++------
>  .../kernel/syscalls/futex/futex_wake03.c      | 111 +++++++------
>  .../kernel/syscalls/futex/futex_wake04.c      | 150 +++++++++---------
>  testcases/kernel/syscalls/futex/futextest.h   | 111 ++++++++-----
>  15 files changed, 609 insertions(+), 472 deletions(-)
>
> diff --git a/include/tst_timer.h b/include/tst_timer.h
> index a726298b407d..b4280042c77f 100644
> --- a/include/tst_timer.h
> +++ b/include/tst_timer.h
> @@ -243,6 +243,18 @@ static inline int sys_clock_nanosleep64(clockid_t
> clk_id, int flags,
>                            request, remain);
>  }
>
> +static inline int sys_futex(int *uaddr, int futex_op, int val, void *to,
> +                           int *uaddr2, int val3)
> +{
> +       return tst_syscall(__NR_futex, uaddr, futex_op, val, to, uaddr2,
> val3);
> +}
> +
> +static inline int sys_futex_time64(int *uaddr, int futex_op, int val,
> void *to,
> +                                  int *uaddr2, int val3)
> +{
> +       return tst_syscall(__NR_futex_time64, uaddr, futex_op, val, to,
> uaddr2, val3);
> +}
> +
>  static inline int libc_sched_rr_get_interval(pid_t pid, void *ts)
>  {
>         return sched_rr_get_interval(pid, ts);
> diff --git a/testcases/kernel/syscalls/futex/futex_cmp_requeue01.c
> b/testcases/kernel/syscalls/futex/futex_cmp_requeue01.c
> index c50fade9f969..bc9d2a6bee37 100644
> --- a/testcases/kernel/syscalls/futex/futex_cmp_requeue01.c
> +++ b/testcases/kernel/syscalls/futex/futex_cmp_requeue01.c
> @@ -18,6 +18,7 @@
>  #include "tst_timer_test.h"
>  #include "tst_test.h"
>  #include "futextest.h"
> +#include "lapi/abisize.h"
>
>  struct shared_data {
>         futex_t futexes[2];
> @@ -42,14 +43,33 @@ static struct tcase {
>         {1000, 300, 500},
>  };
>
> +static struct test_variants {
> +       enum futex_fn_type fntype;
> +       enum tst_ts_type tstype;
> +       char *desc;
> +} variants[] = {
> +#if defined(TST_ABI32)
> +       { .fntype = FUTEX_FN_FUTEX, .tstype = TST_KERN_OLD_TIMESPEC, .desc
> = "syscall with kernel spec32"},
> +#endif
> +
> +#if defined(TST_ABI64)
> +       { .fntype = FUTEX_FN_FUTEX, .tstype = TST_KERN_TIMESPEC, .desc =
> "syscall with kernel spec64"},
> +#endif
> +
> +#if (__NR_futex_time64 != __LTP__NR_INVALID_SYSCALL)
>

This might not safe to use it directly if only check __NR_futex_time64 being
defined. i.e Test it on the platform without achieving the system
syscall(but
define __NR_futex_time64), the test children exit with TCONF will cause
kind of issues.


RHEL-8.2(ppc64le) failed as:
--------------------------------------

tag=futex_cmp_requeue01 stime=1588947939
cmdline="futex_cmp_requeue01"
contacts=""
analysis=exit
<<<test_output>>>
tst_test.c:1246: INFO: Timeout per run is 0h 05m 00s
futex_cmp_requeue01.c:202: INFO: Testing variant: syscall with kernel spec64
futex_cmp_requeue01.c:114: INFO: Test 0: waiters: 10, wakes: 3, requeues: 7
futex_cmp_requeue01.c:136: INFO: futex_cmp_requeue() returned 10
futex_cmp_requeue01.c:152: INFO: children woken, futex0: 0, futex1: 7,
spurious wakeups: 0
futex_cmp_requeue01.c:197: PASS: futex_cmp_requeue()
futex_cmp_requeue01.c:114: INFO: Test 1: waiters: 10, wakes: 0, requeues: 10
futex_cmp_requeue01.c:136: INFO: futex_cmp_requeue() returned 10
futex_cmp_requeue01.c:152: INFO: children woken, futex0: 0, futex1:
10, spurious wakeups: 0
futex_cmp_requeue01.c:197: PASS: futex_cmp_requeue()
futex_cmp_requeue01.c:114: INFO: Test 2: waiters: 10, wakes: 2, requeues: 6
...
futex_cmp_requeue01.c:152: INFO: children woken, futex0: 200, futex1:
500, spurious wakeups: 0
futex_cmp_requeue01.c:197: PASS: futex_cmp_requeue()
tst_test.c:1246: INFO: Timeout per run is 0h 05m 00s
futex_cmp_requeue01.c:202: INFO: Testing variant: syscall time64 with
kernel spec64
../../../../include/tst_timer.h:256: CONF: syscall(422)
__NR_futex_time64 not supported
...
../../../../include/tst_timer.h:256: CONF: syscall(422)
__NR_futex_time64 not supported
../../../../include/tst_timer.h:256: CONF: syscall(422)
__NR_futex_time64 not supported
Test timeouted, sending SIGKILL!
tst_test.c:1286: INFO: If you are running on slow machine, try
exporting LTP_TIMEOUT_MUL > 1
tst_test.c:1287: BROK: Test killed! (timeout?)


cmdline="futex_wake02"
contacts=""
analysis=exit
<<<test_output>>>
tst_test.c:1246: INFO: Timeout per run is 0h 05m 00s
futex_wake02.c:155: INFO: Testing variant: syscall with kernel spec64
futex_wake02.c:105: PASS: futex_wake() woken up 1 threads
futex_wake02.c:105: PASS: futex_wake() woken up 2 threads
futex_wake02.c:105: PASS: futex_wake() woken up 3 threads
futex_wake02.c:105: PASS: futex_wake() woken up 4 threads
futex_wake02.c:105: PASS: futex_wake() woken up 5 threads
futex_wake02.c:105: PASS: futex_wake() woken up 6 threads
futex_wake02.c:105: PASS: futex_wake() woken up 7 threads
futex_wake02.c:105: PASS: futex_wake() woken up 8 threads
futex_wake02.c:105: PASS: futex_wake() woken up 9 threads
futex_wake02.c:105: PASS: futex_wake() woken up 10 threads
futex_wake02.c:118: PASS: futex_wake() woken up 0 threads
tst_test.c:1246: INFO: Timeout per run is 0h 05m 00s
futex_wake02.c:155: INFO: Testing variant: syscall time64 with kernel spec64
../../../../include/tst_timer.h:256: CONF: syscall(422)
__NR_futex_time64 not supported
../../../../include/tst_timer.h:256: CONF: syscall(422)
__NR_futex_time64 not supported
tst_test.c:1063: BROK: Test haven't reported results!


futex_wake03.c:111: INFO: Testing variant: syscall with kernel spec64
futex_wake03.c:71: PASS: futex_wake() woken up 1 childs
futex_wake03.c:71: PASS: futex_wake() woken up 2 childs
futex_wake03.c:71: PASS: futex_wake() woken up 3 childs
futex_wake03.c:71: PASS: futex_wake() woken up 4 childs
futex_wake03.c:71: PASS: futex_wake() woken up 5 childs
futex_wake03.c:71: PASS: futex_wake() woken up 6 childs
futex_wake03.c:71: PASS: futex_wake() woken up 7 childs
futex_wake03.c:71: PASS: futex_wake() woken up 8 childs
futex_wake03.c:71: PASS: futex_wake() woken up 9 childs
futex_wake03.c:71: PASS: futex_wake() woken up 10 childs
futex_wake03.c:105: PASS: futex_wake() woken up 0 children
tst_test.c:1246: INFO: Timeout per run is 0h 05m 00s
futex_wake03.c:111: INFO: Testing variant: syscall time64 with kernel spec64
../../../../include/tst_timer.h:256: CONF: syscall(422)
__NR_futex_time64 not supported
../../../../include/tst_timer.h:256: CONF: syscall(422)
__NR_futex_time64 not supported
../../../../include/tst_timer.h:256: CONF: syscall(422)
__NR_futex_time64 not supported...
../../../../include/tst_timer.h:256: CONF: syscall(422)
__NR_futex_time64 not supported
../../../../include/tst_timer.h:256: CONF: syscall(422)
__NR_futex_time64 not supported
Test timeouted, sending SIGKILL!
tst_test.c:1286: INFO: If you are running on slow machine, try
exporting LTP_TIMEOUT_MUL > 1
tst_test.c:1287: BROK: Test killed! (timeout?)


cmdline="futex_wake04"
contacts=""
analysis=exit
<<<test_output>>>
tst_test.c:1246: INFO: Timeout per run is 0h 05m 00s
futex_wake04.c:69: INFO: Testing variant: syscall with kernel spec64
futex_wake04.c:142: INFO: Hugepagesize 16777216
futex_wake04.c:127: PASS: Hi hydra, thread2 awake!
tst_test.c:1246: INFO: Timeout per run is 0h 05m 00s
futex_wake04.c:69: INFO: Testing variant: syscall time64 with kernel spec64
futex_wake04.c:142: INFO: Hugepagesize 16777216
../../../../include/tst_timer.h:256: CONF: syscall(422)
__NR_futex_time64 not supported
../../../../include/tst_timer.h:256: CONF: syscall(422)
__NR_futex_time64 not supported
futex_wake04.c:129: FAIL: Bug: wait_thread2 did not wake after 30
secs.: SUCCESS (0)


-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200509/a0d436a4/attachment-0001.htm>
