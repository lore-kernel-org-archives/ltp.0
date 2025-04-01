Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EACFC36014
	for <ltp@archiver.kernel.org>; Tue,  1 Apr 2025 09:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1743499877; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=pWs+UMa6xTGv2KtqGdWS4ZT+j5mC2HecC6S+gDe76zY=;
 b=PfA+Lku58MNCd1YhkaUb1yCjBvQLiDsIc0kQNQCPqg/enzmodsO/G6SyZHaqheoZCiBCg
 qAvLVDwSXlqTIRUmYT6z0cX5I8lgXomjiqCYyQTdV/JQtAVH8SmeylREmfDHYEt8J72lwLy
 a/zWekAx4/bePlsjyTMi+YKSRJIOLU8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 97F293CAFD2
	for <ltp@archiver.kernel.org>; Tue,  1 Apr 2025 11:31:17 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 414F83CAE9F
 for <ltp@lists.linux.it>; Tue,  1 Apr 2025 11:30:55 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=68.232.139.130;
 helo=esa5.hc1455-7.c3s2.iphmx.com; envelope-from=maxj.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa5.hc1455-7.c3s2.iphmx.com (esa5.hc1455-7.c3s2.iphmx.com
 [68.232.139.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 69448600872
 for <ltp@lists.linux.it>; Tue,  1 Apr 2025 11:30:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1743499854; x=1775035854;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=QiKARr/3SDNwEKwbaw1cnGgEIzps8pER4Z5ycwM/Ciw=;
 b=LB9tFnLr9s+ow5rX/Cf17k/73BeXWQMW9YUv86gPCq7WWk6w74zjg2vd
 UJHqQLvFG4hkBwIXCJ7wnu6v9Y9ryQXslHscLw2/6/FF3VmPl6OC3e+1Q
 dRlaMLmFSx1aUZGOkuxelpEYttxi17Uop52uO6yytTgoMpWVqDF9tpNpU
 Q6fC6p5uheNuZskO1xFlWGlYAjnRHXZ3LjkLoj9PVN/IRaoLFuOqtqm/S
 xbkdERdo+G35QVEhu/rNwAe2wHn8tUwxyhWUByFd1LS7vUndwjjLs6idJ
 nO95vWNQ3a7YVlXUn5Owo/2BMNaSALjZSwijqOTD9ulp+ovvUlUaYyBV0 w==;
X-CSE-ConnectionGUID: tL89FInDQmGHRbOVGTScJQ==
X-CSE-MsgGUID: GjEcrG38Qn+Q4sSLcPF/sw==
X-IronPort-AV: E=McAfee;i="6700,10204,11390"; a="194271366"
X-IronPort-AV: E=Sophos;i="6.14,293,1736780400"; d="scan'208";a="194271366"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
 by esa5.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Apr 2025 18:30:52 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com
 [192.168.83.65])
 by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 38489D6EA5
 for <ltp@lists.linux.it>; Tue,  1 Apr 2025 18:30:50 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id EC795D50A8
 for <ltp@lists.linux.it>; Tue,  1 Apr 2025 18:30:49 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.135.101])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 445061A0078;
 Tue,  1 Apr 2025 17:30:49 +0800 (CST)
To: ltp@lists.linux.it
Date: Tue,  1 Apr 2025 17:29:13 +0800
Message-ID: <20250401092913.135745-1-maxj.fnst@fujitsu.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] move_pages04: Fix the doc to fit RST format
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
 .../kernel/syscalls/move_pages/move_pages04.c | 28 +++++++++----------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/testcases/kernel/syscalls/move_pages/move_pages04.c b/testcases/kernel/syscalls/move_pages/move_pages04.c
index e1ee733f0..3a56cdaca 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages04.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages04.c
@@ -10,21 +10,21 @@
  *
  * [Algorithm]
  *
- *      1. Pass the address of a valid memory area where no page is
- *         mapped yet (not read/written), the address of a valid memory area
- *         where the shared zero page is mapped (read, but not written to)
- *         and the address of an invalid memory area as page addresses to
- *         move_pages().
- *      2. Check if the corresponding status for "no page mapped" is set to
- *         -ENOENT. Note that kernels >= 4.3 [1] and < 6.12 [2] wrongly returned
- *         -EFAULT by accident.
- *      3. Check if the corresponding status for "shared zero page" is set to:
- *         -EFAULT. Note that kernels < 4.3 [1] wrongly returned -ENOENT.
- *      4. Check if the corresponding status for "invalid memory area" is set
- *         to -EFAULT.
+ * #. Pass the address of a valid memory area where no page is
+ *    mapped yet (not read/written), the address of a valid memory area
+ *    where the shared zero page is mapped (read, but not written to)
+ *    and the address of an invalid memory area as page addresses to
+ *    move_pages().
+ * #. Check if the corresponding status for "no page mapped" is set to
+ *    -ENOENT. Note that kernels >= 4.3 [1] and < 6.12 [2] wrongly returned
+ *    -EFAULT by accident.
+ * #. Check if the corresponding status for "shared zero page" is set to:
+ *    -EFAULT. Note that kernels < 4.3 [1] wrongly returned -ENOENT.
+ * #. Check if the corresponding status for "invalid memory area" is set
+ *    to -EFAULT.
  *
- *   [1] d899844e9c98 "mm: fix status code which move_pages() returns for zero page"
- *   [2] 7dff875c9436 "mm/migrate: convert add_page_for_migration() from follow_page() to folio_walk"
+ * | [1] d899844e9c98 "mm: fix status code which move_pages() returns for zero page"
+ * | [2] 7dff875c9436 "mm/migrate: convert add_page_for_migration() from follow_page() to folio_walk"
  */
 
 #include <sys/mman.h>
-- 
2.47.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
