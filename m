Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD9B2C982D0
	for <ltp@archiver.kernel.org>; Thu, 17 Sep 2026 08:43:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4731B3E74E0
	for <ltp@archiver.kernel.org>; Thu, 17 Sep 2026 10:43:02 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 705153E259F
 for <ltp@lists.linux.it>; Thu, 17 Sep 2026 10:42:47 +0200 (CEST)
Received: from out28-217.mail.aliyun.com (out28-217.mail.aliyun.com
 [115.124.28.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7B1FD6009F7
 for <ltp@lists.linux.it>; Thu, 17 Sep 2026 10:42:45 +0200 (CEST)
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.09567141|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_regular_dialog|0.0891847-0.000859136-0.909956;
 FP=2722595077987456693|0|0|0|0|-1|-1|-1; HT=maildocker-contentspam011083013073;
 MF=yehuaisheng@open-hieco.net; NM=1; PH=DS; RN=4; RT=4; SR=0;
 TI=SMTPD_---.jFktIpr_1789634560; 
Received: from 172.18.22.180(mailfrom:yehuaisheng@open-hieco.net
 fp:SMTPD_---.jFktIpr_1789634560 cluster:ay29) by smtp.aliyun-inc.com;
 Thu, 17 Sep 2026 16:42:42 +0800
Message-ID: <59881bfe-d060-4c7d-ac5d-9bdc4ba4f678@open-hieco.net>
Date: Thu, 17 Sep 2026 16:42:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: tsahu@linux.ibm.com, pvorel@suse.cz, ltp@lists.linux.it, li.wang@linux.dev
References: <20260914032359.9956-1-yehuaisheng@open-hieco.net>
 <aqpX1P1bNIEol4yt@linux.dev> <aqpjZsOCq-jDfks_@linux.dev>
From: Huaisheng Ye <yehuaisheng@open-hieco.net>
In-Reply-To: <aqpjZsOCq-jDfks_@linux.dev>
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] hugemmap10: Account for memory policy in counter
 checks
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>



On 9/16/2026 17:37, Li Wang wrote:
>> Aside from this patch, my test encountered new failures on a four-node system.
>> Without your patch, the surplus failure can be reproduced consistently, so I
>> suspect it's a different issue.
>>
>> ...
>> hugemmap10.c:402: TFAIL: While doing munmap shared after touch: Bad HugePages_Total: expected 1, actual 2
>> hugemmap10.c:402: TFAIL: While doing munmap shared after touch: Bad HugePages_Free: expected 1, actual 2
>> hugemmap10.c:402: TFAIL: While doing munmap shared after touch: Bad HugePages_Surp: expected 0, actual 1
> The test system has four nodes, and only nodes 0 and 2 have memory.
> I guess that's what caused the failure when running hugemmap10 during
> hugepage allocation.
>
> Something like this:
>
> 1. The test pre-allocates 1 hugepage, which defaults to Node 0.
>
> 2. When the test runs on Node 2, the kernel dynamically creates a surplus
>     hugepage on Node 2 to ensure local memory performance.
>
> 3. The global hugepage count becomes 2 (1 on Node 0 + 1 surplus on Node 2).
>
> 4. The test expects exactly 1 global hugepage, so it reports a failure.
>
> Below are the test results from patched-hugemmap10 on patched-kernel-6.6.
> I'll do more investigation tomorrow.

Yes, I can reproduce it with stable kernel v6.6.145. However, after backporting
commit d0f14f7ee0e2 ("hugetlb: prioritize surplus allocation from current node"),
the issue is resolved.

Commit d0f14f7ee0e2 was designed to fix the side effect of commit 003af997c8a9,
which had been backported to v6.6 stable to ensure that surplus huge pages come
from mempolicy-allowed nodes.

So you could try v6.6 stable with d0f14f7ee0e2 applied, or upstream v7.3-rc.

Kind Regards,
Huaisheng Ye



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
