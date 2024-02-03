Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8E80C4828F
	for <ltp@archiver.kernel.org>; Sat,  3 Feb 2024 05:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1706937576; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=mpf1hpJNCfy5lUXbFPOmwEyeDECFV4KJ0DKxpLBTXZM=;
 b=Sl+/JsrZBfryh5pzUY+PIrgN/vcZzzRBzw/KCUHwba58AY1jxiAsqEQR59Ddes/4qeTJS
 zSzbFhp3QMX/YZR5JNnY6/RtC5I6JVu4DSE+kjvhfxiSih73/ER2xzGiiVFQeJsPumZV/4Q
 NILynmIyM/AVr3g8ujNHRZWyD+8KhKA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 153CA3CF85F
	for <ltp@archiver.kernel.org>; Sat,  3 Feb 2024 06:19:36 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 042E73CC8AF
 for <ltp@lists.linux.it>; Sat,  3 Feb 2024 06:19:13 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=139.138.36.223;
 helo=esa9.hc1455-7.c3s2.iphmx.com; envelope-from=xuyang2018.jy@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com
 [139.138.36.223])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2720110001A1
 for <ltp@lists.linux.it>; Sat,  3 Feb 2024 06:19:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1706937553; x=1738473553;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=w1O9wzN68xpZ5GOxIq//UEEB+PfNjN3knxEQcl9E8mg=;
 b=HlstMaQgiydU6/ikverFjMs04Rgy15jCHK3qV3+Q+JTLZ/UYP1WWNxPt
 MB4INy/tkhc4SCTth0pzh5R0KzxdPbg8kB3Wl8BBcDiQN7GmTsIFvw8MS
 m3jdCzw50PMR5kLmDN0rvHgnCcmPCcwKJkfOjCxRPpcwmDalGGcoHoHee
 kjMAGOkpvkto51vtWM8IyXZzc9+SX/EoOb05piYkw7lX70Pga9ePBYJ8V
 ApQ8ci17CxULCSfhyTXpd4cTEi1in0aVbPO1rpiNQYakYN6ZaObTca980
 naRj/HmzucMf4jYQYRVxHTLydOUo/5rfg5KsdHtYY9x1Y+GoNM9/yQoq8 Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="136706078"
X-IronPort-AV: E=Sophos;i="6.05,238,1701097200"; d="scan'208";a="136706078"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
 by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Feb 2024 14:19:08 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com
 [192.168.87.58])
 by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 6942AD4804
 for <ltp@lists.linux.it>; Sat,  3 Feb 2024 14:19:06 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 9B212242E91
 for <ltp@lists.linux.it>; Sat,  3 Feb 2024 14:19:05 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 361336CB29
 for <ltp@lists.linux.it>; Sat,  3 Feb 2024 14:19:05 +0900 (JST)
Received: from rhel93GA.g08.fujitsu.local (unknown [10.167.221.71])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id BA76F1A009A;
 Sat,  3 Feb 2024 13:19:04 +0800 (CST)
To: ltp@lists.linux.it
Date: Sat,  3 Feb 2024 00:19:00 -0500
Message-Id: <20240203051901.3000-1-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28162.002
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28162.002
X-TMASE-Result: 10--3.317000-10.000000
X-TMASE-MatchedRID: Y8KQO0q7nHqhhjsqgSuNbxF4zyLyne+AVBDQSDMig9HEosIs7IJbkKVG
 0V/PNp0s8YMGIR6ZqjVvp+b/wK4TT1lDiuV7LjH+vR08UROkEAd9LQinZ4QefCP/VFuTOXUT3n8
 eBZjGmUzkwjHXXC/4I8ZW5ai5WKlyxF1uUCMqixdnxi4JLh9FfDySuyt0yDi2+Z0eH9ogqb6ugi
 ws2g2ciZwpHPgAjXk15EAzXwV7yb+gfxv3aA4RpEbrKoLMGn4ZEWW0bEJOTAVAdUD6vW8Z1mZAM
 QMIyK6zB8/x9JIi8hKhgLRzA45JPQ==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] settimeofday01: Convert doc to docparse
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
From: Yang Xu via ltp <ltp@lists.linux.it>
Reply-To: Yang Xu <xuyang2018.jy@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 testcases/kernel/syscalls/settimeofday/settimeofday01.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/settimeofday/settimeofday01.c b/testcases/kernel/syscalls/settimeofday/settimeofday01.c
index b7f84b00f..e523b5b97 100644
--- a/testcases/kernel/syscalls/settimeofday/settimeofday01.c
+++ b/testcases/kernel/syscalls/settimeofday/settimeofday01.c
@@ -1,8 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) International Business Machines  Corp., 2001
- * Ported to LTP 07/2001 John George
- * Testcase to check the basic functionality of settimeofday().
+ * Copyright (c) Linux Test Project, 2001-2024
+ */
+
+/*\
+ * [Description]
+ *
+ * Check the basic functionality of settimeofday().
  */
 
 #include <sys/time.h>
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
