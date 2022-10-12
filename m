Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CECDC4332F
	for <ltp@archiver.kernel.org>; Wed, 12 Oct 2022 08:57:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 69B383CAEC4
	for <ltp@archiver.kernel.org>; Wed, 12 Oct 2022 10:57:14 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 16C733C9481
 for <ltp@lists.linux.it>; Wed, 12 Oct 2022 10:57:04 +0200 (CEST)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9ACF91A009B5
 for <ltp@lists.linux.it>; Wed, 12 Oct 2022 10:57:02 +0200 (CEST)
Received: from canpemm100007.china.huawei.com (unknown [172.30.72.54])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MnRGk3dxqzHtsF
 for <ltp@lists.linux.it>; Wed, 12 Oct 2022 16:51:58 +0800 (CST)
Received: from canpemm500005.china.huawei.com (7.192.104.229) by
 canpemm100007.china.huawei.com (7.192.105.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 12 Oct 2022 16:56:57 +0800
Received: from canpemm500005.china.huawei.com ([7.192.104.229]) by
 canpemm500005.china.huawei.com ([7.192.104.229]) with mapi id 15.01.2375.031; 
 Wed, 12 Oct 2022 16:56:57 +0800
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [LTP][PATCH v2 3/3] syscalls/madvise11: new test for
 madvise(MADV_DONTNEED)
Thread-Index: AdjeGBjF/OjhqEcrh0CIWgn17Kni8g==
Date: Wed, 12 Oct 2022 08:56:57 +0000
Message-ID: <50d81a53dcc5410287c35f99618ccb70@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.110.209]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/3] syscalls/madvise11: new test for
 madvise(MADV_DONTNEED)
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

Hi,

> 
> Hi!
> > +static void run(void)
> > +{
> > +	char cmd[BUF_SIZE];
> > +	char line[BUF_SIZE];
> > +	char vm_area_addr[128];
> > +
> > +	TEST(madvise(addr, MAP_SIZE, MADV_DONTNEED));
> > +	if (TST_RET == -1) {
> > +		tst_brk(TBROK | TTERRNO, "madvise(%p, %d, 0x%x)",
> > +			addr, MAP_SIZE, MADV_DONTNEED);
> > +	}
> > +
> > +	sprintf(vm_area_addr, "%p", addr);
> > +	sprintf(cmd,
> > +		"cat /proc/%d/smaps | grep %s -A 4 | grep Rss: | grep '0 kB'",
> > +		getpid(), &(vm_area_addr[2]));
> 
> This is way too ugly and may break easily too.
> 
> If we are going to parse the file we should do it properly in C instead.
> Why can't we just read the file line by line until we find the right address
> at the start of the line and once we do look for the Rss?


I have do it with C at first, but it seems not intuitive. I will change back on next version of the patch.

Regards,
Gongyi 


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
