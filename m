Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC21CC02198
	for <ltp@archiver.kernel.org>; Mon, 10 Feb 2025 08:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1739177018; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=L3x3vVfw0rmWqzAUl3XKEeHb3Zrr6NZmCAdYlPSBXgc=;
 b=T2Qeyn0ZdVRL7LGjwUTt+GYqEu4TOX37xCzJF6MCudHy2O+NaW2ZFQ+ygZLWBpLc5AJHL
 bBkppp546pEUTUBvASl0EgrG+lm2X1ndnJwRwAnlPZYRkmdMsq+sosyqUAw2uxXCfGgvmp+
 bXDdud1dyT9qOwLCICV/zHPCkeC3YDg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 14E293C9875
	for <ltp@archiver.kernel.org>; Mon, 10 Feb 2025 09:43:38 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8F3373C984C
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 09:43:15 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=68.232.139.117;
 helo=esa4.hc1455-7.c3s2.iphmx.com; envelope-from=maxj.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa4.hc1455-7.c3s2.iphmx.com (esa4.hc1455-7.c3s2.iphmx.com
 [68.232.139.117])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CF1F5100C695
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 09:43:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1739176993; x=1770712993;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=5IG29JUHhhkXLEMa8xk/OWepOx05L+OadapNTDR71Go=;
 b=SLdgnnKrjZt3Ydk5eRY73bs+r0GfRYqiISMsLFaBmEKrCiPDuRqF6sjz
 00sYsDNTWUWbuXhGq1mutOot7JnuSXeqUCdZ6VI9sb6u+Ji17BiAJfJe/
 8JBmGQOtJikz6/Uter5+AokkI6k65c8CmhJcyRBjF460q5n33Tm1jKfSk
 FiVI1yph5Id/q62bzyQRzrwGFMyNR/AVvtsQU6jCxEFRlhmkNVombZ1pa
 uyJtfqKnh3jcA5Jl/tR+ed5/07m3Nos9wqwvbqiF9pMgzKyQ5gNRsxLA/
 eMObaL2V/BwpQUpmbyVOwF4Dqoog5tSWYVhDG8glZb134T+swUE49onKQ Q==;
X-CSE-ConnectionGUID: GTUDQyHtT9ebJJCTm4tueA==
X-CSE-MsgGUID: PrMCPhzGQa+0mmin19UyBQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11340"; a="189710632"
X-IronPort-AV: E=Sophos;i="6.13,274,1732546800"; d="scan'208";a="189710632"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
 by esa4.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2025 17:43:10 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com
 [192.168.83.64])
 by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id C6BDED6EA5
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 17:43:08 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 89C8BCF7C3
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 17:43:08 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.135.101])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id EDA481A000B;
 Mon, 10 Feb 2025 16:43:07 +0800 (CST)
To: ltp@lists.linux.it
Date: Mon, 10 Feb 2025 16:43:10 +0800
Message-ID: <20250210084310.357516-1-maxj.fnst@fujitsu.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] fsync03: Convert docs to docparse
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
 testcases/kernel/syscalls/fsync/fsync03.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/testcases/kernel/syscalls/fsync/fsync03.c b/testcases/kernel/syscalls/fsync/fsync03.c
index d32c4a3e7..1fd8e8648 100644
--- a/testcases/kernel/syscalls/fsync/fsync03.c
+++ b/testcases/kernel/syscalls/fsync/fsync03.c
@@ -4,14 +4,15 @@
  *   Copyright (c) 2019 SUSE LLC <mdoucha@suse.cz>
  */
 
-/*
- * Test Description:
- *  Testcase to check that fsync(2) sets errno correctly.
- *  1. Call fsync() on a pipe(fd), and expect EINVAL.
- *  2. Call fsync() on a socket(fd), and expect EINVAL.
- *  3. Call fsync() on a closed fd, and test for EBADF.
- *  4. Call fsync() on an invalid fd, and test for EBADF.
- *  5. Call fsync() on a fifo(fd), and expect EINVAL.
+/*\
+ * [Description]
+ *
+ * Verify that fsync(2) sets errno to:
+ * 1. EINVAL if calling fsync() on a pipe(fd)
+ * 2. EINVAL if calling fsync() on a socket(fd)
+ * 3. EBADF if calling fsync() on a closed fd
+ * 4. EBADF if calling fsync() on an invalid fd
+ * 5. EINVAL if calling fsync() on a fifo(fd)
  */
 
 #include <unistd.h>
-- 
2.47.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
