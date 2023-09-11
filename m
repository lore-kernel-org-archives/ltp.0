Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9BCBEE57DF
	for <ltp@archiver.kernel.org>; Mon, 11 Sep 2023 12:04:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5E71C3CE87C
	for <ltp@archiver.kernel.org>; Mon, 11 Sep 2023 14:04:23 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9CECD3CB3D4
 for <ltp@lists.linux.it>; Mon, 11 Sep 2023 14:04:12 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 891EF1001170
 for <ltp@lists.linux.it>; Mon, 11 Sep 2023 14:04:11 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D9A2421836;
 Mon, 11 Sep 2023 12:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1694433850; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=x6VHcMh3DsdwDwgu0YvcUPanl17QUiGRc1Vb1Y+3dm0=;
 b=bbsoGCgstFxWLtuXz8NZM2vXrLlNukJ8FmA9Pist0SD8FUavxGcIc1TrAuK1LqLGr+qyim
 +Iyj0XtG2lThgdipLyQHOh1TAWJ9nDvV+FB48IA+2FlZDkhUfMfwvORRzbQ4hIseia4SfF
 9C/KqS++bRbs4CgDCP2PqWsRzfSZXck=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1694433850;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=x6VHcMh3DsdwDwgu0YvcUPanl17QUiGRc1Vb1Y+3dm0=;
 b=BrUWRlmxX4Zh+XFo6MmGzfAwEZabVh9aLA9VZGaCVK8Tbbjp18Yqv+tDTEZGaDWVVZzio0
 /XE/hg9Rd/6An0CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C530E139CC;
 Mon, 11 Sep 2023 12:04:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id AVgkLzoC/2SrfAAAMHmgww
 (envelope-from <mkittler@suse.de>); Mon, 11 Sep 2023 12:04:10 +0000
From: Marius Kittler <mkittler@suse.de>
To: ltp@lists.linux.it
Date: Mon, 11 Sep 2023 14:04:08 +0200
Message-ID: <20230911120408.31921-1-mkittler@suse.de>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] Avoid messing with system tty in ioctl01.c
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

* Use `openpty()` to create a new tty
* Remove `-D` option
* Remove requirement to run as root

Signed-off-by: Marius Kittler <mkittler@suse.de>
---
 runtest/syscalls                           |  2 +-
 testcases/kernel/syscalls/ioctl/ioctl01.c  | 25 ++++++++++------------
 testcases/kernel/syscalls/ioctl/test_ioctl | 23 --------------------
 3 files changed, 12 insertions(+), 38 deletions(-)

diff --git a/runtest/syscalls b/runtest/syscalls
index b1125dd75..f999bd74f 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -557,10 +557,10 @@ init_module01 init_module01
 init_module02 init_module02
 
 #Needs tty device.
-#ioctl01 ioctl01 -D /dev/tty0
 #ioctl02 ioctl02 -D /dev/tty0
 
 # Introducing ioctl tests for all /dev/tty* devices
+ioctl01      ioctl01
 ioctl01_02   test_ioctl
 ioctl03      ioctl03
 ioctl04      ioctl04
diff --git a/testcases/kernel/syscalls/ioctl/ioctl01.c b/testcases/kernel/syscalls/ioctl/ioctl01.c
index 3ca8a9a3b..fe6a5591d 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl01.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl01.c
@@ -23,11 +23,13 @@
 #include <fcntl.h>
 #include <stdio.h>
 #include <termios.h>
+#include <pty.h>
 #include "tst_test.h"
 #include "lapi/ioctl.h"
 
 #define	INVAL_IOCTL	9999999
 
+static int amaster, aslave;
 static int fd, fd_file;
 static int bfd = -1;
 
@@ -59,8 +61,6 @@ static struct tcase {
 	{&fd, TCGETS, NULL, EFAULT}
 };
 
-static char *device;
-
 static void verify_ioctl(unsigned int i)
 {
 	TST_EXP_FAIL(ioctl(*(tcases[i].fd), tcases[i].request, tcases[i].s_tio),
@@ -69,31 +69,28 @@ static void verify_ioctl(unsigned int i)
 
 static void setup(void)
 {
-	if (!device)
-		tst_brk(TBROK, "You must specify a tty device with -D option");
+	if (openpty(&amaster, &aslave, NULL, &termios, NULL) < 0) {
+		tst_brk(TBROK | TERRNO, "unable to open pty");
+	}
 
-	fd = SAFE_OPEN(device, O_RDWR, 0777);
+	fd = amaster;
 	fd_file = SAFE_OPEN("x", O_CREAT, 0777);
 }
 
 static void cleanup(void)
 {
-	if (fd > 0)
-		SAFE_CLOSE(fd);
-
+	if (amaster > 0)
+		SAFE_CLOSE(amaster);
+	if (aslave > 0)
+		SAFE_CLOSE(aslave);
 	if (fd_file > 0)
 		SAFE_CLOSE(fd_file);
 }
 
 static struct tst_test test = {
-	.needs_root = 1,
 	.needs_tmpdir = 1,
 	.setup = setup,
 	.cleanup = cleanup,
 	.test = verify_ioctl,
-	.tcnt = ARRAY_SIZE(tcases),
-	.options = (struct tst_option[]) {
-		{"D:", &device, "Tty device. For example, /dev/tty[0-9]"},
-		{}
-	}
+	.tcnt = ARRAY_SIZE(tcases)
 };
diff --git a/testcases/kernel/syscalls/ioctl/test_ioctl b/testcases/kernel/syscalls/ioctl/test_ioctl
index 923275433..43836a229 100755
--- a/testcases/kernel/syscalls/ioctl/test_ioctl
+++ b/testcases/kernel/syscalls/ioctl/test_ioctl
@@ -34,29 +34,6 @@ has_tty()
     return 1
 }
 
-for tttype in `ls /dev/tty*`
-do
-device_no=${tttype#/dev/tty}
-case "$device_no" in
-[0-9]|[0-9][0-9])
-    has_tty $tttype
-    if [ $? -eq 0 ]; then
-        tst_resm TINFO "Skipping ioctl01 with $tttype"
-        continue
-    fi
-    tst_resm TINFO "Testing ioctl01 with $tttype"
-    ioctl01 -D $tttype
-    RC=$?
-    if  [ $RC -eq 0 ]
-    then
-     tst_resm TPASS "ioctl01 Passed with $tttype"
-    else
-     tst_resm TFAIL "ioctl01 Failed with $tttype"
-    fi
-echo;;
-esac
-done
-
 for tttype in `ls /dev/tty*`
 do
 device_no=${tttype#/dev/tty}
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
