Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54C6BC021B2
	for <ltp@archiver.kernel.org>; Thu, 20 Feb 2025 09:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1740042017; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=DZUDIMEtQZCrlYJ/IJwnEao1yK5HHVtq/FWV0ubMuSo=;
 b=KroQHsfzl+a6vCfQ5Du8QeYGwex8Gq03S29Z35HsEjV2HEy+rsIAp35u0bcjwyu0KNx86
 XZFtrgF2D0/lPpBvbp0zvIpCS8mxD415l9KocHXp1b/0eYvfbOt02PW1nVa8EnSSn9GgD2c
 1aTNBd14g0QkpUtAbv4Icdp692Ja3Gs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 47B853C4F81
	for <ltp@archiver.kernel.org>; Thu, 20 Feb 2025 10:00:17 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9D2093C2F29
 for <ltp@lists.linux.it>; Thu, 20 Feb 2025 09:59:54 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=207.54.90.137;
 helo=esa11.hc1455-7.c3s2.iphmx.com; envelope-from=maxj.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa11.hc1455-7.c3s2.iphmx.com (esa11.hc1455-7.c3s2.iphmx.com
 [207.54.90.137])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B8F1F638110
 for <ltp@lists.linux.it>; Thu, 20 Feb 2025 09:59:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1740041994; x=1771577994;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=2jDbXyWgTDjuYiTI/rOxn2ldJWYlqPDYDEzJdei+fOA=;
 b=MwhBQlY5WSPsBjjX3ygqUxHTAJt+3Nyk68whaKg++ZJB4SCwaxF8SoIv
 sI5W70LQAHQMU1N62SacOI+8kIkEbdVE8vb52pypi0pZRTGsYzS/4mOn0
 lletmq2Q1uWaeEakuuC3xUO7a57vEGSivxN1g/RsmxdtUP1/ipbSobzj0
 jdpLaZyLuJNm8NewWL1c7kuaXQzS8worS+AAlq2SuI2/6Hv//eSZaDyq5
 WB/Nr7e9Xn2S1hcX51OWFgYdm4N4C2g/gwnWTnD/wPh9SePpYh9MUjiYT
 UyzFgnZ3vFMfFMsc8BAh/ovw78udHCmIfny2bVun6/2MGpdwaBKKSRtwa w==;
X-CSE-ConnectionGUID: /Q4MSddSTuC4FbhQf8/jgQ==
X-CSE-MsgGUID: 68x2VQHjSd+YyWb2dfKgqQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="170127795"
X-IronPort-AV: E=Sophos;i="6.13,301,1732546800"; d="scan'208";a="170127795"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
 by esa11.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2025 17:59:52 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com
 [192.168.83.67])
 by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 9270AD6EA7
 for <ltp@lists.linux.it>; Thu, 20 Feb 2025 17:59:49 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 536C4F31CD
 for <ltp@lists.linux.it>; Thu, 20 Feb 2025 17:59:49 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.135.101])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id CB6AB1A0003;
 Thu, 20 Feb 2025 16:59:48 +0800 (CST)
To: ltp@lists.linux.it,
	andrea.cervesato@suse.com
Date: Thu, 20 Feb 2025 16:59:45 +0800
Message-ID: <20250220085945.1128757-1-maxj.fnst@fujitsu.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4] fsync03: Convert docs to RST format
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
 testcases/kernel/syscalls/fsync/fsync03.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/testcases/kernel/syscalls/fsync/fsync03.c b/testcases/kernel/syscalls/fsync/fsync03.c
index d32c4a3e7..3eb47046e 100644
--- a/testcases/kernel/syscalls/fsync/fsync03.c
+++ b/testcases/kernel/syscalls/fsync/fsync03.c
@@ -4,14 +4,14 @@
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
+ * Verify that, fsync(2) returns -1 and sets errno to
+ *
+ * - EINVAL if calling fsync() on a pipe(fd).
+ * - EINVAL if calling fsync() on a socket(fd).
+ * - EBADF if calling fsync() on a closed fd.
+ * - EBADF if calling fsync() on an invalid fd.
+ * - EINVAL if calling fsync() on a fifo(fd).
  */
 
 #include <unistd.h>
-- 
2.47.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
