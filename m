Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAB9FC47DAF
	for <ltp@archiver.kernel.org>; Sun, 21 Jan 2024 16:12:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 05E7F3CE261
	for <ltp@archiver.kernel.org>; Sun, 21 Jan 2024 17:12:41 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 86CE73CE248
 for <ltp@lists.linux.it>; Sun, 21 Jan 2024 17:12:09 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=207.54.90.137;
 helo=esa11.hc1455-7.c3s2.iphmx.com; envelope-from=ruansy.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa11.hc1455-7.c3s2.iphmx.com (esa11.hc1455-7.c3s2.iphmx.com
 [207.54.90.137])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 76FB51400E6B
 for <ltp@lists.linux.it>; Sun, 21 Jan 2024 17:12:06 +0100 (CET)
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="126167407"
X-IronPort-AV: E=Sophos;i="6.05,210,1701097200"; d="scan'208";a="126167407"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
 by esa11.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jan 2024 01:12:04 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com
 [192.168.87.61])
 by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 0B8B6D64AA
 for <ltp@lists.linux.it>; Mon, 22 Jan 2024 01:12:02 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 0011EC13AF
 for <ltp@lists.linux.it>; Mon, 22 Jan 2024 01:12:00 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 755F120079116
 for <ltp@lists.linux.it>; Mon, 22 Jan 2024 01:12:00 +0900 (JST)
Received: from irides.g08.fujitsu.local (unknown [10.167.226.114])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 0223C1A015E
 for <ltp@lists.linux.it>; Mon, 22 Jan 2024 00:11:59 +0800 (CST)
From: Shiyang Ruan <ruansy.fnst@fujitsu.com>
To: ltp@lists.linux.it
Date: Mon, 22 Jan 2024 00:11:58 +0800
Message-Id: <20240121161159.4106646-1-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28134.001
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28134.001
X-TMASE-Result: 10--4.739900-10.000000
X-TMASE-MatchedRID: toN6SH028bWOPHcS3uzQKazGfgakLdjaCZa9cSpBObnAuQ0xDMaXkH4q
 tYI9sRE/L2EYbInFI5ubvdUVlY5ZkKxTA8iT+xtuKiJEqUFWRgidj7YWJLs3nf4DDXoaCqk7QSD
 EyvYoV0Di8zVgXoAltuJ5hXsnxp7jC24oEZ6SpSkgbhiVsIMQK2u5XqFPzjITvUAKOtKcH0UoW7
 0o99+H1Ya5Nqub4GCl2vAXzUE+m9OongbSbyU9v8XfBFd/4tez5DgnY5a8+4OTlSVbXvaZpNONF
 uNksbJZ1wqZyFg4yCCY5Bsvgd8C/vVKhDXp0zcGiwLnYKDZPn8uQHnY0nrehA==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] getxattr04,05: Add [Description] tag
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 testcases/kernel/syscalls/getxattr/getxattr04.c | 4 +++-
 testcases/kernel/syscalls/getxattr/getxattr05.c | 6 ++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/getxattr/getxattr04.c b/testcases/kernel/syscalls/getxattr/getxattr04.c
index e64f2a1f1..b1106ee20 100644
--- a/testcases/kernel/syscalls/getxattr/getxattr04.c
+++ b/testcases/kernel/syscalls/getxattr/getxattr04.c
@@ -4,7 +4,9 @@
  * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
  */
 
-/*
+/*\
+ * [Description]
+ *
  * This is a regression test for the race between getting an existing
  * xattr and setting/removing a large xattr.  This bug leads to that
  * getxattr() fails to get an existing xattr and returns ENOATTR in xfs
diff --git a/testcases/kernel/syscalls/getxattr/getxattr05.c b/testcases/kernel/syscalls/getxattr/getxattr05.c
index 8d1752fd0..b144a87de 100644
--- a/testcases/kernel/syscalls/getxattr/getxattr05.c
+++ b/testcases/kernel/syscalls/getxattr/getxattr05.c
@@ -4,8 +4,10 @@
  * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
  */
 
-/*
- * Description:
+/*\
+ * [Description]
+ *
+ * This test verifies that:
  * 1) Witout a user namespace, getxattr(2) should get same data when
  *    acquiring the value of system.posix_acl_access twice.
  * 2) With/Without mapped root UID in a user namespaces, getxattr(2) should
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
