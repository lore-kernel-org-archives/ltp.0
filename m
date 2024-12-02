Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1FBCE6689A
	for <ltp@archiver.kernel.org>; Mon,  2 Dec 2024 10:13:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 342FB3DD287
	for <ltp@archiver.kernel.org>; Mon,  2 Dec 2024 11:13:42 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 41BE03DD275
 for <ltp@lists.linux.it>; Mon,  2 Dec 2024 11:12:52 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id AA6E2101BC79
 for <ltp@lists.linux.it>; Mon,  2 Dec 2024 11:12:51 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4BB19211BB;
 Mon,  2 Dec 2024 10:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733134371; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dnr9d0rrUMuyabUO32sVdf+XrNiYUr6i/gUbdz8So2s=;
 b=r4ErxSMilPFSDUmlKhraYUjPsPPribpiFwiO8KhV9oVe0uKX4UCcjOhCccg4Yx5YEBr1Ef
 4fRa3snVWL5AN0oPRG9WIjLcfJbCiEJG0dAAsfa3SbiyrVMc9Jm+l0/IK3XDMOx8JbkpJG
 yU8LR9RDvY918EVnXTW1o8QLGiZefBA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733134371;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dnr9d0rrUMuyabUO32sVdf+XrNiYUr6i/gUbdz8So2s=;
 b=EfstxJpoi2880nYK02R6LGftm+Osx+uIVT3nWbPTMuVju6yQDxeT3+GkVraoiDZJfZj+xG
 LOe59n5HcraFzhAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733134371; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dnr9d0rrUMuyabUO32sVdf+XrNiYUr6i/gUbdz8So2s=;
 b=r4ErxSMilPFSDUmlKhraYUjPsPPribpiFwiO8KhV9oVe0uKX4UCcjOhCccg4Yx5YEBr1Ef
 4fRa3snVWL5AN0oPRG9WIjLcfJbCiEJG0dAAsfa3SbiyrVMc9Jm+l0/IK3XDMOx8JbkpJG
 yU8LR9RDvY918EVnXTW1o8QLGiZefBA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733134371;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dnr9d0rrUMuyabUO32sVdf+XrNiYUr6i/gUbdz8So2s=;
 b=EfstxJpoi2880nYK02R6LGftm+Osx+uIVT3nWbPTMuVju6yQDxeT3+GkVraoiDZJfZj+xG
 LOe59n5HcraFzhAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 30A6B13A40;
 Mon,  2 Dec 2024 10:12:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GAoVCiOITWcNSwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 02 Dec 2024 10:12:51 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 02 Dec 2024 11:12:49 +0100
MIME-Version: 1.0
Message-Id: <20241202-input_refactoring-v2-5-369609492896@suse.com>
References: <20241202-input_refactoring-v2-0-369609492896@suse.com>
In-Reply-To: <20241202-input_refactoring-v2-0-369609492896@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733134370; l=4878;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=3oC5HSTkBi5vH12Hjk4+FEDbGl5EHx0aKZvuOga0R8s=;
 b=wgRDUQCIbTLE9i6rdnbGHyfJPeW0bNBlQP7DgY1u4Uzj5JYoERW3FpJP3tggtcuhkHNloDpxs
 gXMjE6fbUZfDpdgQvPkDy0BT/U6mMAieAj8ZHtOySji3NZYEyu2KnEa
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:mid,
 suse.com:email]
Subject: [LTP] [PATCH v2 5/7] Refactor input05 test
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
 testcases/kernel/input/Makefile  |   6 +-
 testcases/kernel/input/input05.c | 119 ++++++++++++---------------------------
 2 files changed, 40 insertions(+), 85 deletions(-)

diff --git a/testcases/kernel/input/Makefile b/testcases/kernel/input/Makefile
index cf35e1bfc150a6c1556ef796d4858c0df9020131..a37aa28fc27688901e0555a0338395a681b45b39 100644
--- a/testcases/kernel/input/Makefile
+++ b/testcases/kernel/input/Makefile
@@ -8,8 +8,8 @@ LTPLIBS = uinput
 include $(top_srcdir)/include/mk/testcases.mk
 
 FILTER_OUT_MAKE_TARGETS		:= input_helper
-input01 input02 input03 input04: LDLIBS += -lltpuinput
+input01 input02 input03 input04 input05: LDLIBS += -lltpuinput
 
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
+input06: %: input_helper.o
 
-input05 input06: %: input_helper.o
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/input/input05.c b/testcases/kernel/input/input05.c
index 46b4fe8b27cfcfe2d025d84c4dc005e528d46dae..4e5072a038ea8e4f7b8e0899d88a58bdf18e9e94 100644
--- a/testcases/kernel/input/input05.c
+++ b/testcases/kernel/input/input05.c
@@ -1,107 +1,62 @@
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
-  *  Create a virtual device (mouse), send events to /dev/uinput
-  *  and Check that events not advertised in the input device bits
-  *  are filtered.
-  */
+/*\
+ * [Description]
+ *
+ * Verify that /dev/input/eventX doesn't receive any event sent from a virtual
+ * device, that in our case is a mouse, when events not advertised in the input
+ * device bits are filtered.
+ */
 
-#include <linux/input.h>
 #include <linux/uinput.h>
 
-#include "test.h"
-#include "safe_macros.h"
-#include "lapi/fcntl.h"
-#include "input_helper.h"
-
-#define X_VALUE 10
-#define Y_VALUE 10
+#include "input_common.h"
 
-#define NB_TEST 20
+#define NUM_EVENTS 20
+#define MOVE_X 10
+#define MOVE_Y 10
 
-static void setup(void);
-static void send_events(void);
-static void cleanup(void);
+static int fd_send = -1;
+static int fd_recv = -1;
 
-static int fd;
-static int fd2;
-
-char *TCID = "input05";
-
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
+	tst_res(TINFO, "Sending relative mouse move (%i, %i)", MOVE_X, MOVE_Y);
 
-		switch (pid) {
-		case 0:
-			send_events();
-			exit(0);
-		case -1:
-			tst_brkm(TBROK | TERRNO, cleanup, "fork() failed");
-		default:
-			if (no_events_queued(fd2, 1))
-				tst_resm(TPASS, "No data received in eventX");
-			else
-				tst_resm(TFAIL, "Data received in eventX");
-		break;
-		}
-
-		SAFE_WAITPID(NULL, pid, NULL, 0);
+	for (int i = 0; i < NUM_EVENTS; i++) {
+		send_relative_move(fd_send, MOVE_X, MOVE_Y);
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
+	fd_send = open_uinput();
+	SAFE_IOCTL(fd_send, UI_SET_EVBIT, EV_KEY);
+	SAFE_IOCTL(fd_send, UI_SET_KEYBIT, BTN_LEFT);
+	create_input_device(fd_send);
 
-	SAFE_IOCTL(NULL, fd, UI_SET_EVBIT, EV_KEY);
-	SAFE_IOCTL(NULL, fd, UI_SET_KEYBIT, BTN_LEFT);
-
-	create_device(fd);
-
-	fd2 = open_device();
+	fd_recv = open_event_device();
 }
 
-static void send_events(void)
+static void cleanup(void)
 {
-	int nb;
+	if (fd_send != -1)
+		destroy_input_device(fd_send);
 
-	for (nb = 0; nb < NB_TEST; ++nb) {
-		send_rel_move(fd, X_VALUE, Y_VALUE);
-		usleep(1000);
-	}
+	if (fd_recv != -1)
+		SAFE_CLOSE(fd_recv);
 }
 
-static void cleanup(void)
-{
-	destroy_device(fd);
-}
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
