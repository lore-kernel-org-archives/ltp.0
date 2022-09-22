Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41227C6FA82
	for <ltp@archiver.kernel.org>; Thu, 22 Sep 2022 12:22:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 153FE3CAD85
	for <ltp@archiver.kernel.org>; Thu, 22 Sep 2022 14:22:07 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C702C3C278D
 for <ltp@lists.linux.it>; Thu, 22 Sep 2022 14:21:56 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id BC46410011D6
 for <ltp@lists.linux.it>; Thu, 22 Sep 2022 14:21:55 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F2E2B1F910;
 Thu, 22 Sep 2022 12:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1663849315; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=IOuQfzLXjpFkXCRO9juLJZ7s8C2+ApB7j3r1Gn7pUvM=;
 b=ZCSQRGqB+nlVUrPav0yKtRAG+AxlhzXzA0TufVc5+jXoMk2Po7p9dF9xCXe9KGo4oPD4rz
 QkhjDKL5lEpK4VckWHdjP6ADGoZZeC23cjvEPcnoWYTNhBR9cwrCB8Q8E1iHXP/VExwyEG
 2Vkb8tCLHdpYjR5woKQLwRPANavplP0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C45281346B;
 Thu, 22 Sep 2022 12:21:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id NEXiLGJTLGO5VQAAMHmgww
 (envelope-from <andrea.cervesato@suse.com>); Thu, 22 Sep 2022 12:21:54 +0000
To: ltp@lists.linux.it
Date: Thu, 22 Sep 2022 14:20:47 +0200
Message-Id: <20220922122047.9368-1-andrea.cervesato@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] Let user decide command alias in ar01.sh
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Now it's possible to select ar alias by exporting AR variable before
running ar01.sh test.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/commands/ar/ar01.sh | 176 +++++++++++++++++-----------------
 1 file changed, 88 insertions(+), 88 deletions(-)

diff --git a/testcases/commands/ar/ar01.sh b/testcases/commands/ar/ar01.sh
index 943944d21..938a85154 100644
--- a/testcases/commands/ar/ar01.sh
+++ b/testcases/commands/ar/ar01.sh
@@ -4,7 +4,7 @@
 # Copyright (c) 2016 Cyril Hrubis <chrubis@suse.cz>
 # Author: Robbie Williamson <robbiew@us.ibm.com>
 #
-# This is a basic ar command test.
+# This is a basic $AR command test.
 
 AR="${AR:=ar}"
 TST_CNT=17
@@ -16,22 +16,22 @@ TST_NEEDS_CMDS="$AR"
 setup()
 {
 	MOD=
-	ar --help | grep "use zero for timestamps and uids/gids (default)" >/dev/null
+	$AR --help | grep "use zero for timestamps and uids/gids (default)" >/dev/null
 	[ $? -eq 0 ] && MOD="U"
 }
 
 test1()
 {
-	ROD ar -cr"$MOD" lib.a $TST_DATAROOT/file1.in $TST_DATAROOT/file3.in
-	ROD ar -ra"$MOD" file1.in lib.a $TST_DATAROOT/file2.in
-	ROD ar -t lib.a \> ar.out
+	ROD $AR -cr"$MOD" lib.a $TST_DATAROOT/file1.in $TST_DATAROOT/file3.in
+	ROD $AR -ra"$MOD" file1.in lib.a $TST_DATAROOT/file2.in
+	ROD $AR -t lib.a \> ar.out
 
 	printf "file1.in\nfile2.in\nfile3.in\n" > ar.exp
 
 	if diff ar.out ar.exp >/dev/null; then
-		tst_res TPASS "ar added new file after another (-a)"
+		tst_res TPASS "$AR added new file after another (-a)"
 	else
-		tst_res TFAIL "ar failed to add new file after another (-a)"
+		tst_res TFAIL "$AR failed to add new file after another (-a)"
 		cat ar.out
 	fi
 
@@ -40,17 +40,17 @@ test1()
 
 test2()
 {
-	ROD ar -cr"$MOD" lib.a $TST_DATAROOT/file1.in $TST_DATAROOT/file2.in \
+	ROD $AR -cr"$MOD" lib.a $TST_DATAROOT/file1.in $TST_DATAROOT/file2.in \
 			       $TST_DATAROOT/file3.in $TST_DATAROOT/file4.in
-	ROD ar -ma"$MOD" file1.in lib.a file4.in
-	ROD ar -t lib.a \> ar.out
+	ROD $AR -ma"$MOD" file1.in lib.a file4.in
+	ROD $AR -t lib.a \> ar.out
 
 	printf "file1.in\nfile4.in\nfile2.in\nfile3.in\n" > ar.exp
 
 	if diff ar.out ar.exp > /dev/null; then
-		tst_res TPASS "ar moved file correctly (-ma)"
+		tst_res TPASS "$AR moved file correctly (-ma)"
 	else
-		tst_res TFAIL "ar failed to move file (-ma)"
+		tst_res TFAIL "$AR failed to move file (-ma)"
 		cat ar.out
 	fi
 
@@ -59,16 +59,16 @@ test2()
 
 test3()
 {
-	ROD ar -cr"$MOD" lib.a $TST_DATAROOT/file1.in $TST_DATAROOT/file3.in
-	ROD ar -rb"$MOD" file3.in lib.a $TST_DATAROOT/file2.in
-	ROD ar -t lib.a \> ar.out
+	ROD $AR -cr"$MOD" lib.a $TST_DATAROOT/file1.in $TST_DATAROOT/file3.in
+	ROD $AR -rb"$MOD" file3.in lib.a $TST_DATAROOT/file2.in
+	ROD $AR -t lib.a \> ar.out
 
 	printf "file1.in\nfile2.in\nfile3.in\n" > ar.exp
 
 	if diff ar.out ar.exp; then
-		tst_res TPASS "ar added new file before another (-b)"
+		tst_res TPASS "$AR added new file before another (-b)"
 	else
-		tst_res TFAIL "ar failed to add new file before another (-b)"
+		tst_res TFAIL "$AR failed to add new file before another (-b)"
 		cat ar.out
 	fi
 
@@ -77,17 +77,17 @@ test3()
 
 test4()
 {
-	ROD ar -cr"$MOD" lib.a $TST_DATAROOT/file1.in $TST_DATAROOT/file3.in \
+	ROD $AR -cr"$MOD" lib.a $TST_DATAROOT/file1.in $TST_DATAROOT/file3.in \
 			       $TST_DATAROOT/file2.in
-	ROD ar -mb"$MOD" file3.in lib.a file2.in
-	ROD ar -t lib.a \> ar.out
+	ROD $AR -mb"$MOD" file3.in lib.a file2.in
+	ROD $AR -t lib.a \> ar.out
 
 	printf "file1.in\nfile2.in\nfile3.in\n" > ar.exp
 
 	if diff ar.out ar.exp > /dev/null; then
-		tst_res TPASS "ar moved file correctly (-mb)"
+		tst_res TPASS "$AR moved file correctly (-mb)"
 	else
-		tst_res TFAIL "ar failed to move file (-mb)"
+		tst_res TFAIL "$AR failed to move file (-mb)"
 		cat ar.out
 	fi
 
@@ -96,13 +96,13 @@ test4()
 
 test5()
 {
-	ROD ar -cr"$MOD" lib.a $TST_DATAROOT/file1.in \> ar.out
+	ROD $AR -cr"$MOD" lib.a $TST_DATAROOT/file1.in \> ar.out
 
 	if [ -s ar.out ]; then
-		tst_res TFAIL "ar produced output unexpectedly (-c)"
+		tst_res TFAIL "$AR produced output unexpectedly (-c)"
 		cat ar.out
 	else
-		tst_res TPASS "ar haven't produced output (-c)"
+		tst_res TPASS "$AR haven't produced output (-c)"
 	fi
 
 	ROD rm lib.a
@@ -110,13 +110,13 @@ test5()
 
 test6()
 {
-	ROD ar -qc"$MOD" lib.a $TST_DATAROOT/file1.in \> ar.out
+	ROD $AR -qc"$MOD" lib.a $TST_DATAROOT/file1.in \> ar.out
 
 	if [ -s ar.out ]; then
-		tst_res TFAIL "ar produced output unexpectedly (-qc)"
+		tst_res TFAIL "$AR produced output unexpectedly (-qc)"
 		cat ar.out
 	else
-		tst_res TPASS "ar haven't produced output (-qc)"
+		tst_res TPASS "$AR haven't produced output (-qc)"
 	fi
 
 	ROD rm lib.a
@@ -124,17 +124,17 @@ test6()
 
 test7()
 {
-	ROD ar -cr"$MOD" lib.a $TST_DATAROOT/file1.in $TST_DATAROOT/file2.in \
+	ROD $AR -cr"$MOD" lib.a $TST_DATAROOT/file1.in $TST_DATAROOT/file2.in \
 			       $TST_DATAROOT/file3.in
-	ROD ar -d"$MOD" lib.a file1.in file2.in
-	ROD ar -t lib.a \> ar.out
+	ROD $AR -d"$MOD" lib.a file1.in file2.in
+	ROD $AR -t lib.a \> ar.out
 
 	printf "file3.in\n" > ar.exp
 
 	if diff ar.out ar.exp > /dev/null; then
-		tst_res TPASS "ar deleted files correctly (-d)"
+		tst_res TPASS "$AR deleted files correctly (-d)"
 	else
-		tst_res TFAIL "ar messed up when deleting files (-d)"
+		tst_res TFAIL "$AR messed up when deleting files (-d)"
 		cat ar.out
 	fi
 
@@ -143,17 +143,17 @@ test7()
 
 test8()
 {
-	ROD ar -cr"$MOD" lib.a $TST_DATAROOT/file1.in $TST_DATAROOT/file2.in \
+	ROD $AR -cr"$MOD" lib.a $TST_DATAROOT/file1.in $TST_DATAROOT/file2.in \
 			       $TST_DATAROOT/file3.in
-	ROD ar -d"$MOD" lib.a
-	ROD ar -t lib.a \> ar.out
+	ROD $AR -d"$MOD" lib.a
+	ROD $AR -t lib.a \> ar.out
 
 	printf "file1.in\nfile2.in\nfile3.in\n" > ar.exp
 
 	if diff ar.out ar.exp > /dev/null; then
-		tst_res TPASS "ar deleted nothing (-d with empty list)"
+		tst_res TPASS "$AR deleted nothing (-d with empty list)"
 	else
-		tst_res TFAIL "ar deleted files (-d with empty list)"
+		tst_res TFAIL "$AR deleted files (-d with empty list)"
 		cat ar.out
 	fi
 
@@ -162,16 +162,16 @@ test8()
 
 test9()
 {
-	ROD ar -cr"$MOD" lib.a $TST_DATAROOT/file1.in $TST_DATAROOT/file3.in
-	ROD ar -ri"$MOD" file3.in lib.a $TST_DATAROOT/file2.in
-	ROD ar -t lib.a \> ar.out
+	ROD $AR -cr"$MOD" lib.a $TST_DATAROOT/file1.in $TST_DATAROOT/file3.in
+	ROD $AR -ri"$MOD" file3.in lib.a $TST_DATAROOT/file2.in
+	ROD $AR -t lib.a \> ar.out
 
 	printf "file1.in\nfile2.in\nfile3.in\n" > ar.exp
 
 	if diff ar.out ar.exp >/dev/null; then
-		tst_res TPASS "ar added new file before another (-i)"
+		tst_res TPASS "$AR added new file before another (-i)"
 	else
-		tst_res TFAIL "ar failed to add new file before another (-i"
+		tst_res TFAIL "$AR failed to add new file before another (-i"
 		cat ar.out
 	fi
 
@@ -180,17 +180,17 @@ test9()
 
 test10()
 {
-	ROD ar -cr"$MOD" lib.a $TST_DATAROOT/file1.in $TST_DATAROOT/file3.in \
+	ROD $AR -cr"$MOD" lib.a $TST_DATAROOT/file1.in $TST_DATAROOT/file3.in \
 			       $TST_DATAROOT/file2.in
-	ROD ar -mi"$MOD" file3.in lib.a file2.in
-	ROD ar -t lib.a \> ar.out
+	ROD $AR -mi"$MOD" file3.in lib.a file2.in
+	ROD $AR -t lib.a \> ar.out
 
 	printf "file1.in\nfile2.in\nfile3.in\n" > ar.exp
 
 	if diff ar.out ar.exp > /dev/null; then
-		tst_res TPASS "ar moved file correctly (-mi)"
+		tst_res TPASS "$AR moved file correctly (-mi)"
 	else
-		tst_res TFAIL "ar failed to move file (-mi)"
+		tst_res TFAIL "$AR failed to move file (-mi)"
 		cat ar.out
 	fi
 
@@ -199,17 +199,17 @@ test10()
 
 test11()
 {
-	ROD ar -cr"$MOD" lib.a $TST_DATAROOT/file1.in $TST_DATAROOT/file3.in \
+	ROD $AR -cr"$MOD" lib.a $TST_DATAROOT/file1.in $TST_DATAROOT/file3.in \
 			       $TST_DATAROOT/file2.in
-	ROD ar -m"$MOD" lib.a file3.in
-	ROD ar -t lib.a \> ar.out
+	ROD $AR -m"$MOD" lib.a file3.in
+	ROD $AR -t lib.a \> ar.out
 
 	printf "file1.in\nfile2.in\nfile3.in\n" > ar.exp
 
 	if diff ar.out ar.exp > /dev/null; then
-		tst_res TPASS "ar moved file correctly (-m)"
+		tst_res TPASS "$AR moved file correctly (-m)"
 	else
-		tst_res TFAIL "ar failed to move file (-m)"
+		tst_res TFAIL "$AR failed to move file (-m)"
 		cat ar.out
 	fi
 
@@ -218,16 +218,16 @@ test11()
 
 test12()
 {
-	ROD ar -cr"$MOD" lib.a $TST_DATAROOT/file1.in $TST_DATAROOT/file2.in \
+	ROD $AR -cr"$MOD" lib.a $TST_DATAROOT/file1.in $TST_DATAROOT/file2.in \
 			       $TST_DATAROOT/file3.in
-	ROD ar -p"$MOD" lib.a \> ar.out
+	ROD $AR -p"$MOD" lib.a \> ar.out
 
 	printf "This is file one\nThis is file two\nThis is file three\n" > ar.exp
 
 	if diff ar.out ar.exp > /dev/null; then
-		tst_res TPASS "ar printed file content correctly (-p)"
+		tst_res TPASS "$AR printed file content correctly (-p)"
 	else
-		tst_res TFAIL "ar failed to print file content (-p)"
+		tst_res TFAIL "$AR failed to print file content (-p)"
 		cat ar.out
 	fi
 
@@ -237,17 +237,17 @@ test12()
 test13()
 {
 
-	ROD ar -cr"$MOD" lib.a $TST_DATAROOT/file1.in $TST_DATAROOT/file2.in \
+	ROD $AR -cr"$MOD" lib.a $TST_DATAROOT/file1.in $TST_DATAROOT/file2.in \
 			       $TST_DATAROOT/file3.in
-	ROD ar -q"$MOD" lib.a $TST_DATAROOT/file4.in
-	ROD ar -t lib.a \> ar.out
+	ROD $AR -q"$MOD" lib.a $TST_DATAROOT/file4.in
+	ROD $AR -t lib.a \> ar.out
 
 	printf "file1.in\nfile2.in\nfile3.in\nfile4.in\n" > ar.exp
 
 	if diff ar.out ar.exp > /dev/null; then
-		tst_res TPASS "ar appended file correctly (-q)"
+		tst_res TPASS "$AR appended file correctly (-q)"
 	else
-		tst_res TFAIL "ar failed to append file (-q)"
+		tst_res TFAIL "$AR failed to append file (-q)"
 		cat ar.out
 	fi
 
@@ -257,28 +257,28 @@ test13()
 test14()
 {
 	ROD touch file0.in
-	ROD ar -cr"$MOD" lib.a file0.in $TST_DATAROOT/file1.in
+	ROD $AR -cr"$MOD" lib.a file0.in $TST_DATAROOT/file1.in
 
-	file0_mtime1=$(ar -tv lib.a | grep file0.in)
-	file1_mtime1=$(ar -tv lib.a | grep file1.in)
+	file0_mtime1=$($AR -tv lib.a | grep file0.in)
+	file1_mtime1=$($AR -tv lib.a | grep file1.in)
 
 	touch -c -t $(date --date='next day' +"%Y%m%d%H%M") file0.in
 
-	ROD ar -ru"$MOD" lib.a file0.in $TST_DATAROOT/file1.in
+	ROD $AR -ru"$MOD" lib.a file0.in $TST_DATAROOT/file1.in
 
-	file0_mtime2=$(ar -tv lib.a | grep file0.in)
-	file1_mtime2=$(ar -tv lib.a | grep file1.in)
+	file0_mtime2=$($AR -tv lib.a | grep file0.in)
+	file1_mtime2=$($AR -tv lib.a | grep file1.in)
 
 	if [ "$file0_mtime1" = "$file0_mtime2" ]; then
-		tst_res TFAIL "ar haven't updated modified file0 (-u)"
+		tst_res TFAIL "$AR haven't updated modified file0 (-u)"
 	else
-		tst_res TPASS "ar updated modified file0 (-u)"
+		tst_res TPASS "$AR updated modified file0 (-u)"
 	fi
 
 	if [ "$file1_mtime1" = "$file1_mtime2" ]; then
-		tst_res TPASS "ar haven't updated unmodified file1 (-u)"
+		tst_res TPASS "$AR haven't updated unmodified file1 (-u)"
 	else
-		tst_res TFAIL "ar updated unmodified file1 (-u)"
+		tst_res TFAIL "$AR updated unmodified file1 (-u)"
 	fi
 
 	ROD rm lib.a file0.in
@@ -286,13 +286,13 @@ test14()
 
 test15()
 {
-	ROD ar -cr"$MOD" lib.a $TST_DATAROOT/file1.in
-	ROD ar -tv lib.a \> ar.out
+	ROD $AR -cr"$MOD" lib.a $TST_DATAROOT/file1.in
+	ROD $AR -tv lib.a \> ar.out
 
 	if grep -q '[rwx-]\{9\} [0-9].*/[0-9].*\s*[0-9].*.*file1.in' ar.out; then
-		tst_res TPASS "ar verbose listing works (-tv)"
+		tst_res TPASS "$AR verbose listing works (-tv)"
 	else
-		tst_res TFAIL "ar verbose listing failed (-tv)"
+		tst_res TFAIL "$AR verbose listing failed (-tv)"
 		cat ar.out
 	fi
 
@@ -301,23 +301,23 @@ test15()
 
 test16()
 {
-	ROD ar -cr"$MOD" lib.a $TST_DATAROOT/file1.in $TST_DATAROOT/file2.in \
+	ROD $AR -cr"$MOD" lib.a $TST_DATAROOT/file1.in $TST_DATAROOT/file2.in \
 			       $TST_DATAROOT/file3.in
-	ROD ar -xv"$MOD" lib.a \> ar.out
+	ROD $AR -xv"$MOD" lib.a \> ar.out
 
 	printf "x - file1.in\nx - file2.in\nx - file3.in\n" > ar.exp
 
 	if diff ar.out ar.exp > /dev/null; then
-		tst_res TPASS "ar printed extracted filenames (-xv)"
+		tst_res TPASS "$AR printed extracted filenames (-xv)"
 	else
-		tst_res TFAIL "ar failed to print extracted filenames (-xv)"
+		tst_res TFAIL "$AR failed to print extracted filenames (-xv)"
 		cat ar.out
 	fi
 
 	if [ -e file1.in -a -e file2.in -a -e file3.in ]; then
-		tst_res TPASS "ar extracted files correctly"
+		tst_res TPASS "$AR extracted files correctly"
 	else
-		tst_res TFAIL "ar failed to extract files"
+		tst_res TFAIL "$AR failed to extract files"
 	fi
 
 	ROD rm -f lib.a file1.in file2.in file3.in
@@ -325,22 +325,22 @@ test16()
 
 test17()
 {
-	ROD ar -cr"$MOD" lib.a $TST_DATAROOT/file1.in $TST_DATAROOT/file2.in
-	ROD ar -xv"$MOD" lib.a file2.in \> ar.out
+	ROD $AR -cr"$MOD" lib.a $TST_DATAROOT/file1.in $TST_DATAROOT/file2.in
+	ROD $AR -xv"$MOD" lib.a file2.in \> ar.out
 
 	printf "x - file2.in\n" > ar.exp
 
 	if diff ar.out ar.exp > /dev/null; then
-		tst_res TPASS "ar printed extracted filename (-xv)"
+		tst_res TPASS "$AR printed extracted filename (-xv)"
 	else
-		tst_res TFAIL "ar failed to print extracted filename (-xv)"
+		tst_res TFAIL "$AR failed to print extracted filename (-xv)"
 		cat ar.out
 	fi
 
 	if [ -e file2.in ]; then
-		tst_res TPASS "ar extracted file correctly"
+		tst_res TPASS "$AR extracted file correctly"
 	else
-		tst_res TFAIL "ar failed to extract file"
+		tst_res TFAIL "$AR failed to extract file"
 	fi
 
 	ROD rm -f lib.a file2.in
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
