Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E39C4C4828F
	for <ltp@archiver.kernel.org>; Mon,  5 Feb 2024 02:29:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 24FCB3CC6CA
	for <ltp@archiver.kernel.org>; Mon,  5 Feb 2024 03:29:36 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2F0ED3C9968
 for <ltp@lists.linux.it>; Mon,  5 Feb 2024 03:29:06 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8AE0B2000C2
 for <ltp@lists.linux.it>; Mon,  5 Feb 2024 03:29:05 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5C679220EC;
 Mon,  5 Feb 2024 02:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1707100143; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=HqGPKdYnMQ6qXm+O+7h/4mu14SPuoMxyyRRVQBzzRTc=;
 b=hpFhrWtT6G7Uic2GB5CQgODtPEnHDJR6bYwRTs0jL2gtHStNKxo8pho4zP3FtxejOKu07+
 O0b21Fw4VSfXI32q+bODeoQWDsgm2DcutT/59VBBjjHLnIhM/EessOU2Hb8aGj6WS6x738
 bt2AKUHQWqjDMyB+4SZDONhSdsToCIk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1707100143;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=HqGPKdYnMQ6qXm+O+7h/4mu14SPuoMxyyRRVQBzzRTc=;
 b=ni8HxYzKqXzFI1MhrfdjYDUjbftMPw/OUXjIqIhE8MUAQJlZOWBwBLenYFLhDT88uetoRc
 7uuY2RPCwwf41VBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1707100142; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=HqGPKdYnMQ6qXm+O+7h/4mu14SPuoMxyyRRVQBzzRTc=;
 b=kRAIcMqiak14VedBLaRBUPLOgDDGle1cBAENsVl+N6k4piRLXhWKmuOujfQKNRFux3d47b
 KDRZHu3S3HKLVBJmsQLHYHUwEoDO6CENg+yaa3MBwxteq7gFaqYK/7XIqQpLl0Yctr9Y4n
 PcCgGE3oa9NGLXJS/UAScK43ne7hras=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1707100142;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=HqGPKdYnMQ6qXm+O+7h/4mu14SPuoMxyyRRVQBzzRTc=;
 b=HozBHKW2RNgn+GblTMzY1bHj3ZNOG5F/8bmsOrffLJfJxzOa16yI8DvcoZ7T99a0Q8vwwe
 l7xuNg2+ylf/VWCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 37CEB132DD;
 Mon,  5 Feb 2024 02:29:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id rBCrDO5HwGUPRgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 05 Feb 2024 02:29:02 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon,  5 Feb 2024 03:28:56 +0100
Message-ID: <20240205022857.191692-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [0.70 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; TO_DN_SOME(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] swapon03: Cleanup
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

* There is no need to check for sprintf() return code.
* Use tst_res() instead of printf and remove bogus comments.
* Define EXPECTED_ERRNO as constant (not assigned).
* Use SAFE_*() functions.
* Fix remaining checkpack.pl warnings.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/syscalls/swapon/swapon03.c | 63 ++++++++-------------
 1 file changed, 25 insertions(+), 38 deletions(-)

diff --git a/testcases/kernel/syscalls/swapon/swapon03.c b/testcases/kernel/syscalls/swapon/swapon03.c
index 05fe2045f..3dbcd5bfd 100644
--- a/testcases/kernel/syscalls/swapon/swapon03.c
+++ b/testcases/kernel/syscalls/swapon/swapon03.c
@@ -24,14 +24,15 @@
 
 #define MNTPOINT	"mntpoint"
 #define TEST_FILE	MNTPOINT"/testswap"
+#define EXPECTED_ERRNO EPERM
 
 static int setup_swap(void);
 static int clean_swap(void);
 static int check_and_swapoff(const char *filename);
 
 static int swapfiles;
+static int testfiles = 3;
 
-int testfiles = 3;
 static struct swap_testfile_t {
 	char *filename;
 } swap_testfiles[] = {
@@ -40,8 +41,6 @@ static struct swap_testfile_t {
 	{"thirdswapfile"}
 };
 
-int expected_errno = EPERM;
-
 static void verify_swapon(void)
 {
 	if (setup_swap() < 0) {
@@ -51,14 +50,14 @@ static void verify_swapon(void)
 
 	TEST(tst_syscall(__NR_swapon, swap_testfiles[0].filename, 0));
 
-	if ((TST_RET == -1) && (TST_ERR == expected_errno)) {
+	if ((TST_RET == -1) && (TST_ERR == EXPECTED_ERRNO)) {
 		tst_res(TPASS, "swapon(2) got expected failure (%d),",
-			expected_errno);
+			EXPECTED_ERRNO);
 	} else if (TST_RET < 0) {
 		tst_res(TFAIL | TTERRNO,
 			"swapon(2) failed to produce expected error "
 			"(%d). System reboot recommended.",
-			expected_errno);
+			EXPECTED_ERRNO);
 	} else {
 		/*
 		 * Probably the system supports MAX_SWAPFILES > 30, let's try with
@@ -78,19 +77,19 @@ static void verify_swapon(void)
 			TEST(tst_syscall(__NR_swapon, swap_testfiles[2].filename, 0));
 
 			/* Check return code (should be an error) */
-			if ((TST_RET == -1) && (TST_ERR == expected_errno)) {
+			if ((TST_RET == -1) && (TST_ERR == EXPECTED_ERRNO)) {
 				tst_res(TPASS,
 					"swapon(2) got expected failure;"
 					" Got errno = %d, probably your"
 					" MAX_SWAPFILES is 32",
-					expected_errno);
+					EXPECTED_ERRNO);
 			} else {
 				tst_res(TFAIL,
 					"swapon(2) failed to produce"
 					" expected error: %d, got %s."
 					" System reboot after execution of LTP"
 					" test suite is recommended.",
-					expected_errno, strerror(TST_ERR));
+					EXPECTED_ERRNO, strerror(TST_ERR));
 			}
 		}
 	}
@@ -114,30 +113,24 @@ static int setup_swap(void)
 	/* Find out how many swapfiles (1 line per entry) already exist */
 	swapfiles = 0;
 
-	if (seteuid(0) < 0)
-		tst_brk(TFAIL | TERRNO, "Failed to call seteuid");
+	SAFE_SETEUID(0);
 
-	/* This includes the first (header) line */
-	if ((fd = open("/proc/swaps", O_RDONLY)) == -1) {
-		tst_brk(TFAIL | TERRNO,
-			"Failed to find out existing number of swap files");
-	}
+	fd = SAFE_OPEN("/proc/swaps", O_RDONLY);
 	do {
 		char *p = buf;
-		res = read(fd, buf, BUFSIZ);
-		if (res < 0) {
-			tst_brk(TFAIL | TERRNO,
-				 "Failed to find out existing number of swap files");
-		}
+
+		res = SAFE_READ(0, fd, buf, BUFSIZ);
 		buf[res] = '\0';
 		while ((p = strchr(p, '\n'))) {
 			p++;
 			swapfiles++;
 		}
-	} while (BUFSIZ <= res);
-	close(fd);
+	} while (res >= BUFSIZ);
+	SAFE_CLOSE(fd);
+
+	/* don't count the /proc/swaps header */
 	if (swapfiles)
-		swapfiles--;	/* don't count the /proc/swaps header */
+		swapfiles--;
 
 	if (swapfiles < 0)
 		tst_brk(TFAIL, "Failed to find existing number of swapfiles");
@@ -146,36 +139,30 @@ static int setup_swap(void)
 	swapfiles = MAX_SWAPFILES - swapfiles;
 	if (swapfiles > MAX_SWAPFILES)
 		swapfiles = MAX_SWAPFILES;
+
 	pid = SAFE_FORK();
 	if (pid == 0) {
 		/*create and turn on remaining swapfiles */
 		for (j = 0; j < swapfiles; j++) {
-
-			/* prepare filename for the iteration */
-			if (sprintf(filename, "swapfile%02d", j + 2) < 0) {
-				printf("sprintf() failed to create "
-				       "filename");
-				exit(1);
-			}
-
-			/* Create the swapfile */
+			sprintf(filename, "swapfile%02d", j + 2);
 			make_swapfile(filename, 10, 0);
 
 			/* turn on the swap file */
 			res = tst_syscall(__NR_swapon, filename, 0);
 			if (res != 0) {
 				if (errno == EPERM) {
-					printf("Successfully created %d swapfiles\n", j);
+					tst_res(TINFO, "Successfully created %d swapfiles", j);
 					break;
-				} else {
-					printf("Failed to create swapfile: %s\n", filename);
-					exit(1);
 				}
+
+				tst_res(TWARN | TERRNO, "Failed to create swapfile: %s", filename);
+				exit(1);
 			}
 		}
 		exit(0);
-	} else
+	} else {
 		waitpid(pid, &status, 0);
+	}
 
 	if (WEXITSTATUS(status))
 		tst_brk(TFAIL, "Failed to setup swaps");
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
