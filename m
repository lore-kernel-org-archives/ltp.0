Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B1EEECAAD1
	for <ltp@archiver.kernel.org>; Thu,  1 Sep 2022 09:04:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EE0EE3CA81D
	for <ltp@archiver.kernel.org>; Thu,  1 Sep 2022 11:04:11 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C793F3CA070
 for <ltp@lists.linux.it>; Thu,  1 Sep 2022 11:04:01 +0200 (CEST)
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com
 [162.62.57.87])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2F00D60098F
 for <ltp@lists.linux.it>; Thu,  1 Sep 2022 11:03:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1662023035;
 bh=SUoZ//bynKPOX4pqYUZVXHRMJpkqSJjMgCcTYnkyPwM=;
 h=From:To:Cc:Subject:Date;
 b=Qo4IngZnU8075O578pjU7M5Tdd+XJOlmFUChSIy/xz1OPe1+itdOuQDkNyBJ7e7TI
 4u2QETo0vm0eqtV2MSJ1BH92LqlNKiP4bFJOM030VfwiQfbKgrSVTWhmsze+DRCUo5
 EKsC8AJpTyvNC7/3Y6IWCo7oBXp4usDSqNdCeEgQ=
Received: from localhost.localdomain ([123.52.25.162])
 by newxmesmtplogicsvrsza32.qq.com (NewEsmtp) with SMTP
 id F5A3AF9; Thu, 01 Sep 2022 17:03:53 +0800
X-QQ-mid: xmsmtpt1662023033tk3jduxb1
Message-ID: <tencent_357C210832AC0D20B4889919FC9761627505@qq.com>
X-QQ-XMAILINFO: OEgU9iHXvJ5F+K8ud2AAPnhFEnvd2UrKbd7zDCs6etDOfx0IfRrj1YZmAgrADq
 RPEho5jkegdmWiDQDSIg7plRpsTJP2DboDtxnxfothjyfrPNFfehGbH+OESRPrmzR0yvG8vcqV3w
 U2kKDgpFi+NGASnE8OcNmQEwfawRulvcLZWppc9nyoh1+4mXOmc62rNqJs8w6SQSp1cqzR3FZDUo
 /7im26oDYTNlGuBkKD58VZJWg9iDSC15Y2bEZmaMrIztYKXIwcVm72N1jb6aY+T+xfXcm5bt8ina
 Q3NxHKhQbomFswORNlRIc34EgUbQnFqKTNdqcBZsRflpA1Y01sRaMoKFcnRYLCUIxVP5+3RihwpL
 pInKgqqE28hAGT9kkR0b86JFZihsl9hfHcosHrjKppQPcv/8pzBdH236rTUxef0DVk+vqHimzzh+
 WToPSzh0BRcXnlJdCBJ0JbkLB/H+84RTARXso/UT34zicogzHRZIdvuwbun/ptsGlkU27qXhtqwC
 vFrFxFRLHnavm6hAR/10JjSV3KKj/7yDIcBtFqSZ7C8vpJU3jcu2KMzKRbHJhexiHE5QspWIkd+z
 T5hsWmDtnKynKum52teoH7A8mvxx8mhw1/rMMSXC4RseUepkDa80rSFJH9SnMzlfBuUHoSitTu/b
 WvlCzaPSMtE7Cmjnsu0gWr57u9lO1x5ypCJewoXxatnrg8Xf+1nWQY5jl9TxtJtMXzw9Rmic8Tf2
 02Cf1r4Cl8MOtOi7lU4bulIpCUFHH1UgvdP6yrsjWmbzh7rkEGc9+2rPDxIfNqkd7Nmf6jXEdEje
 i+1i9sLnp6GRGJTHGLVbU3tqiFaRYsR3LVfzMSC2J/UaKpjPoAhL5/YDibxKY4V8GA3X/4adMoGj
 yCAVBz5VmfB9kVkrWABCL4z/WXs8twyAa0sZWxfJ0/TERwi3MfL0XDEDIR4Z0jL/t+VbQt571/7n
 6mQSyBxIquIC+c3X9AwBa6hCvg+1ga2Ngw5uqZhz3K4qxw7mbWWj5+JgeHuPRwb4ZPMp8qF5rQd2
 3gF0nmb/saOLSU/ukY
From: huangjuniter@foxmail.com
To: ltp@lists.linux.it
Date: Thu,  1 Sep 2022 17:03:21 +0800
X-OQ-MSGID: <20220901090321.2437-1-huangjuniter@foxmail.com>
X-Mailer: git-send-email 2.37.2.windows.2
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] pm_include.sh: Fix calculation error of no_of_sockets
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
Cc: Jun Huang <huangjuniter@foxmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Jun Huang <huangjuniter@foxmail.com>

An error will occur when there are multiple sockets and each socket has 
more than 10 cores, resulting in the value of no_of_sockets being 1.

Signed-off-by: Jun Huang <huangjuniter@foxmail.com>
---
 testcases/kernel/power_management/pm_include.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/power_management/pm_include.sh b/testcases/kernel/power_management/pm_include.sh
index 35ff0f1e6..f3e160445 100755
--- a/testcases/kernel/power_management/pm_include.sh
+++ b/testcases/kernel/power_management/pm_include.sh
@@ -124,8 +124,8 @@ check_input() {
 
 is_multi_socket() {
 	no_of_sockets=`cat \
-		/sys/devices/system/cpu/cpu?/topology/physical_package_id \
-		| uniq | wc -l`
+		/sys/devices/system/cpu/cpu*/topology/physical_package_id \
+		| sort -u | wc -l`
 	[ $no_of_sockets -gt 1 ] ; echo $?
 }
 
-- 
2.37.2.windows.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
