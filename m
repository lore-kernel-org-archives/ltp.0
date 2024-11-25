Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05183D5808D
	for <ltp@archiver.kernel.org>; Mon, 25 Nov 2024 12:21:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 814B33DAAC3
	for <ltp@archiver.kernel.org>; Mon, 25 Nov 2024 13:21:19 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 29D0F3DAAC6
 for <ltp@lists.linux.it>; Mon, 25 Nov 2024 13:19:02 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 15F2762C2F5
 for <ltp@lists.linux.it>; Mon, 25 Nov 2024 13:19:02 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 12D6821198
 for <ltp@lists.linux.it>; Mon, 25 Nov 2024 12:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1732537141; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=++FEL+nStN2kw3jFeJSIMnfiGfr/iQJw1VdpOFLStzw=;
 b=th1PnRUHI4LKADjqAd9W0yNzCX3T3kqvYuftaWRoXEsuha2f9GXKc5DTCD8y78iVA43mRu
 5XpoJOTOrsw0FCAxfdXZIV7cnGe2XQCQewLMmf6bQpHZu5rfG6BK/rMEwGw6meWkhxU5Rf
 QVvjGUlJn4x4TgFudEEWnn4Lv6ZLFSk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1732537141;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=++FEL+nStN2kw3jFeJSIMnfiGfr/iQJw1VdpOFLStzw=;
 b=VQFxtpSqSfRdELrEO2HFk/WLpQSIwNGwTY+I9xhZrEuC2bGSjeDBaJLTWh0Zn7Mj5n3ld8
 swk0NnANoy6uxpDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1732537141; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=++FEL+nStN2kw3jFeJSIMnfiGfr/iQJw1VdpOFLStzw=;
 b=th1PnRUHI4LKADjqAd9W0yNzCX3T3kqvYuftaWRoXEsuha2f9GXKc5DTCD8y78iVA43mRu
 5XpoJOTOrsw0FCAxfdXZIV7cnGe2XQCQewLMmf6bQpHZu5rfG6BK/rMEwGw6meWkhxU5Rf
 QVvjGUlJn4x4TgFudEEWnn4Lv6ZLFSk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1732537141;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=++FEL+nStN2kw3jFeJSIMnfiGfr/iQJw1VdpOFLStzw=;
 b=VQFxtpSqSfRdELrEO2HFk/WLpQSIwNGwTY+I9xhZrEuC2bGSjeDBaJLTWh0Zn7Mj5n3ld8
 swk0NnANoy6uxpDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E856B13890
 for <ltp@lists.linux.it>; Mon, 25 Nov 2024 12:19:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id COKeNTRrRGepGwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Mon, 25 Nov 2024 12:19:00 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 25 Nov 2024 13:19:02 +0100
MIME-Version: 1.0
Message-Id: <20241125-input_refactoring-v1-6-b622b3aa698d@suse.com>
References: <20241125-input_refactoring-v1-0-b622b3aa698d@suse.com>
In-Reply-To: <20241125-input_refactoring-v1-0-b622b3aa698d@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732537139; l=8529;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=p4yLVLPjcCTTBj+dkNjWo7wyyJULRIGPy4MCTaFMzdE=;
 b=auLQ/jlZlh6n8bE6p+EgJy0D6L52sSSM0/NNArtJPYF2FZ+HyiPKy3ToAvbM6UxsO5atp36kx
 scKdQR4+mI6DkbbBN1EDPt69eys844rBNEq8F2A9uDa0E4RukMvcl+c
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid, suse.com:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 6/7] Refactor input06 test
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

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/input/Makefile  |   5 +-
 testcases/kernel/input/input06.c | 190 ++++++++++++++++-----------------------
 2 files changed, 79 insertions(+), 116 deletions(-)

diff --git a/testcases/kernel/input/Makefile b/testcases/kernel/input/Makefile
index a37aa28fc27688901e0555a0338395a681b45b39..945299a13bfcecc3eeae029931ef5ae44781b7ad 100644
--- a/testcases/kernel/input/Makefile
+++ b/testcases/kernel/input/Makefile
@@ -7,9 +7,6 @@ LTPLIBS = uinput
 
 include $(top_srcdir)/include/mk/testcases.mk
 
-FILTER_OUT_MAKE_TARGETS		:= input_helper
-input01 input02 input03 input04 input05: LDLIBS += -lltpuinput
-
-input06: %: input_helper.o
+LDLIBS += -lltpuinput
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/input/input06.c b/testcases/kernel/input/input06.c
index b698c277d875ed2df8a0f07a88784997944eeee4..5527e160c4569a94d5b5f50da3dc3360143f231d 100644
--- a/testcases/kernel/input/input06.c
+++ b/testcases/kernel/input/input06.c
@@ -1,102 +1,30 @@
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
-  *  Create a virtual device, activate auto-repeat and
-  *  and check that auto repeat is working
-  */
+/*\
+ * [Description]
+ *
+ * Verify that auto-repeat is working on a virtual device, that in our case
+ * it's a mouse.
+ */
 
-#include <linux/input.h>
 #include <linux/uinput.h>
-#include <linux/kd.h>
-
-#include "test.h"
-#include "safe_macros.h"
-#include "lapi/fcntl.h"
-#include "input_helper.h"
 
-static void setup(void);
-static void send_events(void);
-static int check_events(void);
-static void cleanup(void);
+#include "input_common.h"
 
-static int fd;
-static int fd2;
 struct input_event events[64];
 static int num_events;
 static int ev_iter;
-
-char *TCID = "input06";
-
-int main(int ac, char **av)
-{
-	int lc;
-	int pid;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); ++lc) {
-		pid = tst_fork();
-
-		switch (pid) {
-		case 0:
-			send_events();
-			exit(0);
-		case -1:
-			tst_brkm(TBROK | TERRNO, cleanup, "fork() failed");
-		default:
-			if (!check_events())
-				tst_resm(TFAIL,
-					"Wrong data received in eventX");
-			else
-				tst_resm(TPASS, "Data received in eventX");
-		break;
-		}
-
-		SAFE_WAITPID(NULL, pid, NULL, 0);
-	}
-
-	cleanup();
-	tst_exit();
-}
-
-static void setup(void)
-{
-	tst_require_root();
-
-	fd = open_uinput();
-
-	SAFE_IOCTL(NULL, fd, UI_SET_EVBIT, EV_KEY);
-	SAFE_IOCTL(NULL, fd, UI_SET_EVBIT, EV_REP);
-	SAFE_IOCTL(NULL, fd, UI_SET_KEYBIT, KEY_X);
-
-	create_device(fd);
-
-	fd2 = open_device();
-	SAFE_IOCTL(NULL, fd2, EVIOCGRAB, 1);
-}
+static int fd_send = -1;
+static int fd_recv = -1;
 
 static void send_events(void)
 {
-	send_event(fd, EV_KEY, KEY_X, 1);
-	send_event(fd, EV_SYN, 0, 0);
+	send_event(fd_send, EV_KEY, KEY_X, 1);
+	send_event(fd_send, EV_SYN, 0, 0);
 
 	/*
 	 * Sleep long enough to keep the key pressed for some time
@@ -106,8 +34,8 @@ static void send_events(void)
 	 */
 	usleep(500000);
 
-	send_event(fd, EV_KEY, KEY_X, 0);
-	send_event(fd, EV_SYN, 0, 0);
+	send_event(fd_send, EV_KEY, KEY_X, 0);
+	send_event(fd_send, EV_SYN, 0, 0);
 }
 
 static int check_event(struct input_event *iev, int event, int code, int value)
@@ -117,20 +45,18 @@ static int check_event(struct input_event *iev, int event, int code, int value)
 
 static void read_events(void)
 {
-	int rd = read(fd2, events, sizeof(events));
-	if (rd < 0)
-		tst_brkm(TBROK | TERRNO, cleanup, "read() failed");
+	int num_bytes = SAFE_READ(0, fd_recv, events, sizeof(events));
 
-	if (rd == 0)
-		tst_brkm(TBROK, cleanup, "Failed to read events");
+	if (!num_bytes)
+		tst_brk(TBROK, "Failed to read events");
 
-	if (rd % sizeof(struct input_event) != 0) {
-		tst_brkm(TBROK, cleanup, "read size %i not multiple of %zu",
-		         rd, sizeof(struct input_event));
+	if (num_bytes % sizeof(struct input_event) != 0) {
+		tst_brk(TBROK, "Read size %i is not multiple of %zu",
+			num_bytes, sizeof(struct input_event));
 	}
 
 	ev_iter = 0;
-	num_events = rd / sizeof(struct input_event);
+	num_events = num_bytes / sizeof(struct input_event);
 }
 
 static int have_events(void)
@@ -146,29 +72,37 @@ static struct input_event *next_event(void)
 	return &events[ev_iter++];
 }
 
+static int check_event_code(struct input_event *iev, int event, int code)
+{
+	return iev->type == event && iev->code == code;
+}
+
 static int parse_autorepeat_config(struct input_event *iev)
 {
 	if (!check_event_code(iev, EV_REP, REP_DELAY)) {
-		tst_resm(TFAIL,
-			 "Didn't get EV_REP configuration with code REP_DELAY");
+		tst_res(TFAIL, "Didn't get EV_REP type with REP_DELAY code");
 		return 0;
 	}
 
 	if (!check_event_code(next_event(), EV_REP, REP_PERIOD)) {
-		tst_resm(TFAIL,
-			 "Didn't get EV_REP configuration with code REP_PERIOD");
+		tst_res(TFAIL, "Didn't get EV_REP type with REP_PERIOD code");
 		return 0;
 	}
 
 	return 1;
 }
 
+static int check_sync_event(struct input_event *iev)
+{
+	return check_event_code(iev, EV_SYN, SYN_REPORT);
+}
+
 static int parse_key(struct input_event *iev)
 {
 	int autorep_count = 0;
 
 	if (!check_event(iev, EV_KEY, KEY_X, 1) || !check_sync_event(next_event())) {
-		tst_resm(TFAIL, "Didn't get expected key press for KEY_X");
+		tst_res(TFAIL, "Didn't get expected key press for KEY_X");
 		return 0;
 	}
 
@@ -180,19 +114,16 @@ static int parse_key(struct input_event *iev)
 
 	/* make sure we have at least one auto-repeated key event */
 	if (!autorep_count) {
-		tst_resm(TFAIL,
-			 "Didn't get autorepeat events for the key - KEY_X");
+		tst_res(TFAIL, "Didn't get autorepeat events for the key - KEY_X");
 		return 0;
 	}
 
 	if (!check_event(iev, EV_KEY, KEY_X, 0) || !check_sync_event(next_event())) {
-		tst_resm(TFAIL,
-			 "Didn't get expected key release for KEY_X");
+		tst_res(TFAIL, "Didn't get expected key release for KEY_X");
 		return 0;
 	}
 
-	tst_resm(TINFO,
-		 "Received %d repititions for KEY_X", autorep_count);
+	tst_res(TINFO, "Received %d repetitions for KEY_X", autorep_count);
 
 	return 1;
 }
@@ -218,8 +149,7 @@ static int check_events(void)
 			rep_keys_done = 1;
 			break;
 		default:
-			tst_resm(TFAIL,
-				 "Unexpected event type '0x%04x' received",
+			tst_res(TFAIL, "Unexpected event type '0x%04x' received",
 				iev->type);
 			ret = 0;
 			break;
@@ -232,10 +162,46 @@ static int check_events(void)
 	return ret;
 }
 
+static void run(void)
+{
+	if (!SAFE_FORK()) {
+		send_events();
+		exit(0);
+	}
+
+	if (!check_events())
+		tst_res(TFAIL, "Wrong data received from input device");
+	else
+		tst_res(TPASS, "Data received from input device");
+}
+
+static void setup(void)
+{
+	fd_send = open_uinput();
+
+	SAFE_IOCTL(fd_send, UI_SET_EVBIT, EV_KEY);
+	SAFE_IOCTL(fd_send, UI_SET_EVBIT, EV_REP);
+	SAFE_IOCTL(fd_send, UI_SET_KEYBIT, KEY_X);
+
+	create_input_device(fd_send);
+
+	fd_recv = open_event_device();
+	SAFE_IOCTL(fd_recv, EVIOCGRAB, 1);
+}
+
 static void cleanup(void)
 {
-	if (fd2 > 0 && close(fd2))
-		tst_resm(TWARN | TERRNO, "close(fd2) failed");
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
+	.forks_child = 1,
+};

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
