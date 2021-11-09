Return-Path: <SRS0=8di7=P4=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF83EC433EF
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 10:55:02 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77FB361054
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 10:55:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 77FB361054
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 37A013C07C1
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 11:55:01 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 268793C0890
 for <ltp@lists.linux.it>; Tue,  9 Nov 2021 11:54:44 +0100 (CET)
Received: from mail1.bemta25.messagelabs.com (mail1.bemta25.messagelabs.com
 [195.245.230.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 71DE1100024A
 for <ltp@lists.linux.it>; Tue,  9 Nov 2021 11:54:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1636455279; i=@fujitsu.com;
 bh=JXamCGTOVyRfKDFzMMVQap0M56vaZ4b9CrcskUTnBuY=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=JSoNUHQ/wmEkDOyfUZ1+I0kNaCMvwHVDFnT9NPovBKFIfgmgO73bwuuRGQaGFtir+
 /Vy6pXCnDHXfTIpEF5NYfROBnKVbUIoLhxprNR9McO7uoLMr/8mS9Mg8p2KJRZjGVe
 7K1oKeUrAM6PXxEYt7+3XZ9DPMaDI5+jbYDPxXI/9KmrFiul1TjoJrF0/JS6SYrBXQ
 K9Zs2E0HN+4fQEUbWcwk/6cNNOiA1I2xNZEHUPMR3kBCaQ7gBaec6wbaE/NzC5ziPh
 6I+TkUbgXk9gXzdQWoxUkB0o5DW0xfdhwLN9wK57DhoYxnXrpHkPDuxlPvPCa86E+B
 O67el4OKvZtqw==
Received: from [100.112.193.107] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-2.bemta.az-a.eu-west-1.aws.symcld.net id DD/F1-19641-F635A816;
 Tue, 09 Nov 2021 10:54:39 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPIsWRWlGSWpSXmKPExsViZ8ORqJsf3JV
 osOkqm8WK7zsYHRg99v1exxrAGMWamZeUX5HAmjFv5Qf2ggNcFZfPz2FrYHzM0cXIxSEkcJZR
 4sO3ZywQzk4miQsTHkA5uxkl9vZtYu9i5ORgE9CUeNa5gBnEFhGQkOhoeAsWZxZQl1g+6RcTi
 C0s4C5xbu0csDiLgIrE7qblbF2MHBy8Ah4SGyZJgIQlBBQkpjx8DzaGV0BQ4uTMJywQYyQkDr
 54wQxRoyhxqeMbI4RdITFrVhsThK0mcfXcJuYJjPyzkLTPQtK+gJFpFaN5UlFmekZJbmJmjq6
 hgYGuoaGRrqGlia6ZmV5ilW6iXmqpbnlqcYmuoV5iebFecWVuck6KXl5qySZGYDimFBxy2sH4
 /vUHvUOMkhxMSqK8l8W6EoX4kvJTKjMSizPii0pzUosPMcpwcChJ8Cb4A+UEi1LTUyvSMnOAs
 QGTluDgURLh1fMBSvMWFyTmFmemQ6ROMSpKifOmBAElBEASGaV5cG2weLzEKCslzMvIwMAgxF
 OQWpSbWYIq/4pRnINRSZj3UyDQFJ7MvBK46a+AFjMBLT74pR1kcUkiQkqqgcnF/gLTxnUO+/W
 2JJSpSBlqxBkcX79XlvP020L7IvfVmbor5gobLjOK0Vu6bAJnKFvPE33Lve/0lh5tFZ2wpefn
 fb/ox21anHunHZh9yPK3g/GF++HHoi68v2u0a/rqXIOLKlzdRfPmym9d5rOrNPvQ8c8Ht2usr
 Pjy7LvzF+blrwo6DLamprULOjV2F2/jjLfLUCzZ4lFSnGujOf2ZrNoW62y1r19NTtaqFezetY
 zNzcz97Ql2A0WxQ1s1vu13aazeUW+6boVAJVNYfavLM44rInp1z30XXzuYUSCx+Om7x5p/Jwd
 8tJQ8waa0euXnvmV5jkusPJ4m7lcTLbp/InirRL7vInnpRfusz6sI+imxFGckGmoxFxUnAgBF
 gQBlQgMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-15.tower-265.messagelabs.com!1636455278!576297!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 24828 invoked from network); 9 Nov 2021 10:54:39 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
 by server-15.tower-265.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 9 Nov 2021 10:54:39 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 970A910024B
 for <ltp@lists.linux.it>; Tue,  9 Nov 2021 10:54:38 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 8A70B100238
 for <ltp@lists.linux.it>; Tue,  9 Nov 2021 10:54:38 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.24; Tue, 9 Nov 2021 10:54:29 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Tue, 9 Nov 2021 18:54:42 +0800
Message-ID: <1636455285-8372-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 06/12] lapi/quotactl.h: Add fallback for quotactl_fd
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

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
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
