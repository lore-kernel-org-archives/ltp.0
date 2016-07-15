From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 15 Jul 2016 14:04:58 +0200
Subject: [LTP] [PATCH] syscallls/sched_setscheduler: add
 sched_setscheduler03
Message-ID: <5788D16A.3010607@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it




----- Original Message -----
> From: "Chunyu Hu" <chuhu@redhat.com>
> To: ltp@lists.linux.it
> Sent: Thursday, 14 July, 2016 11:25:29 AM
> Subject: [LTP] [PATCH] syscallls/sched_setscheduler: add sched_setscheduler03
> +#define _GNU_SOURCE
> +#include <stdio.h>
> +#include <errno.h>
> +#include <sched.h>
> +#include <linux/capability.h>

Hi,

from doc/style-guide.txt:
"Don't use +linux/+ headers if at all possible."

It does not compile on RHEL5.6 at the moment:
sched_setscheduler03.c: In function ‘setup’:
sched_setscheduler03.c:175: error: ‘_LINUX_CAPABILITY_VERSION_1’ undeclared (first use in this function)
sched_setscheduler03.c:175: error: (Each undeclared identifier is reported only once
sched_setscheduler03.c:175: error: for each function it appears in.)
make: *** [sched_setscheduler03] Error 1

Are capabilities needed only to clear CAP_SYS_NICE?
Couldn't we just fork and seteuid to "nobody"?

> +#include <sys/time.h>
> +#include <sys/resource.h>
> +
> +#include "tst_test.h"
> +#include "linux_syscall_numbers.h"
> +
> +#define RLIMIT_NICE_NORMAL 20
> +
> +#ifndef SCHED_IDLE
> +#define SCHED_IDLE 5
> +#endif

This ifdef should rather disable testcase that needs it.
Otherwise you'll get failure on older kernels:

sched_setscheduler03.c:116: FAIL: unexpected error - 22 : Invalid argument - expected 0

# uname -r
2.6.18-238.el5

> +
> +/* cap_user_header_t is a pointer to __user_cap_header_struct */
> +static struct __user_cap_header_struct cap_header;
> +
> +/*
> + * cap_user_data_t is a pointer to to __user_cap_data_struct.
> + * there are three versions of header, on v2 and v3, the calls
> + * need two data struct, here we use only v1 is enough, but
> + * leave it as a two item array for deprecate consideration.
> + */
> +static struct __user_cap_data_struct cap_data[2];
> +
> +static struct rlimit limit;
> +static pid_t zero_pid;
> +static struct sched_param param[1] = {{0}};
> +
> +struct test_case_t {
> +	pid_t *pid;
> +	int policy;
> +	struct sched_param *sched_param;
> +	int error;
> +};
> +
> +struct test_case_t cases[] = {
> +	{
> +		.pid = &zero_pid,
> +		.policy = SCHED_OTHER,
> +		.sched_param = &param[0]
> +	},
> +	{
> +		.pid = &zero_pid,
> +		.policy = SCHED_BATCH,
> +		.sched_param = &param[0]
> +	},
> +	{
> +		.pid = &zero_pid,
> +		.policy = SCHED_IDLE,
> +		.sched_param = &param[0]
> +	}
> +};
> +
<snip>
> +
> +static void verify_fn(unsigned int i)
> +{
> +

Here could be some message saying what test is going to run.


> +	TEST(sched_setscheduler(*cases[i].pid, cases[i].policy,
> +					cases[i].sched_param));
> +	if (TEST_RETURN)
> +		tst_res(TFAIL, "unexpected error - %d : %s - "

TFAIL | TTERRNO

> +			 "expected %d", TEST_ERRNO,
> +			 strerror(TEST_ERRNO), cases[i].error);
> +	else
> +		tst_res(TPASS, "Succeed - %d : %s - "
> +			 "expected %d", TEST_ERRNO,
> +			 strerror(TEST_ERRNO), cases[i].error);

No need to print errno if call succeeded and that was expected.

> +}
> +
> +static void setup(void)
> +{
> +
> +	cap_header.version = _LINUX_CAPABILITY_VERSION_1;
> +
> +	l_rlimit_show(RLIMIT_NICE, &limit);
> +
> +	/*
> +	* nice rlimit ranges from 1 to 40, mapping to real nice
> +	* value from 19 to -20. We set it to 19, as the default priority
> +	* of process with fair policy is 120, which will be translated
> +	* into nice 20, we make this RLIMIT_NICE smaller than that, to
> +	* verify the can_nice usage issue.
> +	*/
> +	limit.rlim_cur = (RLIMIT_NICE_NORMAL - 1);
> +	limit.rlim_max = (RLIMIT_NICE_NORMAL - 1);
> +
> +	l_rlimit_setup(RLIMIT_NICE, &limit);
> +
> +	tst_res(TINFO, "Setting init sched policy to SCHED_OTHER");
> +	if (sched_setscheduler(0, SCHED_OTHER, &param[0]) != 0)
> +		tst_brk(TBROK | TERRNO,
> +			 "ERROR sched_setscheduler: (0, SCHED_OTHER, param)");
> +
> +	if (sched_getscheduler(0) != SCHED_OTHER)
> +		tst_brk(TBROK | TERRNO, "ERROR sched_tetscheduler");
> +
> +	l_cap_show(&cap_header, &cap_data[0]);
> +
> +	cap_data[0].effective &= (~(1 << CAP_SYS_NICE));
> +	cap_data[0].permitted &= (~(1 << CAP_SYS_NICE));
> +	cap_data[0].inheritable = 1;
> +
> +	l_cap_setup(&cap_header, &cap_data[0]);
> +}
> +
> +static void cleanup(void)
> +{
> +	tst_res(TINFO, "cleanup() executed by pid %i", getpid());
> +}
> +
> +static void do_test(unsigned int i)
> +{
> +	verify_fn(i);
> +}
> +
> +static struct tst_test test = {
> +	.tid = "sched_setscheduler03",
> +	.tcnt = 3,

ARRAY_SIZE(cases)

Also needs_root seems to be missing here.

Regards,
Jan

> +	.test = do_test,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.forks_child = 1,
> +};
> +
> --
> 1.8.3.1
> 
> 
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
> 
