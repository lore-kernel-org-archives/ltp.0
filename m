Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB26DC43334
	for <ltp@archiver.kernel.org>; Thu, 23 Jun 2022 04:02:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 326303C9539
	for <ltp@archiver.kernel.org>; Thu, 23 Jun 2022 06:02:54 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 926CD3C67FA
 for <ltp@lists.linux.it>; Thu, 23 Jun 2022 06:02:42 +0200 (CEST)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8262A2009FA
 for <ltp@lists.linux.it>; Thu, 23 Jun 2022 06:02:38 +0200 (CEST)
Received: from canpemm100007.china.huawei.com (unknown [172.30.72.57])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LT63Y0fYWzhXWX
 for <ltp@lists.linux.it>; Thu, 23 Jun 2022 12:00:25 +0800 (CST)
Received: from canpemm500005.china.huawei.com (7.192.104.229) by
 canpemm100007.china.huawei.com (7.192.105.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 23 Jun 2022 12:02:33 +0800
Received: from canpemm500005.china.huawei.com ([7.192.104.229]) by
 canpemm500005.china.huawei.com ([7.192.104.229]) with mapi id 15.01.2375.024; 
 Thu, 23 Jun 2022 12:02:33 +0800
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [LTP] [PATCH v2] syscalls/nice05: Add testcase for nice() syscall
Thread-Index: AdiGGvkDpCkdBwF8TZWYRzHL3psAjw==
Date: Thu, 23 Jun 2022 04:02:33 +0000
Message-ID: <531492970f1746ffa966e77dbf0d14ac@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.110.209]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] syscalls/nice05: Add testcase for nice()
 syscall
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: zhaogongyi via ltp <ltp@lists.linux.it>
Reply-To: zhaogongyi <zhaogongyi@huawei.com>
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

Thanks for your review!

Best wishes,
Gongyi

> 
> Hi!
> > diff --git a/runtest/syscalls b/runtest/syscalls index
> > 88c31db06..a1f741d6a 100644
> > --- a/runtest/syscalls
> > +++ b/runtest/syscalls
> > @@ -901,6 +901,7 @@ nice01 nice01
> >  nice02 nice02
> >  nice03 nice03
> >  nice04 nice04
> > +nice05 nice05
> >
> >  open01 open01
> >  open01A symlink01 -T open01
> > diff --git a/testcases/kernel/syscalls/nice/.gitignore
> > b/testcases/kernel/syscalls/nice/.gitignore
> > index 9d7a1bb43..58d64779e 100644
> > --- a/testcases/kernel/syscalls/nice/.gitignore
> > +++ b/testcases/kernel/syscalls/nice/.gitignore
> > @@ -2,3 +2,4 @@
> >  /nice02
> >  /nice03
> >  /nice04
> > +/nice05
> > diff --git a/testcases/kernel/syscalls/nice/Makefile
> > b/testcases/kernel/syscalls/nice/Makefile
> > index 044619fb8..9b155295e 100644
> > --- a/testcases/kernel/syscalls/nice/Makefile
> > +++ b/testcases/kernel/syscalls/nice/Makefile
> > @@ -3,6 +3,11 @@
> >
> >  top_srcdir		?= ../../../..
> >
> > +LTPLIBS = ltpnewipc
> > +
> > +nice05: CFLAGS += -pthread
> > +nice05: LTPLDLIBS  += -lltpnewipc
> > +
> >  include $(top_srcdir)/include/mk/testcases.mk
> >
> >  include $(top_srcdir)/include/mk/generic_leaf_target.mk
> > diff --git a/testcases/kernel/syscalls/nice/nice05.c
> > b/testcases/kernel/syscalls/nice/nice05.c
> > new file mode 100644
> > index 000000000..cdaa96e97
> > --- /dev/null
> > +++ b/testcases/kernel/syscalls/nice/nice05.c
> > @@ -0,0 +1,196 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Copyright(c) 2022 Huawei Technologies Co., Ltd
> > + * Author: Li Mengfei <limengfei4@huawei.com>
> > + *         Zhao Gongyi <zhaogongyi@huawei.com>
> > + */
> > +
> > +/*\
> > + * [Description]
> > + *
> > + * 1. Create a high nice thread and a low nice thread, the main
> > + *    thread wake them at the same time
> > + * 2. Both threads run on the same CPU
> > + * 3. Verify that the low nice thread executes more time than
> > + *    the high nice thread
> > + */
> > +
> > +#define _GNU_SOURCE
> > +#include <pthread.h>
> > +#include <sys/types.h>
> > +#include <stdio.h>
> > +#include "tst_test.h"
> > +#include "tst_safe_pthread.h"
> > +#include "tst_safe_sysv_ipc.h"
> > +#include "lapi/syscalls.h"
> > +#include "libnewipc.h"
> > +
> > +static pthread_barrier_t barrier;
> > +static int some_cpu;
> > +static cpu_set_t *set;
> > +static pid_t *child_tid;
> > +static key_t shm_key;
> > +static int shm_id;
> > +
> > +static void set_nice(int nice_inc)
> > +{
> > +	int orig_nice;
> > +
> > +	orig_nice = SAFE_GETPRIORITY(PRIO_PROCESS, 0);
> 
> Why not just nice(0) ?

Nice(0) is ok, but there are no safe API for nice() now, so we need to add it?

> 
> > +	TEST(nice(nice_inc));
> > +
> > +	if (TST_RET != (orig_nice + nice_inc)) {
> > +		tst_brk(TFAIL | TTERRNO, "nice(%d) returned %li, expected %i",
> > +				nice_inc, TST_RET, orig_nice + nice_inc);
> 
> You cannot use tst_brk() with TFAIL unfortunatelly.
> 
> See: https://github.com/linux-test-project/ltp/issues/462
> 
> > +	}
> > +
> > +	if (TST_ERR)
> > +		tst_brk(TFAIL | TTERRNO, "nice(%d) failed", nice_inc);
> > +
> > +}
> > +
> > +static void *nice_low_thread(void *arg) {
> > +	int number = 0;
> 
> We may need to change the number to volatile in order to avoid for
> compiler being too smart about it's value.
> 

LGTM

> > +	int ret = 0;
> > +
> > +	child_tid[0] = tst_syscall(__NR_gettid);
> > +	set_nice(*(int *)arg);
> > +	ret = pthread_barrier_wait(&barrier);
> > +	if (ret != 0 && ret != PTHREAD_BARRIER_SERIAL_THREAD) {
> > +		tst_brk(TBROK, "pthread_barrier_wait() returned %s",
> > +				tst_strerrno(-ret));
> > +	}
> > +
> > +	while (1)
> > +		number++;
> > +
> > +	return NULL;
> > +}
> > +
> > +static void *nice_high_thread(void *arg) {
> > +	int number = 0;
> > +	int ret = 0;
> > +
> > +	child_tid[1] = tst_syscall(__NR_gettid);
> > +	set_nice(*(int *)arg);
> > +	ret = pthread_barrier_wait(&barrier);
> > +	if (ret != 0 && ret != PTHREAD_BARRIER_SERIAL_THREAD) {
> > +		tst_brk(TBROK, "pthread_barrier_wait() returned %s",
> > +				tst_strerrno(-ret));
> > +	}
> > +
> > +	while (1)
> > +		number++;
> > +
> > +	return NULL;
> > +}
> > +
> > +static void setup(void)
> > +{
> > +	size_t size;
> > +	int index;
> > +	int nrcpus = 1024;
> > +
> > +	set = CPU_ALLOC(nrcpus);
> > +	if (!set)
> > +		tst_brk(TBROK | TERRNO, "CPU_ALLOC()");
> > +
> > +	size = CPU_ALLOC_SIZE(nrcpus);
> > +	CPU_ZERO_S(size, set);
> > +	if (sched_getaffinity(0, size, set) < 0)
> > +		tst_brk(TBROK | TERRNO, "sched_getaffinity()");
> > +
> > +	for (index = 0; index < (int)size * 8; index++)
> > +		if (CPU_ISSET_S(index, size, set))
> > +			some_cpu = index;
> 
> Can we just use i instead of index? Also if you define the loop variable as
> size_t there would be no need for the cast.
> 

It seems more better.

> > +	CPU_ZERO_S(size, set);
> > +	CPU_SET_S(some_cpu, size, set);
> > +	if (sched_setaffinity(0, size, set) < 0)
> > +		tst_brk(TBROK | TERRNO, "sched_setaffinity()");
> > +
> > +	shm_key = GETIPCKEY();
> > +	shm_id = SAFE_SHMGET(shm_key, getpagesize(), 0666 | IPC_CREAT);
> > +	child_tid = SAFE_SHMAT(shm_id, 0, 0);
> 
> We can jdust do a single mmap() instead all of this. There is no need to
> bother with the IPC complexity since the forked child will simply have
> access to the shared memory mmaped by mmap(). Not to mention there
> are systems that does not have support for SysV IPC compiled in.
> 
It seems more better.


> > +}
> > +
> > +static void cleanup(void)
> > +{
> > +	if (set)
> > +		CPU_FREE(set);
> > +
> > +	if (child_tid)
> > +		SAFE_SHMDT(child_tid);
> > +
> > +	if (shm_id)
> > +		SAFE_SHMCTL(shm_id, IPC_RMID, 0);
> > +}
> > +
> > +static void verify_nice(void)
> > +{
> > +	int ret;
> > +	int nice_inc_high = -1;
> > +	int nice_inc_low = -2;
> > +	char buf[4096] = {0};
> > +	float sum_exec_runtime[2];
> > +	pthread_t nice_low, nice_high;
> > +	pid_t pid;
> > +
> > +	pid = SAFE_FORK();
> > +	if (!pid) {
> > +		ret = pthread_barrier_init(&barrier, NULL, 3);
> > +		if (ret != 0) {
> > +			tst_brk(TBROK, "pthread_barrier_init() returned %s",
> > +					tst_strerrno(-ret));
> > +		}
> > +
> > +		SAFE_PTHREAD_CREATE(&nice_high, NULL, nice_high_thread,
> > +				(void *)&nice_inc_high);
> > +		SAFE_PTHREAD_CREATE(&nice_low, NULL, nice_low_thread,
> > +				(void *)&nice_inc_low);
> 
> The usuall way how to pass an integer to a thread is to pass it by a value
> create with/casted to a correct size, we can for instance do:
> 
> 	intptr_t nice_inc_high = -1;
> 
> 
> 	pthread_create(...., (void*)nice_inc_high);
> 
> 
> 	And then cast it back to intptr_t int he thread function as:
> 
> 	set_nice((intptr_t)arg);
> 

It seems more better.


> > +		ret = pthread_barrier_wait(&barrier);
> > +		if (ret != 0 && ret != PTHREAD_BARRIER_SERIAL_THREAD) {
> > +			tst_brk(TBROK, "pthread_barrier_wait() returned %s",
> > +					tst_strerrno(-ret));
> > +		}
> > +
> > +		while (1)
> > +			sleep(1);
> 
> Maybe even better:
> 		while (1)
> 			pause();
> 
> As that would not wake up every second unnecessarily.
> 
> > +	} else {
> 
> There is no need for the else branch, the child process does not return
> from the if branch at all.
> 
> > +		sleep(3);
> 
> This has to be tied to runtime now, so the test has to:
> 
> - set .max_runtime = 3, in the tst_test structure
> - do sleep(tst_remaining_runtime()) here.
> 
> The bonus point is that you can then change for how long the sampling
> runs with the -I commandline parameter.
> 

Thanks for your suggestiones, it seems more better.


> > +		SAFE_KILL(pid, SIGSTOP);
> > +
> > +		sprintf(buf, "/proc/%d/sched", child_tid[0]);
> > +		SAFE_FILE_SCANF(buf, "%*s %*s %*s %*s %*s"
> > +				"%*s %*s %*f %*s %*s %*f %*s %*s %f",
> > +				&sum_exec_runtime[0]);
> > +
> > +		sprintf(buf, "/proc/%d/sched", child_tid[1]);
> > +		SAFE_FILE_SCANF(buf, "%*s %*s %*s %*s %*s"
> > +				"%*s %*s %*f %*s %*s %*f %*s %*s %f",
> > +				&sum_exec_runtime[1]);
> > +
> > +		if (sum_exec_runtime[0] < sum_exec_runtime[1]) {
> > +			tst_brk(TFAIL, "nice_low_thread sum_exec_runtime: %f "
> > +				"nice_high_thread sum_exec_runtime: %f",
> > +				sum_exec_runtime[0], sum_exec_runtime[1]);
> > +		} else {
> > +			tst_res(TPASS, "executes more cycles "
> > +				"than the high nice thread");
> > +		}
> > +
> > +		SAFE_KILL(pid, SIGKILL);
> > +		SAFE_WAIT(NULL);
> > +	}
> > +}
> > +
> > +static struct tst_test test = {
> > +	.setup = setup,
> > +	.cleanup = cleanup,
> > +	.test_all = verify_nice,
> > +	.needs_root = 1,
> > +	.forks_child = 1,
> > +};
> > --
> > 2.17.1
> >
> >
> > --
> > Mailing list info: https://lists.linux.it/listinfo/ltp
> 
> --
> Cyril Hrubis
> chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
