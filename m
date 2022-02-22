Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86CFDC433F5
	for <ltp@archiver.kernel.org>; Tue, 22 Feb 2022 01:20:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9E4193CA187
	for <ltp@archiver.kernel.org>; Tue, 22 Feb 2022 02:20:09 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9052C3C8D9F
 for <ltp@lists.linux.it>; Tue, 22 Feb 2022 02:19:59 +0100 (CET)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 120941A0091E
 for <ltp@lists.linux.it>; Tue, 22 Feb 2022 02:19:56 +0100 (CET)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.53])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4K2hB94V4xz9st1
 for <ltp@lists.linux.it>; Tue, 22 Feb 2022 09:18:09 +0800 (CST)
Received: from dggpemm500004.china.huawei.com (7.185.36.219) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 22 Feb 2022 09:19:48 +0800
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 dggpemm500004.china.huawei.com (7.185.36.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 22 Feb 2022 09:19:48 +0800
To: <ltp@lists.linux.it>
Date: Tue, 22 Feb 2022 09:19:46 +0800
Message-ID: <1645492786-67242-1-git-send-email-mafeng.ma@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
X-Originating-IP: [10.175.103.112]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500004.china.huawei.com (7.185.36.219)
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syslog: Add TPASS log
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
From: Ma Feng via ltp <ltp@lists.linux.it>
Reply-To: Ma Feng <mafeng.ma@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Add TPASS log to facilitate the analysis of cases.

Signed-off-by: Ma Feng <mafeng.ma@huawei.com>
---
 testcases/kernel/syscalls/syslog/syslog01 | 7 +++++--
 testcases/kernel/syscalls/syslog/syslog03 | 3 +++
 testcases/kernel/syscalls/syslog/syslog04 | 5 ++++-
 testcases/kernel/syscalls/syslog/syslog05 | 5 ++++-
 testcases/kernel/syscalls/syslog/syslog06 | 5 ++++-
 testcases/kernel/syscalls/syslog/syslog07 | 5 ++++-
 testcases/kernel/syscalls/syslog/syslog09 | 4 ++++
 testcases/kernel/syscalls/syslog/syslog10 | 6 +++++-
 8 files changed, 33 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/syscalls/syslog/syslog01 b/testcases/kernel/syscalls/syslog/syslog01
index 2f3aea0bb..f99c44914 100755
--- a/testcases/kernel/syscalls/syslog/syslog01
+++ b/testcases/kernel/syscalls/syslog/syslog01
@@ -88,8 +88,11 @@ syslog_case1()
 
 		newvalue1=`grep -c "syslogtst: mail info test" $MAILLOG`
 		if [ "x$(( $newvalue1 - $oldvalue1 ))" != "x1" ]; then
-			status_flag=1
-		fi
+                        tst_resm TFAIL "mail info test: messages are not logged to $MAILLOG"
+                        status_flag=1
+                else
+                        tst_resm TPASS "mail info test: messages are logged to $MAILLOG"
+                fi
 	else
 		status_flag=1
 	fi
diff --git a/testcases/kernel/syscalls/syslog/syslog03 b/testcases/kernel/syscalls/syslog/syslog03
index 31b7fd66d..8e8b887eb 100755
--- a/testcases/kernel/syscalls/syslog/syslog03
+++ b/testcases/kernel/syscalls/syslog/syslog03
@@ -75,7 +75,10 @@ syslog_case3()
 
 	newvalue4=`grep -c "SYSLOG_CASE3" /var/log/messages`
 	if [ "x$(( $newvalue4 - $oldvalue4 ))" != x1 ]; then
+        tst_resm TFAIL "dameon info test: ident string is not prepended to the message"
 		status_flag=1
+        else
+                tst_resm TPASS "dameon info test: ident string is prepended to the message"
 	fi
 }
 
diff --git a/testcases/kernel/syscalls/syslog/syslog04 b/testcases/kernel/syscalls/syslog/syslog04
index d1739d32a..a551ea003 100755
--- a/testcases/kernel/syscalls/syslog/syslog04
+++ b/testcases/kernel/syscalls/syslog/syslog04
@@ -71,7 +71,10 @@ syslog_case4()
 
 	found=`grep -c "\[$log_pid\]: syslogtst: user info test." /var/log/messages`
 	if [ $found -ne 1 ]; then
-		status_flag=1
+		tst_resm TFAIL "user info test: pid is not logged with /var/log/messages"
+                status_flag=1
+        else
+                tst_resm TPASS "user info test: pid is logged with /var/log/messages"
 	fi
 }
 
diff --git a/testcases/kernel/syscalls/syslog/syslog05 b/testcases/kernel/syscalls/syslog/syslog05
index 40dd1fa1a..2350765a7 100755
--- a/testcases/kernel/syscalls/syslog/syslog05
+++ b/testcases/kernel/syscalls/syslog/syslog05
@@ -80,7 +80,10 @@ syslog_case5()
 	newvalue=`grep -c "syslogtst: info to console test." /var/log/messages`
 
 	if [ "x$(( $newvalue - $oldvalue ))" != "x1" ]; then
-		status_flag=1
+		tst_resm TFAIL "info to console test: syslog is not written to the console"
+                status_flag=1
+        else
+                tst_resm TPASS "info to console test: syslog is written to the console"
 	fi
 }
 
diff --git a/testcases/kernel/syscalls/syslog/syslog06 b/testcases/kernel/syscalls/syslog/syslog06
index 7050fd264..bcdda4737 100755
--- a/testcases/kernel/syscalls/syslog/syslog06
+++ b/testcases/kernel/syscalls/syslog/syslog06
@@ -59,7 +59,10 @@ syslog_case6()
 	restart_syslog_daemon
 
 	if ! syslogtst 6 2>/dev/null; then
-		status_flag=1
+		tst_resm TFAIL "openlog fd test: open has returned unexpected fd"
+                status_flag=1
+        else
+                tst_resm TPASS "openlog fd test: open has returned expected fd"
 	fi
 }
 
diff --git a/testcases/kernel/syscalls/syslog/syslog07 b/testcases/kernel/syscalls/syslog/syslog07
index a24c3e207..cc5f9cdf8 100755
--- a/testcases/kernel/syscalls/syslog/syslog07
+++ b/testcases/kernel/syscalls/syslog/syslog07
@@ -119,7 +119,10 @@ syslog_case7()
 	if [ $emerg -ne 1 -o $alert -ne 1 -o $crit -ne 1 -o $err -ne 1 -o \
 	     $warning -ne 1 -o $notice -ne 1 -o $info -ne 1 -o \
 	     $info -ne 1 ]; then
-		status_flag=1
+		tst_resm TFAIL "syslogtst: not all level logs logged"
+                status_flag=1
+        else
+                tst_resm TPASS "syslogtst: all level logs logged"
 	fi
 }
 
diff --git a/testcases/kernel/syscalls/syslog/syslog09 b/testcases/kernel/syscalls/syslog/syslog09
index 9cfafa840..2a67faaa4 100755
--- a/testcases/kernel/syscalls/syslog/syslog09
+++ b/testcases/kernel/syscalls/syslog/syslog09
@@ -83,12 +83,16 @@ syslog_case9()
 		tst_resm TFAIL "Expected message was not logged...."
 		status_flag=1
 		return
+        else
+                tst_resm TPASS "Expected message was logged..."
 	fi
 
 	diff2=$(( $donot_allow2 - $donot_allow1 ))
 	if [ $diff2 -ne 0 ]; then
 		tst_resm TFAIL "Unexpected message was logged..."
 		status_flag=1
+        else
+                tst_resm TPASS "Unexpected message was not logged..."
 	fi
 }
 
diff --git a/testcases/kernel/syscalls/syslog/syslog10 b/testcases/kernel/syscalls/syslog/syslog10
index 573ab755e..97f7c54cc 100755
--- a/testcases/kernel/syscalls/syslog/syslog10
+++ b/testcases/kernel/syscalls/syslog/syslog10
@@ -85,12 +85,16 @@ syslog_case10()
 		tst_resm TFAIL "Expected message was not logged...."
 		status_flag=1
 		return
-	fi
+        else
+                tst_resm TPASS "Expected message was logged..."
+        fi
 
 	diff2=$(( $donot_allow2 - $donot_allow1 ))
 	if [ $diff2 -ne 0 ]; then
 		tst_resm TFAIL "Unexpected message was logged..."
 		status_flag=1
+        else
+                tst_resm TPASS "Unexpected message was not logged..."
 	fi
 
 }
-- 
2.22.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
