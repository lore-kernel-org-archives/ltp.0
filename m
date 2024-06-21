Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B1A4C27C4F
	for <ltp@archiver.kernel.org>; Fri, 21 Jun 2024 11:00:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5B5433D0EBC
	for <ltp@archiver.kernel.org>; Fri, 21 Jun 2024 13:00:46 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D362E3D0E50
 for <ltp@lists.linux.it>; Fri, 21 Jun 2024 13:00:06 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 550DF608A8F
 for <ltp@lists.linux.it>; Fri, 21 Jun 2024 13:00:05 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7FB9421AFE;
 Fri, 21 Jun 2024 11:00:05 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5599413AAA;
 Fri, 21 Jun 2024 11:00:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YCjYEjVddWbBXgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 21 Jun 2024 11:00:05 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 21 Jun 2024 12:59:57 +0200
Message-ID: <20240621105957.671338-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240621105957.671338-1-pvorel@suse.cz>
References: <20240621105957.671338-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 7FB9421AFE
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/2] lib: Create tst_tmpdir.h
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

This fixes our sparse warning:

tst_tmpdir.c:347:6: warning: Symbol 'tst_purge_dir' has no prototype or
library ('tst_') prefix. Should it be static?

Also add header into our readthedocs docs (C API section).

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v1->v2:
* Use proper kerneldoc comment (Cyril)
* Add the header to readthedocs docs

 doc/developers/api_c_tests.rst |  4 ++++
 include/tst_device.h           |  6 +-----
 include/tst_tmpdir.h           | 19 +++++++++++++++++++
 lib/tst_tmpdir.c               |  1 +
 4 files changed, 25 insertions(+), 5 deletions(-)
 create mode 100644 include/tst_tmpdir.h

diff --git a/doc/developers/api_c_tests.rst b/doc/developers/api_c_tests.rst
index 164f82504..74185c29e 100644
--- a/doc/developers/api_c_tests.rst
+++ b/doc/developers/api_c_tests.rst
@@ -37,3 +37,7 @@ Capabilities
 libltpswap
 ----------
 .. kernel-doc:: ../../include/libswap.h
+
+Temporary directory
+-------------------
+.. kernel-doc:: ../../include/tst_tmpdir.h
diff --git a/include/tst_device.h b/include/tst_device.h
index 36258f436..391fb4e56 100644
--- a/include/tst_device.h
+++ b/include/tst_device.h
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2016-2019 Cyril Hrubis <chrubis@suse.cz>
+ * Copyright (c) Linux Test Project, 2019-2024
  */
 
 #ifndef TST_DEVICE_H__
@@ -101,11 +102,6 @@ int tst_dev_sync(int fd);
  */
 unsigned long tst_dev_bytes_written(const char *dev);
 
-/*
- * Wipe the contents of given directory but keep the directory itself
- */
-void tst_purge_dir(const char *path);
-
 /*
  * Find the file or path belongs to which block dev
  * @path       Path to find the backing dev
diff --git a/include/tst_tmpdir.h b/include/tst_tmpdir.h
new file mode 100644
index 000000000..e6c5d962c
--- /dev/null
+++ b/include/tst_tmpdir.h
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2017 Cyril Hrubis <chrubis@suse.cz>
+ * Copyright (c) 2020 Martin Doucha <mdoucha@suse.cz>
+ */
+
+#ifndef TST_TMPDIR_H__
+#define TST_TMPDIR_H__
+
+/**
+ * tst_purge_dir - Wipe the content of given directory.
+ *
+ * Wipe the content of given directory but keep the directory itself.
+ *
+ * @path: Path of the directory to be wiped.
+ */
+void tst_purge_dir(const char *path);
+
+#endif /* TST_TMPDIR_H__ */
diff --git a/lib/tst_tmpdir.c b/lib/tst_tmpdir.c
index bcc788390..0f1b15ca4 100644
--- a/lib/tst_tmpdir.c
+++ b/lib/tst_tmpdir.c
@@ -72,6 +72,7 @@
 
 #include "test.h"
 #include "safe_macros.h"
+#include "tst_tmpdir.h"
 #include "ltp_priv.h"
 #include "lapi/futex.h"
 
-- 
2.45.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
