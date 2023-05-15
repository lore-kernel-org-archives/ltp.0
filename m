Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73A28C7EE22
	for <ltp@archiver.kernel.org>; Mon, 15 May 2023 07:11:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B50C23CB398
	for <ltp@archiver.kernel.org>; Mon, 15 May 2023 09:11:50 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 65FE73C97CC
 for <ltp@lists.linux.it>; Mon, 15 May 2023 09:11:38 +0200 (CEST)
Received: from esa8.hc1455-7.c3s2.iphmx.com (esa8.hc1455-7.c3s2.iphmx.com
 [139.138.61.253])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6DD3B20007D
 for <ltp@lists.linux.it>; Mon, 15 May 2023 09:11:37 +0200 (CEST)
X-IronPort-AV: E=McAfee;i="6600,9927,10710"; a="104745927"
X-IronPort-AV: E=Sophos;i="5.99,275,1677510000"; d="scan'208";a="104745927"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
 by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2023 16:11:35 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com
 [192.168.83.65])
 by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 1D3F1DAE0C
 for <ltp@lists.linux.it>; Mon, 15 May 2023 16:11:34 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 6360AD5E9B
 for <ltp@lists.linux.it>; Mon, 15 May 2023 16:11:33 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.215.131])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id D5A4B37C45;
 Mon, 15 May 2023 16:11:32 +0900 (JST)
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: ltp@lists.linux.it
Date: Mon, 15 May 2023 15:11:17 +0800
Message-Id: <1684134680-6190-3-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1684134680-6190-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1684134680-6190-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27626.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27626.005
X-TMASE-Result: 10--4.809700-10.000000
X-TMASE-MatchedRID: fAvJMTxJv7wv+0FNnM7lDQPZZctd3P4Bfb+ZO7kHlEi41slblCqbQrM1
 m24REs33rIQrECzVq3X06k715KT4Y7/5L4S7IZUTngIgpj8eDcBpkajQR5gb3lQwtQm7iV5jKra
 uXd3MZDXqf5AUOTCfVj+rsgUVKqCf7e6PjL0LO2yq5gCwK1FScKiZ6vx7p0xtQHlSz69bf/9UgQ
 XOHsde2g+kDUN7J8mmLeUibtPEAqgyLmVkJTlglFPJnXL2yNYdkuo847l05tDEzMyAmsz+FHoWL
 WlXcsZv
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 3/6] lapi/stat.h: Simplify definition
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 include/lapi/stat.h | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/include/lapi/stat.h b/include/lapi/stat.h
index 6ed4b6637..e247c2159 100644
--- a/include/lapi/stat.h
+++ b/include/lapi/stat.h
@@ -11,6 +11,8 @@
 #include <stdint.h>
 #include <unistd.h>
 #include "lapi/syscalls.h"
+#include <sys/stat.h>
+
 /*
  * Timestamp structure for the timestamps in struct statx.
  *
@@ -21,9 +23,7 @@
  *
  * __reserved is held in case we need a yet finer resolution.
  */
-#if defined(HAVE_STRUCT_STATX_TIMESTAMP)
-#include <sys/stat.h>
-#else
+#ifndef HAVE_STRUCT_STATX_TIMESTAMP
 struct statx_timestamp {
 	int64_t tv_sec;
 	uint32_t tv_nsec;
@@ -67,9 +67,7 @@ struct statx_timestamp {
  * will have values installed for compatibility purposes so that stat() and
  * co. can be emulated in userspace.
  */
-#if defined(HAVE_STRUCT_STATX)
-#include <sys/stat.h>
-#else
+#ifndef HAVE_STRUCT_STATX
 struct statx {
 	/* 0x00 */
 	uint32_t	stx_mask;
@@ -106,8 +104,7 @@ struct statx {
 };
 #endif
 
-#if !defined(HAVE_STATX)
-
+#ifndef HAVE_STATX
 /*
  * statx: wrapper function of statx
  *
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
