Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE9A9C6FD20
	for <ltp@archiver.kernel.org>; Fri, 24 Mar 2023 08:18:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EB6FB3CD1E8
	for <ltp@archiver.kernel.org>; Fri, 24 Mar 2023 09:18:02 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BBAFC3CA4C4
 for <ltp@lists.linux.it>; Fri, 24 Mar 2023 09:17:52 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D1D9F14010D9
 for <ltp@lists.linux.it>; Fri, 24 Mar 2023 09:17:51 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0620833A22;
 Fri, 24 Mar 2023 08:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1679645871; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=gNdYa8JqnWPhUqZBmknsQQoBO72sQMG9CiC5ivqdt0g=;
 b=nL6/hQEs8PcI/gSenJScLarEQ08rjpeEoj67gM/QhlkwxncFaonuIqNvpjGoxdMKXsIsEI
 Jzqojb6Mu4NnFCvpBXsZz6/xppecx1wtd4xO+DSLj/bQDav+KDxy8Ns14METc96Nj9Vx4x
 MPHKjCXFHdPdzR5bCgnRsZDeSzbVFNw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1679645871;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=gNdYa8JqnWPhUqZBmknsQQoBO72sQMG9CiC5ivqdt0g=;
 b=kr14LHb+oUbRv78LaF2dFwZXSaZKHUAaaQ/FQY/ivXOcd8vRGb1ZtnhF7+YBrSEnmJri/E
 FB1l+YxaE1XfEnCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ABF8113A26;
 Fri, 24 Mar 2023 08:17:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id jPLpJq5cHWRndgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 24 Mar 2023 08:17:50 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 24 Mar 2023 09:17:44 +0100
Message-Id: <20230324081744.539431-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] file01.sh: Drop csh and ksh detection
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

in.csh and in.ksh data files causes automatic csh and ksh dependency
of ltp package built in openSUSE / SLES build systems.
csh and ksh shells aren't commonly used in nowadays Linux distros,
therefore it's not worth to deal with workarounds for missing
dependency.

Reported-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/commands/file/datafiles/in.csh |  4 ---
 testcases/commands/file/datafiles/in.ksh |  4 ---
 testcases/commands/file/file01.sh        | 35 ++++++++++++------------
 3 files changed, 17 insertions(+), 26 deletions(-)
 delete mode 100644 testcases/commands/file/datafiles/in.csh
 delete mode 100644 testcases/commands/file/datafiles/in.ksh

diff --git a/testcases/commands/file/datafiles/in.csh b/testcases/commands/file/datafiles/in.csh
deleted file mode 100644
index c475aef9c..000000000
--- a/testcases/commands/file/datafiles/in.csh
+++ /dev/null
@@ -1,4 +0,0 @@
-#! /bin/csh
-
-echo "this is a shell script"
-echo "used to test file command"
diff --git a/testcases/commands/file/datafiles/in.ksh b/testcases/commands/file/datafiles/in.ksh
deleted file mode 100644
index 3ae45125c..000000000
--- a/testcases/commands/file/datafiles/in.ksh
+++ /dev/null
@@ -1,4 +0,0 @@
-#! /bin/ksh
-
-echo "this is a shell script"
-echo "used to test file command"
diff --git a/testcases/commands/file/file01.sh b/testcases/commands/file/file01.sh
index df152b656..f0c129f33 100755
--- a/testcases/commands/file/file01.sh
+++ b/testcases/commands/file/file01.sh
@@ -2,12 +2,13 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) International Business Machines Corp., 2001
 # Copyright (c) 2016 Cyril Hrubis <chrubis@suse.cz>
+# Copyright (c) Linux Test Project, 2017-2023
 #
 # This program tests the file command. The tests are aimed at
 # testing if the file command can recognize some of the commonly
 # used file formats like, tar, tar.gz, rpm, C, ASCII, ELF etc.
 
-TST_CNT=20
+TST_CNT=18
 TST_SETUP=setup
 TST_TESTFUNC=do_test
 TST_NEEDS_TMPDIR=1
@@ -61,30 +62,28 @@ do_test()
 			    "POSIX shell script text executable" \
 			    "POSIX shell script text" \
 			    "Bourne shell script text executable";;
-	 4) file_test in.ksh "Korn shell script";;
-	 5) file_test in.csh "C shell script";;
-	 6) file_test in.c "ASCII C program text" "C source, ASCII text";;
-	 7) file_test in.pl "[pP]erl script, ASCII text executable" \
+	 4) file_test in.c "ASCII C program text" "C source, ASCII text";;
+	 5) file_test in.pl "[pP]erl script, ASCII text executable" \
 			    "[pP]erl script text executable" \
 			    "a /usr/bin/perl script text";;
-	 8) file_test in.py "[pP]ython3\{0,1\} script, ASCII text executable" \
+	 6) file_test in.py "[pP]ython3\{0,1\} script, ASCII text executable" \
 			    "[pP]ython3\{0,1\} script text executable";;
-	 9) file_test in.m4 "M4 macro processor script, ASCII text" \
+	 7) file_test in.m4 "M4 macro processor script, ASCII text" \
 			    "ASCII M4 macro language pre-processor text";;
-	10) file_test in "ELF .*-bit $TEST_ARCH executable, .*" \
+	 8) file_test in "ELF .*-bit $TEST_ARCH executable, .*" \
 			 "ELF .*-bit $TEST_ARCH shared object, .*" \
 			 "ELF .*-bit $TEST_ARCH pie executable, .*" \
 			 "ELF .*-bit $TEST_ARCH pie shared object, .*";;
-	11) file_test in.ar "current ar archive";;
-	12) file_test in.tar "tar archive";;
-	13) file_test in.tar.gz "gzip compressed data, .*";;
-	14) file_test in.tar.bz2 "bzip2 compressed data, .*";;
-	15) file_test in.src.rpm "RPM v3 src" "RPM v3.0 src";;
-	16) file_test in.jpg "JPEG image data";;
-	17) file_test in.png "PNG image data";;
-	18) file_test in.wav "RIFF (little-endian) data, WAVE audio, Microsoft PCM";;
-	19) file_test in.mp3 "MPEG ADTS, layer III";;
-	20) file_test in.zip "Zip archive data";;
+	 9) file_test in.ar "current ar archive";;
+	10) file_test in.tar "tar archive";;
+	11) file_test in.tar.gz "gzip compressed data, .*";;
+	12) file_test in.tar.bz2 "bzip2 compressed data, .*";;
+	13) file_test in.src.rpm "RPM v3 src" "RPM v3.0 src";;
+	14) file_test in.jpg "JPEG image data";;
+	15) file_test in.png "PNG image data";;
+	16) file_test in.wav "RIFF (little-endian) data, WAVE audio, Microsoft PCM";;
+	17) file_test in.mp3 "MPEG ADTS, layer III";;
+	18) file_test in.zip "Zip archive data";;
 	esac
 }
 
-- 
2.40.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
