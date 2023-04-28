Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF2EAC77B60
	for <ltp@archiver.kernel.org>; Fri, 28 Apr 2023 16:32:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 721B43CBB05
	for <ltp@archiver.kernel.org>; Fri, 28 Apr 2023 18:32:21 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DC07D3CBA24
 for <ltp@lists.linux.it>; Fri, 28 Apr 2023 18:32:11 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6AAA2200059
 for <ltp@lists.linux.it>; Fri, 28 Apr 2023 18:32:11 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C496F21FA1;
 Fri, 28 Apr 2023 16:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1682699530; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=DCihsyFa8l1jWHLvFbZDq5cTgOwGKgldnNcQVS0EtT0=;
 b=AZs5ST4LrX4zw7h3brePfVOkT4ug+Je9mV/Ceno3gSF6/SBg6qZ5dIgCDjimcRrlfb6blx
 ERxVtKYtNSpAorGZh3Szp2G/kK1/NAI3OD6iyhHdj+nybwA/5I6vbR18Yvm4lyGAzSxIWm
 tRaWoduOIen2QpyPMHIpotn4tKzB/g0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1682699530;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=DCihsyFa8l1jWHLvFbZDq5cTgOwGKgldnNcQVS0EtT0=;
 b=YHGhJJBQQbWCUAekF1xKys3jivpc/LPfqgT1EEZ8n8OQE7IysqB2BopBl/Xwatie4ejNAy
 ukgJycF868QNbhCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7CA251390E;
 Fri, 28 Apr 2023 16:32:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id yAJYHAr1S2SwfAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 28 Apr 2023 16:32:10 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 28 Apr 2023 18:32:19 +0200
Message-Id: <20230428163219.3540793-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] nfslock01: Allow to pass parameters
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

Parameter for chars in line and number of lines can be made lower to
make debugging faster.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v1->v2:
Rebased

 testcases/network/nfs/nfslock01/nfs_flock.c   | 37 +++++++++++--------
 .../network/nfs/nfslock01/nfs_flock_dgen.c    |  8 ++--
 testcases/network/nfs/nfslock01/nfslock01.sh  | 20 ++++++----
 3 files changed, 37 insertions(+), 28 deletions(-)

diff --git a/testcases/network/nfs/nfslock01/nfs_flock.c b/testcases/network/nfs/nfslock01/nfs_flock.c
index d13c9766c..62e4c1a4a 100644
--- a/testcases/network/nfs/nfslock01/nfs_flock.c
+++ b/testcases/network/nfs/nfslock01/nfs_flock.c
@@ -20,17 +20,15 @@
 #include <stdlib.h>
 #include <unistd.h>
 
-#define BYTES 64
-#define LINES 16384
-
 int main(int argc, char **argv)
 {
-	int i, fd, mac;
+	int i, fd, mac, nchars, nlines;
 	int offset = 0;
 	char buf[BUFSIZ];
 
-	if (argc != 3) {
-		fprintf(stderr, "Usage: %s <mac num> <file name>\n", argv[0]);
+	if (argc != 5) {
+		fprintf(stderr, "Usage: %s <mac num> <file name> <nchars> <nlines>\n",
+				argv[0]);
 		exit(2);
 	}
 
@@ -41,48 +39,55 @@ int main(int argc, char **argv)
 	}
 
 	mac = atoi(argv[1]);
+	nchars = atoi(argv[3]);
+	nlines = atoi(argv[4]);
+
+	if (nchars > BUFSIZ) {
+		printf("Exceeded the maximum limit of the buffer (%d)\n", BUFSIZ);
+		exit(3);
+	}
 
 	/*
 	 * Replace a line of characters by 1's if it is process one
-	 * else with 0's. Number of charcters in any line are BYTES-1,
+	 * else with 0's. Number of charcters in any line are nchars-1,
 	 * the last character being a newline character.
 	 */
-	for (i = 0; i < BYTES - 1; i++) {
+	for (i = 0; i < nchars - 1; i++) {
 		if (mac == 1)
 			buf[i] = '1';
 		else
 			buf[i] = '0';
 	}
-	buf[BYTES - 1] = '\n';
+	buf[nchars - 1] = '\n';
 
-	for (i = 0; i < LINES; i++) {
+	for (i = 0; i < nlines; i++) {
 		if (mac == 1) {	/* Set the offset to even lines */
 			if ((i % 2) == 0) {
 				if (i == 0)
 					offset = 0;
 				else
-					offset += 2 * BYTES;
+					offset += 2 * nchars;
 			} else
 				continue;
 		} else {	/* Set the offset to odd lines */
 			if ((i % 2) == 1) {
 				if (i == 1)
-					offset = BYTES;
+					offset = nchars;
 				else
-					offset += 2 * BYTES;
+					offset += 2 * nchars;
 			} else
 				continue;
 		}
 
-		if (writeb_lock(fd, offset, SEEK_SET, BYTES) < 0)
+		if (writeb_lock(fd, offset, SEEK_SET, nchars) < 0)
 			printf("failed in writeb_lock, Errno = %d", errno);
 
 		lseek(fd, offset, SEEK_SET);
 
 		/* write to the test file */
-		write(fd, buf, BYTES);
+		write(fd, buf, nchars);
 
-		if (unb_lock(fd, offset, SEEK_SET, BYTES) < 0)
+		if (unb_lock(fd, offset, SEEK_SET, nchars) < 0)
 			printf("failed in unb_lock, Errno = %d", errno);
 	}
 	exit(0);
diff --git a/testcases/network/nfs/nfslock01/nfs_flock_dgen.c b/testcases/network/nfs/nfslock01/nfs_flock_dgen.c
index bef5219fc..995c3800b 100644
--- a/testcases/network/nfs/nfslock01/nfs_flock_dgen.c
+++ b/testcases/network/nfs/nfslock01/nfs_flock_dgen.c
@@ -22,17 +22,15 @@ int main(int argc, char **argv)
 	FILE *fp;
 
 	if (argc != 5) {
-		printf
-		    ("usage: <nfs_flock_dgen> <file> <char/line> <lines> <ctype>\n");
+		printf("usage: <nfs_flock_dgen> <file> <char/line> <lines> <ctype>\n");
 		exit(2);
 	}
 
 	fp = fopen(argv[1], "w");
 
-	nchars = atoi(argv[2]);
+	nchars = atoi(argv[2]) - 1;
 	if (nchars > BUFSIZ) {
-		printf("Exceeded the maximum limit of the buffer (%d)\n",
-		       BUFSIZ);
+		printf("Exceeded the maximum limit of the buffer (%d)\n", BUFSIZ);
 		exit(3);
 	}
 	nlines = atoi(argv[3]);
diff --git a/testcases/network/nfs/nfslock01/nfslock01.sh b/testcases/network/nfs/nfslock01/nfslock01.sh
index fbcc3c00f..34eeb74a1 100755
--- a/testcases/network/nfs/nfslock01/nfslock01.sh
+++ b/testcases/network/nfs/nfslock01/nfslock01.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
-# Copyright (c) Linux Test Project, 2002-2022
+# Copyright (c) Linux Test Project, 2002-2023
 # Copyright (c) 2016-2018 Oracle and/or its affiliates. All Rights Reserved.
 # Copyright (c) International Business Machines  Corp., 2001
 #
@@ -13,18 +13,24 @@
 TST_SETUP="do_setup"
 TST_TESTFUNC="do_test"
 
+NCHARS=${NCHARS:-64}
+NLINES=${NLINES:-16384}
+
 do_setup()
 {
+	local exp_size
+
 	nfs_setup
 
 	tst_res TINFO "creating test files"
-	ROD nfs_flock_dgen flock_data 63 16384 0
-	ROD nfs_flock_dgen flock_odata 63 16384 1
+	ROD nfs_flock_dgen flock_data $NCHARS $NLINES 0
+	ROD nfs_flock_dgen flock_odata $NCHARS $NLINES 1
 
-	[ "$(wc -c flock_data | awk '{print $1}')" -ne 1048576 ] && \
+	exp_size=$(( NCHARS * NLINES ))
+	[ "$(wc -c flock_data | awk '{print $1}')" -ne $exp_size ] && \
 		tst_brk TBROK "could not create 'flock_data'"
 
-	[ "$(wc -c flock_odata | awk '{print $1}')" -ne 1048576 ] && \
+	[ "$(wc -c flock_odata | awk '{print $1}')" -ne $exp_size ] && \
 		tst_brk TBROK "could not create 'flock_odata'"
 }
 
@@ -36,9 +42,9 @@ do_test()
 
 	tst_res TINFO "locking 'flock_idata' file and writing data"
 
-	nfs_flock 0 flock_idata &
+	nfs_flock 0 flock_idata $NCHARS $NLINES &
 	local pids=$!
-	nfs_flock 1 flock_idata &
+	nfs_flock 1 flock_idata $NCHARS $NLINES &
 	pids="$pids $!"
 
 	tst_res TINFO "waiting for pids: $pids"
-- 
2.40.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
