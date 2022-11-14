Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 840B8C4332F
	for <ltp@archiver.kernel.org>; Mon, 14 Nov 2022 11:13:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 734E43CD24A
	for <ltp@archiver.kernel.org>; Mon, 14 Nov 2022 12:13:44 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6DC033C2306
 for <ltp@lists.linux.it>; Mon, 14 Nov 2022 12:13:34 +0100 (CET)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5EBDA2005E7
 for <ltp@lists.linux.it>; Mon, 14 Nov 2022 12:13:33 +0100 (CET)
Received: from canpemm500006.china.huawei.com (unknown [172.30.72.56])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4N9mnB3Ys4zJnjM
 for <ltp@lists.linux.it>; Mon, 14 Nov 2022 19:10:22 +0800 (CST)
Received: from canpemm500005.china.huawei.com (7.192.104.229) by
 canpemm500006.china.huawei.com (7.192.105.130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 14 Nov 2022 19:13:28 +0800
Received: from canpemm500005.china.huawei.com ([7.192.104.229]) by
 canpemm500005.china.huawei.com ([7.192.104.229]) with mapi id 15.01.2375.031; 
 Mon, 14 Nov 2022 19:13:28 +0800
To: "rpalethorpe@suse.de" <rpalethorpe@suse.de>
Thread-Topic: Re[LTP] [PATCH] syscalls/sched_setscheduler04: new test for
 sched_setscheduler()
Thread-Index: Adj4Gho1BVH8bk7tQ6qY/MBojcV06w==
Date: Mon, 14 Nov 2022 11:13:28 +0000
Message-ID: <efc489b0b94a488c9c3c1dbc438da279@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.110.209]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Re [PATCH] syscalls/sched_setscheduler04: new test for
 sched_setscheduler()
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

Hi!

> > >> > +static void test_sched_setscheduler02(void) {
> >> > +	pthread_t tid;
> >> > +
> >> > +	SAFE_PTHREAD_CREATE(&tid, NULL, thread_func, NULL);
> >> > +	SAFE_PTHREAD_JOIN(tid, NULL);
> >> > +}
> >> > +
> >> > +
> >> > +static void run(void)
> >> > +{
> >> > +	sched_prio = sched_get_priority_min(SCHED_POLICY);
> >>
> >> This can go in the setup function.
> >
> > If move it to setup function, we run the test with option "-I 200", it
> > will fail.
> 
> Why?

sched_prio is a global variable, and it increase in any running loop, thus it will be out of range and report:

sched_setscheduler04.c:52: TPASS: param.sched_priority == sched_prio (99)
sched_setscheduler04.c:53: TPASS: new_policy == EXP_POLICY (1)
sched_setscheduler04.c:34: TINFO: Setting of tid: 70774
sched_setscheduler04.c:40: TBROK: sched_setscheduler(70774, 1, ...) failed: EINVAL (22)

Summary:
passed   196
failed   0
broken   1
skipped  0
warnings 0


> >
> >>
> >> > +
> >> > +	test_sched_setscheduler01();
> >> > +	test_sched_setscheduler02();
> >>
> >> This should be replaced with .tcnt = 2 and .test. or else just merge
> >> them into run.
> >
> > Agree, I will fix it int the next version.
> >
> >>
> >> > +}
> >> > +
> >> > +static struct tst_test test = {
> >> > +	.test_all = run,
> >>
> >> We probably need to ensure CAP_SYS_NICE. Full details are in 'man 7
> >> sched'
> >>
> >> i.e. .caps = (struct tst_cap[]) {
> >>   TST_CAP(TST_CAP_REQ, CAP_SYS_NICE),
> >>    null
> >> }
> >>
> >
> > In this testcase, we just increase the priority, should we add the checking
> of capability?
> 
> For the test to run we need CAP_SYS_NICE. If you want to test that the
> priority can only be set when CAP_SYS_NICE is available, then that is a
> seperate test in my opinion.

Anybody can call nice() to increase the priority, i have test it with normal user and passed.

And if decrease the priority, the test will report EPERM when running with normal user.

Regards,
Gongyi

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
