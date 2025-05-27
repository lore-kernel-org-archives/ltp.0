Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D49BC54F30
	for <ltp@archiver.kernel.org>; Tue, 27 May 2025 11:47:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CEF963C6579
	for <ltp@archiver.kernel.org>; Tue, 27 May 2025 13:47:52 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 273393C5371
 for <ltp@lists.linux.it>; Tue, 27 May 2025 13:47:34 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7DCFC140044F
 for <ltp@lists.linux.it>; Tue, 27 May 2025 13:47:34 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3917421E70
 for <ltp@lists.linux.it>; Tue, 27 May 2025 11:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1748346453; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=LSoT6pnXsytUTFnw1FWZgc8ceapZtF2uufyNO9aJhFQ=;
 b=Un/fMKKr290Xt8VW6Lvx7OOz0IevL1Q50c2U+BdhZ+YVlNwmOktmmr22w17TY/OrOl0vI8
 EWu/5RFeTKBWCjvUExt4gvRRMzTg0peFwiKVkK9QUuvdGHREsuMfQ4/+gE3AZ43gGzUBP5
 pUnHMek8i4eWpYk8T0sCeCUqW7s62IE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1748346453;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=LSoT6pnXsytUTFnw1FWZgc8ceapZtF2uufyNO9aJhFQ=;
 b=knHrz3TcpxfOz/mlU5bKT6JJqmnLkR9RFGFrx5eZJGKdK6yEDx5mUORrSKCD2qPaXUCz6y
 5/JGFtoh6fnWETAw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="Un/fMKKr";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=knHrz3Tc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1748346453; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=LSoT6pnXsytUTFnw1FWZgc8ceapZtF2uufyNO9aJhFQ=;
 b=Un/fMKKr290Xt8VW6Lvx7OOz0IevL1Q50c2U+BdhZ+YVlNwmOktmmr22w17TY/OrOl0vI8
 EWu/5RFeTKBWCjvUExt4gvRRMzTg0peFwiKVkK9QUuvdGHREsuMfQ4/+gE3AZ43gGzUBP5
 pUnHMek8i4eWpYk8T0sCeCUqW7s62IE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1748346453;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=LSoT6pnXsytUTFnw1FWZgc8ceapZtF2uufyNO9aJhFQ=;
 b=knHrz3TcpxfOz/mlU5bKT6JJqmnLkR9RFGFrx5eZJGKdK6yEDx5mUORrSKCD2qPaXUCz6y
 5/JGFtoh6fnWETAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2A9EC136E0
 for <ltp@lists.linux.it>; Tue, 27 May 2025 11:47:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UoKaCVWmNWhKCgAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 27 May 2025 11:47:33 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 27 May 2025 13:47:57 +0200
Message-ID: <20250527114757.14704-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,suse.cz:mid];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_NONE(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_ONE(0.00)[1]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 3917421E70
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] lib: Move tst_get_supported_fs_types() to private
 header
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

The function is not supposed to be used by tests hence it shouldn't be
part of the tst_fs.h include by them.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/tst_fs.h                 | 7 -------
 include/tst_private.h            | 7 +++++++
 lib/tst_supported_fs_types.c     | 1 +
 testcases/lib/tst_supported_fs.c | 1 +
 4 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/include/tst_fs.h b/include/tst_fs.h
index 19c240e07..ceae78e7e 100644
--- a/include/tst_fs.h
+++ b/include/tst_fs.h
@@ -203,13 +203,6 @@ enum tst_fs_impl {
  */
 enum tst_fs_impl tst_fs_is_supported(const char *fs_type);
 
-/*
- * Returns NULL-terminated array of kernel-supported filesystems.
- *
- * @skiplist A NULL terminated array of filesystems to skip.
- */
-const char **tst_get_supported_fs_types(const char *const *skiplist);
-
 /*
  * Returns 1 if filesystem is in skiplist 0 otherwise.
  *
diff --git a/include/tst_private.h b/include/tst_private.h
index 4c6479f4b..292f7e936 100644
--- a/include/tst_private.h
+++ b/include/tst_private.h
@@ -47,4 +47,11 @@ char tst_kconfig_get(const char *confname);
  */
 int tst_check_cmd(const char *cmd, const int brk_nosupp);
 
+/*
+ * Returns NULL-terminated array of kernel-supported filesystems.
+ *
+ * @skiplist A NULL terminated array of filesystems to skip.
+ */
+const char **tst_get_supported_fs_types(const char *const *skiplist);
+
 #endif
diff --git a/lib/tst_supported_fs_types.c b/lib/tst_supported_fs_types.c
index 46165ebc6..bbd5a5fb4 100644
--- a/lib/tst_supported_fs_types.c
+++ b/lib/tst_supported_fs_types.c
@@ -14,6 +14,7 @@
 #define TST_NO_DEFAULT_MAIN
 #include "tst_test.h"
 #include "tst_fs.h"
+#include "tst_private.h"
 
 /*
  * NOTE: new filesystem should be also added to
diff --git a/testcases/lib/tst_supported_fs.c b/testcases/lib/tst_supported_fs.c
index 1832154f0..af02a9ccb 100644
--- a/testcases/lib/tst_supported_fs.c
+++ b/testcases/lib/tst_supported_fs.c
@@ -14,6 +14,7 @@
 #define TST_NO_DEFAULT_MAIN
 #include "tst_test.h"
 #include "tst_fs.h"
+#include "tst_private.h"
 
 #define err_exit(...) ({ \
 	fprintf(stderr, __VA_ARGS__); \
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
