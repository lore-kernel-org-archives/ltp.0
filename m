Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E59C3D690E4
	for <ltp@archiver.kernel.org>; Thu, 28 Nov 2024 07:29:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4D56A3DBABD
	for <ltp@archiver.kernel.org>; Thu, 28 Nov 2024 08:29:01 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E756C3DBA8C
 for <ltp@lists.linux.it>; Thu, 28 Nov 2024 08:28:45 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=canonical.com (client-ip=185.125.188.120;
 helo=smtp-relay-canonical-0.canonical.com;
 envelope-from=po-hsu.lin@canonical.com; receiver=lists.linux.it)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C78A9140BD35
 for <ltp@lists.linux.it>; Thu, 28 Nov 2024 08:28:44 +0100 (CET)
Received: from Phocidae.conference (1.general.phlin.uk.vpn [10.172.194.38])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 07E8E3F78F; 
 Thu, 28 Nov 2024 07:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1732778923;
 bh=0iHQfJ5R1KwcDpbaeNACSb6U8g9gHPmrRdwXGgbj3h4=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=YaoXJwjiL4y4ahaqIYcaT4IQ3gVW8V6Zk7e6g7uBFBhwStA5rpU4/AIy7ZCBUsgMW
 R+a6em3dZXYCI9Y9yuO7joBU+2EzdOsscZQ+C0oNxW5Kg+aLumWqPmNLJTzv+CjMTf
 SbQBOA9tOsAZhmbkPtbcgiCuWC+Ixt2V7DDwNlMvhFegS2qCfMs4vjCP7AOYWo05uJ
 CVmDadpaBPBiMTuW5oDAAkh/HCnKxLfb2VRoECoNP0KN1E4C4/eXoz4dDrsC8eStR6
 kFXiiWF75NTVC5X/lAfXFnO9CA1Ru4Mt38CbGdHXlDGuVtru3GpGC5DCk2LwpRB9sr
 NQzax6u2rXQZQ==
From: Po-Hsu Lin <po-hsu.lin@canonical.com>
To: ltp@lists.linux.it
Date: Thu, 28 Nov 2024 15:28:19 +0800
Message-Id: <20241128072820.364726-1-po-hsu.lin@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] logrotate: support new rotate debug message
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

This test was found failing on Ubuntu Oracular with:
    grep -q forced from command line (5 rotations) tst_logrotate.out
    failed unexpectedly

This is because the logrotate debug message has been changed in upstream:
https://github.com/logrotate/logrotate/commit/be6a263c87

Include the new debug message to fix this issue.

Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
---
 testcases/commands/logrotate/logrotate_tests.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/commands/logrotate/logrotate_tests.sh b/testcases/commands/logrotate/logrotate_tests.sh
index 0aa9f12e1..1cd355f02 100755
--- a/testcases/commands/logrotate/logrotate_tests.sh
+++ b/testcases/commands/logrotate/logrotate_tests.sh
@@ -90,7 +90,7 @@ test1()
 	ROD logrotate -fv tst_logrotate.conf > tst_logrotate.out 2>&1
 
 	EXPECT_PASS grep -q "reading config file tst_logrotate.conf" tst_logrotate.out
-	EXPECT_PASS grep -q "forced from command line (5 rotations)" tst_logrotate.out
+	EXPECT_PASS grep -E -q "forced from command line (5 rotations)|forced from command line empty log files are rotated, \(5 rotations\)" tst_logrotate.out
 	EXPECT_PASS grep -E -q "compressing new|log with" tst_logrotate.out
 
 	check_log /var/log/tst_logfile.1.gz
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
