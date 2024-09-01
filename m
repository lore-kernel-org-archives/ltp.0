Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FB60C54FC6
	for <ltp@archiver.kernel.org>; Sun,  1 Sep 2024 14:51:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F10483CC91E
	for <ltp@archiver.kernel.org>; Sun,  1 Sep 2024 16:51:11 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A48743CC81C
 for <ltp@lists.linux.it>; Sun,  1 Sep 2024 16:50:56 +0200 (CEST)
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
 by in-6.smtp.seeweb.it (Postfix) with ESMTP id 530D61400B9F
 for <ltp@lists.linux.it>; Sun,  1 Sep 2024 16:50:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=P0iqe
 6vXWSjMmRXDrMjZrivCVdtRvOplSj137lptWKg=; b=SNUYNWPoBCluXsWkItYvY
 qyMDY62i5MFeU5ycVwREEshcJ/mIcASlz/zJlkojT6P3iqNpTOVkr6b40Ht40fpP
 ALSOteL47xEQ270K1hBPa5a0s6Ri6aLs39tEOV2OZzN6RbsqPoNd/lZAW4ANSlVf
 A6p7aldKFeYk7ORrKkJyO0=
Received: from fedora40-vm.. (unknown [160.86.227.247])
 by gzga-smtp-mta-g3-1 (Coremail) with SMTP id _____wD3_0Q0f9Rm6pl+BA--.39198S2;
 Sun, 01 Sep 2024 22:50:31 +0800 (CST)
From: Xiao Yang <ice_yangxiao@163.com>
To: Liam.Howlett@Oracle.com,
	linux-mm@kvack.org
Date: Sun,  1 Sep 2024 23:50:25 +0900
Message-ID: <20240901145025.2311-1-ice_yangxiao@163.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
X-CM-TRANSID: _____wD3_0Q0f9Rm6pl+BA--.39198S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKr4DtF4fArWUKF47Zw4rGrg_yoWkXwb_Wr
 W093WkWFsYkFnIyw17Zr9xtrn2grWqvrZ7GFnYkF1aq3ZrC3WrXrWvv3sxArn0qr4qvr9x
 GwnIkrZayw1j9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRknYn5UUUUU==
X-Originating-IP: [160.86.227.247]
X-CM-SenderInfo: 5lfhs5xdqj5xldr6il2tof0z/1tbiqRxNXmVOClPWIAAAsi
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] mm/vma: Return the exact errno for
 vms_gather_munmap_vmas()
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

can_modify_vma() in vms_gather_munmap_vmas() returns -EPERM if vma is
sealed so don't always return the fixed -ENOMEM on failure.

Fixes: c2eb22189bbc ("mm/vma: inline munmap operation in mmap_region()")
Fixes: 5887a7ac2383 ("mm/vma: expand mmap_region() munmap call")
Signed-off-by: Xiao Yang <ice_yangxiao@163.com>
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202408312155.fd26a58c-oliver.sang@intel.com
---
 mm/mmap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index c1781f643046..c9a0dc035819 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1386,8 +1386,9 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		mt_on_stack(mt_detach);
 		mas_init(&mas_detach, &mt_detach, /* addr = */ 0);
 		/* Prepare to unmap any existing mapping in the area */
-		if (vms_gather_munmap_vmas(&vms, &mas_detach))
-			return -ENOMEM;
+		error = vms_gather_munmap_vmas(&vms, &mas_detach);
+		if (error)
+			return error;
 
 		vmg.next = vms.next;
 		vmg.prev = vms.prev;
-- 
2.44.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
