Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CC00CD6E5A
	for <ltp@archiver.kernel.org>; Wed, 11 Oct 2023 10:55:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C62DE3CD608
	for <ltp@archiver.kernel.org>; Wed, 11 Oct 2023 12:55:43 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 98D0B3C88F3
 for <ltp@lists.linux.it>; Wed, 11 Oct 2023 12:55:23 +0200 (CEST)
Received: from esa1.hc1455-7.c3s2.iphmx.com (esa1.hc1455-7.c3s2.iphmx.com
 [207.54.90.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 1E982600816
 for <ltp@lists.linux.it>; Wed, 11 Oct 2023 12:55:21 +0200 (CEST)
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="135512896"
X-IronPort-AV: E=Sophos;i="6.03,214,1694703600"; d="scan'208";a="135512896"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
 by esa1.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2023 19:55:20 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com
 [192.168.83.66])
 by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id E6079E428B
 for <ltp@lists.linux.it>; Wed, 11 Oct 2023 19:55:17 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 26177F9B9
 for <ltp@lists.linux.it>; Wed, 11 Oct 2023 19:55:17 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 9DC3F200649D6
 for <ltp@lists.linux.it>; Wed, 11 Oct 2023 19:55:16 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.215.131])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 29F3C1A006F;
 Wed, 11 Oct 2023 18:55:15 +0800 (CST)
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: ltp@lists.linux.it
Date: Wed, 11 Oct 2023 18:55:07 +0800
Message-Id: <1697021709-22916-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27928.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27928.006
X-TMASE-Result: 10--6.883800-10.000000
X-TMASE-MatchedRID: 92ZTZZEhhTOhhjsqgSuNbxF4zyLyne+ATJDl9FKHbrkWxRFlzVAvGli5
 r+TKtIsrAOe0VVRgxtBWTBAeKqaX9Spe4ofkluPsqug9vIA2WODdvovMm13clcPfJfU0tMOF4Xg
 khF5FTCHzbv3mOafziDQOAygP9Dmd0vsjMZhH6s/aHU/pMDSkG9mhsJODizUsvnhgJqkfm0B9Jp
 pVNkb1KxeFELRmbzxEY018kD9GAOHBDRN9OhshUUW5la/dMBNIMVVFhl7NwvNlt/se1haCZagN0
 Z4XHtao8GY7wd3cYT2AMuqetGVetr9k4V4N5ceA3QfwsVk0UbtuRXh7bFKB7qg8bUGxwF466TTy
 smDEQ0ar3L4GdpF1eG2Cgaq0dTIjH8FerAT0dJY=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/3] link03: Convert docs to docparse
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
 testcases/kernel/syscalls/link/link03.c | 41 +++++--------------------
 1 file changed, 7 insertions(+), 34 deletions(-)

diff --git a/testcases/kernel/syscalls/link/link03.c b/testcases/kernel/syscalls/link/link03.c
index 1f45240ae..27f8a4efe 100644
--- a/testcases/kernel/syscalls/link/link03.c
+++ b/testcases/kernel/syscalls/link/link03.c
@@ -1,42 +1,15 @@
 /*
  * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
- *  AUTHOR		: Richard Logan
- *  CO-PILOT		: William Roske
+ * AUTHOR		: Richard Logan
+ * CO-PILOT		: William Roske
  * Copyright (c) 2014 Cyril Hrubis <chrubis@suse.cz>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * Further, this software is distributed without any warranty that it is
- * free of the rightful claim of any third person regarding infringement
- * or the like.  Any license provided herein, whether implied or
- * otherwise, applies only to this software file.  Patent licenses, if
- * any, provided herein do not apply to combinations of this program with
- * other software, or any other product whatsoever.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
- * Contact information: Silicon Graphics, Inc., 1600 Amphitheatre Pkwy,
- * Mountain View, CA  94043, or:
- *
- * http://www.sgi.com
- *
- * For further information regarding this notice, see:
- *
- * http://oss.sgi.com/projects/GenInfo/NoticeExplan/
- *
  */
 
- /*
-  * Tests that link(2) succeds with creating n links.
-  */
+/*\
+ * [Description]
+ *
+ * Tests that link(2) succeds with creating n links.
+ */
 
 #include <sys/types.h>
 #include <fcntl.h>
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
