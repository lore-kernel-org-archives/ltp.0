Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E691FC44517
	for <ltp@archiver.kernel.org>; Fri, 17 Jul 2026 07:37:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3714C3E24E6
	for <ltp@archiver.kernel.org>; Fri, 17 Jul 2026 09:37:32 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 09BF63C9911
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 09:37:15 +0200 (CEST)
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com
 [91.218.175.170])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 014B92009EF
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 09:37:14 +0200 (CEST)
Date: Fri, 17 Jul 2026 15:36:51 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1784273832;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6Ai0IU+avXMPn0Yi59Q3ycnq8b/Ykoppu7Cokinlqjw=;
 b=kQNf14NPuSbd0v4z44w5+miND/eYJ5eTSimvPSl2wmli2n/c013vqte0rMC9Z/XZ13V033
 8DzcyVskHw2AJPeqyLGrZaZQQ8iEIx70yflmAc/IIkSc9Mevuic911aFvLE8niuheAdkuJ
 U+cRGw51cu/uEhCUfOusze+UYhOgbRw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Li Wang <li.wang@linux.dev>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <alnbk-wNqcenHl2S@linux.dev>
Mail-Followup-To: Andrea Cervesato <andrea.cervesato@suse.de>,
 Linux Test Project <ltp@lists.linux.it>
References: <20260717-fix_tst_test_hugepages-v1-1-a63bf2ccdd17@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260717-fix_tst_test_hugepages-v1-1-a63bf2ccdd17@suse.com>
X-Migadu-Flow: FLOW_OUT
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] hugepages: ensure CONFIG_COMPACTION is defined
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

> From: Andrea Cervesato <andrea.cervesato@suse.com>

> --- a/lib/tst_hugepage.c
> +++ b/lib/tst_hugepage.c
> @@ -46,6 +46,11 @@ unsigned long tst_reserve_hugepages(struct tst_hugepage *hp)
>  		goto set_hugepages;
>  	}
>  
> +	if (access(PATH_VM_COMPACT_MEMORY, F_OK)) {
> +		if (hp->policy == TST_NEEDS || hp->policy == TST_REQUEST)
> +			tst_brk(TCONF, "CONFIG_COMPACTION not enabled in kernel");
> +	}
> +

Thanks for the patch. I think the goal is reasonable, but I'd
push back on the core assumption: compact_memory is not actually
required to reserve hugepages.

Writing 1 to /proc/sys/vm/compact_memory only triggers proactive
memory compaction. It's a best-effort hint that makes a hugepage
reservation more likely to succeed by defragmenting memory
beforehand, but the reservation itself does not depend on it.

The kernel can (and often will) still satisfy the request without
any explicit compaction step. So treating a missing compact_memory
(i.e. CONFIG_COMPACTION=n) as a hard TCONF is too strict: it skips
tests that could otherwise run perfectly fine.

Given that, I don't think we should tst_brk(TCONF) here at all.
My suggetion is not to use SAFE_* macros:

--- a/lib/tst_hugepage.c
+++ b/lib/tst_hugepage.c
@@ -47,7 +47,7 @@ unsigned long tst_reserve_hugepages(struct tst_hugepage *hp)
        }
 
        SAFE_FILE_PRINTF(PATH_VM_DROP_CACHES, "3");
-       SAFE_FILE_PRINTF(PATH_VM_COMPACT_MEMORY, "1");
+       FILE_PRINTF(PATH_VM_COMPACT_MEMORY, "1");
        if (hp->policy == TST_NEEDS) {
                tst_hugepages += SAFE_READ_MEMINFO("HugePages_Total:");
                goto set_hugepages;


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
