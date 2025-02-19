Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A15BC021AA
	for <ltp@archiver.kernel.org>; Wed, 19 Feb 2025 05:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1739942529; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=HDpMO0gMQ72+tmDgCdkHH4vrmu0/qW3Smp8hsyzwo6I=;
 b=W4QLr7k0b4Nr9OykcHHyuGgzTlT3qwTDHFomtYnwcYt5QbygZ6Fi60yj5qLhIVck4c4/+
 fzdunaydIedgFNchfyKQM6PNzSZZ7IDFhhb238+gSc62r5LpMqiKl7PTHr4THDmvBrOOCP7
 Dx5mcHihKtc/Ufp2WoyvtsXUx33x/9w=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6B3063C290F
	for <ltp@archiver.kernel.org>; Wed, 19 Feb 2025 06:22:09 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BB4263C1769
 for <ltp@lists.linux.it>; Wed, 19 Feb 2025 06:21:48 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=139.138.61.253;
 helo=esa8.hc1455-7.c3s2.iphmx.com; envelope-from=maxj.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa8.hc1455-7.c3s2.iphmx.com (esa8.hc1455-7.c3s2.iphmx.com
 [139.138.61.253])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8A4D21029631
 for <ltp@lists.linux.it>; Wed, 19 Feb 2025 06:21:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1739942507; x=1771478507;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=8kYTwLzrdw1RSsHU38HAw/hSmofZFQSIBNdMJsVyF84=;
 b=QLbixvsoLdHfw8uuecBU8ryIem+sfqrObWTuPsX6bVnH7KCuL86F3Cf8
 pjk/93PFqhmyQp0aseTisE+ssYQ4Kv/If2wuzKhDBHfd+UGix3/FDdB08
 cKpnyqTXzIakYcQJPxK1xQgMaGXHWASlviDp+tJPjSPoEltd4NOAJx9Dl
 JSQ4I55lWOmMVIXH4r3WO1EGNRN0+4O98bXIGdJbudOTHm+hgN8FDw7zg
 YTtBD9VP66WU5izfWmgxLVE4tWx0g5mmjbW/CuKBewTYUV3sDUIQiY3p7
 ZBTckFpd5EVwaK6y98j1tqFREG3xIm8QjzRZ2ILMjLuG2o9VdSnNUYAmr Q==;
X-CSE-ConnectionGUID: JTcrwpPlSrCIACWf9Y+nJw==
X-CSE-MsgGUID: jwGX59k1S8qtQP4OsP+G+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="178444357"
X-IronPort-AV: E=Sophos;i="6.13,298,1732546800"; d="scan'208";a="178444357"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
 by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2025 14:21:43 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com
 [192.168.87.60])
 by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 37FFADBB91
 for <ltp@lists.linux.it>; Wed, 19 Feb 2025 14:21:42 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id F1C4FD6FF9
 for <ltp@lists.linux.it>; Wed, 19 Feb 2025 14:21:41 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.135.101])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 2EFEB1A0003;
 Wed, 19 Feb 2025 13:21:41 +0800 (CST)
To: ltp@lists.linux.it,
	pvorel@suse.cz
Date: Wed, 19 Feb 2025 13:20:09 +0800
Message-ID: <20250219052009.1020281-1-maxj.fnst@fujitsu.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250218121745.GA2469726@pevik>
References: <20250218121745.GA2469726@pevik>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] fork13: Fix the doc
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

Use :: to keep the race description as original text when viewed in RST format.

Signed-off-by: Ma Xinjian <maxj.fnst@fujitsu.com>
---
 testcases/kernel/syscalls/fork/fork13.c | 27 +++++++++++++------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/testcases/kernel/syscalls/fork/fork13.c b/testcases/kernel/syscalls/fork/fork13.c
index 3da698e33..add8fc77e 100644
--- a/testcases/kernel/syscalls/fork/fork13.c
+++ b/testcases/kernel/syscalls/fork/fork13.c
@@ -15,21 +15,22 @@
  * implementation.  Furthermore, many shell scripts assume that pid
  * numbers will not be used for some length of time.
  *
- * [Race Description]
- * ---------------------------------------------------------------------
- * A                                B
+ * [Race Description] ::
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
