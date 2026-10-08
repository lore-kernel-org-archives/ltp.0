Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70878CA600A
	for <ltp@archiver.kernel.org>; Thu,  8 Oct 2026 08:27:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 95AE23E2F9B
	for <ltp@archiver.kernel.org>; Thu,  8 Oct 2026 10:27:01 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 687443E2F51
 for <ltp@lists.linux.it>; Thu,  8 Oct 2026 10:26:46 +0200 (CEST)
Received: from mta0.migadu.com (out-115.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::73])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 55E25600A1C
 for <ltp@lists.linux.it>; Thu,  8 Oct 2026 10:26:45 +0200 (CEST)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=57VhLVKb88hn/0j/xJnOI0pUQ3LO1GXqjGeMhb9GrvI=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791448005; v=1; x=1792052805;
 b=fFJoAq/F5j5b8B2LMWW/iAUuSdIFgllP2hSaL6JiS/ykAJnFYQz+KrRgKUO/YIw3l6ATw34m
 qqetMLVOBlQBIka47Y2bu5CYH45sNYOadrtAoXJVmADnQO1CLll55REImdmFv9b5PtO+BVW05aL
 h9auhVtm0IYU7Q0sW+8jGpL0=
X-Envelope-To: ltp@lists.linux.it
Received: by smtp.migadu.com with ESMTPS id e525ee04a6977c51;
 Thu, 08 Oct 2026 08:26:45 +0000
X-Mizu-Trace-ID: e525ee04a6977c51
X-Migadu-Flow: FLOW_OUT
Date: Thu, 8 Oct 2026 16:26:39 +0800
From: Li Wang <li.wang@linux.dev>
To: Huaisheng Ye <yehuaisheng@open-hieco.net>
Message-ID: <asdTv0UIAtgrPLs3@linux.dev>
Mail-Followup-To: Huaisheng Ye <yehuaisheng@open-hieco.net>,
 chrubis@suse.cz, pvorel@suse.cz, ltp@lists.linux.it
References: <20260929072412.20979-1-yehuaisheng@open-hieco.net>
 <20260929072412.20979-2-yehuaisheng@open-hieco.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260929072412.20979-2-yehuaisheng@open-hieco.net>
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/3] hugemmap10: Account for memory policy in
 mmap counter checks
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Huaisheng Ye wrote:

> Expected surplus accounting for mappings that reserve at mmap() time only
> considers the global free and reserved hugepage counters. But sometimes,
> for instance with MPOL_BIND, globally free hugepages can reside outside
> nodes from which the task can allocate or plans to allocate. Hugetlb
> then creates surplus pages on allowed nodes, while the test expects
> no counter change.
> 
> For example, reproduce this on an eight-node system running 7.3.0-rc1:
> 
>     $ numactl --membind=0-3 ./hugemmap10
>     tst_hugepage.c:84: TINFO: 3 hugepage(s) reserved
>     ...
>     hugemmap10.c:386: TINFO: Base pool size: 0
>     hugemmap10.c:313: TINFO: Clean...
>     hugemmap10.c:364: TINFO: OK
>     hugemmap10.c:313: TINFO: Untouched, shared...
>     hugemmap10.c:364: TINFO: OK
>     hugemmap10.c:313: TINFO: Untouched, private...
>     hugemmap10.c:364: TINFO: OK
>     hugemmap10.c:313: TINFO: Touched, shared...
>     hugemmap10.c:364: TINFO: OK
>     hugemmap10.c:313: TINFO: Touched, private...
>     hugemmap10.c:364: TINFO: OK
>     hugemmap10.c:386: TINFO: Base pool size: 1
>     hugemmap10.c:313: TINFO: Clean...
>     hugemmap10.c:319: TFAIL: While doing mmap shared with no touch: Bad HugePages_Total: expected 1, actual 2
>     hugemmap10.c:319: TFAIL: While doing mmap shared with no touch: Bad HugePages_Free: expected 1, actual 2
>     hugemmap10.c:319: TFAIL: While doing mmap shared with no touch: Bad HugePages_Surp: expected 0, actual 1
> 
>     Summary:
>     passed   0
>     failed   3
>     broken   0
>     skipped  0
>     warnings 0
> 
>     $ numactl --membind=4-7 ./hugemmap10
>     ...
>     hugemmap10.c:364: TINFO: OK
>     hugemmap10.c:429: TPASS: Hugepages Counters works as expected.
> 
>     Summary:
>     passed   1
>     failed   0
>     broken   0
>     skipped  0
>     warnings 0
> 
> If global free hugepages are on nodes 4-7 while the memory policy restricts
> hugemmap10 to nodes 0-3, the counter discrepancy is observed.
> 
> Read the task policy and cpuset mask, then sum free hugepages on the
> nodes available to the mapping. Calculate the expected surplus as the
> maximum of the global and allowed-node shortfalls. Match hugetlb's fallback
> to the cpuset when an MPOL_BIND mask no longer intersects it.
> 
> This fixes counter expectations for MAP_SHARED and MAP_PRIVATE mappings
> that create reservations at mmap() time.
> 
> This complements the hugetlb reservation fix:
> https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?h=mm-new&id=506f9bf248c092fc80df046f9deb26094ea84592
> 
> Signed-off-by: Huaisheng Ye <yehuaisheng@open-hieco.net>

Reviewed-by: Li Wang <li.wang@linux.dev>

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
