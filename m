Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DB22C4332F
	for <ltp@archiver.kernel.org>; Thu, 13 Oct 2022 14:03:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7EA623CAEE6
	for <ltp@archiver.kernel.org>; Thu, 13 Oct 2022 16:03:52 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4B30D3C1769
 for <ltp@lists.linux.it>; Thu, 13 Oct 2022 16:03:41 +0200 (CEST)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id DD3FC601A86
 for <ltp@lists.linux.it>; Thu, 13 Oct 2022 16:03:39 +0200 (CEST)
Received: from canpemm500006.china.huawei.com (unknown [172.30.72.53])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MpB2g4CfGzVhtn
 for <ltp@lists.linux.it>; Thu, 13 Oct 2022 21:59:07 +0800 (CST)
Received: from canpemm500005.china.huawei.com (7.192.104.229) by
 canpemm500006.china.huawei.com (7.192.105.130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 13 Oct 2022 22:03:35 +0800
Received: from canpemm500005.china.huawei.com ([7.192.104.229]) by
 canpemm500005.china.huawei.com ([7.192.104.229]) with mapi id 15.01.2375.031; 
 Thu, 13 Oct 2022 22:03:35 +0800
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH 2/2] needs_root: Add setting of needs_root
Thread-Index: AdjfDAz3OOLl4JFDQ5KrOFrJT18FrA==
Date: Thu, 13 Oct 2022 14:03:35 +0000
Message-ID: <56be207009104d16b9c49624db3c6f32@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.110.209]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

> 
> > Hi Petr,
> 
> > It is failed on my system:
> 
> > sh-4.4$ ./msgget03
> > tst_test.c:1535: TINFO: Timeout per run is 0h 00m 30s
> > msgget03.c:42: TINFO: Current environment 0 message queues are
> already
> > in use
> > msgget03.c:45: TBROK: Failed to open FILE '/proc/sys/kernel/msgmni'
> > for writing: EACCES (13)
> 
> Ah, b740bfac5 ("msgget03: Set custom queue limit") causes the need for
> root. IMHO this one is valid.
> 
> I'd suggest to remove needs_root for needs_device and mount_device
> now (i.e. send v2).

Just remove the patch 1 and keep adding needs_root in patch 2?

> 
> nit: FYI most of the people use bottom posting on mailing lists, you use top
> posting. Combine both makes it hard to follow.
> 
> https://en.wikipedia.org/wiki/Posting_style

Thanks for your reminder, I will reply to emails according to the posting_style.

> 
> Kind regards,
> Petr
> 
> 
> > Summary:
> > passed   0
> > failed   0
> > broken   1
> > skipped  0
> > warnings 0
> > tst_sys_conf.c:118: TWARN: Failed to open FILE
> '/proc/sys/kernel/msgmni'

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
