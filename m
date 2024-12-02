Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D6ACD78301
	for <ltp@archiver.kernel.org>; Mon,  2 Dec 2024 10:14:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 28FAF3C7134
	for <ltp@archiver.kernel.org>; Mon,  2 Dec 2024 11:14:50 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ACC323DD246
 for <ltp@lists.linux.it>; Mon,  2 Dec 2024 11:12:52 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 843BC66EB2A
 for <ltp@lists.linux.it>; Mon,  2 Dec 2024 11:12:51 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D58E4211AD;
 Mon,  2 Dec 2024 10:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733134370; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ROv/MiFMrRgeqbdxb3f4BBkEwCDdiJwxAYerya1Bla0=;
 b=iQs/ImHYV+g1rpim8dNOCvFoYMjqHXVOqO9KmTIi8mMnHOs+Ny39bWR0rqqptHBaCqVWHD
 tH9E/gq8BzXZxqCIGL3oUaBcQPHWCQJj8vSs/VWS+rrRSfzGRbM/at+3qWIN1/411MudC8
 o2R2i+kSY0pfDVQnmSSGFv2PV7M26a0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733134370;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ROv/MiFMrRgeqbdxb3f4BBkEwCDdiJwxAYerya1Bla0=;
 b=UjbdbSKmnqueLRAJNtvNfow/TQ8i3vBjP2knCy5AoXsD7lI6oB/BlNb3rMSh0TQqeeB2Q5
 o6pZQJ0M+CuunPDA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="iQs/ImHY";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=UjbdbSKm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733134370; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ROv/MiFMrRgeqbdxb3f4BBkEwCDdiJwxAYerya1Bla0=;
 b=iQs/ImHYV+g1rpim8dNOCvFoYMjqHXVOqO9KmTIi8mMnHOs+Ny39bWR0rqqptHBaCqVWHD
 tH9E/gq8BzXZxqCIGL3oUaBcQPHWCQJj8vSs/VWS+rrRSfzGRbM/at+3qWIN1/411MudC8
 o2R2i+kSY0pfDVQnmSSGFv2PV7M26a0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733134370;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ROv/MiFMrRgeqbdxb3f4BBkEwCDdiJwxAYerya1Bla0=;
 b=UjbdbSKmnqueLRAJNtvNfow/TQ8i3vBjP2knCy5AoXsD7lI6oB/BlNb3rMSh0TQqeeB2Q5
 o6pZQJ0M+CuunPDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B5A7A13A43;
 Mon,  2 Dec 2024 10:12:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wDKXKiKITWcNSwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 02 Dec 2024 10:12:50 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 02 Dec 2024 11:12:46 +0100
MIME-Version: 1.0
Message-Id: <20241202-input_refactoring-v2-2-369609492896@suse.com>
References: <20241202-input_refactoring-v2-0-369609492896@suse.com>
In-Reply-To: <20241202-input_refactoring-v2-0-369609492896@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733134370; l=5026;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=C2qgRUpBGrsd4txdQ9E7FRSn9QynmjyxofhGXRlTc78=;
 b=qi0NvMH7soQuBbQvMgC8ydr8zpJkh9yBVp0S26U9OIFOAq4J3dcNkqWcoQANRLpBzCpM7PC2r
 FLkd6mP2K4TDeDfuXBt4tgDPGwHqxBzZ1/U6UyZDtU0itmqREKIakQb
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: D58E4211AD
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.com:mid];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Subject: [LTP] [PATCH v2 2/7] Refactor input02 test
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
 testcases/kernel/input/input02.c | 132 +++++++++++++++------------------------
 2 files changed, 54 insertions(+), 82 deletions(-)

diff --git a/testcases/kernel/input/Makefile b/testcases/kernel/input/Makefile
index e686005c69da8b83d954da754b2e5db93ae89da7..5bc729802d1e302d7d52d71be0b6b22a20efb852 100644
--- a/testcases/kernel/input/Makefile
+++ b/testcases/kernel/input/Makefile
@@ -8,8 +8,8 @@ LTPLIBS = uinput
 include $(top_srcdir)/include/mk/testcases.mk
 
 FILTER_OUT_MAKE_TARGETS		:= input_helper
-input01: LDLIBS += -lltpuinput
+input01 input02: LDLIBS += -lltpuinput
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
 
-input02 input03 input04 input05 input06: %: input_helper.o
+input03 input04 input05 input06: %: input_helper.o
diff --git a/testcases/kernel/input/input02.c b/testcases/kernel/input/input02.c
index 6964ed70320a585a755e926e066f5e24fc7a9a30..eeff54ed21cbff6eac2d90dc53c6447d379e29ed 100644
--- a/testcases/kernel/input/input02.c
+++ b/testcases/kernel/input/input02.c
@@ -1,106 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2015 Cedric Hnyda <chnyda@suse.com>
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
  *
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
+ * Verify that /dev/input/eventX won't receive any event sent from a virtual
+ * device, that in our case is a mouse, when the event device has been grabbed
+ * by an another process.
  */
 
- /*
-  *  Create a virtual device (mouse), send events to /dev/uinput
-  *  and check that the events are not received in /dev/input/eventX
-  *  because the device is grabbed by another process
-  */
+#include "input_common.h"
 
-#include <linux/input.h>
+#define MOVE_X 10
+#define MOVE_Y 1
 
-#include "test.h"
-#include "safe_macros.h"
-#include "lapi/fcntl.h"
-#include "input_helper.h"
+static int fd_send = -1;
+static int fd_recv = -1;
 
-#define NB_TEST 20
+static void send_events(void)
+{
+	int fd;
 
-static void setup(void);
-static void send_information(void);
-static void cleanup(void);
+	fd = open_event_device();
 
-static int fd;
-static int fd2;
+	SAFE_IOCTL(fd, EVIOCGRAB, 1);
+	tst_res(TINFO, "The virtual device was grabbed");
 
-char *TCID = "input02";
+	send_relative_move(fd_send, MOVE_X, MOVE_Y);
 
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
-		fd2 = open_device();
-
-		switch (pid) {
-		case 0:
-			send_information();
-			exit(0);
-		case -1:
-			tst_brkm(TBROK | TERRNO, cleanup, "fork() failed");
-		default:
-			if (no_events_queued(fd2, 0))
-				tst_resm(TPASS, "No data received in eventX");
-			else
-				tst_resm(TFAIL, "Data received in eventX");
-			SAFE_CLOSE(NULL, fd2);
-		break;
-		}
-
-		SAFE_WAITPID(NULL, pid, NULL, 0);
-	}
+	TST_CHECKPOINT_WAKE_AND_WAIT(0);
 
-	cleanup();
-	tst_exit();
+	SAFE_CLOSE(fd);
 }
 
-static void setup(void)
+static void run(void)
 {
-	tst_require_root();
+	if (!SAFE_FORK()) {
+		send_events();
+		exit(0);
+	}
 
-	fd = open_uinput();
-	setup_mouse_events(fd);
-	create_device(fd);
-}
+	TST_CHECKPOINT_WAIT(0);
 
-static void send_information(void)
-{
-	int nb;
+	verify_no_events_queued(fd_recv);
 
-	SAFE_IOCTL(NULL, fd2, EVIOCGRAB, 1);
-	tst_resm(TINFO, "The virtual device was grabbed");
+	TST_CHECKPOINT_WAKE(0);
+}
 
-	for (nb = 0; nb < NB_TEST; ++nb) {
-		send_rel_move(fd, 10, 1);
-		usleep(1000);
-	}
+static void setup(void)
+{
+	fd_send = open_uinput();
+	setup_mouse_events(fd_send);
+	create_input_device(fd_send);
 
-	SAFE_CLOSE(NULL, fd2);
+	fd_recv = open_event_device();
 }
 
 static void cleanup(void)
 {
-	destroy_device(fd);
+	if (fd_send != -1)
+		destroy_input_device(fd_send);
+
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
