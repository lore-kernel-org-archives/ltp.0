From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 7 Aug 2020 15:27:00 +0200
Subject: [LTP] [PATCH V8 5/5] syscalls/semtimedop: Add support for
 semtimedop and its time64 version
In-Reply-To: <c1ca12b5df0510279a8b2f0a93106b1ca153c4a7.1596008484.git.viresh.kumar@linaro.org>
References: <fab6e65d02767b60594916da89cca34221989229.1596008484.git.viresh.kumar@linaro.org>
 <c1ca12b5df0510279a8b2f0a93106b1ca153c4a7.1596008484.git.viresh.kumar@linaro.org>
Message-ID: <20200807132700.GB9851@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> --- /dev/null
> +++ b/testcases/kernel/syscalls/ipc/semop/semop.h
> @@ -0,0 +1,55 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +#ifndef SEMOP_VAR__
> +#define SEMOP_VAR__
> +
> +#include <sys/sem.h>
> +#include "tst_timer.h"
> +
> +static inline int sys_semtimedop(int semid, struct sembuf *sops, size_t nsops,
> +		void *timeout)
> +{
> +	return tst_syscall(__NR_semtimedop, semid, sops, nsops, timeout);
> +}
> +
> +static inline int sys_semtimedop_time64(int semid, struct sembuf *sops,
> +					size_t nsops, void *timeout)
> +{
> +	return tst_syscall(__NR_semtimedop_time64, semid, sops, nsops, timeout);
> +}
> +
> +struct test_variants {
> +	int (*semop)(int semid, struct sembuf *sops, size_t nsops);
> +	int (*semtimedop)(int semid, struct sembuf *sops, size_t nsops, void *timeout);
> +	enum tst_ts_type type;
> +	char *desc;
> +} variants[] = {
> +	{ .semop = semop, .type = TST_LIBC_TIMESPEC, .desc = "semop: vDSO or syscall"},

I'm pretty sure semop will never be vDSO :-).

> +#if (__NR_semtimedop != __LTP__NR_INVALID_SYSCALL)
> +	{ .semtimedop = sys_semtimedop, .type = TST_KERN_OLD_TIMESPEC, .desc = "semtimedop: syscall with old kernel spec"},
> +#endif
> +
> +#if (__NR_semtimedop_time64 != __LTP__NR_INVALID_SYSCALL)
> +	{ .semtimedop = sys_semtimedop_time64, .type = TST_KERN_TIMESPEC, .desc = "semtimedop: syscall time64 with kernel spec"},
> +#endif
> +};
> +
> +static inline int call_semop(struct test_variants *tv, int semid,
> +		struct sembuf *sops, size_t nsops, struct tst_ts *timeout)
> +{
> +	if (tv->semop)
> +		return tv->semop(semid, sops, nsops);
> +
> +	return tv->semtimedop(semid, sops, nsops, tst_ts_get(timeout));
> +}
> +
> +static inline void semop_supported_by_kernel(struct test_variants *tv)
> +{
> +       /* Check if the syscall is implemented on the platform */
> +       TEST(call_semop(tv, 0, NULL, 0, NULL));
> +       if (TST_RET == -1 && TST_ERR == ENOSYS)
> +               tst_brk(TCONF, "Test not supported on kernel/platform");
> +}
> +
> +#endif /* SEMOP_VAR__ */
> diff --git a/testcases/kernel/syscalls/ipc/semop/semop01.c b/testcases/kernel/syscalls/ipc/semop/semop01.c
> index 19607ee6d653..c3443da58af4 100644
> --- a/testcases/kernel/syscalls/ipc/semop/semop01.c
> +++ b/testcases/kernel/syscalls/ipc/semop/semop01.c
> @@ -12,6 +12,7 @@
>  #include "tst_test.h"
>  #include "libnewipc.h"
>  #include "lapi/semun.h"
> +#include "semop.h"
>  
>  #define NSEMS	4		/* the number of primitive semaphores to test */
>  
> @@ -23,11 +24,17 @@ static struct sembuf sops[PSEMS];
>  
>  static void run(void)
>  {
> +	struct test_variants *tv = &variants[tst_variant];
>  	union semun arr = { .val = 0 };
> +	struct tst_ts timeout;
>  	int fail = 0;
>  	int i;
>  
> -	TEST(semop(sem_id, sops, NSEMS));
> +	timeout.type = tv->type;
> +	tst_ts_set_sec(&timeout, 1);
> +	tst_ts_set_nsec(&timeout, 10000);

Can't we just set the timeout once in the test setup?


Other than these we really lack semtimedop testcases that really utilize
the timeout.

We need at least:

* Tests with NULL timeout

* A test that we get EAGAIN if semtimedop() timeouted either with:
  - semop == 0 and non-zero semaphore
  - semop < 0 and semaphore less than abs value of semop

* An EFAULT test for semtimedop() with bad address for timeout

-- 
Cyril Hrubis
chrubis@suse.cz
