Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEA44C27C79
	for <ltp@archiver.kernel.org>; Thu, 20 Jun 2024 05:50:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 28C683D0DF8
	for <ltp@archiver.kernel.org>; Thu, 20 Jun 2024 07:50:24 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 32E963CF2D7
 for <ltp@lists.linux.it>; Thu, 20 Jun 2024 07:50:07 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 618061A0123C
 for <ltp@lists.linux.it>; Thu, 20 Jun 2024 07:50:06 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D577721AA1;
 Thu, 20 Jun 2024 05:50:05 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718862605; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u2eFbK5v5dqaorftDJqPpBH2Hyya0If51NLsYmQpSbU=;
 b=H5UDgLN0xOAOFKovfBKgCPeG3LFlPx+N6LaIrJ5rnbInPdiQPfi2tS2mxXoyoa1tsF1MRu
 E5j6RErzvdxMAFp+1Ny+pryRIg+aTS90RwH1d5+176oZNnsPbFCZzL19nIIz0vKalBUpgd
 zsCxjSTzSpQirbRHGj4QDxx/1yaiqHY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718862605;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u2eFbK5v5dqaorftDJqPpBH2Hyya0If51NLsYmQpSbU=;
 b=Ahiv7BnN+PTIxc26IdZ3miOWuF5nfNZtHch2lZ43BG77MrCfis/9VSDhGbLkdmkyRLS8P2
 j+sWrUHYAVyYuYDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BAC4B13AC1;
 Thu, 20 Jun 2024 05:50:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EMq8LA3Dc2aZMQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 20 Jun 2024 05:50:05 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 20 Jun 2024 07:49:58 +0200
Message-ID: <20240620054958.554319-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240620054958.554319-1-pvorel@suse.cz>
References: <20240620054958.554319-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: D577721AA1
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] lib: Create tst_tmpdir.h
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

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 include/tst_device.h |  6 +-----
 include/tst_tmpdir.h | 15 +++++++++++++++
 lib/tst_tmpdir.c     |  1 +
 3 files changed, 17 insertions(+), 5 deletions(-)
 create mode 100644 include/tst_tmpdir.h

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
index 000000000..b4f95b666
--- /dev/null
+++ b/include/tst_tmpdir.h
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2017 Cyril Hrubis <chrubis@suse.cz>
+ * Copyright (c) 2020 Martin Doucha <mdoucha@suse.cz>
+ */
+
+#ifndef TST_TMPDIR_H__
+#define TST_TMPDIR_H__
+
+/*
+ * Wipe the contents of given directory but keep the directory itself
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
