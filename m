Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA82AC021AA
	for <ltp@archiver.kernel.org>; Wed, 19 Feb 2025 09:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1739958367; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=VZULfg8gt9VticfokEcpV2FWVZiVT1ycnSVwtM+WqA0=;
 b=C3lDaPNTC6sNtYVTuL82ccr5r/waUPED0+lTbMepyNfFXY5bNS7yTgi7wUi+yeQKaIbVl
 NhMQLXpzUVZ3pA0WYwIjfmuqzvE21/pe+VTfRusXHydvi1J8wrbZkhwsSO/DVqr24VzDL6h
 2YYl7BYwHq1f55QpkhnKi3k94Us2fYE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3E11B3C0503
	for <ltp@archiver.kernel.org>; Wed, 19 Feb 2025 10:46:07 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A81EC3C0503
 for <ltp@lists.linux.it>; Wed, 19 Feb 2025 10:45:45 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=139.138.37.100;
 helo=esa12.hc1455-7.c3s2.iphmx.com; envelope-from=maxj.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com
 [139.138.37.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E33BE601CC0
 for <ltp@lists.linux.it>; Wed, 19 Feb 2025 10:45:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1739958345; x=1771494345;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=AHYITH5Ay2HgRlDewyuIOpo28oqJR404I/CEQm7oOe8=;
 b=Tqeq4ivsmZoGI3FMbk7qpNxuAHYwzPPQXZTmys2icQNB4aZe6fPQnzdF
 uqj0gZgyIO+bqDAMCvTJFhXqTPty2FK/z3rGZccqhmxPOuKFfua22TuKv
 HzFGmxj0sQwfoLqHT0NSWUnpP9ESc12b7h/njZbFVOSG6w5uuVMeneBgo
 RV1THh6okJDsIepQqaUW9zhkrvq4q1gxHXu8eNDMfN2+U7L6oosKhMw1b
 8X2MAbv2FRQfBrpPg13xk0ahK9Ae5obCjM5NHvsYtmZ9z5dFsCGQbtJBP
 /f23Ge5cYo7O+S54PuKW7dpt1G4AFlg/GVh+uxvpNkjplK28prhinAALF A==;
X-CSE-ConnectionGUID: M3wiRmG0QiuewcOZxAUy5Q==
X-CSE-MsgGUID: pkpOSqQ8Twu83ZtEIJ6Czw==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="169424719"
X-IronPort-AV: E=Sophos;i="6.13,298,1732546800"; d="scan'208";a="169424719"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
 by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2025 18:45:43 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com
 [192.168.83.66])
 by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id CA967D4F5F
 for <ltp@lists.linux.it>; Wed, 19 Feb 2025 18:45:40 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 949EF17CB0
 for <ltp@lists.linux.it>; Wed, 19 Feb 2025 18:45:40 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.135.101])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id F12D61A0003;
 Wed, 19 Feb 2025 17:45:39 +0800 (CST)
To: ltp@lists.linux.it
Date: Wed, 19 Feb 2025 17:45:44 +0800
Message-ID: <20250219094544.1048098-1-maxj.fnst@fujitsu.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] getrlimit02: Fix comment indentation to fit RST format
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
 testcases/kernel/syscalls/getrlimit/getrlimit02.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/getrlimit/getrlimit02.c b/testcases/kernel/syscalls/getrlimit/getrlimit02.c
index 20c247a0e..bbedabe28 100644
--- a/testcases/kernel/syscalls/getrlimit/getrlimit02.c
+++ b/testcases/kernel/syscalls/getrlimit/getrlimit02.c
@@ -8,10 +8,10 @@
  * Test for checking error conditions for getrlimit(2):
  *
  * 1. getrlimit(2) returns -1 and sets errno to EFAULT if an invalid
- *	  address is given for address parameter.
+ *    address is given for address parameter.
  * 2. getrlimit(2) returns -1 and sets errno to EINVAL if an invalid
- *	  resource type (RLIM_NLIMITS is a out of range resource type) is
- *	  passed.
+ *    resource type (RLIM_NLIMITS is a out of range resource type) is
+ *    passed.
  */
 
 #include <sys/resource.h>
-- 
2.47.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
