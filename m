Return-Path: <SRS0=uAqx=PY=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D6DBC433F5
	for <ltp@archiver.kernel.org>; Fri,  5 Nov 2021 02:10:49 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3125960FC0
	for <ltp@archiver.kernel.org>; Fri,  5 Nov 2021 02:10:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3125960FC0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 632C23C7507
	for <ltp@archiver.kernel.org>; Fri,  5 Nov 2021 03:10:46 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5140D3C559D
 for <ltp@lists.linux.it>; Fri,  5 Nov 2021 03:10:36 +0100 (CET)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 40BE6200FC0
 for <ltp@lists.linux.it>; Fri,  5 Nov 2021 03:10:35 +0100 (CET)
Received: from dggeml758-chm.china.huawei.com (unknown [172.30.72.54])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HlkSS0s51zZcKT
 for <ltp@lists.linux.it>; Fri,  5 Nov 2021 10:08:24 +0800 (CST)
Received: from dggeml753-chm.china.huawei.com (10.1.199.152) by
 dggeml758-chm.china.huawei.com (10.1.199.159) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.15; Fri, 5 Nov 2021 10:10:31 +0800
Received: from dggeml753-chm.china.huawei.com ([10.1.199.152]) by
 dggeml753-chm.china.huawei.com ([10.1.199.152]) with mapi id 15.01.2308.015;
 Fri, 5 Nov 2021 10:10:30 +0800
From: zhaogongyi <zhaogongyi@huawei.com>
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [LTP] [PATCH] syscalls/epoll_create: Replace syscall to libc
Thread-Index: AdfR6i69w5TMtS/JRUe/AlEWhtx3gg==
Date: Fri, 5 Nov 2021 02:10:30 +0000
Message-ID: <9e996006298545a5b71fda3ebbd01fbd@huawei.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.110.209]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/epoll_create: Replace syscall to libc
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

It looks good for me and I have resubmit the patch, please see: https://patchwork.ozlabs.org/project/ltp/patch/20211105020729.162391-1-zhaogongyi@huawei.com/

Thanks so much!

Best Regards,
Gongyi

> Hi!
> > For epoll_create01.c/epoll_create02.c, we should replace syscall to
> > libc or the testcase will fail because of Syscall epoll_create is not
> > support in some arches.
> 
> I guess that epoll_create() is emulated via epoll_create1() in these cases
> right?
> 
> Does these testcases fail in these cases though? The __NR_epoll_create
> should be set to -1 when the syscall is not supported and the test should
> be skipped with TCONF.
> 
> The patch looks good, however it would be slightly better to add test
> variants so that we call both the raw syscall, if available, and the glibc
> wrapper, with something as:
> 
> 
> static int do_epoll_create(int size)
> {
> 	switch (tst_variant) {
> 	case 0:
> 		return tst_syscall(__NR_epoll_create, size);
> 	break;
> 	case 1:
> 		return epoll_create(size);
> 	break;
> }
> 
> static void run(unsigned int n)
> {
> 	TST_EXP_FD(do_epoll_create(tc[n]) ...);
> 
> 	...
> }
> 
> static void setup(void)
> {
> 	switch (tst_variant) {
> 	case 0:
> 		tst_res(TINFO, "Testing variant: syscall __NR_epoll_create");
> 	break;
> 	case 1:
> 		tst_res(TINFO, "Testing variant: libc epoll_create()");
> 	break;
> 	}
> }
> 
> static struct tst_test test = {
> 	...
> 	.test_variants = 2,
> 	...
> };
> 
> 
> > Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
> > ---
> >  testcases/kernel/syscalls/epoll_create/epoll_create01.c | 2 +-
> > testcases/kernel/syscalls/epoll_create/epoll_create02.c | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/testcases/kernel/syscalls/epoll_create/epoll_create01.c
> > b/testcases/kernel/syscalls/epoll_create/epoll_create01.c
> > index 3ef5b5cac..b6ebe9ad7 100644
> > --- a/testcases/kernel/syscalls/epoll_create/epoll_create01.c
> > +++ b/testcases/kernel/syscalls/epoll_create/epoll_create01.c
> > @@ -24,7 +24,7 @@ static int tc[] = {1, INT_MAX};
> >
> >  static void run(unsigned int n)
> >  {
> > -	TST_EXP_FD(tst_syscall(__NR_epoll_create, tc[n]), "epoll_create(%d)",
> tc[n]);
> > +	TST_EXP_FD(epoll_create(tc[n]), "epoll_create(%d)", tc[n]);
> >
> >  	if (!TST_PASS)
> >  		return;
> > diff --git a/testcases/kernel/syscalls/epoll_create/epoll_create02.c
> > b/testcases/kernel/syscalls/epoll_create/epoll_create02.c
> > index c59ea7944..e96228983 100644
> > --- a/testcases/kernel/syscalls/epoll_create/epoll_create02.c
> > +++ b/testcases/kernel/syscalls/epoll_create/epoll_create02.c
> > @@ -27,7 +27,7 @@ static struct test_case_t {
> >
> >  static void run(unsigned int n)
> >  {
> > -	TST_EXP_FAIL(tst_syscall(__NR_epoll_create, tc[n].size),
> > +	TST_EXP_FAIL(epoll_create(tc[n].size),
> >  		     tc[n].exp_err, "create(%d)", tc[n].size);  }
> >
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
