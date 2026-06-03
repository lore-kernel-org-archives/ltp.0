Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 515BECD6E4A
	for <ltp@archiver.kernel.org>; Wed,  3 Jun 2026 11:59:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F31CE3E619E
	for <ltp@archiver.kernel.org>; Wed,  3 Jun 2026 13:59:43 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CDCC43E7215
 for <ltp@lists.linux.it>; Wed,  3 Jun 2026 13:58:51 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4A4AA600845
 for <ltp@lists.linux.it>; Wed,  3 Jun 2026 13:58:51 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 61E2D6756A;
 Wed,  3 Jun 2026 11:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1780487921; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PpctseLQ3tuEMQAvuUb5KpDQlksorvLqEE8ZwL8SSHA=;
 b=0ZCr+km7Ebo1vk6Fk/loe7QQ2foqZZHOkzWtvQYzuZjicei7amYLguhSuMN6XlkT0I2RNR
 QmntGdxTX3Ku3BpvUnaN92xk7Y7ZfHPyRTs1sB7GMvQyH/nQr2sNLKhhsYVlq0B09L3zVK
 n4qrw6Uxh7LMDvsLeCNmB08brZFUfZ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1780487921;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PpctseLQ3tuEMQAvuUb5KpDQlksorvLqEE8ZwL8SSHA=;
 b=dThdCG3yH96tY73bKVP/y3mC+WqSzUH/LNJ3XETQzKyljIMq9il137ApVAMm9/kKYVpu4I
 0s6Bc5HYsiBtp8AA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=0ZCr+km7;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=dThdCG3y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1780487921; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PpctseLQ3tuEMQAvuUb5KpDQlksorvLqEE8ZwL8SSHA=;
 b=0ZCr+km7Ebo1vk6Fk/loe7QQ2foqZZHOkzWtvQYzuZjicei7amYLguhSuMN6XlkT0I2RNR
 QmntGdxTX3Ku3BpvUnaN92xk7Y7ZfHPyRTs1sB7GMvQyH/nQr2sNLKhhsYVlq0B09L3zVK
 n4qrw6Uxh7LMDvsLeCNmB08brZFUfZ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1780487921;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PpctseLQ3tuEMQAvuUb5KpDQlksorvLqEE8ZwL8SSHA=;
 b=dThdCG3yH96tY73bKVP/y3mC+WqSzUH/LNJ3XETQzKyljIMq9il137ApVAMm9/kKYVpu4I
 0s6Bc5HYsiBtp8AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 47159779AA;
 Wed,  3 Jun 2026 11:58:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6Em4EPEWIGqLagAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 03 Jun 2026 11:58:41 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed,  3 Jun 2026 13:58:28 +0200
Message-ID: <20260603115828.587769-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260603115828.587769-1-pvorel@suse.cz>
References: <20260603115828.587769-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 61E2D6756A
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:email,suse.cz:mid,suse.com:email];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/3] lapi: Move renameat2.h into lapi/stdio.h
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

Fallback definition for renameat2() is currently needed at least for
Musl < v1.2.6 (in current Alpine in CI) and openSUSE Leap 42.2
(still being supported due the same SLES version being tested).

testcases/kernel/syscalls/renameat2/renameat2.h was a test specific
header which contains only fallback for renameat2(). Move it into
include/lapi/stdio.h with minor cleanup. That will help to use it in
other tests.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Originally triggered by fanotify13.c fix, see the cover letter.

 include/lapi/stdio.h                          | 25 +++++++++++++
 .../kernel/syscalls/renameat2/renameat2.h     | 35 -------------------
 .../kernel/syscalls/renameat2/renameat201.c   |  4 +--
 .../kernel/syscalls/renameat2/renameat202.c   |  2 +-
 .../kernel/syscalls/renameat2/renameat203.c   |  4 +--
 5 files changed, 30 insertions(+), 40 deletions(-)
 create mode 100644 include/lapi/stdio.h
 delete mode 100644 testcases/kernel/syscalls/renameat2/renameat2.h

diff --git a/include/lapi/stdio.h b/include/lapi/stdio.h
new file mode 100644
index 0000000000..cdcb3e2062
--- /dev/null
+++ b/include/lapi/stdio.h
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2015 Cedric Hnyda <chnyda@suse.com>
+ * Copyright (c) 2026 Petr Vorel <pvorel@suse.cz>
+ */
+
+#ifndef LAPI_STDIO_H__
+#define LAPI_STDIO_H__
+
+#include "config.h"
+#include "lapi/syscalls.h"
+#include <stdio.h>
+#include <stdint.h>
+#include <sys/types.h>
+
+#ifndef HAVE_RENAMEAT2
+int renameat2(int olddirfd, const char *oldpath, int newdirfd,
+				const char *newpath, unsigned int flags)
+{
+	return tst_syscall(__NR_renameat2, olddirfd, oldpath, newdirfd,
+						newpath, flags);
+}
+#endif
+
+#endif /* LAPI_STDIO_H__ */
diff --git a/testcases/kernel/syscalls/renameat2/renameat2.h b/testcases/kernel/syscalls/renameat2/renameat2.h
deleted file mode 100644
index c4688ed535..0000000000
--- a/testcases/kernel/syscalls/renameat2/renameat2.h
+++ /dev/null
@@ -1,35 +0,0 @@
-/*
- * Copyright (c) 2015 Cedric Hnyda <chnyda@suse.com>
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
- */
-
-#ifndef RENAMEAT2_H
-#define RENAMEAT2_H
-
-#include <sys/types.h>
-#include "config.h"
-#include "lapi/syscalls.h"
-
-#if !defined(HAVE_RENAMEAT2)
-int renameat2(int olddirfd, const char *oldpath, int newdirfd,
-				const char *newpath, unsigned int flags)
-{
-	return tst_syscall(__NR_renameat2, olddirfd, oldpath, newdirfd,
-						newpath, flags);
-}
-#endif
-
-#endif /* RENAMEAT2_H */
diff --git a/testcases/kernel/syscalls/renameat2/renameat201.c b/testcases/kernel/syscalls/renameat2/renameat201.c
index a7ec388ab4..0ffb147af1 100644
--- a/testcases/kernel/syscalls/renameat2/renameat201.c
+++ b/testcases/kernel/syscalls/renameat2/renameat201.c
@@ -15,9 +15,9 @@
 
 #define _GNU_SOURCE
 
-#include "lapi/fcntl.h"
 #include "tst_test.h"
-#include "renameat2.h"
+#include "lapi/fcntl.h"
+#include "lapi/stdio.h"
 
 #define TEST_DIR "test_dir/"
 #define TEST_DIR2 "test_dir2/"
diff --git a/testcases/kernel/syscalls/renameat2/renameat202.c b/testcases/kernel/syscalls/renameat2/renameat202.c
index 17acd7206e..79c2abaea9 100644
--- a/testcases/kernel/syscalls/renameat2/renameat202.c
+++ b/testcases/kernel/syscalls/renameat2/renameat202.c
@@ -12,7 +12,7 @@
 
 #include "lapi/fcntl.h"
 #include "tst_test.h"
-#include "renameat2.h"
+#include "lapi/stdio.h"
 
 #define TEST_DIR "test_dir/"
 #define TEST_DIR2 "test_dir2/"
diff --git a/testcases/kernel/syscalls/renameat2/renameat203.c b/testcases/kernel/syscalls/renameat2/renameat203.c
index dba12e48b3..262c871983 100644
--- a/testcases/kernel/syscalls/renameat2/renameat203.c
+++ b/testcases/kernel/syscalls/renameat2/renameat203.c
@@ -13,9 +13,9 @@
 
 #define _GNU_SOURCE
 
-#include "lapi/fcntl.h"
 #include "tst_test.h"
-#include "renameat2.h"
+#include "lapi/fcntl.h"
+#include "lapi/stdio.h"
 
 #define TEST_DIR "test_dir/"
 #define TEST_DIR2 "test_dir2/"
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
