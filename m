Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B5A9D78301
	for <ltp@archiver.kernel.org>; Mon,  2 Dec 2024 10:15:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 950CE3DD275
	for <ltp@archiver.kernel.org>; Mon,  2 Dec 2024 11:15:23 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0B5073DD27C
 for <ltp@lists.linux.it>; Mon,  2 Dec 2024 11:12:53 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C0951219111
 for <ltp@lists.linux.it>; Mon,  2 Dec 2024 11:12:52 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 271E61F444;
 Mon,  2 Dec 2024 10:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733134371; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qwZAgogNBkPakN7CPuznyIdwZGHLgs1c+jpUyrWV/Ng=;
 b=d5+reOLiMrfd3XodpIsQz33iHe8Pm3auZHKy3+4PywQBEutn5e6K4a+fAeK60dAN/NP8iG
 RpS5gWTgoiJWP97IGJIlWAxHavhHHLRQ5+0B3OyTAEq3UjES2ry4kXS6xQA5hzRTj/fhmu
 rafik++PLenFNqJae6Gx0iaUTqPrfWg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733134371;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qwZAgogNBkPakN7CPuznyIdwZGHLgs1c+jpUyrWV/Ng=;
 b=8kt5PrWQQWTQuxQWSacj84yqL3MPOoEME77AhfSXOPHnIgCT4uKxd31+T5I2L3/813aNji
 MoqWZVsCUveeE5AQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=d5+reOLi;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=8kt5PrWQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733134371; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qwZAgogNBkPakN7CPuznyIdwZGHLgs1c+jpUyrWV/Ng=;
 b=d5+reOLiMrfd3XodpIsQz33iHe8Pm3auZHKy3+4PywQBEutn5e6K4a+fAeK60dAN/NP8iG
 RpS5gWTgoiJWP97IGJIlWAxHavhHHLRQ5+0B3OyTAEq3UjES2ry4kXS6xQA5hzRTj/fhmu
 rafik++PLenFNqJae6Gx0iaUTqPrfWg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733134371;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qwZAgogNBkPakN7CPuznyIdwZGHLgs1c+jpUyrWV/Ng=;
 b=8kt5PrWQQWTQuxQWSacj84yqL3MPOoEME77AhfSXOPHnIgCT4uKxd31+T5I2L3/813aNji
 MoqWZVsCUveeE5AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0BC3813A31;
 Mon,  2 Dec 2024 10:12:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gIoXASOITWcNSwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 02 Dec 2024 10:12:51 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 02 Dec 2024 11:12:48 +0100
MIME-Version: 1.0
Message-Id: <20241202-input_refactoring-v2-4-369609492896@suse.com>
References: <20241202-input_refactoring-v2-0-369609492896@suse.com>
In-Reply-To: <20241202-input_refactoring-v2-0-369609492896@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733134370; l=4520;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=DtVIhdT/DMeTx8539HR6oBGEFZOj4cLjb9hWOqrlOSE=;
 b=tJXr+Nw8sqIf0wOU9azoS74KHkj6mKkTwKIL+HOZhJ7v2kidHstqa5rM6xCXaqC5llpxyx42v
 Yasnu2tfpCJBlonin+4JtSBEDHpl0ofj4sGYf0PSENhLtxDh+8Ivha3
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: 271E61F444
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.com:email,suse.com:mid];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 4/7] Refactor input04 test
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

Reviewed-by: Li Wang <liwang@redhat.com>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/input/Makefile  |   4 +-
 testcases/kernel/input/input04.c | 113 ++++++++++++---------------------------
 2 files changed, 35 insertions(+), 82 deletions(-)

diff --git a/testcases/kernel/input/Makefile b/testcases/kernel/input/Makefile
index 8c302dbc8c75cf4fd42bc162b4bb8a9882237164..cf35e1bfc150a6c1556ef796d4858c0df9020131 100644
--- a/testcases/kernel/input/Makefile
+++ b/testcases/kernel/input/Makefile
@@ -8,8 +8,8 @@ LTPLIBS = uinput
 include $(top_srcdir)/include/mk/testcases.mk
 
 FILTER_OUT_MAKE_TARGETS		:= input_helper
-input01 input02 input03: LDLIBS += -lltpuinput
+input01 input02 input03 input04: LDLIBS += -lltpuinput
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
 
-input04 input05 input06: %: input_helper.o
+input05 input06: %: input_helper.o
diff --git a/testcases/kernel/input/input04.c b/testcases/kernel/input/input04.c
index e57b76b0b40f8be4f851137f1a9185b37c6e64c0..3c76d7c82ad7fe76f35f5a4ecfc78f27069d3fa0 100644
--- a/testcases/kernel/input/input04.c
+++ b/testcases/kernel/input/input04.c
@@ -1,103 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2015 Cedric Hnyda <chnyda@suse.com>
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
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
  */
 
- /*
-  *  Create a virtual device (mouse), send empty events to /dev/uinput
-  *  and check that the events are not received in /dev/inputX
-  */
-
-#include <linux/input.h>
-
-#include "test.h"
-#include "safe_macros.h"
-#include "lapi/fcntl.h"
-#include "input_helper.h"
-
-#define NB_TEST 20
+/*\
+ * [Description]
+ *
+ * Verify that /dev/input/eventX doesn't receive any event sent from a virtual
+ * device, that in our case is a mouse, when relative move is (0, 0)
+ */
 
-static void setup(void);
-static void send_events(void);
-static void cleanup(void);
+#include "input_common.h"
 
-static int fd, fd2;
+#define NUM_EVENTS 20
 
-char *TCID = "input04";
+static int fd_send = -1;
+static int fd_recv = -1;
 
-int main(int ac, char **av)
+static void run(void)
 {
-	int lc;
-	int pid;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); ++lc) {
-		pid = tst_fork();
+	tst_res(TINFO, "Sending empty relative move");
 
-		switch (pid) {
-		case 0:
-			send_events();
-			exit(0);
-		case -1:
-			tst_brkm(TBROK | TERRNO, cleanup, "fork() failed");
-		default:
-			if (no_events_queued(fd2, 1))
-				tst_resm(TPASS,
-					"No data received in /dev/inputX");
-			else
-				tst_resm(TFAIL,
-					"Data received /dev/inputX");
-		break;
-		}
-
-		SAFE_WAITPID(NULL, pid, NULL, 0);
+	for (int i = 0; i < NUM_EVENTS; i++) {
+		send_relative_move(fd_send, 0, 0);
+		usleep(1000);
 	}
 
-	cleanup();
-	tst_exit();
+	verify_no_events_queued(fd_recv);
 }
 
 static void setup(void)
 {
-	tst_require_root();
-
-	fd = open_uinput();
-	setup_mouse_events(fd);
-	create_device(fd);
-
-	fd2 = open_device();
-}
-
-static void send_events(void)
-{
-	int nb;
+	fd_send = open_uinput();
+	setup_mouse_events(fd_send);
+	create_input_device(fd_send);
 
-	for (nb = 0; nb < NB_TEST; ++nb) {
-		send_rel_move(fd, 0, 0);
-		usleep(1000);
-	}
+	fd_recv = open_event_device();
 }
 
 static void cleanup(void)
 {
-	if (fd2 > 0 && close(fd2))
-		tst_resm(TWARN | TERRNO, "close(fd2)");
+	if (fd_send != -1)
+		destroy_input_device(fd_send);
 
-	destroy_device(fd);
+	if (fd_recv != -1)
+		SAFE_CLOSE(fd_recv);
 }
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_root = 1,
+};

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
