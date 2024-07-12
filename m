Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57CC7C2BD09
	for <ltp@archiver.kernel.org>; Fri, 12 Jul 2024 08:14:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D4AA43D198D
	for <ltp@archiver.kernel.org>; Fri, 12 Jul 2024 10:14:34 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 14CE43D12C9
 for <ltp@lists.linux.it>; Fri, 12 Jul 2024 10:14:03 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 6735A102F3E3
 for <ltp@lists.linux.it>; Fri, 12 Jul 2024 10:14:03 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 323AB1FB6F;
 Fri, 12 Jul 2024 08:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1720772042; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XokzayjvG7Uw0NuOdzPFO76ytTBshbcxMwrjbeeIJFs=;
 b=yG45cPrtdQogirbfE3B2uNt5wnbL1LNmNeEQat3cO/QNe+avkAASQWogszTJklQiVm30Qt
 e/lbK9vr81zjSI5GrB9FR8jSX4eUpADrC738XQnzCS8bd1ZPogPDoJ82BdOaKIxOoz74fy
 xVe8oLd/dC7DSPO7fezz9Zbxd5sGnYU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1720772042;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XokzayjvG7Uw0NuOdzPFO76ytTBshbcxMwrjbeeIJFs=;
 b=dhd6rUcnwtbj2yQr6vjNkTNEBwGLLKtDwNmPXQ+cKj06o6vehlpIqWgU2sQOYG+JYERa7u
 3ND85PHpVHgGv7BA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=yG45cPrt;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=dhd6rUcn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1720772042; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XokzayjvG7Uw0NuOdzPFO76ytTBshbcxMwrjbeeIJFs=;
 b=yG45cPrtdQogirbfE3B2uNt5wnbL1LNmNeEQat3cO/QNe+avkAASQWogszTJklQiVm30Qt
 e/lbK9vr81zjSI5GrB9FR8jSX4eUpADrC738XQnzCS8bd1ZPogPDoJ82BdOaKIxOoz74fy
 xVe8oLd/dC7DSPO7fezz9Zbxd5sGnYU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1720772042;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XokzayjvG7Uw0NuOdzPFO76ytTBshbcxMwrjbeeIJFs=;
 b=dhd6rUcnwtbj2yQr6vjNkTNEBwGLLKtDwNmPXQ+cKj06o6vehlpIqWgU2sQOYG+JYERa7u
 3ND85PHpVHgGv7BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D6466137D2;
 Fri, 12 Jul 2024 08:14:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0DzaMcnlkGYOfwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 12 Jul 2024 08:14:01 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 12 Jul 2024 10:13:58 +0200
Message-ID: <20240712081359.116227-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240712081359.116227-1-pvorel@suse.cz>
References: <20240712081359.116227-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 323AB1FB6F
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/2] lib: Create tst_tmpdir.h
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

Header needs to be added also to include/tst_test.h (for tests which use
tst_purge_dir, e.g. creat08.c).

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 include/tst_device.h |  6 +-----
 include/tst_test.h   |  1 +
 include/tst_tmpdir.h | 19 +++++++++++++++++++
 lib/tst_tmpdir.c     |  1 +
 4 files changed, 22 insertions(+), 5 deletions(-)
 create mode 100644 include/tst_tmpdir.h

diff --git a/include/tst_device.h b/include/tst_device.h
index 36258f436c..391fb4e568 100644
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
diff --git a/include/tst_test.h b/include/tst_test.h
index eea14469e8..a5fd9a00e2 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -46,6 +46,7 @@
 #include "tst_memutils.h"
 #include "tst_arch.h"
 #include "tst_fd.h"
+#include "tst_tmpdir.h"
 
 void tst_res_(const char *file, const int lineno, int ttype,
               const char *fmt, ...)
diff --git a/include/tst_tmpdir.h b/include/tst_tmpdir.h
new file mode 100644
index 0000000000..e6c5d962ce
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
index bcc788390d..0f1b15ca4c 100644
--- a/lib/tst_tmpdir.c
+++ b/lib/tst_tmpdir.c
@@ -72,6 +72,7 @@
 
 #include "test.h"
 #include "safe_macros.h"
+#include "tst_tmpdir.h"
 #include "ltp_priv.h"
 #include "lapi/futex.h"
 
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
