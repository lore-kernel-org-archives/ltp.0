Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZPt1q-0006te-S9
	for ltp-list@lists.sourceforge.net; Thu, 13 Aug 2015 13:58:46 +0000
Received: from mx2.suse.de ([195.135.220.15])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZPt1n-000134-I9
	for ltp-list@lists.sourceforge.net; Thu, 13 Aug 2015 13:58:46 +0000
Date: Thu, 13 Aug 2015 15:58:14 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150813135813.GA9179@rei.suse.de>
References: <1439427926-7958-1-git-send-email-cuibixuan@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1439427926-7958-1-git-send-email-cuibixuan@huawei.com>
Subject: Re: [LTP] [PATCH] edf-scheduler/edf_test01: Add new testcase to
 test edf-sched
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Cui Bixuan <cuibixuan@huawei.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> +LDLIBS			+= -lpthread

This is wrong. You have to do:

CFLAGS += -pthread

instead othewise it will fail to compile on some distributions.

> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/sched/edf-scheduler/edf_test01.c b/testcases/kernel/sched/edf-scheduler/edf_test01.c
> new file mode 100644
> index 0000000..6c136c8
> --- /dev/null
> +++ b/testcases/kernel/sched/edf-scheduler/edf_test01.c
> @@ -0,0 +1,129 @@
> +#define _GNU_SOURCE
> +#include <unistd.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <time.h>
> +#include <linux/unistd.h>
> +#include <linux/kernel.h>
> +#include <linux/types.h>
> +#include <sys/syscall.h>
> +#include <pthread.h>
> +#include <sched.h> 
                     ^
		     Trailing whitespace.

Have you used checkpatch.pl to check the patch before sending?
(checkpatch.pl is shipped with Linux kernel sources)

> +#include <errno.h>
> +
> +#include "test.h"
> +
> +char *TCID = "edf_test01";
> +int TST_TOTAL = 1;
> +
> +#define gettid() syscall(__NR_gettid)

Even since this is not particulary harmful, can we use static inline
function instead?

> +#define SCHED_DEADLINE	6

This is defined in /usr/include/linux/sched.h, Why don't just include
the header.

> +/* XXX use the proper syscall numbers */
> +#ifdef __x86_64__
> +#define __NR_sched_setattr		314
> +#define __NR_sched_getattr		315
> +#endif
> +
> +#ifdef __i386__
> +#define __NR_sched_setattr		351
> +#define __NR_sched_getattr		352
> +#endif
> +
> +#ifdef __arm__
> +#define __NR_sched_setattr		380
> +#define __NR_sched_getattr		381
> +#endif

You should add these to the tables in testcases/kernel/include/,
regenerate them and include linux_syscall_numbers.h here.

> +struct sched_attr {
> +	__u32 size;
> +
> +	__u32 sched_policy;
> +	__u64 sched_flags;
> +
> +	/* SCHED_NORMAL, SCHED_BATCH */
> +	__s32 sched_nice;
> +
> +	/* SCHED_FIFO, SCHED_RR */
> +	__u32 sched_priority;
> +
> +	/* SCHED_DEADLINE (nsec) */
> +	__u64 sched_runtime;
> +	__u64 sched_deadline;
> +	__u64 sched_period;
> +};

Where is this structure from?

I can find it in manual page, so I guess that it's correct, but even
then it should be in include/lapi/sched.h and we should use userspace
types, i.e. uint32_t instead of __u32 (wich are glibc internal types if
I remeber correctly).

> +int sched_setattr(pid_t pid,
> +       	  const struct sched_attr *attr,
> +       	  unsigned int flags)
    ^
    Spaces before tabs.
> +{
> +	return syscall(__NR_sched_setattr, pid, attr, flags);
> +}
> +
> +int sched_getattr(pid_t pid,
> +       	  struct sched_attr *attr,
> +       	  unsigned int size,
> +       	  unsigned int flags)
    ^
    Here as well.
> +{
> +	return syscall(__NR_sched_getattr, pid, attr, size, flags);
> +}

These should go to the lapi/sched.h as well.

> +void *run_deadline(void* data)
> +{
> +	struct sched_attr attr, attr_copy;
> +	int ret;
> +	unsigned int flags = 0;
> +	unsigned int size;
> +
> +	attr.size = sizeof(attr);
> +	attr.sched_flags = 0;
> +	attr.sched_nice = 0;
> +	attr.sched_priority = 0;
> +
> +	/* This creates a 10ms/30ms reservation */
> +	attr.sched_policy = SCHED_DEADLINE;
> +	attr.sched_runtime = 10 * 1000 * 1000;
> +	attr.sched_period = 30 * 1000 * 1000;
> +	attr.sched_deadline = 30 * 1000 * 1000;
> +
> +	ret = sched_setattr(0, &attr, flags);
> +	if ( ret < 0) {
> +		printf("errno = %d, ret = %d\n", errno, ret);
> +		tst_brkm(TFAIL, NULL, "sched_setattr error\n");
                           ^
			   TFAIL | TERRNO here and remove the printf
			   before the tst_brkm()
> +	}
> +
> +	size = sizeof(attr_copy);
> +	ret = sched_getattr(0, &attr_copy, size, flags);
> +	if ( ret < 0) {
> +                printf("errno = %d, ret = %d\n", errno, ret);
> +        	tst_brkm(TFAIL, NULL, "sched_getattr error\n");

                Here a well.
> +	}
> +
> +	if ( (10000000 != attr_copy.sched_runtime) || 
> +		(30000000 != attr_copy.sched_period) || 
> +		(30000000 != attr_copy.sched_deadline) ) {
> +		tst_brkm(TFAIL, NULL, "edf_test01 failed\n");

                             Do not include name of the test in the
			     error message. It will be include there
			     in the test library.


			     Also split this if to three ifs and print
			     what exactly was different that we
			     expected. I.e.

	#define RUNTIME_VAL 10000000


	...

	int fail = 0;

	if (attr_copy.sched_runtime != RUNTIME_VAL) {
		tst_resm(TINFO, "sched_runtime is incorrect (%" PRIu64
		                ") expected %u", attr.sched_runtime,
				RUNTIME_VAL);
		fail++;
	}


	...


	if (fail)
		tst_resm(TFAIL, "attributes were read back incorrectly");
	else
		tst_resm(TPASS, "attributes were read back correctly");


> +	}

There are more trailing whitespaces and other unwanted whitespaces.

> +	return NULL;
> +}
> +
> +int main (int argc, char **argv)
> +{
> +	pthread_t thread;
> +
> +	if ((tst_kvercmp(3, 14, 0)) < 0) {
> +		tst_brkm(TCONF, NULL, "EDF needs kernel 3.14 or higher\n");
> +	}
> +
> +	pthread_create(&thread, NULL, run_deadline, NULL);
> +
> +	sleep(1);

Do not use sleep this way in testcases ever. The main thread will sleep
in the pthread_join() until the thread that does the test exits. This
will only slow the execution because it will wait 1 second even after
the test thread has finished allready.

> +	pthread_join(thread, NULL);
> +
> +	tst_resm(TPASS, "edf_test01 succeed");

Do not print PASS unconditionally here. The test should print TPASS only
if the testing passed.

> +	tst_exit();
> +}


Looking at the test it may be more suitable to be in
syscalls/sched_getattr/ directory, since it's not testing nothing more
than the syscalls can set and read back it's parameters.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
