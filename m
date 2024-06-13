Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2064AC27C4F
	for <ltp@archiver.kernel.org>; Thu, 13 Jun 2024 07:54:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0032E3D0C3C
	for <ltp@archiver.kernel.org>; Thu, 13 Jun 2024 09:54:30 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 94DB23D07FF
 for <ltp@lists.linux.it>; Thu, 13 Jun 2024 09:54:15 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=canonical.com (client-ip=185.125.188.120;
 helo=smtp-relay-canonical-0.canonical.com;
 envelope-from=po-hsu.lin@canonical.com; receiver=lists.linux.it)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6E97F603448
 for <ltp@lists.linux.it>; Thu, 13 Jun 2024 09:54:14 +0200 (CEST)
Received: from Phocidae.conference (1.general.phlin.uk.vpn [10.172.194.38])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 62A153F2CC; 
 Thu, 13 Jun 2024 07:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1718265251;
 bh=0izTb1R9r8XWQlQxYvz3auijb82XbQvDVAAHSYXERZM=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=vZEBdtmbXpeJpOuM6DKhcx08C+au3x4fbZlZDfrDm6MmBuPdUPJ8srUVDcdbuspHk
 rD7t8A6r5jKSow0ql+M5vfvL/dJAcrpxqHV2ULaHK2IHqWBB2MfFiujT+Z5zg70Gy0
 pu9eoG5CgQKehGaL3g3nbDE+c1OSj2ljKMvdu/1kt1/l3QeL+K4JPDr8nfpAtoxRQ+
 UpyyBJUx2msQ67WEEsk2LMUtPYnlcNN0gKFxx9mf0Ut8yzbl0wP3fY5wAFtuWr1m6y
 7o2U4xrs9d5CnewtirnNgoqnNYNFV0yHkwjFhoFJ4D3zQAH9IntloauHsD0gaPdm8I
 RKPUN82GwyRmw==
From: Po-Hsu Lin <po-hsu.lin@canonical.com>
To: ltp@lists.linux.it
Date: Thu, 13 Jun 2024 15:53:48 +0800
Message-Id: <20240613075348.696575-1-po-hsu.lin@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] logrotate: fix permission issue on Ubuntu
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

When running this logrotate test on Ubuntu, the test will fail with:
  logrotate_tests 2 TINFO: sleep 1 min to wait for rotating logs
  logrotate_tests 2 TFAIL: [ -f /var/log/tst_largelogfile.1.gz ] failed unexpectedly
  logrotate_tests 2 TFAIL: Failed to create a compressed file

Look more closely to what this test is trying to do we will see there
are two issues here in the tst_largelog.conf:

1. "include /etc/logrotate.d"
This will rotate other log files defined here, since we are just testing
the log rotation capibility I think there is no need to rotate log files
other than the one for this test.

2. Permission issue on Ubuntu
Trying to rotate the target file on Ubuntu will cause the following error:
  error: skipping "/var/log/tst_largelogfile" because parent directory has
         insecure permissions (It's world writable or writable by group which
         is not "root") Set "su" directive in config file to tell logrotate
         which user/group should be used for rotation.

Solution is to add an extra line with the user and group information of
the /var/log directory. This change has been limited to Ubuntu to prevent
causing regression on other OS.

Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
---
 testcases/commands/logrotate/logrotate_tests.sh | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/testcases/commands/logrotate/logrotate_tests.sh b/testcases/commands/logrotate/logrotate_tests.sh
index 1f3e61294..4506ab5c6 100755
--- a/testcases/commands/logrotate/logrotate_tests.sh
+++ b/testcases/commands/logrotate/logrotate_tests.sh
@@ -90,14 +90,17 @@ test1()
 
 test2()
 {
+	permission=""
+	if `grep -q 'NAME="Ubuntu"' /etc/os-release 2>/dev/null`; then
+		permission="su `stat -c "%U %G" /var/log`"
+	fi
 	cat >tst_largelog.conf <<-EOF
         # create new (empty) log files after rotating old ones
         create
         # compress the log files
         compress
-        # RPM packages drop log rotation information into this directory
-        include /etc/logrotate.d
         /var/log/tst_largelogfile {
+            $permission
             rotate 5
             size=2k
         }
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
