Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEC48C5321D
	for <ltp@archiver.kernel.org>; Tue, 20 Aug 2024 08:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1724141018; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=SoKecuZFFlYEeUqcmp9ww+AJDI2XnzCr/8tgsjNClS0=;
 b=XtLgegfOIMsKnRjjpq5nPpKCdIP5sdMjqoBOmCIVdAQ70hBn7AeM9qNa28btRXu1Nq4BE
 Qj7NyssDMMMI4RstOMzcEM+7WlUcVEB1ICCMlugWrrS30PmpqgFCF4ibCtVfCAW3eUwN91L
 785aqYcvtZLzGUO0Aruu3YODpNxi7Kc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2D91B3CC2E6
	for <ltp@archiver.kernel.org>; Tue, 20 Aug 2024 10:03:38 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 81DDA3CAE79
 for <ltp@lists.linux.it>; Tue, 20 Aug 2024 10:03:18 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=139.138.37.100;
 helo=esa12.hc1455-7.c3s2.iphmx.com; envelope-from=maxj.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com
 [139.138.37.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8D69C600D57
 for <ltp@lists.linux.it>; Tue, 20 Aug 2024 10:03:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1724140997; x=1755676997;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=h4CYkBA43gHWkjIBmKqcUukvylJ238hk+HDhUdm5dIg=;
 b=Z48wp2CQ9mjmM1p8lwgTKwqxZfTVxw+9HM+TuXSrJ6wBS+KSoUKptB/m
 t19xf1Pmel45Wisug6mfVFzfRARiueR6jRnEEduBBkrYUR2bXdFeX2dRT
 vNVSzNp1p76uabfFo1aYFUwwCOiUp56KAU43kytk8hAt+AnHDsW7yp6jt
 5L98LlTA6PouJ1bsuESCcsjlpa9UdJgm2FV/343bWagzE5GrccpWQqPan
 6pGU5mzEzDVa9mWh6HfVCNJzGRmZOBOza6cHmuHzGSoIf8/GP04ufAWUn
 8V1U3N3GGKvmyp3A1YvO7xMEPjBv9J+vVWGSuRz0pxqiE5XjFBfhlAmcg g==;
X-CSE-ConnectionGUID: qLGCpv95SHeOwfRn2MU5TQ==
X-CSE-MsgGUID: lWL7Dlh3SqC9lWYmsij3WQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="150084155"
X-IronPort-AV: E=Sophos;i="6.10,161,1719846000"; d="scan'208";a="150084155"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
 by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Aug 2024 17:03:14 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com
 [192.168.87.61])
 by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 13A7CD800F
 for <ltp@lists.linux.it>; Tue, 20 Aug 2024 17:03:12 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 4F5C3D4BC4
 for <ltp@lists.linux.it>; Tue, 20 Aug 2024 17:03:11 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id C9CED2007FAD2
 for <ltp@lists.linux.it>; Tue, 20 Aug 2024 17:03:10 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.182])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 510D21A0002;
 Tue, 20 Aug 2024 16:03:10 +0800 (CST)
To: ltp@lists.linux.it
Date: Tue, 20 Aug 2024 16:04:13 +0800
Message-ID: <20240820080413.2740955-1-maxj.fnst@fujitsu.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28606.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28606.005
X-TMASE-Result: 10--12.872100-10.000000
X-TMASE-MatchedRID: DMsOoTK7WFDyq/cli2hvDU7nLUqYrlslNmVjpriVEtmOEENgsUAuYqm7
 Ppyf7RSRp7UbmHyWcPyoEutnhRxmtsc6R/b4owP8+GYt8f/VhTuOVGny5q72hr5TVqwOzxj8W1R
 FmDf+CHaqffmRegzerIAy6p60ZV62fJ5/bZ6npdjiRhduhvElsqX8y2tPBLhQhqRVT2k7g0zwrk
 85MMFPdChSLlvpYbILOqLX4qkk2VcqKAHuRowG7g==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] readlink03: Convert docs to docparse
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
 .../kernel/syscalls/readlink/readlink03.c     | 35 +++++++++----------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/testcases/kernel/syscalls/readlink/readlink03.c b/testcases/kernel/syscalls/readlink/readlink03.c
index 01ff304d8..dce636664 100644
--- a/testcases/kernel/syscalls/readlink/readlink03.c
+++ b/testcases/kernel/syscalls/readlink/readlink03.c
@@ -4,25 +4,22 @@
  * Ported to LTP: Wayne Boyer
  */
 
-/*
- * Test Description :
- *   1) readlink(2) returns -1 and sets errno to EACCES if search/write
- *	permission is denied in the directory where the symbolic link
- *	resides.
- *   2) readlink(2) returns -1 and sets errno to EINVAL if the buffer size
- *	is not positive.
- *   3) readlink(2) returns -1 and sets errno to EINVAL if the specified
- *	file is not a symbolic link file.
- *   4) readlink(2) returns -1 and sets errno to ENAMETOOLONG if the
- *	pathname component of symbolic link is too long (ie, > PATH_MAX).
- *   5) readlink(2) returns -1 and sets errno to ENOENT if the component of
- *	symbolic link points to an empty string.
- *   6) readlink(2) returns -1 and sets errno to ENOTDIR if a component of
- *	the path prefix is not a directory.
- *   7) readlink(2) returns -1 and sets errno to ELOOP if too many symbolic
- *	links were encountered in translating the pathname.
- *   8) readlink(2) returns -1 and sets errno to EFAULT if buf outside the
- *	process allocated address space.
+/*\
+ * [Description]
+ *
+ * Verify that, readlink(2) returns -1 and sets errno to
+ *
+ * 1. EACCES if search/write permission is denied in the directory where the
+ * symbolic link esides.
+ * 2. EINVAL if the buffer size is not positive.
+ * 3. EINVAL if the specified file is not a symbolic link file.
+ * 4. ENAMETOOLONG if the pathname component of symbolic link is too long
+ * (ie, > PATH_MAX).
+ * 5. ENOENT if the component of symbolic link points to an empty string.
+ * 6. ENOTDIR if a component of the path prefix is not a directory.
+ * 7. ELOOP if too many symbolic links were encountered in translating the
+ * pathname.
+ * 8. EFAULT if buf outside the process allocated address space.
  */
 
 #include <pwd.h>
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
