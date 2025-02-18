Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88397C021AA
	for <ltp@archiver.kernel.org>; Tue, 18 Feb 2025 09:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1739871806; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=MP+/BHoWqAYSIU2PvLeOHBIKKkZESeHmr3sUO/+alFw=;
 b=JY31XqMbvUiMVmKICDpkQUByb4AQDB5otpqGANkqMji2nAgmVPZRyUqTJGHW5H1sLOJ8Z
 dhLpZqv6GEoMxNXmfImQgSYSJ6UtSFQc/JMnczcQ1tp0rKljoyDQqubRUfvEPlicsWTTbga
 oY2TIZJkIkjLKz1o8aotOC7AWUNDOhI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B1E633C9C39
	for <ltp@archiver.kernel.org>; Tue, 18 Feb 2025 10:43:26 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D6AB23C98B5
 for <ltp@lists.linux.it>; Tue, 18 Feb 2025 10:43:05 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=139.138.37.100;
 helo=esa12.hc1455-7.c3s2.iphmx.com; envelope-from=maxj.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com
 [139.138.37.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4E91A141D0BA
 for <ltp@lists.linux.it>; Tue, 18 Feb 2025 10:43:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1739871784; x=1771407784;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=7mimKssYx3/CQTqCjzAMmjVfUEAoVO7/zKXh546ee7k=;
 b=fpGEI9G77bUeBeBNpViP7EWRIu0aMjptZao8d8d024kJmBXLD5FxEhHI
 NEiPgA7YG+j96VIW21QSV+GpS0D77oO0hU4gN1oF+8N/9U8iy/O+T0RRh
 lLjxd6mx7wGLeYfzHrwTj9wAO31BrWjjB52U7gjMChPq41pAlSizR3FSO
 Wd0Thx8ysDupeS3sJ0xID1ig9taXkqeiBUXGucPGGmjCeaNNfRkoFWiTl
 9LBhrwir31VhEFmRa/MPwHmByTWInzzurJ+f3UVJEk6ohV4kA+zt5uSPh
 Ng4DDV/b2h+IAkyLpGPLx7uia8YplGCT3ae1TZZLw8fvyJiOjql7ByVUE Q==;
X-CSE-ConnectionGUID: ys8Xy8fUTqqEOPa9071OzA==
X-CSE-MsgGUID: 9JJc4P5wS7Cr6qjClqDVNA==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="169285591"
X-IronPort-AV: E=Sophos;i="6.13,295,1732546800"; d="scan'208";a="169285591"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
 by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2025 18:43:01 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com
 [192.168.87.58])
 by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 31AC4D4807
 for <ltp@lists.linux.it>; Tue, 18 Feb 2025 18:42:59 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id EBE52F80DA
 for <ltp@lists.linux.it>; Tue, 18 Feb 2025 18:42:58 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.135.101])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 61D671A000B;
 Tue, 18 Feb 2025 17:42:58 +0800 (CST)
To: ltp@lists.linux.it
Date: Tue, 18 Feb 2025 17:43:02 +0800
Message-ID: <20250218094302.956853-1-maxj.fnst@fujitsu.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] fork13: Fix the doc
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

Previously, the use of "-" would cause "Race Description" to be misinterpreted as a subsection.
Add a blank line to avoid it and use :: to keep the description as origin text.

Signed-off-by: Ma Xinjian <maxj.fnst@fujitsu.com>
---
 testcases/kernel/syscalls/fork/fork13.c | 27 +++++++++++++------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/testcases/kernel/syscalls/fork/fork13.c b/testcases/kernel/syscalls/fork/fork13.c
index 3da698e33..9e07c9d4f 100644
--- a/testcases/kernel/syscalls/fork/fork13.c
+++ b/testcases/kernel/syscalls/fork/fork13.c
@@ -15,21 +15,22 @@
  * implementation.  Furthermore, many shell scripts assume that pid
  * numbers will not be used for some length of time.
  *
- * [Race Description]
- * ---------------------------------------------------------------------
- * A                                B
+ * **Race Description** ::
  *
- * // pid == offset == n            // pid == offset == n + 1
- * test_and_set_bit(offset, map->page)
- *                                  test_and_set_bit(offset, map->page);
- *                                  pid_ns->last_pid = pid;
- * pid_ns->last_pid = pid;
- *                                  // pid == n + 1 is freed (wait())
+ *    ---------------------------------------------------------------------
+ *    A                                B
  *
- *                                  // Next fork()...
- *                                  last = pid_ns->last_pid; // == n
- *                                  pid = last + 1;
- * ---------------------------------------------------------------------
+ *    // pid == offset == n            // pid == offset == n + 1
+ *    test_and_set_bit(offset, map->page)
+ *                                     test_and_set_bit(offset, map->page);
+ *                                     pid_ns->last_pid = pid;
+ *    pid_ns->last_pid = pid;
+ *                                     // pid == n + 1 is freed (wait())
+ *
+ *                                     // Next fork()...
+ *                                     last = pid_ns->last_pid; // == n
+ *                                     pid = last + 1;
+ *    ---------------------------------------------------------------------
  */
 
 #include <sys/types.h>
-- 
2.47.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
