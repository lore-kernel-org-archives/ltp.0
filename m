From: Li Wang <liwang@redhat.com>
Date: Sat, 9 May 2020 12:21:51 +0800
Subject: [LTP] [PATCH V2 15/17] syscalls/semtimedop: Add support for
 semtimedop and its time64 version
In-Reply-To: <8a675726b6e553e740016390c774bce19efc5a12.1588911607.git.viresh.kumar@linaro.org>
References: <cover.1588911607.git.viresh.kumar@linaro.org>
 <8a675726b6e553e740016390c774bce19efc5a12.1588911607.git.viresh.kumar@linaro.org>
Message-ID: <CAEemH2cX=zyULO6qZBV5fBQv74dm2yuiUeRJ8SMe7OXYWJJ_sQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, May 8, 2020 at 12:28 PM Viresh Kumar <viresh.kumar@linaro.org>
wrote:

> This adds support for semtimedop() and its time64 variant to the
> existing semop() syscall tests.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  testcases/kernel/syscalls/ipc/semop/semop.h   | 52 +++++++++++++++++++
>  testcases/kernel/syscalls/ipc/semop/semop01.c | 11 +++-
>  testcases/kernel/syscalls/ipc/semop/semop02.c | 12 ++++-
>  testcases/kernel/syscalls/ipc/semop/semop03.c | 12 ++++-
>  testcases/kernel/syscalls/ipc/semop/semop04.c | 12 ++++-
>  testcases/kernel/syscalls/ipc/semop/semop05.c | 12 ++++-
>  6 files changed, 106 insertions(+), 5 deletions(-)
>  create mode 100644 testcases/kernel/syscalls/ipc/semop/semop.h
>
> diff --git a/testcases/kernel/syscalls/ipc/semop/semop.h
> b/testcases/kernel/syscalls/ipc/semop/semop.h
> new file mode 100644
> index 000000000000..8d1245b65ec0
> --- /dev/null
> +++ b/testcases/kernel/syscalls/ipc/semop/semop.h
> @@ -0,0 +1,52 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +#ifndef SEMOP_VAR__
> +#define SEMOP_VAR__
> +
> +#include <sys/sem.h>
> +#include "tst_timer.h"
> +#include "lapi/abisize.h"
> +
> +static inline int sys_semtimedop(int semid, struct sembuf *sops, size_t
> nsops,
> +               void *timeout)
> +{
> +       return tst_syscall(__NR_semtimedop, semid, sops, nsops, timeout);
> +}
> +
> +static inline int sys_semtimedop_time64(int semid, struct sembuf *sops,
> +                                       size_t nsops, void *timeout)
> +{
> +       return tst_syscall(__NR_semtimedop_time64, semid, sops, nsops,
> timeout);
> +}
> +
> +struct test_variants {
> +       int (*semop)(int semid, struct sembuf *sops, size_t nsops);
> +       int (*semtimedop)(int semid, struct sembuf *sops, size_t nsops,
> void *timeout);
> +       enum tst_ts_type type;
> +       char *desc;
> +} variants[] = {
> +       { .semop = semop, .type = TST_LIBC_TIMESPEC, .desc = "semop: vDSO
> or syscall"},
> +#if defined(TST_ABI32)
> +       { .semtimedop = sys_semtimedop, .type = TST_LIBC_TIMESPEC, .desc =
> "semtimedop: syscall with libc spec"},
> +       { .semtimedop = sys_semtimedop, .type = TST_KERN_OLD_TIMESPEC,
> .desc = "semtimedop: syscall with kernel spec32"},
> +#endif
> +
> +#if defined(TST_ABI64)
> +       { .semtimedop = sys_semtimedop, .type = TST_KERN_TIMESPEC, .desc =
> "semtimedop: syscall with kernel spec64"},
> +#endif
> +
> +#if (__NR_semtimedop_time64 != __LTP__NR_INVALID_SYSCALL)
> +       { .semtimedop = sys_semtimedop_time64, .type = TST_KERN_TIMESPEC,
> .desc = "semtimedop: syscall time64 with kernel spec64"},
> +#endif
> +};
> +
> +static inline int call_semop(struct test_variants *tv, int semid,
> +               struct sembuf *sops, size_t nsops, struct tst_ts *timeout)
> +{
> +       if (tv->semop)
> +               return tv->semop(semid, sops, nsops);
> +
> +       return tv->semtimedop(semid, sops, nsops, tst_ts_get(timeout));
> +}
> +
> +#endif /* SEMOP_VAR__ */
> diff --git a/testcases/kernel/syscalls/ipc/semop/semop01.c
> b/testcases/kernel/syscalls/ipc/semop/semop01.c
> index bcb45fa69320..a4924376e32c 100644
> --- a/testcases/kernel/syscalls/ipc/semop/semop01.c
> +++ b/testcases/kernel/syscalls/ipc/semop/semop01.c
> @@ -41,6 +41,7 @@
>  #include "tst_test.h"
>  #include "libnewipc.h"
>  #include "lapi/semun.h"
> +#include "semop.h"
>
>  #define NSEMS  4               /* the number of primitive semaphores to
> test */
>
> @@ -52,11 +53,16 @@ static struct sembuf sops[PSEMS];
>
>  static void run(void)
>  {
> +       struct test_variants *tv = &variants[tst_variant];
>         union semun arr = { .val = 0 };
> +       struct tst_ts timeout;
>         int fail = 0;
>         int i;
>
> -       TEST(semop(sem_id, sops, NSEMS));
> +       timeout.type = tv->type;
> +       tst_ts_set_nsec(&timeout, 10000);
> +
> +       TEST(call_semop(tv, sem_id, sops, NSEMS, &timeout));
>
>         if (TST_RET == -1) {
>                 tst_res(TFAIL | TTERRNO, "semop() failed");
> @@ -94,6 +100,8 @@ static void setup(void)
>  {
>         int i;
>
> +       tst_res(TINFO, "Testing variant: %s", variants[tst_variant].desc);
> +
>         get_arr.array = malloc(sizeof(unsigned short int) * PSEMS);
>         if (get_arr.array == NULL)
>                 tst_brk(TBROK, "malloc failed");
> @@ -124,6 +132,7 @@ static void cleanup(void)
>
>  static struct tst_test test = {
>         .test_all = run,
> +       .test_variants = ARRAY_SIZE(variants),
>         .setup = setup,
>         .cleanup = cleanup,
>         .needs_tmpdir = 1,
> diff --git a/testcases/kernel/syscalls/ipc/semop/semop02.c
> b/testcases/kernel/syscalls/ipc/semop/semop02.c
> index f24d284776a4..a51906340400 100644
> --- a/testcases/kernel/syscalls/ipc/semop/semop02.c
> +++ b/testcases/kernel/syscalls/ipc/semop/semop02.c
> @@ -20,6 +20,7 @@
>  #include "tst_test.h"
>  #include "libnewipc.h"
>  #include "lapi/semun.h"
> +#include "semop.h"
>
>  static int sem_id_1 = -1;      /* a semaphore set with read & alter
> permissions */
>  static int sem_id_2 = -1;      /* a semaphore set without read & alter
> permissions */
> @@ -52,6 +53,8 @@ static void setup(void)
>         struct seminfo ipc_buf;
>         union semun arr;
>
> +       tst_res(TINFO, "Testing variant: %s", variants[tst_variant].desc);
> +
>         ltpuser = SAFE_GETPWNAM(nobody_uid);
>         SAFE_SETUID(ltpuser->pw_uid);
>
> @@ -84,7 +87,13 @@ static void setup(void)
>
>  static void run(unsigned int i)
>  {
> -       TEST(semop(*(tc[i].semid), tc[i].t_sbuf, tc[i].t_ops));
> +       struct test_variants *tv = &variants[tst_variant];
> +       struct tst_ts timeout;
> +
> +       timeout.type = tv->type;
> +       tst_ts_set_nsec(&timeout, 10000);
> +
> +       TEST(call_semop(tv, *(tc[i].semid), tc[i].t_sbuf, tc[i].t_ops,
> &timeout));
>
>         if (TST_RET != -1) {
>                 tst_res(TFAIL | TTERRNO, "call succeeded unexpectedly");
> @@ -117,6 +126,7 @@ static void cleanup(void)
>  static struct tst_test test = {
>         .test = run,
>         .tcnt = ARRAY_SIZE(tc),
> +       .test_variants = ARRAY_SIZE(variants),
>         .setup = setup,
>         .cleanup = cleanup,
>         .needs_tmpdir = 1,
> diff --git a/testcases/kernel/syscalls/ipc/semop/semop03.c
> b/testcases/kernel/syscalls/ipc/semop/semop03.c
> index 4f5f78eb6d8d..d36194ce1f41 100644
> --- a/testcases/kernel/syscalls/ipc/semop/semop03.c
> +++ b/testcases/kernel/syscalls/ipc/semop/semop03.c
> @@ -38,6 +38,7 @@
>  #include "tst_test.h"
>  #include "libnewipc.h"
>  #include "lapi/semun.h"
> +#include "semop.h"
>
>  static key_t semkey;
>  static int sem_id = -1;
> @@ -47,6 +48,12 @@ static int tc[] = { -1, PSEMS + 1 }; /* negative and
> too many "primitive" semas
>
>  static void run(unsigned int i)
>  {
> +       struct test_variants *tv = &variants[tst_variant];
> +       struct tst_ts timeout;
> +
> +       timeout.type = tv->type;
> +       tst_ts_set_nsec(&timeout, 10000);
> +
>         /* initialize two fields in the sembuf structure here */
>         s_buf.sem_op = 1;       /* add this value to struct sem.semval */
>         s_buf.sem_flg = SEM_UNDO;       /* undo when process exits */
> @@ -61,7 +68,7 @@ static void run(unsigned int i)
>          * use the TEST macro to make the call
>          */
>
> -       TEST(semop(sem_id, &s_buf, 1));
> +       TEST(call_semop(tv, sem_id, &s_buf, 1, &timeout));
>
>         if (TST_RET != -1) {
>                 tst_res(TFAIL | TTERRNO, "call succeeded unexpectedly");
> @@ -80,6 +87,8 @@ static void run(unsigned int i)
>
>  static void setup(void)
>  {
> +       tst_res(TINFO, "Testing variant: %s", variants[tst_variant].desc);
> +
>         /* get an IPC resource key */
>         semkey = GETIPCKEY();
>
> @@ -102,6 +111,7 @@ static void cleanup(void)
>  static struct tst_test test = {
>         .test = run,
>         .tcnt = ARRAY_SIZE(tc),
> +       .test_variants = ARRAY_SIZE(variants),
>         .setup = setup,
>         .cleanup = cleanup,
>         .needs_tmpdir = 1,
> diff --git a/testcases/kernel/syscalls/ipc/semop/semop04.c
> b/testcases/kernel/syscalls/ipc/semop/semop04.c
> index 0faf00a3585f..033065e7bbfc 100644
> --- a/testcases/kernel/syscalls/ipc/semop/semop04.c
> +++ b/testcases/kernel/syscalls/ipc/semop/semop04.c
> @@ -38,6 +38,7 @@
>  #include "tst_test.h"
>  #include "libnewipc.h"
>  #include "lapi/semun.h"
> +#include "semop.h"
>
>  static int sem_id = -1;
>  static int val; /* value for SETVAL */
> @@ -62,6 +63,12 @@ static struct test_case_t {
>
>  static void run(unsigned int i)
>  {
> +       struct test_variants *tv = &variants[tst_variant];
> +       struct tst_ts timeout;
> +
> +       timeout.type = tv->type;
> +       tst_ts_set_nsec(&timeout, 10000);
> +
>         /* initialize the s_buf buffer */
>         s_buf.sem_op = tc[i].op;
>         s_buf.sem_flg = tc[i].flg;
> @@ -72,7 +79,7 @@ static void run(unsigned int i)
>         if (semctl(sem_id, tc[i].num, SETVAL, tc[i].get_arr) == -1)
>                 tst_brk(TBROK | TERRNO, "semctl() failed");
>
> -       TEST(semop(sem_id, &s_buf, 1));
> +       TEST(call_semop(tv, sem_id, &s_buf, 1, &timeout));
>         if (TST_RET != -1) {
>                 tst_res(TFAIL, "call succeeded unexpectedly");
>                 return;
> @@ -86,6 +93,8 @@ static void run(unsigned int i)
>
>  static void setup(void)
>  {
> +       tst_res(TINFO, "Testing variant: %s", variants[tst_variant].desc);
> +
>         val = 1;
>
>         /* get an IPC resource key */
> @@ -114,6 +123,7 @@ static void cleanup(void)
>  static struct tst_test test = {
>         .test = run,
>         .tcnt = ARRAY_SIZE(tc),
> +       .test_variants = ARRAY_SIZE(variants),
>         .setup = setup,
>         .cleanup = cleanup,
>         .needs_tmpdir = 1,
> diff --git a/testcases/kernel/syscalls/ipc/semop/semop05.c
> b/testcases/kernel/syscalls/ipc/semop/semop05.c
> index 9e8e040b0b19..f892cd519ecf 100644
> --- a/testcases/kernel/syscalls/ipc/semop/semop05.c
> +++ b/testcases/kernel/syscalls/ipc/semop/semop05.c
> @@ -52,6 +52,7 @@
>  #include "tst_test.h"
>  #include "libnewipc.h"
>  #include "lapi/semun.h"
> +#include "semop.h"
>
>  static key_t semkey;
>  static int sem_id = -1;
> @@ -115,7 +116,13 @@ static inline int process_state_wait2(pid_t pid,
> const char state)
>
>  static void do_child(int i)
>  {
> -       TEST(semop(sem_id, &s_buf, 1));
> +       struct test_variants *tv = &variants[tst_variant];
> +       struct tst_ts timeout;
> +
> +       timeout.type = tv->type;
> +       tst_ts_set_nsec(&timeout, 10000);
> +
> +       TEST(call_semop(tv, sem_id, &s_buf, 1, &timeout));
>         if (TST_RET != -1) {
>                 tst_res(TFAIL, "call succeeded when error expected");
>                 exit(-1);
> @@ -137,6 +144,8 @@ static void sighandler(int sig)
>
>  static void setup(void)
>  {
> +       tst_res(TINFO, "Testing variant: %s", variants[tst_variant].desc);
> +
>         SAFE_SIGNAL(SIGHUP, sighandler);
>
>         /* get an IPC resource key */
> @@ -238,6 +247,7 @@ static void do_child_uclinux(void)
>  static struct tst_test test = {
>         .test = run,
>         .tcnt = ARRAY_SIZE(tc),
> +       .test_variants = ARRAY_SIZE(variants),
>

RHEL8.2(x84_64) failed as:

# ./semop05
tst_test.c:1246: INFO: Timeout per run is 0h 05m 00s
semop05.c:147: INFO: Testing variant: semop: vDSO or syscall
semop05.c:132: PASS: expected failure: EIDRM (43)
semop05.c:132: PASS: expected failure: EIDRM (43)
semop05.c:132: PASS: expected failure: EINTR (4)
semop05.c:132: PASS: expected failure: EINTR (4)
tst_test.c:1246: INFO: Timeout per run is 0h 05m 00s
semop05.c:147: INFO: Testing variant: semtimedop: syscall with kernel spec64
semop05.c:134: FAIL: unexpected failure: EAGAIN/EWOULDBLOCK (11)
Test timeouted, sending SIGKILL!
tst_test.c:1286: INFO: If you are running on slow machine, try exporting
LTP_TIMEOUT_MUL > 1
tst_test.c:1287: BROK: Test killed! (timeout?)


RHEL8.2(s390x) failed as:

tst_test.c:1246: INFO: Timeout per run is 0h 05m 00s
semop05.c:147: INFO: Testing variant: semop: vDSO or syscall
semop05.c:132: PASS: expected failure: EIDRM (43)
semop05.c:132: PASS: expected failure: EIDRM (43)
semop05.c:132: PASS: expected failure: EINTR (4)
semop05.c:132: PASS: expected failure: EINTR (4)
tst_test.c:1246: INFO: Timeout per run is 0h 05m 00s
semop05.c:147: INFO: Testing variant: semtimedop: syscall with kernel spec64
semop.h:13: CONF: syscall(392) __NR_semtimedop not supported
Test timeouted, sending SIGKILL!
tst_test.c:1286: INFO: If you are running on slow machine, try exporting
LTP_TIMEOUT_MUL > 1
tst_test.c:1287: BROK: Test killed! (timeout?)



>         .setup = setup,
>         .cleanup = cleanup,
>         .needs_tmpdir = 1,
> --
> 2.25.0.rc1.19.g042ed3e048af
>
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>
>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200509/01bea12c/attachment-0001.htm>
