Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EF66C36010
	for <ltp@archiver.kernel.org>; Fri, 11 Apr 2025 03:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1744343424; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=BoDGLbxDtk1sDPTXpEMdbqQQCokI+rssFiY5jWHMmoI=;
 b=ijrbvQRl4kGF8V/obB0/QiEk/UvdnifcBmazldnS3R4JtgHAhuZJzCP0AX++HveYvuWBa
 xvyHwKCIveWZjjYb4H/bfRMVponp4vChZZe9uSMtzvD4uui615rWZPY4/rkQtNpuedFoIuO
 ZDjB/KeYtjtZU3GqootYYCVo03V0P8I=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 96B6C3CB532
	for <ltp@archiver.kernel.org>; Fri, 11 Apr 2025 05:50:24 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 87A9D3CA355
 for <ltp@lists.linux.it>; Fri, 11 Apr 2025 05:50:02 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=68.232.139.139;
 helo=esa6.hc1455-7.c3s2.iphmx.com; envelope-from=maxj.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa6.hc1455-7.c3s2.iphmx.com (esa6.hc1455-7.c3s2.iphmx.com
 [68.232.139.139])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6890014004E5
 for <ltp@lists.linux.it>; Fri, 11 Apr 2025 05:50:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1744343401; x=1775879401;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=SmR2+AOSC0jTq6XXZovZWJQLwcfHwIKnAEpIImTB1nQ=;
 b=Vk4lCudDhRcIqlCqwTZQsc6zJiMprTvpr7MHf9p+0jeyfauRMpMGUQub
 1L6z7IFLNEiQVT+3UIIjy4pTL9Ah5h0l1UMVIRxB0rWSQ5mTF/AoDCKR4
 OLuoPPagT47UGVUrIz0KoGM9QlpfbxiDlcSxHranzgUqOa1MTacNNaBJK
 kgJC4xDoxIiE39666WN9qSN4P8ew+8Lr0g6KxaQsYVd1PjIi4Lg30ZzQV
 X1Yp+RGON5sZKHNswzpV8KAyLnHuep5ok+K9IUHrGc5l3vnw1i8fouptx
 jFt115y2FEtZrmhHPOkFPYp+U6VTqObw27HFTJzxUf5RTRDfQY7Mw8nl5 w==;
X-CSE-ConnectionGUID: gmI+j1cgTOOhh/p5UzgNRg==
X-CSE-MsgGUID: qwBmePO0RkuBuyV2GZxCAw==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="198911287"
X-IronPort-AV: E=Sophos;i="6.15,203,1739804400"; d="scan'208";a="198911287"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
 by esa6.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Apr 2025 12:49:59 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com
 [192.168.87.58])
 by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id A1E5FD4809
 for <ltp@lists.linux.it>; Fri, 11 Apr 2025 12:49:56 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 5CD3ED8C12
 for <ltp@lists.linux.it>; Fri, 11 Apr 2025 12:49:56 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.135.101])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id BA9601A009A;
 Fri, 11 Apr 2025 11:49:55 +0800 (CST)
To: ltp@lists.linux.it
Date: Fri, 11 Apr 2025 11:47:03 +0800
Message-ID: <20250411034703.13290-1-maxj.fnst@fujitsu.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] readlink03: Fix the doc to fit RST format
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
From: Ma Xinjian via ltp <ltp@lists.linux.it>
Reply-To: Ma Xinjian <maxj.fnst@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Ma Xinjian <maxj.fnst@fujitsu.com>
---
 .../kernel/syscalls/readlink/readlink03.c     | 22 +++++++++----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/testcases/kernel/syscalls/readlink/readlink03.c b/testcases/kernel/syscalls/readlink/readlink03.c
index 834838737..5c7b5e34c 100644
--- a/testcases/kernel/syscalls/readlink/readlink03.c
+++ b/testcases/kernel/syscalls/readlink/readlink03.c
@@ -7,17 +7,17 @@
 /*\
  * Verify that, readlink(2) returns -1 and sets errno to
  *
- * 1. EACCES if search/write permission is denied in the directory where the
- * symbolic link esides.
- * 2. EINVAL if the buffer size is not positive.
- * 3. EINVAL if the specified file is not a symbolic link file.
- * 4. ENAMETOOLONG if the pathname component of symbolic link is too long
- * (ie, > PATH_MAX).
- * 5. ENOENT if the component of symbolic link points to an empty string.
- * 6. ENOTDIR if a component of the path prefix is not a directory.
- * 7. ELOOP if too many symbolic links were encountered in translating the
- * pathname.
- * 8. EFAULT if buf outside the process allocated address space.
+ * - EACCES if search/write permission is denied in the directory where the
+ *   symbolic link esides.
+ * - EINVAL if the buffer size is not positive.
+ * - EINVAL if the specified file is not a symbolic link file.
+ * - ENAMETOOLONG if the pathname component of symbolic link is too long
+ *   (ie, > PATH_MAX).
+ * - ENOENT if the component of symbolic link points to an empty string.
+ * - ENOTDIR if a component of the path prefix is not a directory.
+ * - ELOOP if too many symbolic links were encountered in translating the
+ *   pathname.
+ * - EFAULT if buf outside the process allocated address space.
  */
 
 #include <pwd.h>
-- 
2.47.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
