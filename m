Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DE43D73612
	for <ltp@archiver.kernel.org>; Mon,  2 Dec 2024 10:13:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 541643DD287
	for <ltp@archiver.kernel.org>; Mon,  2 Dec 2024 11:13:25 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 33E093DD246
 for <ltp@lists.linux.it>; Mon,  2 Dec 2024 11:12:52 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A1A1B203C56
 for <ltp@lists.linux.it>; Mon,  2 Dec 2024 11:12:51 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AF80B211B8;
 Mon,  2 Dec 2024 10:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733134370; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8mHzBlVx7wYmaYU2aQ47NripNNtxxJKYdN1gSuJZqqg=;
 b=AuQ2DuImtHUM6T0pNTygFrzp6WvUZ065IoAV4N9NEh+MRVuaHn3oFA3v5Z1RMISETwrvYf
 8j6RnYq6e3eGACpqxZPDCg+UQJSGp2G2ihnewt2zf/aqWsSyZeWa6CyNhcncSs7dYJmUeg
 ynFEtD5I0hV5CLQFy2afPixlNOxi7eM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733134370;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8mHzBlVx7wYmaYU2aQ47NripNNtxxJKYdN1gSuJZqqg=;
 b=Re6u5r5yMhuQGuY+bXnF5l7rsbRkz0mubN0q7klffmtUPBHqkWkOt8yYmsBFQ4AiTV9TTg
 oTxdEVYdm36XqkAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733134370; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8mHzBlVx7wYmaYU2aQ47NripNNtxxJKYdN1gSuJZqqg=;
 b=AuQ2DuImtHUM6T0pNTygFrzp6WvUZ065IoAV4N9NEh+MRVuaHn3oFA3v5Z1RMISETwrvYf
 8j6RnYq6e3eGACpqxZPDCg+UQJSGp2G2ihnewt2zf/aqWsSyZeWa6CyNhcncSs7dYJmUeg
 ynFEtD5I0hV5CLQFy2afPixlNOxi7eM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733134370;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8mHzBlVx7wYmaYU2aQ47NripNNtxxJKYdN1gSuJZqqg=;
 b=Re6u5r5yMhuQGuY+bXnF5l7rsbRkz0mubN0q7klffmtUPBHqkWkOt8yYmsBFQ4AiTV9TTg
 oTxdEVYdm36XqkAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 90AC013A40;
 Mon,  2 Dec 2024 10:12:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UH5+ISKITWcNSwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 02 Dec 2024 10:12:50 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 02 Dec 2024 11:12:45 +0100
MIME-Version: 1.0
Message-Id: <20241202-input_refactoring-v2-1-369609492896@suse.com>
References: <20241202-input_refactoring-v2-0-369609492896@suse.com>
In-Reply-To: <20241202-input_refactoring-v2-0-369609492896@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733134370; l=10357;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=Wc1cH84xtXonixepp885728aRQFDk9JNahLsz/vvzOA=;
 b=+GXKuyVrVEMmSViiWYljbzv5w2G1M9lUPSti19N2Y5qnAmuVRc1BWAAZt3jFJtIY+5yebgRxE
 T7vJjdXUGUQCEzq1KQMHkbcW5otGyfoO2YOIlsmfQZiSC/d13LFghT0
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid, suse.com:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/7] Refactor input01 test
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
 libs/uinput/tst_uinput.c              |  26 ++++-
 testcases/kernel/input/Makefile       |   5 +-
 testcases/kernel/input/input01.c      | 205 ++++++++--------------------------
 testcases/kernel/input/input_common.h |  97 ++++++++++++++++
 4 files changed, 173 insertions(+), 160 deletions(-)

diff --git a/libs/uinput/tst_uinput.c b/libs/uinput/tst_uinput.c
index 6dc8a7d4ec41f1c53eb675c894cdcd059ee1198a..36f3d5e2759bc13c5ae989799741bbd288a2c234 100644
--- a/libs/uinput/tst_uinput.c
+++ b/libs/uinput/tst_uinput.c
@@ -13,6 +13,7 @@
 #include "tst_test.h"
 
 #include "tst_uinput.h"
+#include "tst_safe_stdio.h"
 
 #define VIRTUAL_DEVICE "virtual-device-ltp"
 
@@ -127,6 +128,27 @@ void destroy_input_device(int fd)
 	SAFE_CLOSE(fd);
 }
 
+static void check_ui_get_sysname_ioctl(int fd)
+{
+	char sys_name[256];
+	char dev_name[256];
+	char *path;
+
+	SAFE_IOCTL(fd, UI_GET_SYSNAME(sizeof(sys_name)), sys_name, NULL);
+	SAFE_ASPRINTF(&path, "/sys/devices/virtual/input/%s/name", sys_name);
+
+	if (FILE_SCANF(path, "%s", dev_name)) {
+		tst_brk(TBROK|TERRNO, "Failed to read '%s'", path);
+		free(path);
+		return;
+	}
+
+	if (strcmp(VIRTUAL_DEVICE, dev_name))
+		tst_brk(TBROK, "ioctl UI_GET_SYSNAME returned wrong name");
+
+	free(path);
+}
+
 void create_input_device(int fd)
 {
 	int nb;
@@ -144,8 +166,10 @@ void create_input_device(int fd)
 	SAFE_IOCTL(fd, UI_DEV_CREATE, NULL);
 
 	for (nb = 100; nb > 0; nb--) {
-		if (check_device())
+		if (check_device()) {
+			check_ui_get_sysname_ioctl(fd);
 			return;
+		}
 		usleep(10000);
 	}
 
diff --git a/testcases/kernel/input/Makefile b/testcases/kernel/input/Makefile
index 032254444e1a1e5d53e3299dfe5d7e4cba6a5162..e686005c69da8b83d954da754b2e5db93ae89da7 100644
--- a/testcases/kernel/input/Makefile
+++ b/testcases/kernel/input/Makefile
@@ -3,10 +3,13 @@
 
 top_srcdir			?= ../../..
 
+LTPLIBS = uinput
+
 include $(top_srcdir)/include/mk/testcases.mk
 
 FILTER_OUT_MAKE_TARGETS		:= input_helper
+input01: LDLIBS += -lltpuinput
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
 
-$(MAKE_TARGETS): %: input_helper.o
+input02 input03 input04 input05 input06: %: input_helper.o
diff --git a/testcases/kernel/input/input01.c b/testcases/kernel/input/input01.c
index 95db3f43f37f361db2691beb0d077626e81b6368..0872204111b81fd19a1525ef7f099e8ddead9658 100644
--- a/testcases/kernel/input/input01.c
+++ b/testcases/kernel/input/input01.c
@@ -1,187 +1,76 @@
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
-  *  and check that the events are well received in /dev/input/eventX
-  */
-
-#include <linux/input.h>
-
-#include "input_helper.h"
-#include "test.h"
-#include "safe_macros.h"
-#include "lapi/fcntl.h"
-
-#define NB_TEST 20
+/*\
+ * [Description]
+ *
+ * Verify that /dev/input/eventX receive events sent from a virtual device,
+ * that in our case is a mouse.
+ */
 
-static void setup(void);
-static void send_events(void);
-static int verify_data(struct input_event *iev, int nb);
-static int check_events(void);
-static void cleanup(void);
+#include "input_common.h"
 
-static int fd;
-static int fd2;
+#define NUM_EVENTS 20
+#define MOVE_X 10
+#define MOVE_Y 1
 
-char *TCID = "input01";
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
-
-		switch (pid) {
-		case 0:
-			send_events();
-			exit(0);
-		case -1:
-			tst_brkm(TBROK | TERRNO, cleanup, "fork() failed");
-		default:
-			if (check_events())
-				tst_resm(TFAIL, "Wrong data read from eventX");
-			else
-				tst_resm(TPASS, "Data received from eventX");
-		break;
-		}
-
-		SAFE_WAITPID(NULL, pid, NULL, 0);
-	}
+	struct input_event iev[3];
 
-	cleanup();
-	tst_exit();
-}
+	tst_res(TINFO, "Sending relative move: (%i, %i)", MOVE_X, MOVE_Y);
 
-static void setup(void)
-{
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
-
-	for (nb = 0; nb < NB_TEST; ++nb) {
-		send_rel_move(fd, 10, 1);
+	for (int i = 0; i < NUM_EVENTS; i++) {
+		send_relative_move(fd_send, MOVE_X, MOVE_Y);
 		usleep(1000);
 	}
-}
 
-static int check_events(void)
-{
-	int nb, rd;
-	unsigned int i;
-	struct input_event iev[64];
-
-	nb = 0;
+	tst_res(TINFO, "Reading events back");
 
-	while (nb < NB_TEST * 3) {
-		rd = read(fd2, iev, sizeof(iev));
+	for (int i = 0; i < NUM_EVENTS; i++) {
+		SAFE_READ(0, fd_recv, iev, 3 * sizeof(struct input_event));
 
-		if (rd < 0)
-			tst_brkm(TBROK | TERRNO, cleanup, "read()");
+		TST_EXP_EQ_LI(iev[0].type, EV_REL);
+		TST_EXP_EQ_LI(iev[0].code, REL_X);
+		TST_EXP_EQ_LI(iev[0].value, MOVE_X);
 
-		if (rd == 0 || rd % sizeof(struct input_event)) {
-			tst_resm(TINFO, "read() returned unexpected %i", rd);
-			return 1;
-		}
+		TST_EXP_EQ_LI(iev[1].type, EV_REL);
+		TST_EXP_EQ_LI(iev[1].code, REL_Y);
+		TST_EXP_EQ_LI(iev[1].value, MOVE_Y);
 
-		for (i = 0; i < rd / sizeof(struct input_event); i++) {
-			if (verify_data(&iev[i], nb++))
-				return 1;
-		}
+		TST_EXP_EQ_LI(iev[2].type, EV_SYN);
+		TST_EXP_EQ_LI(iev[2].code, 0);
+		TST_EXP_EQ_LI(iev[2].value, 0);
 	}
-
-	return 0;
 }
 
-static int verify_data(struct input_event *iev, int nb)
+static void setup(void)
 {
-	if (nb % 3 == 0) {
-		if (iev->type != EV_REL) {
-			tst_resm(TINFO,
-			         "%i: Unexpected event type %i expected %i",
-			         nb, iev->type, EV_REL);
-			return 1;
-		}
-
-		if (iev->code != REL_X)
-			return 1;
-
-		if (iev->value != 10)
-			return 1;
-
-		return 0;
-	}
-
-	if (nb % 3 == 1) {
-		if (iev->type != EV_REL) {
-			tst_resm(TINFO,
-			         "%i: Unexpected event type %i expected %i",
-			         nb, iev->type, EV_REL);
-			return 1;
-		}
+	fd_send = open_uinput();
+	setup_mouse_events(fd_send);
+	create_input_device(fd_send);
 
-		if (iev->code != REL_Y)
-			return 1;
-
-		if (iev->value != 1)
-			return 1;
-
-		return 0;
-	}
-
-	if (nb % 3 == 2) {
-		if (iev->type != EV_SYN) {
-			tst_resm(TINFO,
-			         "%i: Unexpected event type %i expected %i",
-			         nb, iev->type, EV_SYN);
-			return 1;
-		}
-
-		if (iev->code != 0)
-			return 1;
-
-		if (iev->value != 0)
-			return 1;
-
-		return 0;
-	}
-	return 1;
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
diff --git a/testcases/kernel/input/input_common.h b/testcases/kernel/input/input_common.h
new file mode 100644
index 0000000000000000000000000000000000000000..0ac1624b3042f0bd14f063db76189dfc18d84674
--- /dev/null
+++ b/testcases/kernel/input/input_common.h
@@ -0,0 +1,97 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+#ifndef INPUT_COMMON_H__
+#define INPUT_COMMON_H__
+
+#include <linux/input.h>
+#include <poll.h>
+
+#include "tst_test.h"
+#include "tst_uinput.h"
+
+static inline int open_event_device(void)
+{
+	int fd;
+	char path[1024];
+	char *device;
+	char *handlers;
+
+	memset(path, 0, sizeof(path));
+
+	handlers = get_input_field_value('H');
+	device = strtok(handlers, " ");
+
+	while (device) {
+		if (strstr(device, "event") != NULL) {
+			memset(path, 0, sizeof(path));
+			snprintf(path, sizeof(path), "/dev/input/%s", device);
+
+			if (!access(path, F_OK)) {
+				tst_res(TINFO, "Found event device: %s", path);
+				break;
+			}
+		}
+
+		device = strtok(NULL, " ");
+	}
+
+	free(handlers);
+
+	if (path[0] == '\0')
+		tst_brk(TBROK, "Can't find event device");
+
+	fd = SAFE_OPEN(path, O_RDONLY);
+
+	return fd;
+}
+
+static inline void send_event(
+	const int fd, const int event,
+	const int code, const int value)
+{
+	struct input_event ev = {
+		.type = event,
+		.code = code,
+		.value = value,
+	};
+
+	SAFE_WRITE(SAFE_WRITE_ALL, fd, &ev, sizeof(ev));
+}
+
+static inline void send_relative_move(const int fd, const int x, const int y)
+{
+	send_event(fd, EV_REL, REL_X, x);
+	send_event(fd, EV_REL, REL_Y, y);
+	send_event(fd, EV_SYN, 0, 0);
+}
+
+static inline void verify_no_events_queued(const int fd_recv)
+{
+	int num_bytes;
+	int num_events;
+	struct input_event ev;
+	struct pollfd fds = {
+		.fd = fd_recv,
+		.events = POLLIN
+	};
+
+	num_events = poll(&fds, 1, 30);
+
+	TST_EXP_EQ_LI(num_events, 0);
+	if (!num_events)
+		return;
+
+	num_bytes = SAFE_READ(0, fd_recv, &ev, sizeof(ev));
+	if (!num_bytes)
+		return;
+
+	tst_res(TFAIL, "Received unexpected event: "
+		"type=%i, code=%i, value=%i",
+		ev.type,
+		ev.code,
+		ev.value);
+}
+#endif

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
