Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FF60C433FE
	for <ltp@archiver.kernel.org>; Wed, 26 Oct 2022 08:21:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D70CD3CA729
	for <ltp@archiver.kernel.org>; Wed, 26 Oct 2022 10:21:17 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C99663C0294
 for <ltp@lists.linux.it>; Wed, 26 Oct 2022 10:21:06 +0200 (CEST)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 65F161000A31
 for <ltp@lists.linux.it>; Wed, 26 Oct 2022 10:21:03 +0200 (CEST)
Received: from canpemm100005.china.huawei.com (unknown [172.30.72.57])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4My1sL3RpgzJnFV
 for <ltp@lists.linux.it>; Wed, 26 Oct 2022 16:18:14 +0800 (CST)
Received: from canpemm500005.china.huawei.com (7.192.104.229) by
 canpemm100005.china.huawei.com (7.192.105.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 26 Oct 2022 16:21:00 +0800
Received: from canpemm500005.china.huawei.com ([7.192.104.229]) by
 canpemm500005.china.huawei.com ([7.192.104.229]) with mapi id 15.01.2375.031; 
 Wed, 26 Oct 2022 16:21:00 +0800
To: "rpalethorpe@suse.de" <rpalethorpe@suse.de>
Thread-Topic: [LTP] [PATCH 2/2] syscalls/nice06: new test for nice()
Thread-Index: AdjpEgfrXdcJCepdSPGY4olv+BU0lg==
Date: Wed, 26 Oct 2022 08:21:00 +0000
Message-ID: <910b68cd082a4a8cb5d23db7fd90a8d7@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.110.209]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] syscalls/nice06: new test for nice()
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
> Hello,
> 
> Zhao Gongyi via ltp <ltp@lists.linux.it> writes:
> 
> > Verify that the errno is nonzero when callling of nice legitimately
> > return -1.
> 
> This does not require a separate test and EPERM is the only errno that is
> listed in the man page.
> 

This testcase is intentionally designed to test the errno is zero when callling of nice legitimately return -1,

For the other testcases of nice, return -1 will report TBROK, shall we need to add a test to check it ? 

Regards,
Gongyi

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
