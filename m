Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A459BD73619
	for <ltp@archiver.kernel.org>; Mon,  2 Dec 2024 10:13:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B22B43DD279
	for <ltp@archiver.kernel.org>; Mon,  2 Dec 2024 11:13:08 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0AA393DD246
 for <ltp@lists.linux.it>; Mon,  2 Dec 2024 11:12:51 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 816A51BE85F9
 for <ltp@lists.linux.it>; Mon,  2 Dec 2024 11:12:51 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0050B211BA;
 Mon,  2 Dec 2024 10:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733134371; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aoBtueZOmaV9g3axA68bzJ+P7wevourCYoq+ja/JvWE=;
 b=sydyaOFznd3hDOcAdaeS6n+gyFVoCy59uno9KDeREC1ROg+B+c4mHXTs+JsKBF3Ou1DcfG
 4XKSyYWggpe/Lg3h31OoV6NscfqHCK4lreHE/Xjt7SXx+rzCNuTQI5MiPs4TzyYS+/fOn+
 Gug55DD4rdYFZBTnu5jW/EmBa8X+g/c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733134371;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aoBtueZOmaV9g3axA68bzJ+P7wevourCYoq+ja/JvWE=;
 b=QsQzySlr+1Qidn4s+7yy6ECNyxsePV/JQxBmkrXShGbexMhFgBANzjYRmXGx0tq7IvRi2q
 uoTEhJ36MuLtN9Aw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733134371; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aoBtueZOmaV9g3axA68bzJ+P7wevourCYoq+ja/JvWE=;
 b=sydyaOFznd3hDOcAdaeS6n+gyFVoCy59uno9KDeREC1ROg+B+c4mHXTs+JsKBF3Ou1DcfG
 4XKSyYWggpe/Lg3h31OoV6NscfqHCK4lreHE/Xjt7SXx+rzCNuTQI5MiPs4TzyYS+/fOn+
 Gug55DD4rdYFZBTnu5jW/EmBa8X+g/c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733134371;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aoBtueZOmaV9g3axA68bzJ+P7wevourCYoq+ja/JvWE=;
 b=QsQzySlr+1Qidn4s+7yy6ECNyxsePV/JQxBmkrXShGbexMhFgBANzjYRmXGx0tq7IvRi2q
 uoTEhJ36MuLtN9Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DAAC613A40;
 Mon,  2 Dec 2024 10:12:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gHujMyKITWcNSwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 02 Dec 2024 10:12:50 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 02 Dec 2024 11:12:47 +0100
MIME-Version: 1.0
Message-Id: <20241202-input_refactoring-v2-3-369609492896@suse.com>
References: <20241202-input_refactoring-v2-0-369609492896@suse.com>
In-Reply-To: <20241202-input_refactoring-v2-0-369609492896@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733134370; l=6429;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=HtbkLFM6+ORsgAA45HAcMDHxzzK8+FbVBi2oMR0TAkw=;
 b=DLlsxESBYTljFE2KRPblOYURWl1rhuZ6l8WikS/n1akfTigRjKF06KheLZXdDyD6elwK2BWPc
 QHI6j4JutyMBmZSaKH8M5kG6WLXtjU3AGn5EDOttoy4tfiTWwKzMvpU
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
Subject: [LTP] [PATCH v2 3/7] Refactor input03 test
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
 testcases/kernel/input/input03.c | 176 ++++++++++++++++-----------------------
 2 files changed, 73 insertions(+), 107 deletions(-)

diff --git a/testcases/kernel/input/Makefile b/testcases/kernel/input/Makefile
index 5bc729802d1e302d7d52d71be0b6b22a20efb852..8c302dbc8c75cf4fd42bc162b4bb8a9882237164 100644
--- a/testcases/kernel/input/Makefile
+++ b/testcases/kernel/input/Makefile
@@ -8,8 +8,8 @@ LTPLIBS = uinput
 include $(top_srcdir)/include/mk/testcases.mk
 
 FILTER_OUT_MAKE_TARGETS		:= input_helper
-input01 input02: LDLIBS += -lltpuinput
+input01 input02 input03: LDLIBS += -lltpuinput
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
 
-input03 input04 input05 input06: %: input_helper.o
+input04 input05 input06: %: input_helper.o
diff --git a/testcases/kernel/input/input03.c b/testcases/kernel/input/input03.c
index 6cd753d0b1bf98ce671dfa739cde817b4c52c547..4a3eb464ee0322b134f44158a08dbb4ed000216f 100644
--- a/testcases/kernel/input/input03.c
+++ b/testcases/kernel/input/input03.c
@@ -1,145 +1,111 @@
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
-  *  and check that the events are well received in /dev/input/mice
-  */
+/*\
+ * [Description]
+ *
+ * Verify that /dev/input/mice receive events sent from a virtual device,
+ * that in our case is a mouse. The events are a sequence of mouse right click.
+ */
 
-#include <linux/input.h>
 #include <linux/uinput.h>
 
-#include "test.h"
-#include "safe_macros.h"
-#include "lapi/fcntl.h"
-#include "input_helper.h"
+#include "input_common.h"
 
-#define NB_TEST 10
+#define NUM_EVENTS 10
 #define PS2_RIGHT_BTN 0x02
+#define MOUSE_DEV "/dev/input/mice"
 
-static void setup(void);
-static void send_events(void);
-static int check_events(void);
-static void cleanup(void);
+static int fd_send = -1;
+static int fd_recv = -1;
 
-static int fd, fd2;
-
-char *TCID = "input03";
-
-int main(int ac, char **av)
+static void recv_data(void)
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
-
-		switch (pid) {
-		case 0:
-			send_events();
-			exit(0);
-		case -1:
-			tst_brkm(TBROK | TERRNO, cleanup, "fork() failed");
-		default:
-			if (check_events())
-				tst_resm(TFAIL, "Wrong data received");
-			else
-				tst_resm(TPASS,
-					"Data received in /dev/input/mice");
-		break;
-		}
+	tst_res(TINFO, "Reading events back");
 
-		SAFE_WAITPID(NULL, pid, NULL, 0);
-	}
+	char buf[30];
+	int events = 0;
+	int pressed = 0;
+	int num_bytes = 0;
 
-	cleanup();
-	tst_exit();
-}
+	TST_CHECKPOINT_WAKE(0);
 
-static void setup(void)
-{
-	tst_require_root();
+	while (events < NUM_EVENTS) {
+		memset(buf, 0, sizeof(buf));
 
-	fd = open_uinput();
+		num_bytes = SAFE_READ(0, fd_recv, buf, sizeof(buf));
 
-	setup_mouse_events(fd);
-	SAFE_IOCTL(NULL, fd, UI_SET_EVBIT, EV_KEY);
-	SAFE_IOCTL(NULL, fd, UI_SET_KEYBIT, BTN_RIGHT);
+		for (int i = 0; i < num_bytes / 3; i++) {
+			if (buf[3*i] & PS2_RIGHT_BTN)
+				pressed = 1;
 
-	create_device(fd);
+			if (pressed == 1 && !(buf[3*i] & PS2_RIGHT_BTN)) {
+				pressed = 0;
+				events++;
+			}
+		}
+	}
 
-	fd2 = SAFE_OPEN(NULL, "/dev/input/mice", O_RDONLY);
+	TST_EXP_EQ_LI(events, NUM_EVENTS);
 }
 
-static void send_events(void)
+static void send_mouse_events(void)
 {
-	int nb;
+	tst_res(TINFO, "Sending right click");
+
+	TST_CHECKPOINT_WAIT(0);
 
-	for (nb = 0; nb < NB_TEST; ++nb) {
-		send_event(fd, EV_KEY, BTN_RIGHT, 1);
-		send_event(fd, EV_SYN, 0, 0);
+	for (int i = 0; i < NUM_EVENTS; i++) {
+		send_event(fd_send, EV_KEY, BTN_RIGHT, 1);
+		send_event(fd_send, EV_SYN, 0, 0);
 		usleep(1000);
-		send_event(fd, EV_KEY, BTN_RIGHT, 0);
-		send_event(fd, EV_SYN, 0, 0);
+
+		send_event(fd_send, EV_KEY, BTN_RIGHT, 0);
+		send_event(fd_send, EV_SYN, 0, 0);
 		usleep(1000);
 	}
 }
 
-static int check_events(void)
+static void run(void)
 {
-	int nb, rd, i, pressed = 0;
-	char buf[30];
-
-	nb = 0;
-
-	while (nb < NB_TEST) {
-		rd = read(fd2, buf, sizeof(buf));
+	if (!SAFE_FORK()) {
+		send_mouse_events();
+		exit(0);
+	}
 
-		if (rd < 0)
-			tst_brkm(TBROK | TERRNO, NULL, "read() failed");
+	recv_data();
+}
 
-		if (rd % 3) {
-			tst_resm(TINFO, "read() returned %i", rd);
-			return 1;
-		}
+static void setup(void)
+{
+	fd_send = open_uinput();
 
-		for (i = 0; i < rd / 3; i++) {
-			if (buf[3*i] & PS2_RIGHT_BTN)
-				pressed = 1;
+	setup_mouse_events(fd_send);
+	SAFE_IOCTL(fd_send, UI_SET_EVBIT, EV_KEY);
+	SAFE_IOCTL(fd_send, UI_SET_KEYBIT, BTN_RIGHT);
 
-			if (pressed == 1 && !(buf[3*i] & PS2_RIGHT_BTN)) {
-				pressed = 0;
-				nb++;
-			}
-		}
-	}
+	create_input_device(fd_send);
 
-	return nb != NB_TEST;
+	fd_recv = SAFE_OPEN(MOUSE_DEV, O_RDONLY);
 }
 
 static void cleanup(void)
 {
-	if (fd2 > 0 && close(fd2))
-		tst_resm(TWARN, "close(fd2) failed");
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
+	.forks_child = 1,
+	.needs_root = 1,
+	.needs_checkpoints = 1,
+};

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
