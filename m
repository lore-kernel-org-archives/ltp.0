Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A18BC4332F
	for <ltp@archiver.kernel.org>; Fri, 14 Oct 2022 07:03:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 04B5D3CAF02
	for <ltp@archiver.kernel.org>; Fri, 14 Oct 2022 09:03:01 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 39AA03CADA7
 for <ltp@lists.linux.it>; Fri, 14 Oct 2022 09:02:51 +0200 (CEST)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 49946200DBB
 for <ltp@lists.linux.it>; Fri, 14 Oct 2022 09:02:48 +0200 (CEST)
Received: from canpemm500008.china.huawei.com (unknown [172.30.72.53])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Mpch425qzzpVyP;
 Fri, 14 Oct 2022 14:59:32 +0800 (CST)
Received: from canpemm500005.china.huawei.com (7.192.104.229) by
 canpemm500008.china.huawei.com (7.192.105.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 14 Oct 2022 15:02:45 +0800
Received: from canpemm500005.china.huawei.com ([7.192.104.229]) by
 canpemm500005.china.huawei.com ([7.192.104.229]) with mapi id 15.01.2375.031; 
 Fri, 14 Oct 2022 15:02:45 +0800
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH 2/2] needs_root: Add setting of needs_root
Thread-Index: Adjfmu2xGBWt4wJITsKsr4wxJodqjg==
Date: Fri, 14 Oct 2022 07:02:45 +0000
Message-ID: <d495451fa949461d80df25e7274bab51@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.110.209]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] needs_root: Add setting of needs_root
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>, Martin
 Doucha <martin.doucha@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

> Hi all,
> 
> > Hi,
> 
> 
> > > > > > Hi Petr,
> 
> > > > > > It is failed on my system:
> 
> > > > > > sh-4.4$ ./msgget03
> > > > > > tst_test.c:1535: TINFO: Timeout per run is 0h 00m 30s
> > > > > > msgget03.c:42: TINFO: Current environment 0 message queues
> are
> > > > > already
> > > > > > in use
> > > > > > msgget03.c:45: TBROK: Failed to open FILE
> > > '/proc/sys/kernel/msgmni'
> > > > > > for writing: EACCES (13)
> 
> > > > > Ah, b740bfac5 ("msgget03: Set custom queue limit") causes the
> > > > > need for root. IMHO this one is valid.
> 
> > > > > I'd suggest to remove needs_root for needs_device and
> > > mount_device
> > > > > now (i.e. send v2).
> 
> > > > Just remove the patch 1 and keep adding needs_root in patch 2?
> 
> > > If you haven't added it to any test which would have needs_device or
> > > mount_device, then v2 can be kept.
> 
> > > But process_vm_readv02 works for me (on master, on Debian) without
> > > root:
> 
> > > $ ./process_vm_readv02
> > > tst_test.c:1526: TINFO: Timeout per run is 0h 00m 30s
> > > process_vm_readv02.c:32: TINFO: child 0: memory allocated and
> > > initialized
> > > process_vm_readv02.c:49: TINFO: child 1: reading string from same
> > > memory location
> > > process_vm_readv02.c:61: TPASS: expected string received
> 
> > > Summary:
> > > passed   1
> > > failed   0
> > > broken   0
> > > skipped  0
> > > warnings 0
> 
> > > Also process_vm_readv03, process_vm_writev02 (I stopped checking
> > > now).
> 
> > > Why you need it?
> 
> 
> 
> > On my system, these testcases failed and report EPERM:
> 
> > sh-4.4$ ./process_vm_readv02
> OK, your system is Alpine (it can shorten our discussion next time if you
> report you have problems on musl - i.e. which kernel and libc + versions
> you use).

My system is base on kernel version 4.15.0 and glibc 2.27.

When I run the test on the kernel version 6.0 system with non-root, it is passed.

Regards,
Gongyi
 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
