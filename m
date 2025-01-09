Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7175DE77197
	for <ltp@archiver.kernel.org>; Thu,  9 Jan 2025 14:14:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D8FF43C2677
	for <ltp@archiver.kernel.org>; Thu,  9 Jan 2025 15:14:49 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 83F703C2577
 for <ltp@lists.linux.it>; Thu,  9 Jan 2025 15:11:20 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 838D620DFC4
 for <ltp@lists.linux.it>; Thu,  9 Jan 2025 15:11:19 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1DC4021173
 for <ltp@lists.linux.it>; Thu,  9 Jan 2025 14:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736431879; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3xQ+ut4ZZbr4c1tML7I9tArOSbetiOcmz0IEl3ndniE=;
 b=WBrQii5VekC72vwz2TJQJnPRcn773+JQNKzDV9jnd8RLbtxpey6H0j2ktinz70NbN+IXvL
 gC38aEkceRdKkiah4VWOyjPdyIfMSeG/zjmPbY2eKv+0cvylkrHVNccD/GoKp/ddxM2CCG
 wGFYW/IlGIiyo+DNxiSjblw+RZwU+dU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736431879;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3xQ+ut4ZZbr4c1tML7I9tArOSbetiOcmz0IEl3ndniE=;
 b=E9bv958VC05fJDCWuL7kZThb3Xu8ht92mq4u/v0DreHPNWdUdeOsFwhETyyVqLL8cXwd8y
 qnPAo6Z0jrdqzOAg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=WBrQii5V;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=E9bv958V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736431879; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3xQ+ut4ZZbr4c1tML7I9tArOSbetiOcmz0IEl3ndniE=;
 b=WBrQii5VekC72vwz2TJQJnPRcn773+JQNKzDV9jnd8RLbtxpey6H0j2ktinz70NbN+IXvL
 gC38aEkceRdKkiah4VWOyjPdyIfMSeG/zjmPbY2eKv+0cvylkrHVNccD/GoKp/ddxM2CCG
 wGFYW/IlGIiyo+DNxiSjblw+RZwU+dU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736431879;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3xQ+ut4ZZbr4c1tML7I9tArOSbetiOcmz0IEl3ndniE=;
 b=E9bv958VC05fJDCWuL7kZThb3Xu8ht92mq4u/v0DreHPNWdUdeOsFwhETyyVqLL8cXwd8y
 qnPAo6Z0jrdqzOAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 096C113A8B
 for <ltp@lists.linux.it>; Thu,  9 Jan 2025 14:11:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id aFp5AAfZf2eVWgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Thu, 09 Jan 2025 14:11:19 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 09 Jan 2025 15:11:13 +0100
MIME-Version: 1.0
Message-Id: <20250109-fix_setsid_tests-v3-10-2ce60c904019@suse.com>
References: <20250109-fix_setsid_tests-v3-0-2ce60c904019@suse.com>
In-Reply-To: <20250109-fix_setsid_tests-v3-0-2ce60c904019@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736431876; l=11713;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=NbNCRUFkF5RxoXVwE/7C6QU5NcSfTJt+F7VjXSg+rOs=;
 b=E6/CxXRJK4oDT6yePT0mjFvAunxJDWGjXmPW0mmQjX2lgLCsdT2NWr9cPG45F3JwI7NalhEcq
 q61/QwruP4jCpre2QVgJBaHhNCPt2LYf11zbSZKLvkA6wYgSZczb3JU
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: 1DC4021173
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.com:mid];
 MIME_TRACE(0.00)[0:+];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_ONE(0.00)[1]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 10/12] Refactor pty01 test
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

Rewrite part of the code using the new LTP library and fix the execution
of the test inside a new session via setsid(). The test is now split
into multiple files, instead of having multiple test* functions
executing all in one file.

Fixes: https://github.com/linux-test-project/kirk/issues/28
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/pty/pty01.c | 409 +++++--------------------------------------
 1 file changed, 39 insertions(+), 370 deletions(-)

diff --git a/testcases/kernel/pty/pty01.c b/testcases/kernel/pty/pty01.c
index 666b221b017fe214b7baa0b2bc608dfc2feff732..4320082eac1ac8b81b7e8dbbfac826ab4f4c1488 100644
--- a/testcases/kernel/pty/pty01.c
+++ b/testcases/kernel/pty/pty01.c
@@ -1,395 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- *
- *   Copyright (c) International Business Machines  Corp., 2002
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
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
  */
 
-/* 12/23/2002	Port to LTP	robbiew@us.ibm.com */
-/* 06/30/2001	Port to Linux	nsharoff@us.ibm.com */
+/*\
+ * [Description]
+ *
+ * Verify that write/read is properly working when master and slave
+ * pseudo terminals communicate with each other.
+ */
 
 #define _GNU_SOURCE
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <sys/wait.h>
-#include <errno.h>
-#include <fcntl.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
-#include <termios.h>
-#include <unistd.h>
-
-#include "test.h"
-#include "safe_macros.h"
-#include "lapi/ioctl.h"
-
-char *TCID = "pty01";		/* Test program identifier.    */
-int TST_TOTAL = 5;		/* Total number of test cases. */
-/**************/
 
-/*
- * pty master clone device
- */
-#define MASTERCLONE "/dev/ptmx"
+#include "common.h"
 
-/*
- * string for testing read/write on ptys
- */
 #define STRING "Linux Test Project\n"
 
-/*
- * test buffer size
- */
-#define TESTSIZE 1024
-
-/*
- * mode we expect grantpt() to leave pty as
- */
-#define PTY_MODE 020622
-
-/*
- * number of procs for parallel test
- */
-#define NUMPROCS 15
-
-/*
- * test slave locking
- */
-static int test1(void)
-{
-	int masterfd;		/* master pty fd */
-	int slavefd;		/* slave pty fd */
-	char *slavename;
-	struct stat st;
-	char buf[TESTSIZE];
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
-	if (stat(slavename, &st) != 0) {
-		tst_brkm(TBROK | TERRNO, NULL, "stat(%s) failed", slavename);
-	}
-	if (st.st_uid != getuid()) {
-		tst_brkm(TBROK, NULL, "uid mismatch");
-	}
-
-	 /* grantpt() is a no-op in bionic. */
-#ifndef __BIONIC__
-	if (st.st_mode != (S_IFCHR | S_IRUSR | S_IWUSR | S_IWGRP)) {
-		tst_brkm(TBROK, NULL, "mode mismatch (mode=%o)", st.st_mode);
-	}
-#endif
-
-	slavefd = open(slavename, O_RDWR);
-	if (slavefd >= 0) {
-		tst_brkm(TBROK, NULL, "open didn't fail as expected!");
-	}
-
-	if (unlockpt(masterfd) != 0) {
-		tst_brkm(TBROK | TERRNO, NULL, "unlockpt() failed");
-	}
-
-	slavefd = SAFE_OPEN(NULL, slavename, O_RDWR);
-
-	/*
-	 * test writing to the master / reading from the slave
-	 */
-	if (write(masterfd, STRING, strlen(STRING)) != strlen(STRING)) {
-		/*
-		 * XXX: the errno printout might be garbage, but better to be
-		 * safe than sorry..
-		 */
-		tst_brkm(TFAIL | TERRNO, NULL, "write to master");
-	}
-
-	if (read(slavefd, buf, strlen(STRING)) != strlen(STRING)) {
-		/* XXX: Same as write above.. */
-		tst_brkm(TFAIL | TERRNO, NULL, "read from slave");
-	}
-	if (strncmp(STRING, buf, strlen(STRING) - 1) != 0) {
-		tst_brkm(TFAIL, NULL,
-			 "strings are different (STRING = '%s' != buf = '%s')",
-			 STRING, buf);
-	}
-
-	/*
-	 * test writing to the slave / reading from the master
-	 */
-	if (write(slavefd, STRING, strlen(STRING)) != strlen(STRING)) {
-		/* XXX: Same as write above.. */
-		tst_brkm(TFAIL | TERRNO, NULL, "write to slave");
-	}
-
-	if (read(masterfd, buf, strlen(STRING)) != strlen(STRING)) {
-		/* XXX: Same as write above.. */
-		tst_brkm(TFAIL | TERRNO, NULL, "read from master");
-	}
-	if (strncmp(STRING, buf, strlen(STRING) - 1) != 0) {
-		tst_brkm(TFAIL, NULL,
-			 "strings are different (STRING = '%s' != buf = '%s').",
-			 STRING, buf);
-	}
-
-	/*
-	 * try an invalid ioctl on the slave...
-	 */
-	if (ioctl(slavefd, TIOCGWINSZ, NULL) == 0) {
-		tst_brkm(TFAIL, NULL,
-			 "invalid slave TIOCGWINSZ ioctl succeeded.. it should "
-			 "have failed");
-	}
+static size_t string_len;
+static int masterfd = -1;
+static int slavefd = -1;
 
-	/*
-	 * try an invalid ioctl on the master...
-	 */
-	if (ioctl(masterfd, TIOCGWINSZ, NULL) == 0) {
-		tst_brkm(TFAIL, NULL,
-			 "invalid master TIOCGWINSZ ioctl succeeded.. it should "
-			 "have failed");
-	}
-
-	/*
-	 * close pty fds
-	 */
-	if (close(slavefd) != 0) {
-		tst_brkm(TBROK | TERRNO, NULL, "close of slave");
-	}
-	if (close(masterfd) != 0) {
-		tst_brkm(TBROK | TERRNO, NULL, "close of master");
-	}
-	tst_resm(TPASS, "test1");
-	/** NOTREACHED **/
-	return 0;
-}
-
-/*
- * test slave operations with closed master
- */
-static void test2(void)
+static void run(void)
 {
-	int masterfd;		/* master pty fd */
-	int slavefd;		/* slave pty fd */
-	int i;
-	char *slavename;
-	char c;
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
-		tst_brkm(TBROK | TERRNO, NULL, "unlockpt() call failed");
-	}
-
-	slavefd = SAFE_OPEN(NULL, slavename, O_RDWR);
+	char buf[BUFSIZ];
 
-	/*
-	 * close pty fds.  See what happens when we close the master
-	 * first.
-	 */
-	if (close(masterfd) != 0) {
-		tst_brkm(TBROK | TERRNO, NULL, "close()");
-	}
+	tst_res(TINFO, "Send message to master and read it from slave");
 
-	errno = 0;
-	if ((i = read(slavefd, &c, 1)) == 1) {
-		tst_brkm(TFAIL, NULL,
-			 "reading from slave fd should have failed, but didn't"
-			 "(read '%c')", c);
-	}
+	memset(buf, 0, BUFSIZ);
+	SAFE_WRITE(SAFE_WRITE_ALL, masterfd, STRING, string_len);
+	SAFE_READ(0, slavefd, buf, string_len + 1);
+	TST_EXP_EQ_STRN(STRING, buf, string_len - 1);
 
-	if ((i = write(slavefd, &c, 1)) == 1) {
-		tst_brkm(TFAIL, NULL,
-			 "writing to slave fd should have failed, but didn't");
-	}
+	tst_res(TINFO, "Send message to slave and read it from master");
 
-	if (ioctl(slavefd, TIOCGWINSZ, NULL) == 0) {
-		tst_brkm(TFAIL, NULL,
-			 "trying TIOCGWINSZ on slave fd should have failed, "
-			 "but didn't");
-	}
-
-	if (close(slavefd) != 0) {
-		tst_brkm(TBROK, NULL, "close");
-	}
-	tst_resm(TPASS, "test2");
+	memset(buf, 0, BUFSIZ);
+	SAFE_WRITE(SAFE_WRITE_ALL, slavefd, STRING, string_len);
+	SAFE_READ(0, masterfd, buf, string_len + 1);
+	TST_EXP_EQ_STRN(STRING, buf, string_len - 1);
 }
 
-/*
- * test operations on master with closed slave
- */
-static void test3(void)
+static void setup(void)
 {
-	int masterfd;		/* master pty fd */
+	masterfd = open_master();
+	slavefd = open_slave(masterfd);
 
-	masterfd = SAFE_OPEN(NULL, MASTERCLONE, O_RDWR);
-
-	if (ioctl(masterfd, TIOCGWINSZ, NULL) == 0) {
-		tst_brkm(TFAIL | TERRNO, NULL,
-			 "trying TIOCGWINSZ on master with no open slave "
-			 "succeeded unexpectedly");
-	}
-	tst_resm(TPASS, "test3");
+	string_len = strlen(STRING);
 }
 
-/*
- * test multiple opens on slave side of pty
- */
-static void test4(void)
+static void cleanup(void)
 {
-	int masterfd;		/* master pty fd */
-	int slavefd;		/* slave pty fd */
-	int slavefd2;
-	int slavefd3;
-	char *slavename;
-
-	masterfd = SAFE_OPEN(NULL, MASTERCLONE, O_RDWR);
-
-	slavename = ptsname(masterfd);
-	if (slavename == NULL) {
-		tst_brkm(TBROK, NULL, "ptsname() call failed");
-	}
-
-	if (grantpt(masterfd) != 0) {
-		tst_brkm(TBROK, NULL, "grantpt() call failed");
-	}
+	if (masterfd != -1)
+		SAFE_CLOSE(masterfd);
 
-	if (unlockpt(masterfd) != 0) {
-		tst_brkm(TBROK | TERRNO, NULL, "unlockpt() call failed");
-	}
-
-	slavefd = SAFE_OPEN(NULL, slavename, O_RDWR);
-
-	slavefd2 = open(slavename, O_RDWR);
-	if (slavefd < 0) {
-		tst_brkm(TFAIL | TERRNO, NULL, "Could not open %s (again)",
-			 slavename);
-	}
-
-	slavefd3 = open(slavename, O_RDWR);
-	if (slavefd < 0) {
-		tst_brkm(TFAIL | TERRNO, NULL, "Could not open %s (once more)",
-			 slavename);
-	}
-
-	/*
-	 * close pty fds.
-	 */
-	if (close(slavefd) != 0) {
-		tst_brkm(TBROK | TERRNO, NULL, "close slave");
-	}
-
-	if (close(slavefd2) != 0) {
-		tst_brkm(TBROK, NULL, "close slave again");
-	}
-
-	if (close(slavefd3) != 0) {
-		tst_brkm(TBROK, NULL, "close slave once more");
-	}
-
-	if (close(masterfd) != 0) {
-		tst_brkm(TBROK, NULL, "close master");
-	}
-	tst_resm(TPASS, "test4");
-}
-
-/*
- * test opening/closing lots of ptys in parallel.  We may run out
- * of ptys for this test depending on how the system is configured,
- * but that's not a fatal error.
- */
-static void test5(void)
-{
-	int masterfd;		/* master pty fd */
-	char *slavename;
-	int status;
-	int i;
-
-	for (i = 0; i < NUMPROCS; ++i) {
-		switch (fork()) {
-		case -1:
-			tst_brkm(TBROK, NULL, "fork()");
-			break;
-		case 0:
-			masterfd = open(MASTERCLONE, O_RDWR);
-			if (masterfd < 0) {
-				printf("proc %d: opening %s failed: %s",
-				       i, MASTERCLONE, strerror(errno));
-				exit(1);
-			}
-			if (grantpt(masterfd) != 0) {
-				printf("proc %d: grantpt() call failed: %s",
-				       i, strerror(errno));
-				exit(1);
-			}
-			slavename = ptsname(masterfd);
-			if (slavename == NULL) {
-				printf("proc %d: ptsname() call failed: %s",
-				       i, strerror(errno));
-				exit(1);
-			}
-			sleep(10);
-			if (close(masterfd) != 0) {
-				printf("proc %d: close failed: %s",
-				       i, strerror(errno));
-				exit(1);
-			}
-			exit(0);
-		default:
-			break;
-		}
-	}
-	while (wait(&status) > 0) {
-		if (status) {
-			tst_brkm(TFAIL, NULL,
-				 "child exited with non-zero status %d",
-				 status);
-		}
-	}
-	tst_resm(TPASS, "test5");
+	if (slavefd != -1)
+		SAFE_CLOSE(slavefd);
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
-
-	/*
-	 * all done
-	 */
-	tst_exit();
-}
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+};

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
