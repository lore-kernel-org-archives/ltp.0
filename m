Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ABA9C27C79
	for <ltp@archiver.kernel.org>; Thu, 20 Jun 2024 03:29:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6D6773D0DFC
	for <ltp@archiver.kernel.org>; Thu, 20 Jun 2024 05:29:25 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BE9B53D0DBB
 for <ltp@lists.linux.it>; Thu, 20 Jun 2024 05:29:09 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=canonical.com (client-ip=185.125.188.120;
 helo=smtp-relay-canonical-0.canonical.com;
 envelope-from=po-hsu.lin@canonical.com; receiver=lists.linux.it)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B7AC41001295
 for <ltp@lists.linux.it>; Thu, 20 Jun 2024 05:29:08 +0200 (CEST)
Received: from Phocidae.conference (1.general.phlin.uk.vpn [10.172.194.38])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 6A4C53F2E2; 
 Thu, 20 Jun 2024 03:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1718854147;
 bh=UWr2N75G9KYz+mzgf4e9eupyA5moCKkvd+0vrPjT7B4=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=UJ/dO1MSjzb6UtzWTgAhgMFpKnfxIBal0P/9mKYC3hiWY6JwiMZc7TttSX2zx9q1i
 eJFsjHepflc6DPitcAgSwKcRaH6PMPWHKhx8sNVw4kIfQ6CXELK4Y0LK1YRsd+Qz8H
 wYGt80kYQERcAiWj1xozhKvHwQ8tNHYHgU/ieJ9jb2jZBbZ4eoUSkRj2X1bEEZhRKC
 P9KHyBudK7SBA1fD+Oq89dpaB0eL+oE840I/bw5mRcDOaXp5tmmXqcLWsLTi5peTzK
 vbXAnqgo8M7IOSBvMnAkDr/V6LD/0h5v/m5x2tyJ4X15rmcOP+xhP5KXG9X1RGnZu9
 ynGcfzqQ6eqeQ==
From: Po-Hsu Lin <po-hsu.lin@canonical.com>
To: ltp@lists.linux.it
Date: Thu, 20 Jun 2024 11:27:37 +0800
Message-Id: <20240620032737.1421923-1-po-hsu.lin@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCHv2] logrotate: fix permission issue for test2
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
Cc: po-hsu.lin@canonical.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

When running this logrotate test on Ubuntu, this test will fail with:
  logrotate_tests 2 TINFO: sleep 1 min to wait for rotating logs
  logrotate_tests 2 TFAIL: [ -f /var/log/tst_largelogfile.1.gz ] failed unexpectedly
  logrotate_tests 2 TFAIL: Failed to create a compressed file

Look more closely to what this test is trying to do we will see there
are two issues here in the tst_largelog.conf:

1. "include /etc/logrotate.d"
This will rotate other log files defined here, since we are just testing
the log rotation capability I think there is no need to rotate log files
other than the testfile itself.

2. Permission issue
Trying to rotate the target file on Ubuntu will cause the following error:
  error: skipping "/var/log/tst_largelogfile" because parent directory has
         insecure permissions (It's world writable or writable by group which
         is not "root") Set "su" directive in config file to tell logrotate
         which user/group should be used for rotation.

Fix these by removing the extra include, reuse the existing user/group
setting for test1 with setup() as suggested by Petr Vorel.

Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
---
 .../commands/logrotate/logrotate_tests.sh      | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/testcases/commands/logrotate/logrotate_tests.sh b/testcases/commands/logrotate/logrotate_tests.sh
index 1f3e61294..c382fd1e4 100755
--- a/testcases/commands/logrotate/logrotate_tests.sh
+++ b/testcases/commands/logrotate/logrotate_tests.sh
@@ -25,7 +25,16 @@ TST_NEEDS_CMDS="crontab file grep logrotate"
 TST_TESTFUNC=test
 TST_NEEDS_TMPDIR=1
 TST_CNT=2
+TST_SETUP=setup
 TST_CLEANUP=cleanup
+PERMISSION=
+
+setup()
+{
+	local group="syslog"
+	grep -q $group /etc/group || group="root"
+	PERMISSION="su root $group"
+}
 
 cleanup()
 {
@@ -47,10 +56,6 @@ check_log()
 
 test1()
 {
-	local group="syslog"
-
-	grep -q $group /etc/group || group="root"
-
 	cat >tst_logrotate.conf <<-EOF
         #****** Begin Config file *******
         # create new (empty) log files after rotating old ones
@@ -60,7 +65,7 @@ test1()
         compress
 
         /var/log/tst_logfile {
-                su root $group
+                $PERMISSION
                 rotate 5
                 weekly
         }
@@ -95,9 +100,8 @@ test2()
         create
         # compress the log files
         compress
-        # RPM packages drop log rotation information into this directory
-        include /etc/logrotate.d
         /var/log/tst_largelogfile {
+            $PERMISSION
             rotate 5
             size=2k
         }
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
