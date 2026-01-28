Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC65FD25B48
	for <ltp@archiver.kernel.org>; Wed, 28 Jan 2026 11:55:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6339B3CB36B
	for <ltp@archiver.kernel.org>; Wed, 28 Jan 2026 12:55:18 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 080C83C2A7A
 for <ltp@lists.linux.it>; Wed, 28 Jan 2026 12:54:58 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id BB2D1600B07
 for <ltp@lists.linux.it>; Wed, 28 Jan 2026 12:54:57 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 70E4F33B74;
 Wed, 28 Jan 2026 11:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769601296; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=m6EI3gngy/PrBojYBMhh98vAodpQ/QvGT3eOLNxE81M=;
 b=ApMgXiYngiYifSrQz6aakUtbOcKQkh9iLcrGowI9DFKxo0tEAaNHFk5sCRoMh8yYnsHhFq
 o6H3vl9Nrt7h76lsrWsyz2oXPbEGGwrmJHeyaTF/MN51doj4tAfPLVqm+4B0NBbRns8ios
 JSapgFrN0qFTavHgERWKIf6Ut59Y828=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769601296;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=m6EI3gngy/PrBojYBMhh98vAodpQ/QvGT3eOLNxE81M=;
 b=SHBsPrgdw8ACvCgS6/F2VevQLJqGTcl+7U3NQGERlFNRhBs8D6eM611UNk/BfciXOWLMW6
 8UiHhzVrrkrzWtAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769601296; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=m6EI3gngy/PrBojYBMhh98vAodpQ/QvGT3eOLNxE81M=;
 b=ApMgXiYngiYifSrQz6aakUtbOcKQkh9iLcrGowI9DFKxo0tEAaNHFk5sCRoMh8yYnsHhFq
 o6H3vl9Nrt7h76lsrWsyz2oXPbEGGwrmJHeyaTF/MN51doj4tAfPLVqm+4B0NBbRns8ios
 JSapgFrN0qFTavHgERWKIf6Ut59Y828=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769601296;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=m6EI3gngy/PrBojYBMhh98vAodpQ/QvGT3eOLNxE81M=;
 b=SHBsPrgdw8ACvCgS6/F2VevQLJqGTcl+7U3NQGERlFNRhBs8D6eM611UNk/BfciXOWLMW6
 8UiHhzVrrkrzWtAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 423BA3EA61;
 Wed, 28 Jan 2026 11:54:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id AgOPDhD5eWnMZAAAD6G6ig
 (envelope-from <rbranco@suse.de>); Wed, 28 Jan 2026 11:54:56 +0000
From: Ricardo Branco <rbranco@suse.de>
To: ltp@lists.linux.it
Date: Wed, 28 Jan 2026 12:54:28 +0100
Message-ID: <20260128115432.21199-1-rbranco@suse.de>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.994];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] userfaultfd: Do not use min_kver as gate for test
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

Do not use .min_kver to decide whether the test should run and instead
check for the presence of /dev/userfaultfd at runtime.

Signed-off-by: Ricardo Branco <rbranco@suse.de>
---
 .../kernel/syscalls/userfaultfd/userfaultfd03.c    | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/userfaultfd/userfaultfd03.c b/testcases/kernel/syscalls/userfaultfd/userfaultfd03.c
index ba87bf6e4..d6e1897db 100644
--- a/testcases/kernel/syscalls/userfaultfd/userfaultfd03.c
+++ b/testcases/kernel/syscalls/userfaultfd/userfaultfd03.c
@@ -13,6 +13,7 @@
 
 #include "config.h"
 #include <poll.h>
+#include <unistd.h>
 #include "tst_test.h"
 #include "tst_safe_macros.h"
 #include "tst_safe_pthread.h"
@@ -23,6 +24,17 @@ static char *page;
 static void *copy_page;
 static int uffd;
 
+static void setup(void)
+{
+	if (access("/dev/userfaultfd", F_OK) == 0)
+		return;
+
+	if (tst_kvercmp(6, 1, 0) < 0)
+		tst_brk(TCONF, "/dev/userfaultfd is missing (kernel < 6.1)");
+
+	tst_brk(TBROK, "/dev/userfaultfd is missing (kernel >= 6.1)");
+}
+
 static int open_userfaultfd(int flags)
 {
 	int fd, fd2;
@@ -117,6 +129,6 @@ static void run(void)
 
 static struct tst_test test = {
 	.needs_root = 1,
+	.setup = setup,
 	.test_all = run,
-	.min_kver = "5.11",
 };
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
