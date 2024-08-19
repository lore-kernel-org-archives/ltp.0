Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E85FAC3DA4A
	for <ltp@archiver.kernel.org>; Mon, 19 Aug 2024 08:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1724055689; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=vsnWborzUfN25fg6C3H7dieGgqmtzUkUYr5axnhi1Cg=;
 b=Amtle1jGi3FdM0zigjlSdP1sWMLSN7GUapktVtSWnla3iaa+sVm3aINKW+/WPFYRQf1E3
 tnBAoy9rA655K/oEY9vnd/0LV9Du1j5pN+tEeThdAp3cq5ib+PaZTzZ0pS+GRIhBJeeAZfA
 qD04c0c1SvUqqH6GMYIXEjxNmJGMHUc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 09AAE3D31FB
	for <ltp@archiver.kernel.org>; Mon, 19 Aug 2024 10:21:29 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7D3EE3C01EE
 for <ltp@lists.linux.it>; Mon, 19 Aug 2024 10:21:07 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=68.232.139.130;
 helo=esa5.hc1455-7.c3s2.iphmx.com; envelope-from=maxj.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa5.hc1455-7.c3s2.iphmx.com (esa5.hc1455-7.c3s2.iphmx.com
 [68.232.139.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3FA322001A1
 for <ltp@lists.linux.it>; Mon, 19 Aug 2024 10:21:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1724055666; x=1755591666;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=+y3NiN2Aw61Jfqhju3V8czG4O9iY9rzNrbXtNrVtqEU=;
 b=hgp36AiFqKrdAPgKf59R12XS5mod6l+/773uYTU79RzV6OvCfpjymic8
 51luYybmaMQ9ywm+VGV2uT5OhlmdKSq37VMtALAbrsyNon+Y+de2bt8yV
 jPpqVG2T7uELjNCK6ncYx0HlTj430bP368lNm/MwdW9KQYwye9EKUaAWy
 4xIPz0cb4QuWtXYnzdY0jHoTuzz2RHxs6kX8kI33IMV0JZFNJTVMGE4F4
 J5doCMsuVy6PJhEhlmWyf5HUOSvE59Y6NENkBWp235lRVuUL14qZ8Ehi5
 /eJYepShCnUTNUDTfgyfqliXymZaLC865enVEz7AnDmBIQSRWa6C862rP w==;
X-CSE-ConnectionGUID: XnVaobPPROCkLwv0F3XhwQ==
X-CSE-MsgGUID: sMacJv90T42M/82CpDCj+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="170193896"
X-IronPort-AV: E=Sophos;i="6.10,158,1719846000"; d="scan'208";a="170193896"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
 by esa5.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2024 17:21:04 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com
 [192.168.87.58])
 by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 1EA5ED29E1
 for <ltp@lists.linux.it>; Mon, 19 Aug 2024 17:21:02 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 65858D8AC3
 for <ltp@lists.linux.it>; Mon, 19 Aug 2024 17:21:01 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id EC3342007C3C4
 for <ltp@lists.linux.it>; Mon, 19 Aug 2024 17:21:00 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.182])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 6BB1C1A000A;
 Mon, 19 Aug 2024 16:21:00 +0800 (CST)
To: ltp@lists.linux.it
Date: Mon, 19 Aug 2024 16:22:13 +0800
Message-ID: <20240819082213.2150403-1-maxj.fnst@fujitsu.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28604.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28604.005
X-TMASE-Result: 10--13.457500-10.000000
X-TMASE-MatchedRID: toN6SH028bXX54Vmcx7RYAXtykVcrvpNKQNhMboqZlpgPgeggVwCFr8F
 Hrw7frluf146W0iUu2sUU1QqiMTlE8ufsEj8J7G7a87CDXaKRVKNOKo58EEcaRe1yJq6HIhHUex
 gNDoxdJbCI5ZCQy3Br7pjAjMHHtZlHxPMjOKY7A+u65UDD0aDgsRB0bsfrpPIfiAqrjYtFiQbn+
 Glsj29CIbYTX67dGQxHDSjAVu1ui2DJ9x9DMsqwX7cGd19dSFd
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] getdents02: Add case for errno EFAULT
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

Currently there is no case for EFAULT, so a new case is added.

Signed-off-by: Ma Xinjian <maxj.fnst@fujitsu.com>
---
 testcases/kernel/syscalls/getdents/getdents02.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/testcases/kernel/syscalls/getdents/getdents02.c b/testcases/kernel/syscalls/getdents/getdents02.c
index ade1c9476..578db9d1e 100644
--- a/testcases/kernel/syscalls/getdents/getdents02.c
+++ b/testcases/kernel/syscalls/getdents/getdents02.c
@@ -15,6 +15,7 @@
  *   - getdents() fails with EINVAL if result buffer is too small
  *   - getdents() fails with ENOTDIR if file descriptor does not refer to a directory
  *   - getdents() fails with ENOENT if directory was unlinked()
+ *   - getdents() fails with EFAULT if argument points outside the calling process's address space
  */
 
 #define _GNU_SOURCE
@@ -34,6 +35,7 @@ static size_t size;
 
 static char dirp1_arr[1];
 static char *dirp1 = dirp1_arr;
+static char *dirp_bad;
 static size_t size1 = 1;
 
 static int fd_inv = -5;
@@ -51,6 +53,7 @@ static struct tcase {
 	{ &fd, &dirp1, &size1, EINVAL },
 	{ &fd_file, &dirp, &size, ENOTDIR },
 	{ &fd_unlinked, &dirp, &size, ENOENT },
+	{ &fd, &dirp_bad, &size, EFAULT },
 };
 
 static void setup(void)
@@ -63,6 +66,8 @@ static void setup(void)
 	fd = SAFE_OPEN(".", O_RDONLY);
 	fd_file = SAFE_OPEN("test", O_CREAT | O_RDWR, 0644);
 
+	dirp_bad = tst_get_bad_addr(NULL);
+
 	SAFE_MKDIR(TEST_DIR, DIR_MODE);
 	fd_unlinked = SAFE_OPEN(TEST_DIR, O_DIRECTORY);
 	SAFE_RMDIR(TEST_DIR);
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
