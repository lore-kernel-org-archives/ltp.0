Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B60CC369A8
	for <ltp@archiver.kernel.org>; Fri, 11 Apr 2025 07:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1744356203; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=9gNcbP/Y+pALJnPLV6bva5CgtzDpaAhr+TA0fNiWZDc=;
 b=ZhAcH9zWFiAVbbSc/+rdVzJ+AdTYjInDlo/BTrFWopAbbEav7u8a7rdtoTvwtbWZeLOzA
 IlUvUuS6682gd6YCmO1r/dFzTGpxhLHUk06CH1CaV/TiSJKzMAc+clD2PQbIJVH5Jypa6w3
 DyDBspZcKD+/2D3vIQP6Y/7C3SkB2x4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 313063CB596
	for <ltp@archiver.kernel.org>; Fri, 11 Apr 2025 09:23:23 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1D0A63CB355
 for <ltp@lists.linux.it>; Fri, 11 Apr 2025 09:23:01 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=68.232.139.117;
 helo=esa4.hc1455-7.c3s2.iphmx.com; envelope-from=maxj.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa4.hc1455-7.c3s2.iphmx.com (esa4.hc1455-7.c3s2.iphmx.com
 [68.232.139.117])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id EEF8E600A47
 for <ltp@lists.linux.it>; Fri, 11 Apr 2025 09:23:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1744356180; x=1775892180;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=R9qiSosM5ObHT+1jzo7+xDr6Wx0EcD3GsHeJQsWBCBk=;
 b=SyhXdlAkZdOQ2f+uoB8fR4/t9GzHzygnQRDTV86HwoZsHd9HnKvRfnAx
 XdIFbmuj6KIAsuqnWGUW1r8yAM/Z1/4LUUwo3QNrbCF9e/oZfLB0nDqOj
 I35G1uTQJNpoD/eNMwhBx2xtJEAPrvL2oM/CQW5jr6BQDJCNHcmweRqfk
 LgQ/FoxJ7ZE2svEOyQxwAw9kEQ3CagsHmIHLCL4SbpVnaezsA0Kwr7Jxs
 jFVSi9NZRx5/EBFjMcxexwrn3pnJqK4Mu9VgbTJ6ZvNUkq+bHNk6mVNTk
 F+kvafxAffCt0DKrXFTPPMOgomKGf9xjKzJyVl4RScnxfMuf/zFIqZ+EW A==;
X-CSE-ConnectionGUID: tjLRYiwgQYShVx8ulYOCEw==
X-CSE-MsgGUID: bGr9V/QeTEqRGenA3bYDjQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="196478389"
X-IronPort-AV: E=Sophos;i="6.15,203,1739804400"; d="scan'208";a="196478389"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
 by esa4.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Apr 2025 16:22:59 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com
 [192.168.83.67])
 by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id CEA26D4F57
 for <ltp@lists.linux.it>; Fri, 11 Apr 2025 16:22:56 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 8A542F64C
 for <ltp@lists.linux.it>; Fri, 11 Apr 2025 16:22:56 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.135.101])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id E96A41A0078;
 Fri, 11 Apr 2025 15:22:55 +0800 (CST)
To: ltp@lists.linux.it
Date: Fri, 11 Apr 2025 15:23:09 +0800
Message-ID: <20250411072309.43689-1-maxj.fnst@fujitsu.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] mmap18: Fix the doc
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

Use :: to keep the description of stack memory map as original text when viewed in RST format.

Signed-off-by: Ma Xinjian <maxj.fnst@fujitsu.com>
---
 testcases/kernel/syscalls/mmap/mmap18.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/testcases/kernel/syscalls/mmap/mmap18.c b/testcases/kernel/syscalls/mmap/mmap18.c
index 3de524ecc..5f0eee6ba 100644
--- a/testcases/kernel/syscalls/mmap/mmap18.c
+++ b/testcases/kernel/syscalls/mmap/mmap18.c
@@ -28,18 +28,18 @@
  *
  * Kernel default `stack_guard_gap` size is `256 * getpagesize()`.
  *
- * The stack memory map would look like:
+ * The stack memory map would look like::
  *
- * |  -  -  -   reserved  size   -  -  -  |
+ *   |  -  -  -   reserved  size   -  -  -  |
  *
- * +-- - - - --+------------+-------------+
- * | 256 pages |  unmapped  |   mapped    |
- * +-- - - - --+------------+-------------+
- *                          | mapped size |
- * ^           |  -  -  stack size  -  -  |
- * start
- *             ^                          ^
- *             stack bottom       stack top
+ *   +-- - - - --+------------+-------------+
+ *   | 256 pages |  unmapped  |   mapped    |
+ *   +-- - - - --+------------+-------------+
+ *                            | mapped size |
+ *   ^           |  -  -  stack size  -  -  |
+ *   start
+ *               ^                          ^
+ *               stack bottom       stack top
  *
  * **Test 2**
  *
-- 
2.47.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
