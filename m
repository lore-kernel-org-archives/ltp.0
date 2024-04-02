Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3906ECD1284
	for <ltp@archiver.kernel.org>; Tue,  2 Apr 2024 05:26:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1E5413C8658
	for <ltp@archiver.kernel.org>; Tue,  2 Apr 2024 07:26:34 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A2C573C84C3
 for <ltp@lists.linux.it>; Tue,  2 Apr 2024 07:26:18 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org;
 envelope-from=willy@infradead.org; receiver=lists.linux.it)
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A16CB6005FC
 for <ltp@lists.linux.it>; Tue,  2 Apr 2024 07:26:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=7t2WjsmH8l5lF/Pmb1Te6bnqZx4BXhCY++fg2NjSv5c=; b=krFd6x850goqIRx5xWkc8LQbPX
 L1dVt9sISoRBhDUDFdjSOa+piX61bhGbbqw9U0isYl17RkNU8lWzACm/gP/t2y6ANPlSuHGH5aNxa
 4g/8D1C2AHt5QAzmbLYw+HSLhkvlnuD1V+feTdMOCwfZdZX4UCL33os5bnrdVnHIiM/GOosC+VvdT
 KBibFwG2gIRfqLeaB4LCXAauvUp7WgKgOD1wcsbz2/amhCfiz71r3erRdjAVppW28F3YMBivo9g9x
 VqfGKcCzgQI3TRVb0RtvEMFjDlTKEtQP1WO6aE2p0dLKjQKlwTUwZjKzjt1E/QptSTmaP6bWy/WUn
 dbRihOuA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red
 Hat Linux)) id 1rrWev-00000002HaX-2ykM;
 Tue, 02 Apr 2024 05:26:10 +0000
Date: Tue, 2 Apr 2024 06:26:09 +0100
From: Matthew Wilcox <willy@infradead.org>
To: kernel test robot <oliver.sang@intel.com>
Message-ID: <ZguW8RtudvsJaHLq@casper.infradead.org>
References: <20240321142448.1645400-8-willy@infradead.org>
 <202403312344.c0d273ab-oliver.sang@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <202403312344.c0d273ab-oliver.sang@intel.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 7/9] mm: Free up PG_slab
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
Cc: Miaohe Lin <linmiaohe@huawei.com>, lkp@intel.com,
 David Hildenbrand <david@redhat.com>, Muchun Song <muchun.song@linux.dev>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Vlastimil Babka <vbabka@suse.cz>, oe-lkp@lists.linux.dev,
 Andrew Morton <akpm@linux-foundation.org>, Oscar Salvador <osalvador@suse.de>,
 ltp@lists.linux.it, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Sun, Mar 31, 2024 at 11:11:10PM +0800, kernel test robot wrote:
> kernel test robot noticed "UBSAN:shift-out-of-bounds_in_fs/proc/page.c" on:
> 
> commit: 30e5296811312a13938b83956a55839ac1e3aa40 ("[PATCH 7/9] mm: Free up PG_slab")

Quite right.  Spotted another one while I was at it.  Not able to test
right now, but this should do the trick:

diff --git a/fs/proc/page.c b/fs/proc/page.c
index 5bc82828c6aa..55b01535eb22 100644
--- a/fs/proc/page.c
+++ b/fs/proc/page.c
@@ -175,6 +175,8 @@ u64 stable_page_flags(const struct page *page)
 		u |= 1 << KPF_OFFLINE;
 	if (PageTable(page))
 		u |= 1 << KPF_PGTABLE;
+	if (folio_test_slab(folio))
+		u |= 1 << KPF_SLAB;
 
 #if defined(CONFIG_PAGE_IDLE_FLAG) && defined(CONFIG_64BIT)
 	u |= kpf_copy_bit(k, KPF_IDLE,          PG_idle);
@@ -184,7 +186,6 @@ u64 stable_page_flags(const struct page *page)
 #endif
 
 	u |= kpf_copy_bit(k, KPF_LOCKED,	PG_locked);
-	u |= kpf_copy_bit(k, KPF_SLAB,		PG_slab);
 	u |= kpf_copy_bit(k, KPF_ERROR,		PG_error);
 	u |= kpf_copy_bit(k, KPF_DIRTY,		PG_dirty);
 	u |= kpf_copy_bit(k, KPF_UPTODATE,	PG_uptodate);
diff --git a/tools/cgroup/memcg_slabinfo.py b/tools/cgroup/memcg_slabinfo.py
index 1d3a90d93fe2..270c28a0d098 100644
--- a/tools/cgroup/memcg_slabinfo.py
+++ b/tools/cgroup/memcg_slabinfo.py
@@ -146,12 +146,11 @@ def detect_kernel_config():
 
 
 def for_each_slab(prog):
-    PGSlab = 1 << prog.constant('PG_slab')
-    PGHead = 1 << prog.constant('PG_head')
+    PGSlab = ~prog.constant('PG_slab')
 
     for page in for_each_page(prog):
         try:
-            if page.flags.value_() & PGSlab:
+            if page.page_type.value_() == PGSlab:
                 yield cast('struct slab *', page)
         except FaultError:
             pass

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
