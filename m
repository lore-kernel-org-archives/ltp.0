Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 268EEC433EF
	for <ltp@archiver.kernel.org>; Wed, 16 Feb 2022 10:05:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 388013CA089
	for <ltp@archiver.kernel.org>; Wed, 16 Feb 2022 11:05:00 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B053D3CA06A
 for <ltp@lists.linux.it>; Wed, 16 Feb 2022 11:04:39 +0100 (CET)
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com
 [195.245.231.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5EFC020103C
 for <ltp@lists.linux.it>; Wed, 16 Feb 2022 11:04:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1645005877; i=@fujitsu.com;
 bh=A7lyZlmTfSsk7Ct3WBMN0kRV6J3xiI9PmD2tFKKJwaY=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=wm9mwDkWYgrWelhSvsdDNzmVCbLUc+8cjZ5pBoDpCTeFFdyBHLlXtMn/8xMNVW05t
 qOQa3EmskfnHODwnmjQXFI10nej3UL1VaQ27uKWNAHBe5FTc6Id5pvpAxq3eGpr7rY
 FhW/ST9dUA4HDuvVHCFPL7s491xeMpFc46ZyLLbj+zcTsiI/YsiLMKDoE1gedM9Nah
 nHe/YvY6968rbdq0zhV/j0RyIhOox4OmPizORiCtUXh0dFWWspGnsB9JAHlZczgns0
 bMbtksU03QoCWlKe375ERF4tH53sxC+Kh1Cr/daVMnJF3naOyn/t7R7SqJZ2ARZ2XA
 hHbjvVrbSl33Q==
Received: from [100.115.37.140] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-3.bemta.az-a.eu-west-2.aws.ess.symcld.net id A4/07-22205-53CCC026;
 Wed, 16 Feb 2022 10:04:37 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBIsWRWlGSWpSXmKPExsViZ8ORqGtyhif
 J4PE+M4sV33cwOjB67Pu9jjWAMYo1My8pvyKBNWNRzz+2gg28FZs+PWBpYGzn7mLk4hASOMso
 cabrEDuEs5NJYu6kTWwQzh5Gidbzyxi7GDk52AQ0JZ51LmAGsUUEJCQ6Gt6yg9jMAuoSyyf9Y
 gKxhQW8JDaf2MgCYrMIqEpM/NoI1ssr4CGxYdIesHoJAQWJKQ/fg83hFPCUaO79xApiCwHV/L
 u0ihWiXlDi5MwnLBDzJSQOvnjBDNGrKHGp4xsjhF0hMWtWGxOErSZx9dwm5gmMgrOQtM9C0r6
 AkWkVo3VSUWZ6RkluYmaOrqGBga6hoamusYmukaGFXmKVbqJeaqlueWpxia6RXmJ5sV5qcbFe
 cWVuck6KXl5qySZGYCCnFCvd2sG4YdVPvUOMkhxMSqK8Vqt4koT4kvJTKjMSizPii0pzUosPM
 cpwcChJ8ObvBcoJFqWmp1akZeYAowomLcHBoyTCK30SKM1bXJCYW5yZDpE6xajLsenwlb3MQi
 x5+XmpUuK8k08BFQmAFGWU5sGNgEX4JUZZKWFeRgYGBiGegtSi3MwSVPlXjOIcjErCvB6ngab
 wZOaVwG16BXQEE9ARio1cIEeUJCKkpBqYCnlVjjsrGBx7P5MpenatutPhDw82BIennTl5+dj1
 MM2exT+0BMW52hV2fwu5U/6c7fGWn+kukz0vvZ7M6SpoJl3ndPiU0+J32u1hPMsm6fL6X3pfd
 zXia8NbL/tJj30yZ5jIcV3UnVslNM+Yy+iS2as1D2d+5Nkle+nz0Yun/ze961F6vl8q3mu74z
 KG8O4Vmtd7fNicO0R/nEl47ZVrwd/LOJv/25uVH+7Iyyy8IKN0udrjUvWbbKl+duUdHUcFZ16
 pLgw9ed52Lkf6gu+729qNH5zZUc/42FT26dO4+2/cZFs9a75WO0YlxgcusrXn7J58wERd5VNG
 6boXjzc33tdft1ti2YIJ5oX6hSXSSizFGYmGWsxFxYkAACoFSWsDAAA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-6.tower-571.messagelabs.com!1645005876!50325!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.7; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 28869 invoked from network); 16 Feb 2022 10:04:36 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
 by server-6.tower-571.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 16 Feb 2022 10:04:36 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 6EE4B10019E
 for <ltp@lists.linux.it>; Wed, 16 Feb 2022 10:04:36 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 60227100186
 for <ltp@lists.linux.it>; Wed, 16 Feb 2022 10:04:36 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.28; Wed, 16 Feb 2022 10:04:18 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Wed, 16 Feb 2022 18:04:25 +0800
Message-ID: <1645005868-2373-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1645005868-2373-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1645005868-2373-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/5] lapi/kcmp.h: Replace GPL with
 SPDX-License-Identifier
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 include/lapi/kcmp.h | 25 ++++++-------------------
 1 file changed, 6 insertions(+), 19 deletions(-)

diff --git a/include/lapi/kcmp.h b/include/lapi/kcmp.h
index 59371fc07..77086191f 100644
--- a/include/lapi/kcmp.h
+++ b/include/lapi/kcmp.h
@@ -1,29 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2015 Cedric Hnyda <chnyda@suse.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of
- * the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write the Free Software Foundation,
- * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
-#ifndef KCMP_H
-#define KCMP_H
+#ifndef LAPI_KCMP_H__
+#define LAPI_KCMP_H__
 
 #include <sys/types.h>
 #include "config.h"
 #include "lapi/syscalls.h"
 
-#if !defined(HAVE_ENUM_KCMP_TYPE)
+#ifndef HAVE_ENUM_KCMP_TYPE
 
 enum kcmp_type {
 	KCMP_FILE,
@@ -42,7 +29,7 @@ enum kcmp_type {
 
 #endif
 
-#if !defined(HAVE_KCMP)
+#ifndef HAVE_KCMP
 
 int kcmp(int pid1, int pid2, int type, int fd1, int fd2)
 {
@@ -51,4 +38,4 @@ int kcmp(int pid1, int pid2, int type, int fd1, int fd2)
 
 #endif
 
-#endif /* KCMP_H */
+#endif /* LAPI_KCMP_H__ */
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
