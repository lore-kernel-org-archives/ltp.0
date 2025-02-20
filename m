Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24AE5C021AD
	for <ltp@archiver.kernel.org>; Thu, 20 Feb 2025 07:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1740038343; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=f7y+3jBHazUc0+xvBRxIqttJiE7MAR3LKyK9M+IeEDs=;
 b=PQeQxj28PtMT7QjLCAW99rk+riSEBSN9P8w3LE2LJoiuxmi+vrJIdGxzrGgZ2xVUy7X0D
 j/K31r2RyM4SM9FOIFRAuSwckwQNMCph90dWLj4z5Vxq0oWLOmpHEuHSZJoTwyuKvZRstV+
 WPtmRe0Bxt9y7W5igay+Xw0ZZxclgWo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 827C93C535B
	for <ltp@archiver.kernel.org>; Thu, 20 Feb 2025 08:59:03 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 455A53C0265
 for <ltp@lists.linux.it>; Thu, 20 Feb 2025 08:58:42 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=207.54.90.48;
 helo=esa2.hc1455-7.c3s2.iphmx.com; envelope-from=maxj.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa2.hc1455-7.c3s2.iphmx.com (esa2.hc1455-7.c3s2.iphmx.com
 [207.54.90.48])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2C380635833
 for <ltp@lists.linux.it>; Thu, 20 Feb 2025 08:58:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1740038322; x=1771574322;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=a20DiTSEvJ5sE/hSBHHgEtmd3v2tVXoqsOeY4Sgqq+U=;
 b=czjO/oxXh0z9rXJ6Tr8Yw980P1sk4ZKh7D7HiueEz8uk6bwWtFKjgFGE
 ipbwhsdtbLP6VF2f1g+jiIigI1NUafNS/xuhW75egKI0dRO0PGCIrVDw9
 hWXaagnhzeAmyjlmN7z4VdaGCn5KU2LfD7azAaqoq5d1SnQsU49NV/viQ
 BCbfbEq3vy0PpINLHZu7lDDLfFGqVNXEjCydA1ztAJsSpkvOe5NKpVDOD
 +irrKxmti9g587t0ZFKzireSbjLKHwfhOgO5DF5JXr8D0BR5xdQceLrP2
 7xdYQvFMMyJRYFdQK1rsXwlE1pKGdm8u+FDCq6IDLvwuyy0Srzy8eXqsI g==;
X-CSE-ConnectionGUID: M4H7dgEDQQyJKNqmYhy1gw==
X-CSE-MsgGUID: FSSoVslnSsasLjv4mQaktQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="190676320"
X-IronPort-AV: E=Sophos;i="6.13,301,1732546800"; d="scan'208";a="190676320"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
 by esa2.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2025 16:58:40 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com
 [192.168.87.60])
 by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 89DBEC2260
 for <ltp@lists.linux.it>; Thu, 20 Feb 2025 16:58:37 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 4C4D2D7298
 for <ltp@lists.linux.it>; Thu, 20 Feb 2025 16:58:37 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.135.101])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id A773A1A0003;
 Thu, 20 Feb 2025 15:58:36 +0800 (CST)
To: ltp@lists.linux.it
Date: Thu, 20 Feb 2025 15:58:40 +0800
Message-ID: <20250220075840.1124046-1-maxj.fnst@fujitsu.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] shmdt02: Fix the doc to fit RST format
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
 testcases/kernel/syscalls/ipc/shmdt/shmdt02.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/ipc/shmdt/shmdt02.c b/testcases/kernel/syscalls/ipc/shmdt/shmdt02.c
index a3b20f8ff..4bdc6eb21 100644
--- a/testcases/kernel/syscalls/ipc/shmdt/shmdt02.c
+++ b/testcases/kernel/syscalls/ipc/shmdt/shmdt02.c
@@ -6,8 +6,8 @@
 /*\
  * Tests basic error handing of the shmdt syscall.
  *
- * -EINVAL there is no shared memory segment attached at shmaddr.
- * -EINVAL shmaddr is not aligned on a page boundary.
+ * - EINVAL there is no shared memory segment attached at shmaddr.
+ * - EINVAL shmaddr is not aligned on a page boundary.
  */
 
 #include <sys/types.h>
-- 
2.47.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
