Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EA86C32772
	for <ltp@archiver.kernel.org>; Tue, 23 Aug 2022 11:23:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2B0DB3CA31C
	for <ltp@archiver.kernel.org>; Tue, 23 Aug 2022 13:23:45 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8CA873C8854
 for <ltp@lists.linux.it>; Tue, 23 Aug 2022 13:23:32 +0200 (CEST)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id F17091000BD9
 for <ltp@lists.linux.it>; Tue, 23 Aug 2022 13:23:30 +0200 (CEST)
Received: from canpemm100005.china.huawei.com (unknown [172.30.72.57])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MBmwY3Ydnz1N7Wq
 for <ltp@lists.linux.it>; Tue, 23 Aug 2022 19:19:57 +0800 (CST)
Received: from canpemm500005.china.huawei.com (7.192.104.229) by
 canpemm100005.china.huawei.com (7.192.105.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 23 Aug 2022 19:23:25 +0800
Received: from canpemm500005.china.huawei.com ([7.192.104.229]) by
 canpemm500005.china.huawei.com ([7.192.104.229]) with mapi id 15.01.2375.024; 
 Tue, 23 Aug 2022 19:23:25 +0800
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [LTP][PATCH v3] syscalls/nice05: Add testcase for nice() syscall
Thread-Index: Adi24XRg8TqDqsz+RFygQxPcuwSkXw==
Date: Tue, 23 Aug 2022 11:23:25 +0000
Message-ID: <24ee4c2568554ad8957e1ed9b369dca7@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.110.209]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] syscalls/nice05: Add testcase for nice()
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

> Hi!
> > +static void verify_nice(void)
> > +{
> > +	intptr_t nice_inc_high = -1;
> > +	intptr_t nice_inc_low = -2;
> > +	char buf[4096] = {0};
> > +	float sum_exec_runtime[2];
> > +	pthread_t nice_low, nice_high;
> > +	pid_t pid;
> > +
> > +	pid = SAFE_FORK();
> > +	if (!pid) {
> > +		TEST(pthread_barrier_init(&barrier, NULL, 3));
> > +		if (TST_RET != 0) {
> > +			tst_brk(TBROK | TTERRNO,
> > +				"pthread_barrier_init() failed");
> > +		}
> > +
> > +		SAFE_PTHREAD_CREATE(&nice_high, NULL, nice_high_thread,
> > +			(void *)nice_inc_high);
> > +		SAFE_PTHREAD_CREATE(&nice_low, NULL, nice_low_thread,
> > +			(void *)nice_inc_low);
> > +
> > +		TEST(pthread_barrier_wait(&barrier));
> > +		if (TST_RET != 0 && TST_RET !=
> PTHREAD_BARRIER_SERIAL_THREAD) {
> > +			tst_brk(TBROK | TTERRNO,
> > +				"pthread_barrier_wait() failed");
> > +		}
> > +
> > +		while (1)
> > +			pause();
> > +	}
> > +
> > +	sleep(tst_remaining_runtime());
> > +	SAFE_KILL(pid, SIGSTOP);
> > +
> > +	sprintf(buf, "/proc/%d/sched", child_tid[0]);
> > +	SAFE_FILE_SCANF(buf, "%*s %*s %*s %*s %*s"
> > +			"%*s %*s %*f %*s %*s %*f %*s %*s %f",
> > +			&sum_exec_runtime[0]);
> > +
> > +	sprintf(buf, "/proc/%d/sched", child_tid[1]);
> > +	SAFE_FILE_SCANF(buf, "%*s %*s %*s %*s %*s"
> > +			"%*s %*s %*f %*s %*s %*f %*s %*s %f",
> > +			&sum_exec_runtime[1]);
> 
> The /proc/$PID/sched file is unfortunatelly only present if
> CONFIG_SCHED_DEBUG was set in the kernel, which is not always the case,
> and the test TBROKs on some of my testing targets.
> 
> Thinking of alternatives we can probably do clock_getcpuclockid() for the
> threads and read the counters with clock_gettime().

The kernel does not support obtaining the CPU-time clock of another process according to man 3,and it would retuen the error number of EFAULT.

And, pthread_getcpuclockid() also can not get the CPU-time of the thread belong to another process.

So, it looks a little tricky.

> 
> --
> Cyril Hrubis
> chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
