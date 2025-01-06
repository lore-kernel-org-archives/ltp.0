Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7026EE77188
	for <ltp@archiver.kernel.org>; Mon,  6 Jan 2025 10:32:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D1FDF3C3079
	for <ltp@archiver.kernel.org>; Mon,  6 Jan 2025 11:32:55 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C5E743C305A
 for <ltp@lists.linux.it>; Mon,  6 Jan 2025 11:31:27 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 10AF622548A
 for <ltp@lists.linux.it>; Mon,  6 Jan 2025 11:31:26 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0A4B41F387;
 Mon,  6 Jan 2025 10:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736159486; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z2sGQzB4aAHP4rFwaAfswz5jHpIhJ4lA+uq3HicNbQc=;
 b=n6VW5knDpMrAotg8QiEBUHi/1lxY6BtEZ/urk3ZVSPz9vpK3CefwPJpFxUdfjGhdHEB9Wk
 yOkwtGu8JB1AOP8U/iCuMm/6ffE1o2wVzRsoR6YN9qo7d/RrJMIy1E8K/UYQlUBHsXV5Ri
 mhUEJ9MzKfLbvVMP6MdKj067Pr2oGKc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736159486;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z2sGQzB4aAHP4rFwaAfswz5jHpIhJ4lA+uq3HicNbQc=;
 b=eQRlTb8qzBYrrzLDYtYkF29pFXixVGvdBNxSEfPDhrfwr3u7uP8b4BgKcJ1o7pPRPRIMm2
 rIXK7pOqm5d+1zCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736159486; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z2sGQzB4aAHP4rFwaAfswz5jHpIhJ4lA+uq3HicNbQc=;
 b=n6VW5knDpMrAotg8QiEBUHi/1lxY6BtEZ/urk3ZVSPz9vpK3CefwPJpFxUdfjGhdHEB9Wk
 yOkwtGu8JB1AOP8U/iCuMm/6ffE1o2wVzRsoR6YN9qo7d/RrJMIy1E8K/UYQlUBHsXV5Ri
 mhUEJ9MzKfLbvVMP6MdKj067Pr2oGKc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736159486;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z2sGQzB4aAHP4rFwaAfswz5jHpIhJ4lA+uq3HicNbQc=;
 b=eQRlTb8qzBYrrzLDYtYkF29pFXixVGvdBNxSEfPDhrfwr3u7uP8b4BgKcJ1o7pPRPRIMm2
 rIXK7pOqm5d+1zCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E06CF13AB5;
 Mon,  6 Jan 2025 10:31:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CGwLNf2we2fGfwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 06 Jan 2025 10:31:25 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 06 Jan 2025 11:31:25 +0100
MIME-Version: 1.0
Message-Id: <20250106-fix_setsid_tests-v2-3-c43f57a2bab6@suse.com>
References: <20250106-fix_setsid_tests-v2-0-c43f57a2bab6@suse.com>
In-Reply-To: <20250106-fix_setsid_tests-v2-0-c43f57a2bab6@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736159485; l=12638;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=2332Mlf/u/kF1uvbUXICKI8k+EevNGOk/Te4VdiVTjk=;
 b=90f+3DVGyZUqoq5YPbyRU4XtsVE5gpKHlF81uGKguAgUsMkp8O6b1+UK1J5DoyB7z+j/aaNwB
 AYEdE0aujFBCqjZgMIzk8rFf6wWA9cHhenwVkzjmivS2OYzyg+ML85A
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 03/11] Refactor ptem01 test
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

Fix test failure when running inside a new session via setsid() and
start spliting its internal tests cases implementations into multiple
files.

Fixes: https://github.com/linux-test-project/kirk/issues/28
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/pty/ptem01.c | 454 ++++--------------------------------------
 1 file changed, 37 insertions(+), 417 deletions(-)

diff --git a/testcases/kernel/pty/ptem01.c b/testcases/kernel/pty/ptem01.c
index 20ef5d0a739a55262c1c32ec03e57885dfe09787..0a6844cc68c2c5b57496f81e8c2609a687159956 100644
--- a/testcases/kernel/pty/ptem01.c
+++ b/testcases/kernel/pty/ptem01.c
@@ -1,441 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- *   Copyright (c) International Business Machines  Corp., 2002
- *   Copyright (c) 2020 Petr Vorel <pvorel@suse.cz>
- *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * Copyright (c) International Business Machines  Corp., 2002
+ * Copyright (c) 2020 Petr Vorel <pvorel@suse.cz>
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
  */
 
-/* 12/23/2002   Port to LTP     robbiew@us.ibm.com */
-/* 06/30/2001   Port to Linux   nsharoff@us.ibm.com */
+/*\
+ * [Description]
+ *
+ * Verify that it's possible to open a pseudo-terminal via /dev/ptmx, obtain a
+ * slave device and configure termos/termios ioctls.
+ */
 
 #define _GNU_SOURCE
-#include <errno.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <stdio.h>
-#include <termios.h>
-#include <fcntl.h>
-#include <sys/stat.h>
-#include <sys/poll.h>
-#include <sys/types.h>
-
-#include "test.h"
-#include "safe_macros.h"
-#include "lapi/ioctl.h"
 
-char *TCID = "ptem01";		/* Test program identifier.    */
-int TST_TOTAL = 6;		/* Total number of test cases. */
-/**************/
+#include <termio.h>
+#include <termios.h>
+#include "tst_test.h"
 
-/*
- * pty master clone device
- */
 #define MASTERCLONE "/dev/ptmx"
 
-#define BUFSZ 4096
-
-/*
- * test termio/termios ioctls
- */
-int test1(void)
+static void run(void)
 {
 	int masterfd, slavefd;
 	char *slavename;
 	struct termio termio;
 	struct termios termios;
 
-	masterfd = SAFE_OPEN(NULL, MASTERCLONE, O_RDWR);
-
-	slavename = ptsname(masterfd);
-	if (slavename == NULL) {
-		tst_brkm(TBROK | TERRNO, NULL, "ptsname() call failed");
-	}
-
-	if (grantpt(masterfd) != 0) {
-		tst_brkm(TBROK | TERRNO, NULL, "grantpt() call failed");
-	}
-
-	if (unlockpt(masterfd) != 0) {
-		tst_brkm(TBROK, NULL, "unlockpt() call failed");
-	}
-
-	if ((slavefd = open(slavename, O_RDWR)) < 0) {
-		tst_brkm(TFAIL, NULL, "Could not open %s", slavename);
-	}
-
-	if (ioctl(slavefd, TCGETS, &termios) != 0) {
-		tst_brkm(TFAIL, NULL, "TCGETS");
-	}
-
-	if (ioctl(slavefd, TCSETS, &termios) != 0) {
-		tst_brkm(TFAIL, NULL, "TCSETS");
-	}
-
-	if (ioctl(slavefd, TCSETSW, &termios) != 0) {
-		tst_brkm(TFAIL, NULL, "TCSETSW");
-	}
-
-	if (ioctl(slavefd, TCSETSF, &termios) != 0) {
-		tst_brkm(TFAIL, NULL, "TCSETSF");
-	}
-
-	if (ioctl(slavefd, TCSETS, &termios) != 0) {
-		tst_brkm(TFAIL, NULL, "TCSETS");
-	}
-
-	if (ioctl(slavefd, TCGETA, &termio) != 0) {
-		tst_brkm(TFAIL, NULL, "TCGETA");
-	}
-
-	if (ioctl(slavefd, TCSETA, &termio) != 0) {
-		tst_brkm(TFAIL, NULL, "TCSETA");
-	}
-
-	if (ioctl(slavefd, TCSETAW, &termio) != 0) {
-		tst_brkm(TFAIL, NULL, "TCSETAW");
-	}
-
-	if (ioctl(slavefd, TCSETAF, &termio) != 0) {
-		tst_brkm(TFAIL, NULL, "TCSETAF");
-	}
-
-	if (close(slavefd) != 0) {
-		tst_brkm(TBROK, NULL, "close slave");
-	}
-
-	if (close(masterfd) != 0) {
-		tst_brkm(TBROK, NULL, "close master");
-	}
-	tst_resm(TPASS, "test1");
-
-	/** NOT REACHED **/
-	return 0;
-}
-
-/*
- * test window size setting and getting
- */
-int test2(void)
-{
-	int masterfd, slavefd;
-	char *slavename;
-	struct winsize wsz;
-	struct winsize wsz1 = { 24, 80, 5, 10 };
-	struct winsize wsz2 = { 60, 100, 11, 777 };
-
-	masterfd = SAFE_OPEN(NULL, MASTERCLONE, O_RDWR);
-
-	slavename = ptsname(masterfd);
-	if (slavename == NULL) {
-		tst_brkm(TBROK | TERRNO, NULL, "ptsname() call failed");
-	}
-
-	if (grantpt(masterfd) != 0) {
-		tst_brkm(TBROK | TERRNO, NULL, "grantpt() call failed");
-	}
-
-	if (unlockpt(masterfd) != 0) {
-		tst_brkm(TBROK, NULL, "unlockpt() call failed");
-	}
-
-	if ((slavefd = open(slavename, O_RDWR)) < 0) {
-		tst_brkm(TBROK, NULL, "Could not open %s", slavename);
-	}
-
-	if (ioctl(masterfd, TIOCSWINSZ, &wsz1) != 0) {
-		tst_brkm(TFAIL, NULL, "TIOCSWINSZ");
-	}
-
-	if (ioctl(slavefd, TIOCGWINSZ, &wsz) != 0) {
-		tst_brkm(TFAIL, NULL, "TIOCGWINSZ");
-	}
-
-	if (wsz.ws_row != wsz1.ws_row || wsz.ws_col != wsz1.ws_col ||
-	    wsz.ws_xpixel != wsz1.ws_xpixel ||
-	    wsz.ws_ypixel != wsz1.ws_ypixel) {
-		tst_brkm(TFAIL, NULL, "unexpected window size returned");
-	}
-
-	if (ioctl(masterfd, TIOCGWINSZ, &wsz) != 0) {
-		tst_brkm(TFAIL, NULL, "TIOCGWINSZ");
-	}
-
-	if (wsz.ws_row != wsz1.ws_row || wsz.ws_col != wsz1.ws_col ||
-	    wsz.ws_xpixel != wsz1.ws_xpixel ||
-	    wsz.ws_ypixel != wsz1.ws_ypixel) {
-		tst_brkm(TFAIL, NULL, "unexpected window size returned");
-	}
-
-	if (ioctl(slavefd, TIOCSWINSZ, &wsz2) != 0) {
-		tst_brkm(TFAIL, NULL, "TIOCSWINSZ");
-	}
-
-	if (ioctl(slavefd, TIOCGWINSZ, &wsz) != 0) {
-		tst_brkm(TFAIL, NULL, "TIOCGWINSZ");
-	}
-
-	if (wsz.ws_row != wsz2.ws_row || wsz.ws_col != wsz2.ws_col ||
-	    wsz.ws_xpixel != wsz2.ws_xpixel ||
-	    wsz.ws_ypixel != wsz2.ws_ypixel) {
-		tst_brkm(TFAIL, NULL, "unexpected window size returned");
-	}
-
-	if (close(slavefd) != 0) {
-		tst_brkm(TBROK, NULL, "close");
-	}
-
-	if (close(masterfd) != 0) {
-		tst_brkm(TBROK, NULL, "close");
-	}
-	tst_resm(TPASS, "test2");
-
-	/** NOT REACHED **/
-	return 0;
-}
-
-/*
- * test sending a break
- */
-int test3(void)
-{
-	int masterfd, slavefd;
-	char *slavename;
-
-	masterfd = SAFE_OPEN(NULL, MASTERCLONE, O_RDWR);
-
-	slavename = ptsname(masterfd);
-	if (slavename == NULL) {
-		tst_brkm(TBROK | TERRNO, NULL, "ptsname() call failed");
-	}
-
-	if (grantpt(masterfd) != 0) {
-		tst_brkm(TBROK | TERRNO, NULL, "grantpt() call failed");
-	}
-
-	if (unlockpt(masterfd) != 0) {
-		tst_brkm(TBROK, NULL, "unlockpt() call failed");
-	}
-
-	if ((slavefd = open(slavename, O_RDWR)) < 0) {
-		tst_brkm(TBROK, NULL, "Could not open %s", slavename);
-	}
-
-	if (tcsendbreak(masterfd, 10) != 0) {
-		tst_brkm(TFAIL, NULL, "tcsendbreak");
-	}
-
-	if (tcsendbreak(slavefd, 10) != 0) {
-		tst_brkm(TFAIL, NULL, "tcsendbreak");
-	}
-
-	if (close(slavefd) != 0) {
-		tst_brkm(TBROK, NULL, "close slave");
-	}
-
-	if (close(masterfd) != 0) {
-		tst_brkm(TBROK, NULL, "close master");
-	}
-	tst_resm(TPASS, "test3");
-
-	/** NOT REACHED **/
-	return 0;
-}
-
-/*
- * test multiple opens of slave side
- */
-int test4(void)
-{
-	int masterfd, slavefd, slavefd2, slavefd3;
-	char *slavename;
-
-	masterfd = SAFE_OPEN(NULL, MASTERCLONE, O_RDWR);
-
-	slavename = ptsname(masterfd);
-	if (slavename == NULL) {
-		tst_brkm(TBROK | TERRNO, NULL, "ptsname() call failed");
-	}
-
-	if (grantpt(masterfd) != 0) {
-		tst_brkm(TBROK | TERRNO, NULL, "grantpt() call failed");
-	}
-
-	if (unlockpt(masterfd) != 0) {
-		tst_brkm(TBROK, NULL, "unlockpt() call failed");
-	}
-
-	if ((slavefd = open(slavename, O_RDWR)) < 0) {
-		tst_brkm(TBROK, NULL, "Could not open %s", slavename);
-	}
-
-	if ((slavefd2 = open(slavename, O_RDWR)) < 0) {
-		tst_brkm(TFAIL, NULL, "Could not open %s (again)", slavename);
-	}
-
-	if ((slavefd3 = open(slavename, O_RDWR)) < 0) {
-		tst_brkm(TFAIL, NULL, "Could not open %s (once more)",
-			 slavename);
-	}
-
-	if (close(slavefd) != 0) {
-		tst_brkm(TBROK, NULL, "close slave");
-	}
-	if (close(slavefd2) != 0) {
-		tst_brkm(TBROK, NULL, "close slave again");
-	}
-	if (close(slavefd3) != 0) {
-		tst_brkm(TBROK, NULL, "close slave once more");
-	}
-	if (close(masterfd) != 0) {
-		tst_brkm(TBROK, NULL, "close master");
-	}
-	tst_resm(TPASS, "test4");
-
-	/** NOT REACHED **/
-	return 0;
-}
-
-#define NUMOPENS 6
-
-/*
- * test several simultaneous opens
- */
-int test5(void)
-{
-	static int masterfd[NUMOPENS];
-	static int slavefd[NUMOPENS];
-	char *slavename;
-	int i;
+	masterfd = SAFE_OPEN(MASTERCLONE, O_RDWR);
+	slavename = SAFE_PTSNAME(masterfd);
 
-	for (i = 0; i < NUMOPENS; ++i) {
-		masterfd[i] = open(MASTERCLONE, O_RDWR);
-		if (masterfd[i] < 0) {
-			tst_resm(TBROK, "%s", MASTERCLONE);
-			tst_resm(TBROK, "out of ptys");
-			for (i = 0; i < NUMOPENS; ++i) {
-				if (masterfd[i] != 0) {
-					(void)close(masterfd[i]);
-				}
-				if (slavefd[i] != 0) {
-					(void)close(slavefd[i]);
-				}
-			}
-			tst_exit();
-		}
+	TST_EXP_PASS(grantpt(masterfd));
+	TST_EXP_PASS(unlockpt(masterfd));
 
-		slavename = ptsname(masterfd[i]);
-		if (slavename == NULL) {
-			tst_brkm(TBROK | TERRNO, NULL,
-				 "ptsname() call failed");
-		}
+	slavefd = SAFE_OPEN(slavename, O_RDWR);
 
-		if (grantpt(masterfd[i]) != 0) {
-			tst_brkm(TBROK | TERRNO, NULL,
-				 "grantpt() call failed");
-		}
+	TST_EXP_POSITIVE(ioctl(slavefd, TCGETS, &termios));
+	TST_EXP_POSITIVE(ioctl(slavefd, TCSETS, &termios));
+	TST_EXP_POSITIVE(ioctl(slavefd, TCSETSW, &termios));
+	TST_EXP_POSITIVE(ioctl(slavefd, TCSETSF, &termios));
+	TST_EXP_POSITIVE(ioctl(slavefd, TCSETS, &termios));
+	TST_EXP_POSITIVE(ioctl(slavefd, TCGETA, &termio));
+	TST_EXP_POSITIVE(ioctl(slavefd, TCSETA, &termio));
+	TST_EXP_POSITIVE(ioctl(slavefd, TCSETAW, &termio));
+	TST_EXP_POSITIVE(ioctl(slavefd, TCSETAF, &termio));
 
-		if (unlockpt(masterfd[i]) != 0) {
-			tst_brkm(TBROK, NULL, "unlockpt() call failed");
-		}
-
-		if ((slavefd[i] = open(slavename, O_RDWR)) < 0) {
-			tst_brkm(TFAIL, NULL,
-				 "Iteration %d: Could not open %s", i,
-				 slavename);
-		}
-
-	}
-
-	for (i = 0; i < NUMOPENS; ++i) {
-		if (close(slavefd[i]) != 0) {
-			tst_brkm(TBROK, NULL, "Iteration %d: close slave", i);
-		}
-		if (close(masterfd[i]) != 0) {
-			tst_brkm(TBROK, NULL, "close master");
-		}
-	}
-	tst_resm(TPASS, "test5");
-
-	/** NOT REACHED **/
-	return 0;
+	SAFE_CLOSE(slavefd);
+	SAFE_CLOSE(masterfd);
 }
 
-/*
- * test hangup semantics
- */
-int test6(void)
+static void setup(void)
 {
-	static int masterfd;
-	static int slavefd;
-	char *slavename;
-	struct termios termios;
-
-	masterfd = SAFE_OPEN(NULL, MASTERCLONE, O_RDWR);
-
-	slavename = ptsname(masterfd);
-	if (slavename == NULL) {
-		tst_brkm(TBROK | TERRNO, NULL, "ptsname() call failed");
-	}
-
-	if (grantpt(masterfd) != 0) {
-		tst_brkm(TBROK | TERRNO, NULL, "grantpt() call failed");
-	}
-
-	if (unlockpt(masterfd) != 0) {
-		tst_brkm(TBROK, NULL, "unlockpt() call failed");
-	}
-
-	if ((slavefd = open(slavename, O_RDWR)) < 0) {
-		tst_brkm(TBROK, NULL, "Could not open %s", slavename);
-	}
-
-	if (ioctl(slavefd, TCGETS, &termios) != 0) {
-		tst_brkm(TFAIL, NULL, "TCGETS");
-	}
-
-	termios.c_cflag &= ~CBAUD;
-	termios.c_cflag |= B0 & CBAUD;
-	if (ioctl(slavefd, TCSETS, &termios) != 0) {
-		tst_brkm(TFAIL, NULL, "TCGETS");
-	}
-
-	if (close(slavefd) != 0) {
-		tst_brkm(TBROK, NULL, "close");
-	}
-	if (close(masterfd) != 0) {
-		tst_brkm(TBROK, NULL, "close");
-	}
-	tst_resm(TPASS, "test6");
-
-	/** NOT REACHED **/
-	return 0;
+	if (access(MASTERCLONE, F_OK))
+		tst_brk(TBROK, "%s device doesn't exist", MASTERCLONE);
 }
 
-/*
- * main test driver
- */
-int main(void)
-{
-	test1();
-	test2();
-	test3();
-	test4();
-	test5();
-	test6();
-	/*
-	 * all done
-	 */
-	tst_exit();
-}
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+};

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
