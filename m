Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A482606A325
	for <ltp@archiver.kernel.org>; Wed, 18 Nov 2026 02:02:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6AD3D3EC332
	for <ltp@archiver.kernel.org>; Wed, 18 Nov 2026 03:02:34 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 68E463E2323
 for <ltp@lists.linux.it>; Wed, 18 Nov 2026 03:02:18 +0100 (CET)
Received: from out28-147.mail.aliyun.com (out28-147.mail.aliyun.com
 [115.124.28.147])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 479A26000F2
 for <ltp@lists.linux.it>; Wed, 18 Nov 2026 03:02:13 +0100 (CET)
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.1067066|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_system_inform|0.00818566-0.00032939-0.991485;
 FP=6501118265245922273|0|0|0|0|-1|-1|-1; HT=maildocker-contentspam033037071049;
 MF=yehuaisheng@open-hieco.net; NM=1; PH=DS; RN=4; RT=4; SR=0;
 TI=SMTPD_---.k4NUuW7_1794967328; 
Received: from 172.18.25.140(mailfrom:yehuaisheng@open-hieco.net
 fp:SMTPD_---.k4NUuW7_1794967328 cluster:ay29) by smtp.aliyun-inc.com;
 Wed, 18 Nov 2026 10:02:09 +0800
Message-ID: <c8a71028-339f-4a83-a4b9-dde95ce58117@open-hieco.net>
Date: Wed, 18 Nov 2026 10:02:08 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>
References: <20261116101559.93229-1-yehuaisheng@open-hieco.net>
 <avr8exdOSVwgjR3C@yuki.lan>
Content-Language: en-US
From: Huaisheng Ye <yehuaisheng@open-hieco.net>
In-Reply-To: <avr8exdOSVwgjR3C@yuki.lan>
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] hugemmap10: Add linux-git tag for NUMA fix
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>



On 11/16/2026 8:52 PM, Cyril Hrubis wrote:
> Hi!
>> +/*
>> + * This test also covers the NUMA regression fixed by Linux commit
>> + * 21f514ad520459fbfa58ccdf171bb68148c2f5aa. If free huge pages are outside
>> + * the nodes allowed by the task's cpuset or MPOL_BIND policy, hugetlb must
>> + * account for the allowed-node shortfall when gathering surplus pages.
>> + * Otherwise mmap() may fail with ENOMEM even when nr_overcommit_hugepages
>> + * permits allocating surplus pages on the allowed nodes.
>> + *
>> + * The issue can be exercised on a system with two or more NUMA nodes, for
>> + * example with:
>> + *
>> + *   numactl --cpunodebind=0 --membind=1 ./hugemmap10
> If nothing else, this text should be part of the doc comment just above
> it so that it's properly exported to documentation.
Got it.

> Also if the test needs to be bind to specific nodes to reproduce the
> problem, it would make sense (in a separate patch) to add a subtest to
> the test so that we can test it properly.
>
Noted for later action, thanks.

Huaisheng Ye

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
