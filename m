Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9760C021B0
	for <ltp@archiver.kernel.org>; Thu, 20 Feb 2025 07:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1740037418; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=F9a9/xpsFEwc48FkYwtuiH/jRXzzWk38q0FpwOO8BXg=;
 b=ld2Cq56fa04uNIKNzyAmRLd9f29wwzMMYHZUAjiBHtp8pPSBoTLj/weuXOsGxYP4QtdZX
 VBbK36NB2aXzEONAS4jF9XiqKzSZNCcB8wtPrVdnkrJ9ZbQGDFV0L/TMwoqWJNgOCJ9+U3y
 bocXSSNbjqygS3vI4HlmEPC2CLYK7L4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 72F623C239D
	for <ltp@archiver.kernel.org>; Thu, 20 Feb 2025 08:43:38 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1DF543C0FCF
 for <ltp@lists.linux.it>; Thu, 20 Feb 2025 08:43:16 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=68.232.139.139;
 helo=esa6.hc1455-7.c3s2.iphmx.com; envelope-from=maxj.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa6.hc1455-7.c3s2.iphmx.com (esa6.hc1455-7.c3s2.iphmx.com
 [68.232.139.139])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2436A65375D
 for <ltp@lists.linux.it>; Thu, 20 Feb 2025 08:43:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1740037396; x=1771573396;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=T7hvW37zqxhSOGIALKwBPKNQOnC8Fwyp2s5YmVqa82c=;
 b=EZH8dl4Stqzshqszyp0iKh7LRr4vjmKzhIeTV8bfoubBMH3JvuDHNCOn
 MHHspXHak6DpUlS7PvEGbJ6sJP1u9X8Q4Pf2uCmudjRkSD3BgoQQl3LIv
 VtlYCTfwDVC/KTL2Kwp9OpISl6xC+wA9yWgAnWg9DQNy9gSoh63Bovrms
 sHkhZ+CXtQrmgH7YgfVPpaqMh7zXRL5Qa/F0Wg5DyUQWPZ4+EB9gjVpKL
 dM9C/dg9aStQlXzk5Dfm5Oo7O9y7ilbxbpoq0gqd6Y9xYjik2TkYWgjVB
 WrvHrBzQXHthUQ7PeF/eWvdtSfRuasXpo/s6C8Fdr7WGGHs36Hv7mWX11 A==;
X-CSE-ConnectionGUID: SztdVHfxS0WmCPNKcTCZtg==
X-CSE-MsgGUID: mEoPs3F1TFiJQHEiusKSsw==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="193259957"
X-IronPort-AV: E=Sophos;i="6.13,301,1732546800"; d="scan'208";a="193259957"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
 by esa6.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2025 16:43:14 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com
 [192.168.83.67])
 by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id CF66BE8521
 for <ltp@lists.linux.it>; Thu, 20 Feb 2025 16:43:11 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 8FED6F31A7
 for <ltp@lists.linux.it>; Thu, 20 Feb 2025 16:43:11 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.135.101])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 0D45C1A0071;
 Thu, 20 Feb 2025 15:43:11 +0800 (CST)
To: ltp@lists.linux.it
Date: Thu, 20 Feb 2025 15:43:13 +0800
Message-ID: <20250220074313.1122911-1-maxj.fnst@fujitsu.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] sched_getparam01: Fix comment indentation to fit RST
 format
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
 testcases/kernel/syscalls/sched_getparam/sched_getparam01.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/sched_getparam/sched_getparam01.c b/testcases/kernel/syscalls/sched_getparam/sched_getparam01.c
index 2c56286d6..554ef2ff5 100644
--- a/testcases/kernel/syscalls/sched_getparam/sched_getparam01.c
+++ b/testcases/kernel/syscalls/sched_getparam/sched_getparam01.c
@@ -10,9 +10,9 @@
  * the specified process:
  *
  * - If pid is zero, sched_getparam(2) gets the scheduling parameters
- * for the calling process.
+ *   for the calling process.
  * - If pid is not zero, sched_getparam(2) gets the scheduling
- * parameters for the specified [pid] process.
+ *   parameters for the specified [pid] process.
  */
 
 #include <errno.h>
-- 
2.47.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
