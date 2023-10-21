Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A531C0032E
	for <ltp@archiver.kernel.org>; Sat, 21 Oct 2023 12:30:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6FF8D3CEE91
	for <ltp@archiver.kernel.org>; Sat, 21 Oct 2023 14:30:31 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 327D73CEDB0
 for <ltp@lists.linux.it>; Sat, 21 Oct 2023 14:30:12 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 344981A0109F
 for <ltp@lists.linux.it>; Sat, 21 Oct 2023 14:30:10 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 184AF1F8A3;
 Sat, 21 Oct 2023 12:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1697891410; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XwOHS2pIwnze7/NWXcOkCh1+P9XOCxwwc3mjeRw34lg=;
 b=Hhsat+iIydq6KAwnkVHpkbe2xEJvEXNMhj92PBbjAgbrfTmuJcdP27HFyf33fDo3sBQEsY
 c0iErVi2IAsVkmRyXZ8A3F5jCFu/64AuhIp9kAvi42ZLFyKhtNkoAv5zAWbmEax/P1VAo/
 0Jxd2DtCItBBmFsw1EZdJBzAL+m3vYs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 610A713A2A;
 Sat, 21 Oct 2023 12:30:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id yIj9C1HEM2V6CgAAMHmgww
 (envelope-from <wegao@suse.com>); Sat, 21 Oct 2023 12:30:09 +0000
To: ltp@lists.linux.it
Date: Sat, 21 Oct 2023 08:29:57 -0400
Message-Id: <20231021122958.13458-2-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231021122958.13458-1-wegao@suse.com>
References: <20231021122958.13458-1-wegao@suse.com>
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-3.32 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 REPLY(-4.00)[]; BROKEN_CONTENT_TYPE(1.50)[];
 NEURAL_HAM_LONG(-3.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.com:s=susede1];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 MID_CONTAINS_FROM(1.00)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.22)[71.95%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 1/2] lib: Add .ulimit
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Fix: #530
Signed-off-by: Wei Gao <wegao@suse.com>
---
 include/tst_test.h   |  6 ++++++
 include/tst_ulimit.h | 18 ++++++++++++++++++
 lib/tst_test.c       |  9 +++++++++
 lib/tst_ulimit.c     | 24 ++++++++++++++++++++++++
 4 files changed, 57 insertions(+)
 create mode 100644 include/tst_ulimit.h
 create mode 100644 lib/tst_ulimit.c

diff --git a/include/tst_test.h b/include/tst_test.h
index 75c2109b9..79abc2773 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -34,6 +34,7 @@
 #include "tst_get_bad_addr.h"
 #include "tst_path_has_mnt_flags.h"
 #include "tst_sys_conf.h"
+#include "tst_ulimit.h"
 #include "tst_coredump.h"
 #include "tst_buffers.h"
 #include "tst_capability.h"
@@ -306,6 +307,11 @@ struct tst_test {
 	 */
 	const struct tst_path_val *save_restore;
 
+	/*
+	 * {NULL, NULL} terminated array of (ulimit resource type and value)
+	 */
+	const struct tst_ulimit_val *ulimit;
+
 	/*
 	 * NULL terminated array of kernel config options required for the
 	 * test.
diff --git a/include/tst_ulimit.h b/include/tst_ulimit.h
new file mode 100644
index 000000000..b4f97670a
--- /dev/null
+++ b/include/tst_ulimit.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0-only
+ *
+ * Copyright (c) 2023 Wei Gao <wegao@suse.com>
+ */
+
+#ifndef TST_ULIMIT_H__
+#define TST_ULIMIT_H__
+
+#include <sys/resource.h>
+
+struct tst_ulimit_val {
+	int resource;
+	struct rlimit rlim;
+};
+
+void tst_ulimit_conf(const struct tst_ulimit_val *conf);
+
+#endif
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 2e58cad33..a8c7c7ba6 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1227,6 +1227,15 @@ static void do_setup(int argc, char *argv[])
 		}
 	}
 
+	if (tst_test->ulimit) {
+		const struct tst_ulimit_val *pvl = tst_test->ulimit;
+
+		while (pvl->resource) {
+			tst_ulimit_conf(pvl);
+			pvl++;
+		}
+	}
+
 	if (tst_test->mntpoint)
 		SAFE_MKDIR(tst_test->mntpoint, 0777);
 
diff --git a/lib/tst_ulimit.c b/lib/tst_ulimit.c
new file mode 100644
index 000000000..1249d65d8
--- /dev/null
+++ b/lib/tst_ulimit.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2023 Wei Gao <wegao@suse.com>
+ */
+
+#define TST_NO_DEFAULT_MAIN
+#include "tst_test.h"
+#include "tst_ulimit.h"
+
+struct tst_ulimit_conf {
+	int resource;
+	struct rlimit rlim;
+};
+
+void tst_ulimit_conf(const struct tst_ulimit_val *conf)
+{
+	struct rlimit rlim;
+
+	rlim.rlim_cur = conf->rlim.rlim_cur;
+	rlim.rlim_max = conf->rlim.rlim_max;
+
+	tst_res(TINFO, "Set ulimit resource:%d rlim_cur:%ld rlim_max:%ld", conf->resource, rlim.rlim_cur, rlim.rlim_max);
+	SAFE_SETRLIMIT(conf->resource, &rlim);
+}
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
