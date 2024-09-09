Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A85ACD4F4C
	for <ltp@archiver.kernel.org>; Mon,  9 Sep 2024 05:03:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 25CD23C1014
	for <ltp@archiver.kernel.org>; Mon,  9 Sep 2024 07:03:12 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1E01E3C0944
 for <ltp@lists.linux.it>; Mon,  9 Sep 2024 07:02:55 +0200 (CEST)
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
 by in-2.smtp.seeweb.it (Postfix) with ESMTP id 10574601102
 for <ltp@lists.linux.it>; Mon,  9 Sep 2024 07:02:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=JBh9g
 Ffx3heYPcoalbCGHCAhXyXUQUzmDtHwdRpGsi4=; b=U/jGcGoOG7tos2kQllbc6
 h9/6GvWlPOf7GtDU345cjLcRzZ9eqVVLukbcetnKBx+omyLifVQzjYzi/fkS+ske
 0psRZ2uUnx1M5bUR5eqCj+maDb+w8xbu3inI80PWTr3o4Q8/JIQls0pRpzHnugnB
 pjiyuru8b1Vx1R7+YmzCgw=
Received: from fedora40-vm.. (unknown [106.133.130.25])
 by gzga-smtp-mta-g2-2 (Coremail) with SMTP id _____wCXzkZkgd5mru5JGQ--.57674S2;
 Mon, 09 Sep 2024 13:02:30 +0800 (CST)
From: Xiao Yang <ice_yangxiao@163.com>
To: Liam.Howlett@Oracle.com,
	linux-mm@kvack.org
Date: Mon,  9 Sep 2024 14:02:26 +0900
Message-ID: <20240909050226.2053-1-ice_yangxiao@163.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
X-CM-TRANSID: _____wCXzkZkgd5mru5JGQ--.57674S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uFy8Xw4fXr1fGr1kWrykKrg_yoW8WFy5pr
 93Ww1DXFZ5Xr1Sg3WYqF1jvw1Yqas5X3WrCrWUWFn3Z3Z0qws8trW5tryrZr92grZ7uF9I
 vr4DJF1fW3Z8KaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pinqXkUUUUU=
X-Originating-IP: [106.133.130.25]
X-CM-SenderInfo: 5lfhs5xdqj5xldr6il2tof0z/1tbiMwpVXmXAnu2fxwAAs8
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] mm/vma: Return the exact errno for __split_vma() and
 mas_store_gfp()
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
Cc: oliver.sang@intel.com, linux-kernel@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

__split_vma() and mas_store_gfp() returns several types of errno on
failure so don't ignore them in vms_gather_munmap_vmas(). For example,
__split_vma() returns -EINVAL when an unaligned huge page is unmapped.
This issue is reproduced by ltp memfd_create03 test.

Fixes: 6898c9039bc8 ("mm/vma: extract the gathering of vmas from do_vmi_align_munmap()")
Signed-off-by: Xiao Yang <ice_yangxiao@163.com>
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202409081536.d283a0fb-oliver.sang@intel.com
---
 mm/vma.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index 8d1686fc8d5a..3feeea9a8c3d 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -1200,7 +1200,8 @@ int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 			goto start_split_failed;
 		}
 
-		if (__split_vma(vms->vmi, vms->vma, vms->start, 1))
+		error = __split_vma(vms->vmi, vms->vma, vms->start, 1);
+		if (error)
 			goto start_split_failed;
 	}
 	vms->prev = vma_prev(vms->vmi);
@@ -1220,12 +1221,14 @@ int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 		}
 		/* Does it split the end? */
 		if (next->vm_end > vms->end) {
-			if (__split_vma(vms->vmi, next, vms->end, 0))
+			error = __split_vma(vms->vmi, next, vms->end, 0);
+			if (error)
 				goto end_split_failed;
 		}
 		vma_start_write(next);
 		mas_set(mas_detach, vms->vma_count++);
-		if (mas_store_gfp(mas_detach, next, GFP_KERNEL))
+		error = mas_store_gfp(mas_detach, next, GFP_KERNEL);
+		if (error)
 			goto munmap_gather_failed;
 
 		vma_mark_detached(next, true);
-- 
2.46.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
