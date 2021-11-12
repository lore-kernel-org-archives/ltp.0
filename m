Return-Path: <SRS0=aRd5=P7=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBAC7C433F5
	for <ltp@archiver.kernel.org>; Fri, 12 Nov 2021 16:16:39 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1ACC360FBF
	for <ltp@archiver.kernel.org>; Fri, 12 Nov 2021 16:16:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1ACC360FBF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4608F3C8110
	for <ltp@archiver.kernel.org>; Fri, 12 Nov 2021 17:16:36 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 843A73C0E89
 for <ltp@lists.linux.it>; Fri, 12 Nov 2021 17:16:26 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 879511A017DB
 for <ltp@lists.linux.it>; Fri, 12 Nov 2021 17:16:25 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 5B1561FD5B;
 Fri, 12 Nov 2021 16:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1636733784;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ApfXHCMbh7c3oSifoDQqB4OkDY2YF3//uRo/XbLH+bQ=;
 b=mUAuh5Kb7W7QQUFCccO0ykWnrrCuKeYJJu6Ueyl9BwEgfRKVjz6dh+WxVqdMJHMDEoEEec
 RRsbn3RTDZLjSz5ivfvi2qUrgKtx7O0QWmrGd2pS7RAPV+cr4nUqnrT6j9SoU+0vDj2ZnO
 IQHGhoo9Fijlx0HFGlGJ7UkTIpq1UV8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1636733784;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ApfXHCMbh7c3oSifoDQqB4OkDY2YF3//uRo/XbLH+bQ=;
 b=NpxxEDCNCBTpPieRKpk1iXziNZU5VsQRl8+jGccAHxx5D0GxELM9QZoXWn1IBLITFNJLdR
 qq5wrnDWuP4/UHBQ==
Received: from g78 (unknown [10.163.24.38])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id EBF27A3B81;
 Fri, 12 Nov 2021 16:16:23 +0000 (UTC)
References: <20190726081926.8250-1-camann@suse.com>
 <20200207111028.GA19508@rei.lan>
User-agent: mu4e 1.6.9; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 12 Nov 2021 14:19:33 +0000
In-reply-to: <20200207111028.GA19508@rei.lan>
Message-ID: <875ysxe4dp.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] syscalls/ioprio: Add functional test case
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
Reply-To: rpalethorpe@suse.de
Cc: Christian Amann <camann@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
>> ---
>> 
>> Notes:
>>     This patch was written to be aplicable after the current test
>>     cases from Linus Walleij on the mailing list were corrected
>>     and applied. (That means, putting the runtest entires in place,
>>     moving the syscall function to the "ioprio.h" file, etc.)
>>     Slight adjustment could be necessary, though.
>> 
>>  runtest/syscalls                                |   1 +
>>  testcases/kernel/syscalls/ioprio/.gitignore     |   1 +
>>  testcases/kernel/syscalls/ioprio/Makefile       |   2 +
>>  testcases/kernel/syscalls/ioprio/ioprio_set03.c | 187 ++++++++++++++++++++++++
>>  4 files changed, 191 insertions(+)
>>  create mode 100644 testcases/kernel/syscalls/ioprio/ioprio_set03.c
>> 
>> diff --git a/runtest/syscalls b/runtest/syscalls
>> index 20e4ef0f5..2c205ae8e 100644
>> --- a/runtest/syscalls
>> +++ b/runtest/syscalls
>> @@ -543,6 +543,7 @@ ioprio_get01 ioprio_get01
>>  
>>  ioprio_set01 ioprio_set01
>>  ioprio_set02 ioprio_set02
>> +ioprio_set03 ioprio_set03
>>  
>>  iopl01 iopl01
>>  iopl02 iopl02
>> diff --git a/testcases/kernel/syscalls/ioprio/.gitignore b/testcases/kernel/syscalls/ioprio/.gitignore
>> index 890081d8c..373079bf2 100644
>> --- a/testcases/kernel/syscalls/ioprio/.gitignore
>> +++ b/testcases/kernel/syscalls/ioprio/.gitignore
>> @@ -1,3 +1,4 @@
>>  ioprio_get01
>>  ioprio_set01
>>  ioprio_set02
>> +ioprio_set03
>> diff --git a/testcases/kernel/syscalls/ioprio/Makefile b/testcases/kernel/syscalls/ioprio/Makefile
>> index 5ea7d67db..647d296ca 100644
>> --- a/testcases/kernel/syscalls/ioprio/Makefile
>> +++ b/testcases/kernel/syscalls/ioprio/Makefile
>> @@ -4,3 +4,5 @@ top_srcdir		?= ../../../..
>>  
>>  include $(top_srcdir)/include/mk/testcases.mk
>>  include $(top_srcdir)/include/mk/generic_leaf_target.mk
>> +
>> +ioprio_set03: CFLAGS += -pthread
>> diff --git a/testcases/kernel/syscalls/ioprio/ioprio_set03.c b/testcases/kernel/syscalls/ioprio/ioprio_set03.c
>> new file mode 100644
>> index 000000000..333723b3a
>> --- /dev/null
>> +++ b/testcases/kernel/syscalls/ioprio/ioprio_set03.c
>> @@ -0,0 +1,187 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (c) 2019 SUSE LLC
>> + * Author: Christian Amann <camann@suse.com>
>> + */
>> +/*
>> + * Functional test to see if the I/O priority set with ioprio_set(2)
>> + * has an effect when writing to files.
>> + *
>> + * In order to do so, this test mounts a loop device for which the
>> + * I/O scheduler is set to either 'bfq' or 'cfq'. Then two write
>>  threads

How many threads do loop devices support though? If they support more
than one thread (likely one per CPU) then there is no contention in this
test. Also it's easier to use processes instead of threads for this in
LTP IMO.

>> + * are started which both simultaneusly write to a file each. One thread
>> + * is set to IDLE priority while the other is set to BE.
>> + * If the thread with the higher I/O priority writes at least 10% more
>> + * to its file, the test is successful.

I think this is likely to suffer from non-determinism and scheduler
configs as 10% is arbitrary. By default we probably should just ensure
that the lower priority process never writes more.

>> + */
>> +
>> +#define _GNU_SOURCE
>> +
>> +#include <malloc.h>
>> +#include <pthread.h>
>> +#include <stdlib.h>
>> +#include <time.h>
>> +#include <unistd.h>
>> +#include <sys/types.h>
>> +#include "tst_safe_pthread.h"
>> +#include "tst_test.h"
>> +#include "ioprio.h"
>> +
>> +#define MNTPOINT	"MNTPOINT"
>> +#define FILE1		MNTPOINT"/file1"
>> +#define FILE2		MNTPOINT"/file2"
>> +#define CHUNKSIZE	(blksize > 8192 ? blksize : 8192) /* Bytes */
>
> Having macros that reference variables that were not passed as
> parameters is considered a bad practice.
>
> Why can't we have global chunksize variable that would be set up in
> setup based on this calculation instead?
>
>> +#define IOTIME		(2)	/* Seconds */
>> +
>> +#define SCHED_TEMPLATE	"/sys/block/%s/queue/scheduler"
>> +
>> +static blksize_t blksize;
>> +
>> +static struct thread_data {
>> +	int		fd;
>> +	pthread_t	thread;
>> +	long		prio;
>> +	int		writes;
>> +	char		*out_buf;
>> +} tdata[2];
>> +
>> +static void set_io_scheduler(const char *device_name)
>> +{
>> +	int fd;
>> +	unsigned int i;
>> +	const char * const schedulers[] = {"bfq", "cfq"};
>> +	const char *used_scheduler = NULL;
>> +	char avail_schedulers[256];
>> +	char sched_path[256];
>> +
>> +	sprintf(sched_path, SCHED_TEMPLATE, device_name);
>
> This has the very same problem as we have fixed in:
>
> commit 70766c8f6f9d164057396c8d40a2575903f97efa
> Author: Cyril Hrubis <chrubis@suse.cz>
> Date:   Wed Jan 8 14:48:07 2020 +0100
>
>     tst_device: Scan /sys/block/* for stat file
>
>
> I guess that we should change the find_stat_file() function to a more
> generic one that would take a last bits of a path and return whole sysfs
> path for a given device, i.e.
>
> int tst_dev_get_sysfs(const char *dev, char *path, size_t path_len, const char *sysfile);
>
>
> Then we would call it here with:
>
> if (tst_dev_get_sysfs(tst_device->dev, sched_path, sizeof(sched_path), "queue/scheduler"))
> 	tst_brk(TBROK, "Cannot find sysfs file for scheduller");
>
>
>> +	fd = SAFE_OPEN(sched_path, O_RDWR);
>> +
>> +	SAFE_READ(0, fd, avail_schedulers, 255);
>> +	avail_schedulers[255] = '\0';
>> +
>> +	/* Check if right I/O schedulers are available */
>> +	for (i = 0; i < ARRAY_SIZE(schedulers); ++i) {
>> +		if (strstr(avail_schedulers, schedulers[i]))
>> +			used_scheduler = schedulers[i];
>> +	}
>> +	if (!used_scheduler)
>> +		tst_brk(TCONF, "Needed I/O schedulers are not available");
>> +
>> +	/* Set I/O scheduler */
>> +	TEST(write(fd, used_scheduler, sizeof(used_scheduler)));
>> +	if (TST_RET < 0)
>> +		tst_brk(TBROK | TTERRNO, "Could not set I/O scheduler");
>> +
>> +	SAFE_CLOSE(fd);
>> +
>> +	tst_res(TINFO, "Set I/O scheduler to '%s'", used_scheduler);
>> +	if (TST_RET < 0)
>> +		tst_brk(TBROK | TTERRNO, "Could not set I/O scheduler");
>
> Shouldn't be the order of these two messages reversed? Otherwise if we
> fail at close both would be printed which would be a bit confusing.
>
>> +}
>> +
>> +static void *io_thread(void *arg)
>> +{
>> +	long thread_num = (long) arg;
>> +	int ret;
>> +
>> +	ret = sys_ioprio_set(IOPRIO_WHO_PROCESS, 0, tdata[thread_num].prio);
>> +	if (ret == -1)
>> +		tst_brk(TBROK || TTERRNO, "ioprio_set() failed");
>> +
>> +	ret = sys_ioprio_get(IOPRIO_WHO_PROCESS, 0);
>> +	if (ret != tdata[thread_num].prio)
>> +		tst_brk(TBROK, "ioprio_set() set wrong priority");
>> +
>> +	/* align to blocksize for O_DIRECT writes */
>> +	tdata[thread_num].out_buf = SAFE_MEMALIGN(blksize, CHUNKSIZE);
>> +	memset(tdata[thread_num].out_buf, 'X', CHUNKSIZE);
>
> Shouldn't we allocate and free these buffers in setup/cleanup?
>
>> +	tdata[thread_num].writes = 0;
>> +	while (1) {
>> +		SAFE_WRITE(1, tdata[thread_num].fd,
>> +				tdata[thread_num].out_buf, CHUNKSIZE);
>> +		tdata[thread_num].writes++;
>> +		if (tdata[thread_num].writes % 1000 == 0)
>> +			SAFE_LSEEK(tdata[thread_num].fd, 0, SEEK_SET);
>> +	}
>> +
>> +	return arg;
>> +}
>> +
>> +static void verify_ioprio(void)
>> +{
>> +	long i;
>> +	time_t time_started, time_spent = 0;
>> +
>> +	pthread_setcancelstate(PTHREAD_CANCEL_ENABLE, NULL);
>> +
>> +	for (i = 0; i < 2; i++) {
>> +		SAFE_PTHREAD_CREATE(&tdata[i].thread, NULL,
>> +					io_thread, (void *) i);
>> +	}
>> +
>> +	time_started = time(NULL);
>> +	while (time_spent < IOTIME) {
>> +		time_spent = time(NULL) - time_started;
>> +		usleep(10000);
>> +	}
>
> We shoudn't use wall clock time for time mesurement, since these may
> change when ntp daemon is adjusting system time on background.
>
> We do have nice library functions on the top of monotonic timers, see:
>
> https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#2221-measuring-elapsed-time-and-helper-functions

Also now we have test time remaining in the library.

I think in general things have moved on quite a bit since this was
written. So considering the other issues as well, I will mark it as
rejected in patchwork. If anyone would like to pick this up please see
https://github.com/linux-test-project/ltp/issues/277

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
