Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BB5FC4332F
	for <ltp@archiver.kernel.org>; Tue, 20 Dec 2022 12:49:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8B3C53CBA5A
	for <ltp@archiver.kernel.org>; Tue, 20 Dec 2022 13:49:14 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 575A03CBA51
 for <ltp@lists.linux.it>; Tue, 20 Dec 2022 13:49:05 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 71242600758
 for <ltp@lists.linux.it>; Tue, 20 Dec 2022 13:49:04 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id C00A675F9C;
 Tue, 20 Dec 2022 12:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1671540543;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iaFL9F4a7iYDz8yFhITYmM3cKgZL3ZM4oiW7vV6xWEI=;
 b=dWKy93+IA6yShz1NGgRUkjP6EJV9lI72cDQZrlMjIBY0D4LCb02QQ7WKS/egLi0tSoQw+F
 JbASE0olIefsTxdrx4VnxPct4rsZkq7rBqBc5ogTN35VEaw+dj/u9eo7hzM7s5+Gdbk3e+
 4Q2lhxCrNmCAicbVIoRDkDmsTbjVAts=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1671540543;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iaFL9F4a7iYDz8yFhITYmM3cKgZL3ZM4oiW7vV6xWEI=;
 b=gHP4CJ9IqMZ3E459UudTddQNcgKfG+GhJHrIoKOBzyu/2c+CYudA9oyj99LJ93Z0eEJA3K
 2UL8BTBSYC/2JIAA==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 672BC2C141;
 Tue, 20 Dec 2022 12:49:03 +0000 (UTC)
References: <20221220063109.279007-1-tsahu@linux.ibm.com>
User-agent: mu4e 1.8.13; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Tarun Sahu <tsahu@linux.ibm.com>
Date: Tue, 20 Dec 2022 12:48:55 +0000
Organization: Linux Private Site
In-reply-to: <20221220063109.279007-1-tsahu@linux.ibm.com>
Message-ID: <875ye6tf41.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 0/8][PART 3] Hugetlb:Migrating the libhugetlbfs
 tests
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
Reply-To: rpalethorpe@suse.de
Cc: aneesh.kumar@linux.ibm.com, ltp@lists.linux.it, sbhat@linux.ibm.com,
 geetika@linux.ibm.com, vaibhav@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Merged, Thanks!

Tarun Sahu <tsahu@linux.ibm.com> writes:

> V2:
> 	1. Added linux bug fix commit tag in testcases.
> 	2. Asthetics changes in [PATCH 1/8].
> Hi,
> This patch series is in continuation to part [1] and part [2]
> This series include 8 more tests taken from libhugetlbfs.
>
> Background:
> Libhugetlbfs is not being maintained actively, and some distro is dropping
> support for it. There are some tests that are good for testing hugetlb
> functionality in kernel. These patches include tests from libhugetlbfs.
>
> ref:
>  1. https://lore.kernel.org/all/20221104162511.28658-1-tsahu@linux.ibm.com/
>  2. https://lore.kernel.org/all/20221120191533.164848-1-tsahu@linux.ibm.com/
>  3. https://lore.kernel.org/all/20221201120248.139396-1-tsahu@linux.ibm.com/
>
> Tarun Sahu (8):
>   Hugetlb: Migrating libhugetlbfs fork-cow
>   Hugetlb: Migrating libhugetlbfs huge_at_4GB_normal_below
>   Hugetlb: Migrating libhugetlbfs huge_below_4GB_normal_above
>   Hugetlb: Migrating libhugetlbfs icache-hygiene
>   Hugetlb: Migrating libhugetlbfs madvise_reserve
>   Hugetlb: Migrating libhugetlbfs map_high_truncate_2
>   Hugetlb: Migrating libhugetlbfs misalign
>   Hugetlb: Migrating libhugetlbfs misaligned_offset
>
>  runtest/hugetlb                               |   9 +
>  testcases/kernel/mem/.gitignore               |   8 +
>  .../kernel/mem/hugetlb/hugefork/Makefile      |  10 +
>  .../kernel/mem/hugetlb/hugefork/hugefork01.c  |  92 +++++++
>  .../kernel/mem/hugetlb/hugemmap/Makefile      |   1 +
>  .../kernel/mem/hugetlb/hugemmap/hugemmap13.c  | 126 +++++++++
>  .../kernel/mem/hugetlb/hugemmap/hugemmap14.c  | 159 ++++++++++++
>  .../kernel/mem/hugetlb/hugemmap/hugemmap15.c  | 243 ++++++++++++++++++
>  .../kernel/mem/hugetlb/hugemmap/hugemmap16.c  |  83 ++++++
>  .../kernel/mem/hugetlb/hugemmap/hugemmap17.c  | 103 ++++++++
>  .../kernel/mem/hugetlb/hugemmap/hugemmap18.c  | 153 +++++++++++
>  .../kernel/mem/hugetlb/hugemmap/hugemmap19.c  | 147 +++++++++++
>  12 files changed, 1134 insertions(+)
>  create mode 100644 testcases/kernel/mem/hugetlb/hugefork/Makefile
>  create mode 100644 testcases/kernel/mem/hugetlb/hugefork/hugefork01.c
>  create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap13.c
>  create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap14.c
>  create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap15.c
>  create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap16.c
>  create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap17.c
>  create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap18.c
>  create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap19.c
>
> -- 
> 2.31.1


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
