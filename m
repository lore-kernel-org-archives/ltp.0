Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23390C54EE9
	for <ltp@archiver.kernel.org>; Tue, 27 Sep 2022 16:14:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 561C13C9221
	for <ltp@archiver.kernel.org>; Tue, 27 Sep 2022 18:14:42 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9781F3C0FA6
 for <ltp@lists.linux.it>; Tue, 27 Sep 2022 18:14:20 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D09801A00912
 for <ltp@lists.linux.it>; Tue, 27 Sep 2022 18:14:19 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 6F1461F8A6;
 Tue, 27 Sep 2022 16:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1664295259; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O82NFjYBB7a4AZJbmjCjcsDHefq1jbZVhOm2bCpTTTE=;
 b=ibP95rqa2LGhke9tlEDlKbjQ5AE2fO+DtSBo15tWc8p+CkujcozERqKJw8IjihQ/WUSg9O
 Z9Tu5z0gbgvWIVIt8+p2POsAtjyvV3ztGgUA3ri0pQEdC4vBwbhESFwjnbXNxrsLh9g5GY
 I8jRJlT3IkeOJ0AlQ1XgIX7xzi/EAAY=
Received: from g78.suse.de (unknown [10.163.24.90])
 by relay2.suse.de (Postfix) with ESMTP id B8BAC2C172;
 Tue, 27 Sep 2022 16:14:18 +0000 (UTC)
To: ltp@lists.linux.it
Date: Tue, 27 Sep 2022 17:14:03 +0100
Message-Id: <20220927161408.23743-2-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220927161408.23743-1-rpalethorpe@suse.com>
References: <20220927161408.23743-1-rpalethorpe@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/6] api/epoll: Add safe epoll functions
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
From: Richard Palethorpe via ltp <ltp@lists.linux.it>
Reply-To: Richard Palethorpe <rpalethorpe@suse.com>
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Probably safe to use it over (p)select/(p)poll now.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 include/tst_epoll.h | 36 ++++++++++++++++++++
 lib/tst_epoll.c     | 81 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 117 insertions(+)
 create mode 100644 include/tst_epoll.h
 create mode 100644 lib/tst_epoll.c

diff --git a/include/tst_epoll.h b/include/tst_epoll.h
new file mode 100644
index 000000000..c5ffc07e3
--- /dev/null
+++ b/include/tst_epoll.h
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2022 SUSE LLC <rpalethorpe@suse.com>
+ */
+
+#include <sys/epoll.h>
+
+#ifndef TST_EPOLL_H
+#define TST_EPOLL_H
+
+typedef int (*tst_on_epoll_fn)(void *, uint32_t);
+struct tst_epoll_event_data {
+	tst_on_epoll_fn on_epoll;
+	void *self;
+};
+
+int safe_epoll_create1(const char *const file, const int lineno,
+		       const int flags);
+
+#define SAFE_EPOLL_CREATE1(flags) \
+	safe_epoll_create1(__FILE__, __LINE__, (flags))
+
+int safe_epoll_ctl(const char *const file, const int lineno,
+		   int epfd, int op, int fd, struct epoll_event *ev);
+
+#define SAFE_EPOLL_CTL(epfd, op, fd, ev) \
+	safe_epoll_ctl(__FILE__, __LINE__, epfd, op, fd, ev)
+
+int safe_epoll_wait(const char *const file, const int lineno,
+		    int epfd, struct epoll_event *events,
+		    int maxevents, int timeout);
+
+#define SAFE_EPOLL_WAIT(epfd, events, maxevents, timeout)\
+	safe_epoll_wait(__FILE__, __LINE__, epfd, events, maxevents, timeout)
+
+#endif
diff --git a/lib/tst_epoll.c b/lib/tst_epoll.c
new file mode 100644
index 000000000..556b3bdab
--- /dev/null
+++ b/lib/tst_epoll.c
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2022 SUSE LLC <rpalethorpe@suse.com>
+ */
+#define _GNU_SOURCE
+#define TST_NO_DEFAULT_MAIN
+
+#include "tst_test.h"
+#include "tst_epoll.h"
+
+int safe_epoll_create1(const char *const file, const int lineno,
+		       const int flags)
+{
+	const char *flags_str;
+	int ret = epoll_create1(flags);
+
+	switch (flags) {
+	case EPOLL_CLOEXEC:
+		flags_str = "EPOLL_CLOEXEC";
+		break;
+	case 0:
+		flags_str = "";
+		break;
+	default:
+		flags_str = "???";
+	}
+
+	if (ret == -1) {
+		tst_brk_(file, lineno,
+			 TBROK | TERRNO, "epoll_create1(%s)", flags_str);
+	}
+
+	return ret;
+}
+
+int safe_epoll_ctl(const char *const file, const int lineno,
+		   int epfd, int op, int fd, struct epoll_event *ev)
+{
+	const char *op_str;
+	int ret;
+
+	switch (op) {
+	case EPOLL_CTL_ADD:
+		op_str = "EPOLL_CTL_ADD";
+		break;
+	case EPOLL_CTL_DEL:
+		op_str = "EPOLL_CTL_DEL";
+		break;
+	case EPOLL_CTL_MOD:
+		op_str = "EPOLL_CTL_MOD";
+		break;
+	default:
+		op_str = "???";
+	}
+
+	ret = epoll_ctl(epfd, op, fd, ev);
+
+	if (ret == -1) {
+		tst_brk_(file, lineno,
+			 TBROK | TERRNO,
+			 "epoll_ctl(%d, %s, %d, ...", epfd, op_str, fd);
+	}
+
+	return ret;
+}
+
+int safe_epoll_wait(const char *const file, const int lineno,
+		    int epfd, struct epoll_event *events,
+		    int maxevents, int timeout)
+{
+	int ret = epoll_wait(epfd, events, maxevents, timeout);
+
+	if (ret == -1) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			 "epoll_wait(%d, ..., %d, %d)",
+			 epfd, maxevents, timeout);
+	}
+
+	return ret;
+}
+
-- 
2.36.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
