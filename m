Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28453C6FA86
	for <ltp@archiver.kernel.org>; Thu, 15 Sep 2022 09:54:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F3EAB3CAC10
	for <ltp@archiver.kernel.org>; Thu, 15 Sep 2022 11:54:00 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D09EB3CABA8
 for <ltp@lists.linux.it>; Thu, 15 Sep 2022 11:53:49 +0200 (CEST)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0DA11140098B
 for <ltp@lists.linux.it>; Thu, 15 Sep 2022 11:53:46 +0200 (CEST)
Received: from canpemm100006.china.huawei.com (unknown [172.30.72.54])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MSsqq5jFwz14QW3
 for <ltp@lists.linux.it>; Thu, 15 Sep 2022 17:49:43 +0800 (CST)
Received: from canpemm500005.china.huawei.com (7.192.104.229) by
 canpemm100006.china.huawei.com (7.192.104.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 15 Sep 2022 17:53:42 +0800
Received: from canpemm500005.china.huawei.com ([7.192.104.229]) by
 canpemm500005.china.huawei.com ([7.192.104.229]) with mapi id 15.01.2375.031; 
 Thu, 15 Sep 2022 17:53:42 +0800
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [LTP] [PATCH 1/2] syscalls/io_uring: Add .needs_kconfigs
Thread-Index: AdjI6QHNby2QWedrVEuqob+TZOCTjg==
Date: Thu, 15 Sep 2022 09:53:42 +0000
Message-ID: <47adc06460ed44c58b68f2555e941f68@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.110.209]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] syscalls/io_uring: Add .needs_kconfigs
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

The test broken on my system that kernel version is 5.10, and report:

io_uring01.c:82: TFAIL: io_uring_setup() failed: EOPNOTSUPP (95)

Maybe we can add checking of kconfig to report TCONF at first.


> Hi!
> > Add .needs_kconfigs for io_uring01.c/io_uring02.c.
> 
> We do call io_uring_supported_by_kernel() in the setup() of these tests
> so this shouldn't be needed at all. What is the problem you are trying to
> fix?
> 
> > Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
> > ---
> >  testcases/kernel/syscalls/io_uring/io_uring01.c | 4 ++++
> > testcases/kernel/syscalls/io_uring/io_uring02.c | 4 ++++
> >  2 files changed, 8 insertions(+)
> >
> > diff --git a/testcases/kernel/syscalls/io_uring/io_uring01.c
> > b/testcases/kernel/syscalls/io_uring/io_uring01.c
> > index 70151bb85..cb1cabcb7 100644
> > --- a/testcases/kernel/syscalls/io_uring/io_uring01.c
> > +++ b/testcases/kernel/syscalls/io_uring/io_uring01.c
> > @@ -261,6 +261,10 @@ static struct tst_test test = {
> >  	.test = run,
> >  	.needs_tmpdir = 1,
> >  	.tcnt = ARRAY_SIZE(tcases),
> > +	.needs_kconfigs = (const char *const[]){
> > +		"CONFIG_IO_URING=y",
> > +		NULL
> > +	},
> >  	.bufs = (struct tst_buffers []) {
> >  		{&iov, .iov_sizes = (int[]){BLOCK_SZ, -1}},
> >  		{}
> > diff --git a/testcases/kernel/syscalls/io_uring/io_uring02.c
> > b/testcases/kernel/syscalls/io_uring/io_uring02.c
> > index c5c770074..c7ea87ae5 100644
> > --- a/testcases/kernel/syscalls/io_uring/io_uring02.c
> > +++ b/testcases/kernel/syscalls/io_uring/io_uring02.c
> > @@ -255,6 +255,10 @@ static struct tst_test test = {
> >  		TST_CAP(TST_CAP_REQ, CAP_SYS_CHROOT),
> >  		{}
> >  	},
> > +	.needs_kconfigs = (const char *const[]){
> > +		"CONFIG_IO_URING=y",
> > +		NULL
> > +	},
> >  	.tags = (const struct tst_tag[]) {
> >  		{"linux-git", "9392a27d88b9"},
> >  		{"linux-git", "ff002b30181d"},
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
