Return-Path: <SRS0=gHvU=PP=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C92DC433F5
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 12:28:50 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1530160F5A
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 12:28:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1530160F5A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2FBC83C697C
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 14:28:48 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A2B523C67D8
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 14:28:38 +0200 (CEST)
Received: from mail1.bemta25.messagelabs.com (mail1.bemta25.messagelabs.com
 [195.245.230.68])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B48391A01C83
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 14:28:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1635337712; i=@fujitsu.com;
 bh=6uvk1kLm5pY0ClS4vgFjZC//zHQg9ALq/pKVv+u13tQ=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=JwkqEwoXBh+4oRzaJKromO2VXno31F3ZKJ9ful4hRonSKDEXUTB4olUa5BVgJq43u
 X3fI+Acuj11FqFvxIh4dFJQLsMe83nuJyLS5DAX5a/14zcQXzYgCy5xRTgSLZXOyrx
 HUydISE2qehF/siv1wK35i6qOpFuM9lKcuTara2ptZ0oBi8xkRFJlGMw+swzrBF4yS
 v7KsIKeMgWxGnx7XgvnTCa8rsjDp+H73tJOIUEQcbbSpAWlRdo0CkfuZ29QK44ZhGd
 CasSNq2f531UvAqMwDdKyifcDYJBmXS5siaoVRdlRYAZGScOURLk/bFZYjiBu69icw
 u2CaeHDQ4/OEQ==
Received: from [100.112.196.123] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-4.bemta.az-b.eu-west-1.aws.symcld.net id 1C/8B-04525-0F549716;
 Wed, 27 Oct 2021 12:28:32 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKIsWRWlGSWpSXmKPExsViZ8MRovvBtTL
 R4MQndosV33cwOjB67Pu9jjWAMYo1My8pvyKBNePD7sCCKVwVuy69Z29g3M3RxcjJISTQwiTx
 64JuFyMXkL2HUWLBj7nsIAk2AU2JZ50LmEFsEQEJiY6Gt2BxZgF1ieWTfjF1MXJwCAu4S8ydG
 gUSZhFQlejY+ROsnFfAQ2LbvRtgtoSAgsSUh++h4oISJ2c+YYEYIyFx8MULqBpFiUsd3xgh7A
 qJWbPamCYw8s5C0jILScsCRqZVjBZJRZnpGSW5iZk5uoYGBrqGhka6hpYWuobGBnqJVbpJeqm
 luuWpxSW6hnqJ5cV6xZW5yTkpenmpJZsYgaGVUnCsaQfjydcf9A4xSnIwKYnyBuhUJgrxJeWn
 VGYkFmfEF5XmpBYfYpTh4FCS4M10AcoJFqWmp1akZeYAwxwmLcHBoyTCmwMMdSHe4oLE3OLMd
 IjUKUZFKXFeZZCEAEgiozQPrg0WW5cYZaWEeRkZGBiEeApSi3IzS1DlXzGKczAqCfNGgUzhyc
 wrgZv+CmgxE9BiZqUKkMUliQgpqQampS8+toowfPOfkmcs9U/vtpDLjgXTHkvvbz8oq3pvV0q
 RUcyHhdkaCuq3Mv9o/I7ZZPZz0snJDQum/mxp1Mqo/V7Yfaa+ZknPt6D9+g/XP3n89eG3k1b8
 a/7bHRYvfLxp37Olj0++UFiXVMGkOadT7YizpSGnOsezYw5Oja5Op50m3tvE0rK1zunb3oufz
 DXX7/+woF58y5fXa5WlOCZ1OrHnnOBpjb/LbPW/a9aDU4VMKgvSj01n+XWIVffavb6l72wtT8
 46d15lbkyOgc2smPI24UgP80Il7W9bNrSG3G2QzdOfv2hTv7ncT61v6xInXY28KvXe4E/9D60
 WgYnuN54yN3Pcfi9w/PDDigbVNCWW4oxEQy3mouJEAFl9BS4oAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-9.tower-287.messagelabs.com!1635337711!286967!1
X-Originating-IP: [62.60.8.84]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.4; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 10487 invoked from network); 27 Oct 2021 12:28:32 -0000
Received: from unknown (HELO mailhost3.uk.fujitsu.com) (62.60.8.84)
 by server-9.tower-287.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 27 Oct 2021 12:28:32 -0000
Received: from R01UKEXCASM126.r01.fujitsu.local ([10.183.43.178])
 by mailhost3.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id 19RCSVt0009437
 (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL)
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 13:28:31 +0100
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.24; Wed, 27 Oct 2021 13:28:30 +0100
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Wed, 27 Oct 2021 20:28:23 +0800
Message-ID: <1635337706-4788-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 06/13] lapi/quotactl.h: Add fallback for quotactl_fd
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
 configure.ac            |  1 +
 include/lapi/quotactl.h | 12 ++++++++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index 5bf3c52ec..859aa9857 100644
--- a/configure.ac
+++ b/configure.ac
@@ -122,6 +122,7 @@ AC_CHECK_FUNCS_ONCE([ \
     profil \
     pwritev \
     pwritev2 \
+    quotactl_fd \
     rand_r \
     readlinkat \
     recvmmsg \
diff --git a/include/lapi/quotactl.h b/include/lapi/quotactl.h
index 8e0315d03..739a85616 100644
--- a/include/lapi/quotactl.h
+++ b/include/lapi/quotactl.h
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) 2017-2019 Fujitsu Ltd.
+ * Copyright (c) 2017-2021 FUJITSU LIMITED. All rights reserved
  * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
- * Author: Yang Xu <xuyang2018.jy@cn.jujitsu.com>
+ * Author: Yang Xu <xuyang2018.jy@fujitsu.com>
  */
 
 #ifndef LAPI_QUOTACTL_H__
@@ -10,6 +10,14 @@
 
 #include "config.h"
 #include <sys/quota.h>
+#include "lapi/syscalls.h"
+
+#ifndef HAVE_QUOTACTL_FD
+static inline int quotactl_fd(int fd, int cmd, int id, caddr_t addr)
+{
+	return tst_syscall(__NR_quotactl_fd, fd, cmd, id, addr);
+}
+#endif
 
 #ifdef HAVE_STRUCT_IF_NEXTDQBLK
 # include <linux/quota.h>
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
