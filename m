Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 276A6EDE9B6
	for <ltp@archiver.kernel.org>; Thu, 14 Sep 2023 12:20:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 364153CE733
	for <ltp@archiver.kernel.org>; Thu, 14 Sep 2023 14:20:47 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F017D3CB268
 for <ltp@lists.linux.it>; Thu, 14 Sep 2023 07:53:21 +0200 (CEST)
Received: from r3-23.sinamail.sina.com.cn (r3-23.sinamail.sina.com.cn
 [202.108.3.23])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 20C56140053B
 for <ltp@lists.linux.it>; Thu, 14 Sep 2023 07:53:18 +0200 (CEST)
X-SMAIL-HELO: pek-lxu-l1.wrs.com
Received: from unknown (HELO pek-lxu-l1.wrs.com)([111.198.228.56])
 by sina.com (172.16.97.23) with ESMTP
 id 65029FC9000216F9; Thu, 14 Sep 2023 13:53:14 +0800 (CST)
X-Sender: eadavis@sina.com
X-Auth-ID: eadavis@sina.com
Authentication-Results: sina.com; spf=none smtp.mailfrom=eadavis@sina.com;
 dkim=none header.i=none;
 dmarc=none action=none header.from=eadavis@sina.com
X-SMAIL-MID: 59030431458597
X-SMAIL-UIID: 6CA756EA4A77410D88DFC3554C509A18-20230914-135314-1
From: Edward AD <eadavis@sina.com>
To: oliver.sang@intel.com
Date: Thu, 14 Sep 2023 13:53:13 +0800
Message-ID: <20230914055313.151192-1-eadavis@sina.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <202309121302.8864096c-oliver.sang@intel.com>
References: <202309121302.8864096c-oliver.sang@intel.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Thu, 14 Sep 2023 14:20:23 +0200
Subject: [LTP] [PATCH] mm: extpand queue_pages_range() to find and lock the
 vma range
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
Cc: syzbot+b591856e0f0139f83023@syzkaller.appspotmail.com, lkp@intel.com,
 syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, oe-lkp@lists.linux.dev, akpm@linux-foundation.org,
 ltp@lists.linux.it, eadavis@sina.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Using for_each_vma_range to find vmas, and not only inside locking, but also 
outside locking to ensure that vma_start_write are performed.

Reported-and-tested-by: syzbot+b591856e0f0139f83023@syzkaller.appspotmail.com
Signed-off-by: Edward AD <eadavis@sina.com>
---
 mm/pagewalk.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index b7d7e4fcfad7..b31d59a27f57 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -479,6 +479,7 @@ int walk_page_range(struct mm_struct *mm, unsigned long start,
 		.mm		= mm,
 		.private	= private,
 	};
+	struct vma_iterator vmi;
 
 	if (start >= end)
 		return -EINVAL;
@@ -488,8 +489,9 @@ int walk_page_range(struct mm_struct *mm, unsigned long start,
 
 	process_mm_walk_lock(walk.mm, ops->walk_lock);
 
-	vma = find_vma(walk.mm, start);
-	do {
+	vma_iter_init(&vmi, walk.mm, start);
+	for_each_vma_range(vmi, vma, end) {
+		process_vma_walk_lock(vma, ops->walk_lock);
 		if (!vma) { /* after the last vma */
 			walk.vma = NULL;
 			next = end;
@@ -501,10 +503,8 @@ int walk_page_range(struct mm_struct *mm, unsigned long start,
 			if (ops->pte_hole)
 				err = ops->pte_hole(start, next, -1, &walk);
 		} else { /* inside vma */
-			process_vma_walk_lock(vma, ops->walk_lock);
 			walk.vma = vma;
 			next = min(end, vma->vm_end);
-			vma = find_vma(mm, vma->vm_end);
 
 			err = walk_page_test(start, next, &walk);
 			if (err > 0) {
@@ -522,7 +522,7 @@ int walk_page_range(struct mm_struct *mm, unsigned long start,
 		}
 		if (err)
 			break;
-	} while (start = next, start < end);
+	};
 	return err;
 }
 
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
