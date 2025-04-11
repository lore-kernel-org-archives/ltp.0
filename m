Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E065C36010
	for <ltp@archiver.kernel.org>; Fri, 11 Apr 2025 04:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1744344627; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=gY7KUyIoVfWWZrRJyOVrtK+KJc9Qv+odMOZXilOMyHM=;
 b=RfvPU3Esed+oZA8J3EJRu3BlsmROT8lqIaJNlT635D1WNMrMIqJg0YixckW0jG67d/YjX
 NNGP92Ry+B01uZTpY/9TQG0IXRHYxAS5ogkcqyFxek6FgQbtb2YTE7kakOQu41oz/KMPUMk
 i0QleB5S5vgjC9jG2ILD3OC6L2SKxgA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E59673CB54F
	for <ltp@archiver.kernel.org>; Fri, 11 Apr 2025 06:10:27 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 80EE83CA320
 for <ltp@lists.linux.it>; Fri, 11 Apr 2025 06:10:05 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=68.232.139.139;
 helo=esa6.hc1455-7.c3s2.iphmx.com; envelope-from=maxj.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa6.hc1455-7.c3s2.iphmx.com (esa6.hc1455-7.c3s2.iphmx.com
 [68.232.139.139])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 3CB05600735
 for <ltp@lists.linux.it>; Fri, 11 Apr 2025 06:10:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1744344606; x=1775880606;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=g4vp5uE4fc2XRjQSfGKnVhkvc+AXayeIRGQOn5UVQzo=;
 b=WIJSSU97Sw37ZV/cVSzmkphvNxhOXftnF6z9UmwvBfdurZY6Sl/4XyrH
 1mI/GERQ35GF/zgHtYOJ1sVRYbX4uBX6jnba4LHArrDe7chMFhVzwWrp/
 K9XM+FWyQ2RQzMwOSVUHBEoDkBJcHu4As/oC3dF587MG+hUhsG3r/y6hG
 BX34lzE8UZvRlu9qR2UlOnI3Qdp0mX07nWeAS8NYIL9pDtIcR6l9rCE1a
 zeKN9/tH+iI2+mym9vohp00qbYvrb4xGV/O17Q0G5ymhjwooPQH1LsFly
 biVwSoHrdPSRjNBJF5koRdGOhtCUwybJj3HoajBT+6MpmNxCpP9yHZ0Sv w==;
X-CSE-ConnectionGUID: DxxK5n8MQ8KSYnFM+Ujr/g==
X-CSE-MsgGUID: qlISSGChQhioMppfKP89Lw==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="198913953"
X-IronPort-AV: E=Sophos;i="6.15,203,1739804400"; d="scan'208";a="198913953"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
 by esa6.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Apr 2025 13:10:04 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com
 [192.168.83.64])
 by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 33E46E8528
 for <ltp@lists.linux.it>; Fri, 11 Apr 2025 13:10:01 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id E58E1D198B
 for <ltp@lists.linux.it>; Fri, 11 Apr 2025 13:10:00 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.135.101])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 6F7521A0078;
 Fri, 11 Apr 2025 12:09:59 +0800 (CST)
To: ltp@lists.linux.it
Date: Fri, 11 Apr 2025 12:10:08 +0800
Message-ID: <20250411041008.20272-1-maxj.fnst@fujitsu.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] sched_getparam03: Fix the doc to fit RST format
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
 .../kernel/syscalls/sched_getparam/sched_getparam03.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/syscalls/sched_getparam/sched_getparam03.c b/testcases/kernel/syscalls/sched_getparam/sched_getparam03.c
index 7192b0170..567bc6f7c 100644
--- a/testcases/kernel/syscalls/sched_getparam/sched_getparam03.c
+++ b/testcases/kernel/syscalls/sched_getparam/sched_getparam03.c
@@ -4,14 +4,11 @@
  */
 
 /*\
- * Verify that:
+ * Verify that, sched_getparam(2) returns -1 and sets errno to
  *
- * - sched_getparam(2) returns -1 and sets errno to ESRCH if the
- * process with specified pid could not be found
- * - sched_getparam(2) returns -1 and sets errno to EINVAL if
- * the parameter pid is an invalid value (-1)
- * - sched_getparam(2) returns -1 and sets errno to EINVAL if the
- * parameter p is an invalid address
+ * - ESRCH if the process with specified pid could not be found
+ * - EINVAL if the parameter pid is an invalid value (-1)
+ * - EINVAL if the parameter p is an invalid address
  */
 
 #include <errno.h>
-- 
2.47.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
