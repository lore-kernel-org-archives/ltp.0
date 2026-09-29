Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2D42CA5FA1
	for <ltp@archiver.kernel.org>; Tue, 29 Sep 2026 02:20:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D7BE83E5EBD
	for <ltp@archiver.kernel.org>; Tue, 29 Sep 2026 04:20:37 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C34AA3C2804
 for <ltp@lists.linux.it>; Tue, 29 Sep 2026 04:20:21 +0200 (CEST)
Received: from out28-2.mail.aliyun.com (out28-2.mail.aliyun.com [115.124.28.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id CFF6D1400DD6
 for <ltp@lists.linux.it>; Tue, 29 Sep 2026 04:20:18 +0200 (CEST)
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07198837|-1; CH=green;
 DM=|CONTINUE|false|; DS=CONTINUE|ham_alarm|0.0260218-0.0164822-0.957496;
 FP=2698386587974718701|0|0|0|0|-1|-1|-1; HT=maildocker-contentspam033045220102;
 MF=yehuaisheng@open-hieco.net; NM=1; PH=DS; RN=3; RT=3; SR=0;
 TI=SMTPD_---.jQhwok1_1790648395; 
Received: from 172.18.25.140(mailfrom:yehuaisheng@open-hieco.net
 fp:SMTPD_---.jQhwok1_1790648395 cluster:ay29) by smtp.aliyun-inc.com;
 Tue, 29 Sep 2026 10:20:14 +0800
Message-ID: <8627a28b-4110-4532-9c5c-5d5aa4915dbb@open-hieco.net>
Date: Tue, 29 Sep 2026 10:19:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linuxtestproject.agent@gmail.com
References: <20260914032359.9956-1-yehuaisheng@open-hieco.net>
 <20260914120303.4213-1-linuxtestproject.agent@gmail.com>
Content-Language: en-US
From: Huaisheng Ye <yehuaisheng@open-hieco.net>
In-Reply-To: <20260914120303.4213-1-linuxtestproject.agent@gmail.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] hugemmap10: Account for memory policy in counter checks
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
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>



On 9/14/2026 8:03 PM, linuxtestproject.agent@gmail.com wrote:
> Hi Huaisheng,
>
> On Mon Sep 14 11:23:59 2026 +0800, Huaisheng Ye wrote:
>> hugemmap10: Account for memory policy in counter checks
>> Note that a kernel patch has already been posted for solving Hugetlb
>> reservations defect. Without that, hugemmap10 would fail when mapping .
>> https://lore.kernel.org/all/20260909074642.7308-1-yehuaisheng@open-hieco.net/
> The referenced kernel patch is not merged in mainline or the latest stable
> release (7.3). Tests depending on unmerged kernel changes must use the
> [STAGING] prefix and reside in runtest/staging rather than modifying
> tests in default test suites.

It has been merged to AKPM's mm-new branch only.
https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?h=mm-new&id=506f9bf248c092fc80df046f9deb26094ea84592

>> +static int node_isset(unsigned long node, const unsigned long *nodemask)
>> +{
>> +	return nodemask[node / ULONG_BITS] & (1UL << (node % ULONG_BITS));
>> +}
> On 64-bit systems, the return value truncates to a 32-bit int, yielding 0
> for any node with (node % 64) >= 32. Return !!(...) instead.
Fixed that in V2.

>> +		if ((unsigned long)hpages > allowed_free)
>> +			shortfall = MAX(shortfall,
>> +					(unsigned long)hpages - allowed_free);
> allowed_free sums sysfs free_hugepages, which includes pages already
> reserved by prior mappings. Comparing hpages against allowed_free without
> accounting for reservations on those nodes undercalculates the shortfall
> when prior reservations exist.

That is intended to verify that the requested hugepages cannot be
satisfied by the nodes allowed by the memory policy based on currently
available hugepages.

However, free_hugepages exported via sysfs does include hugepages that
may already be reserved by existing mappings. Therefore
(hpages - allowed_free) cannot provide an exact reservation availability
calculation. So take the larger value of the global_shortfall and
allowed_shortfall, that is taking into account the global reservation.

This is a best-effort check based on per-node free hugepages rather than
exact reservation accounting. And based on our observations that is enough
for LTP testcase hugemmap10.

A fully accurate check would require per-node reservation information,
which is not available from sysfs.

Furthermore, I believe the fundamental reason lies in the lazy page 
allocation
principle of MM. Only when page-fault time can the MM determine hugepage
originates from which nodes. So Kernel is unable to provide Per-node
reservation in multi-node numa system.

Huaisheng Ye



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
