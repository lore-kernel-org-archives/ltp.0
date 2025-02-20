Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28FFAC021AD
	for <ltp@archiver.kernel.org>; Thu, 20 Feb 2025 07:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1740037170; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=3IC3gamyspjNuVu8v4kEyrZnZVRw9SkBms4xm4gGCXo=;
 b=pFHfJPJCSsgcXlxdoMsF5O0p087151+hDKixFsBSmLReWKcHxrzxynWk3oxHW+O3TWtzL
 nZZUHSvuDENwod7MJs63bEdkk/hFc6GD7L27P42qfqB0eZpvbbV2oIytr4+AHH6e+RzW6ea
 NRY014jbmJyoh0qfJa28RAIq9csmijM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 825F23C65B9
	for <ltp@archiver.kernel.org>; Thu, 20 Feb 2025 08:39:30 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E80B93C0FCF
 for <ltp@lists.linux.it>; Thu, 20 Feb 2025 08:39:08 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=139.138.37.100;
 helo=esa12.hc1455-7.c3s2.iphmx.com; envelope-from=maxj.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com
 [139.138.37.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 47963652038
 for <ltp@lists.linux.it>; Thu, 20 Feb 2025 08:39:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1740037148; x=1771573148;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=yAv2lSzk9gsvcD1fKOQcwS/Sp40vZ+f3sz1c1q89WXM=;
 b=SE/gbrKmWf1jIE50DATYOzNDLd+Z+6Tz4hQ8fCyPJcH+1qVMKxgsXUWK
 MQ7NBOJhAKOIeFeE3PpfgPWkPUEkcQFxggkoPGJT3nC2XyUj4dTKwgx/p
 r52+ey+Hy2GYBWo95cIJZZ6EbdqGtee27oVwo2R9EcMtkFdd8t5rPCt3y
 VYqKEdPmwNXVLuXp07D+HUTYiYM1wWYaz7RNbbXzah8JiRFmOdGs2IwY6
 HkOpnE109zVRsrmuDJiD1k9Dlw7AuaqV65VFYFab+jWUC3uDrTtfFyUX1
 74OQJn4z+MxsY8gBNBYgAf8jqiAmOqRVx5+8dMZ5YJyKTrAeedQkZ9pZM A==;
X-CSE-ConnectionGUID: ZGv/KGMQSBCaLxAg5Qinfw==
X-CSE-MsgGUID: mSjNH6v6QdWxUPoHUStERA==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="169570818"
X-IronPort-AV: E=Sophos;i="6.13,301,1732546800"; d="scan'208";a="169570818"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
 by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2025 16:39:06 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com
 [192.168.87.61])
 by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 4F35DC226D
 for <ltp@lists.linux.it>; Thu, 20 Feb 2025 16:39:04 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 15D0AD52EF
 for <ltp@lists.linux.it>; Thu, 20 Feb 2025 16:39:04 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.135.101])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 73EFE1A0003;
 Thu, 20 Feb 2025 15:39:03 +0800 (CST)
To: ltp@lists.linux.it
Date: Thu, 20 Feb 2025 15:39:07 +0800
Message-ID: <20250220073907.1122535-1-maxj.fnst@fujitsu.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] readahead01: Fix comment indentation to fit RST format
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
 testcases/kernel/syscalls/readahead/readahead01.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/readahead/readahead01.c b/testcases/kernel/syscalls/readahead/readahead01.c
index fdf1bb044..890e48014 100644
--- a/testcases/kernel/syscalls/readahead/readahead01.c
+++ b/testcases/kernel/syscalls/readahead/readahead01.c
@@ -9,7 +9,7 @@
  *
  * - EBADF when fd is not a valid file descriptor or is not open for reading.
  * - EINVAL when fd does not refer to a file type to which readahead()
- *          can be applied.
+ *   can be applied.
  */
 #define _GNU_SOURCE
 #include <errno.h>
-- 
2.47.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
