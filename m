Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E5A2C3DA7D
	for <ltp@archiver.kernel.org>; Tue, 27 Dec 2022 08:19:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2656C3CB838
	for <ltp@archiver.kernel.org>; Tue, 27 Dec 2022 09:19:39 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3B1A03CB80E
 for <ltp@lists.linux.it>; Tue, 27 Dec 2022 09:19:28 +0100 (CET)
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com
 [85.158.142.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 1A2901000646
 for <ltp@lists.linux.it>; Tue, 27 Dec 2022 09:19:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1672129165; i=@fujitsu.com;
 bh=APioyppkZY2RyzCkaG9s1efOh0S8knZw96wKwj/oZjk=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=NqMPhfdLMZibPIeYlBJ1ctTdIV+tijyqW81bwutN+5cdsCx24a86CrpZVbTd69SC3
 Ky6SdtVxhfjhQIiuaV8E10XYYP8dpAkSCVQ9cm7KnbJfVZiD53ROmeNPoJBROLrwsw
 FOjCHP3C00+zu4LsXAUslX/2X8TQqPBKxGgj/l+B7zgW74qesgFibB53FfukefLv+u
 L8DdPQRvdFrWRNaHOVc9BGp3yAPpOZaw/MknXKmJoSXBRNIdJthzAtmNyEs1LH6kpz
 W020KmPyPujtJBDU5GvDsStXlbAFs5vXLdop32UXooUwkddMjop7AtfwJW4NEoqvmM
 59VPJTO+GwH3Q==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDIsWRWlGSWpSXmKPExsViZ8ORpNu7alW
 ywZcDAhYrvu9gdGD02Pd7HWsAYxRrZl5SfkUCa8blRaeZC/ZJVXxof87WwPhbtIuRi0NI4BSj
 xMEdyxghnD1MEqvn/WSHchgl7v5ezNTFyMnBJqAp8axzATOILSIgIdHR8JYdxGYWUJdYPukXW
 I2wgJvEtqnrwGwWAVWJxnsP2UBsXgFPiba3G8HqJQQUJKY8fM8MEReUODnzCQvEHAmJgy9eME
 PUKEpc6vjGCGFXSMya1cYEYatJXD23iXkCI/8sJO2zkLQvYGRaxWhenFpUllqka2isl1SUmZ5
 RkpuYmaOXWKWbqJdaqpuXX1SSoWuol1herJdaXKxXXJmbnJOil5dasokRGJApxakSOxgblv/R
 O8QoycGkJMor1b0qWYgvKT+lMiOxOCO+qDQntfgQowwHh5IEr8EKoJxgUWp6akVaZg4wOmDSE
 hw8SiK855YBpXmLCxJzizPTIVKnGHU5Pv65uJdZiCUvPy9VSpxXcyVQkQBIUUZpHtwIWKReYp
 SVEuZlZGBgEOIpSC3KzSxBlX/FKM7BqCTMuxfkEp7MvBK4Ta+AjmACOuLDoZUgR5QkIqSkGpj
 aHI+bLJnw0PVC+ONrFUsYThj9/3Z9gXu0w7yCC/2KE/j93X2cE6zX5WqkZnPJbcj7sMFd52uK
 VsN0r835p44yrF/td2uKWFirMOvOD9/PaLvozhKbZ/Dr2O+9tdMPru7tZtj5OSMibSKn8pWn1
 mKxtSZ3LYzO+5uvmnHr7lXZfcahO6329l+/sL9eXk/+xakwhi8zwm98Dn1qf+VAkmZxRFBP/F
 cn9f7kxP11gQL8EX9Sgtkyl7cXrlosk5az20KsrvfjfdnUg38FfRhvs9vuCSuoWi0grH9vd7p
 N8ezZCn2zDnHoqN+6MG23u7HTR391jknrOK2nT9Jbr7q3dZG/0o43uk/8Ol4ruwd2mSixFGck
 GmoxFxUnAgAN7MjZTwMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-11.tower-732.messagelabs.com!1672129164!519824!1
X-Originating-IP: [62.60.8.98]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.101.2; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 5778 invoked from network); 27 Dec 2022 08:19:25 -0000
Received: from unknown (HELO n03ukasimr03.n03.fujitsu.local) (62.60.8.98)
 by server-11.tower-732.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 27 Dec 2022 08:19:25 -0000
Received: from n03ukasimr03.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTP id AA5931B1
 for <ltp@lists.linux.it>; Tue, 27 Dec 2022 08:19:24 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126
 [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTPS id 9F5C37B
 for <ltp@lists.linux.it>; Tue, 27 Dec 2022 08:19:24 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Tue, 27 Dec 2022 08:19:22 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Tue, 27 Dec 2022 17:20:11 +0800
Message-ID: <1672132813-26636-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/3] shell: Remove old kernel version check below 3.10
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

We have raised the minimal kernel version from 3.0 to 3.10,
so remove these useless check.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 doc/shell-test-api.txt                           |  6 +++---
 .../tracing/dynamic_debug/dynamic_debug01.sh     | 16 ++++------------
 testcases/network/virt/virt_lib.sh               |  8 --------
 3 files changed, 7 insertions(+), 23 deletions(-)

diff --git a/doc/shell-test-api.txt b/doc/shell-test-api.txt
index 7f0ca02a7..df6a56874 100644
--- a/doc/shell-test-api.txt
+++ b/doc/shell-test-api.txt
@@ -661,9 +661,9 @@ if tst_kvcmp -le 4.0.0; then
 	tst_brk TCONF "Kernel newer than 4.0.0 is needed"
 fi
 
-# Exit the test if kernel is newer than 3.8 and older than 4.0.1
-if tst_kvcmp -gt 3.8 -a -lt 4.0.1; then
-	tst_brk TCONF "Kernel must be older than 3.8 or newer than 4.0.1"
+# Exit the test if kernel is newer than 3.16 and older than 4.0.1
+if tst_kvcmp -gt 3.16 -a -lt 4.0.1; then
+	tst_brk TCONF "Kernel must be older than 3.16 or newer than 4.0.1"
 fi
 -------------------------------------------------------------------------------
 
diff --git a/testcases/kernel/tracing/dynamic_debug/dynamic_debug01.sh b/testcases/kernel/tracing/dynamic_debug/dynamic_debug01.sh
index 9d0575b90..ebb961fd9 100755
--- a/testcases/kernel/tracing/dynamic_debug/dynamic_debug01.sh
+++ b/testcases/kernel/tracing/dynamic_debug/dynamic_debug01.sh
@@ -21,8 +21,7 @@ DEBUGFS_WAS_MOUNTED=0
 DEBUGFS_PATH=""
 DEBUGFS_CONTROL=""
 DYNDEBUG_STATEMENTS="./debug_statements"
-EMPTY_FLAG="-"
-NEW_INTERFACE=0
+EMPTY_FLAG="=_"
 
 mount_debugfs()
 {
@@ -55,11 +54,6 @@ setup()
 		tst_brk TBROK "Unable to find $DEBUGFS_CONTROL"
 	fi
 
-	if tst_kvcmp -ge 3.4 ; then
-		NEW_INTERFACE=1
-		EMPTY_FLAG="=_"
-	fi
-
 	grep -v "^#" "$DEBUGFS_CONTROL" > "$DYNDEBUG_STATEMENTS"
 }
 
@@ -83,10 +77,8 @@ do_all_flags()
 
 	for INPUT_LINE in $ALL_INPUTS; do
 		do_flag "+p" "$OPTION" "$INPUT_LINE"
-		if tst_kvcmp -ge 3.2 || [ $NEW_INTERFACE -eq 1 ] ; then
-			do_flag "+flmt" "$OPTION" "$INPUT_LINE"
-			do_flag "-flmt" "$OPTION" "$INPUT_LINE"
-		fi
+		do_flag "+flmt" "$OPTION" "$INPUT_LINE"
+		do_flag "-flmt" "$OPTION" "$INPUT_LINE"
 		do_flag "-p" "$OPTION" "$INPUT_LINE"
 	done
 
@@ -131,7 +123,7 @@ cleanup()
 		FLAGS_SET=$(awk -v emp="$EMPTY_FLAG" '$3 != emp' $DYNDEBUG_STATEMENTS)
 	fi
 	if [ "$FLAGS_SET" ] ; then
-		FLAG_PREFIX=$([ $NEW_INTERFACE -eq 1 ] && echo "" || echo "+")
+		FLAG_PREFIX=$(echo "")
 		/bin/echo "$FLAGS_SET" | while read -r FLAG_LINE ; do
 			/bin/echo -n "$FLAG_LINE" \
 				| awk -v prf="$FLAG_PREFIX" -F " |:" \
diff --git a/testcases/network/virt/virt_lib.sh b/testcases/network/virt/virt_lib.sh
index 98a9bb6aa..e919bc3a5 100644
--- a/testcases/network/virt/virt_lib.sh
+++ b/testcases/network/virt/virt_lib.sh
@@ -44,10 +44,6 @@ virt_lib_setup()
 {
 	case "$virt_type" in
 	vxlan|geneve)
-		if tst_kvcmp -lt "3.8"; then
-			tst_brk TCONF "test must be run with kernel 3.8 or newer"
-		fi
-
 		if [ "$TST_IPV6" ] && tst_kvcmp -lt "3.12"; then
 			tst_brk TCONF "test must be run with kernels >= 3.12"
 		fi
@@ -252,10 +248,6 @@ virt_minimize_timeout()
 
 vxlan_setup_subnet_uni()
 {
-	if tst_kvcmp -lt "3.10"; then
-		tst_brk TCONF "test must be run with kernel 3.10 or newer"
-	fi
-
 	[ "$(ip link add type $virt_type help 2>&1 | grep remote)" ] || \
 		tst_brk TCONF "iproute doesn't support remote unicast address"
 
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
