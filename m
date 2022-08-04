Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B1D8C19F2C
	for <ltp@archiver.kernel.org>; Thu,  4 Aug 2022 07:41:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 987663C926F
	for <ltp@archiver.kernel.org>; Thu,  4 Aug 2022 09:41:24 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0CF5D3C885D
 for <ltp@lists.linux.it>; Thu,  4 Aug 2022 09:41:11 +0200 (CEST)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 17C271A0088B
 for <ltp@lists.linux.it>; Thu,  4 Aug 2022 09:41:08 +0200 (CEST)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.57])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Lz0wV2ccCzmVLF
 for <ltp@lists.linux.it>; Thu,  4 Aug 2022 15:39:06 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.63) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 4 Aug 2022 15:41:04 +0800
To: <ltp@lists.linux.it>
Date: Thu, 4 Aug 2022 15:38:05 +0800
Message-ID: <20220804073805.196537-1-zhaogongyi@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.67.174.63]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] cpuhotplug*.sh: Check return value of
 online_cpu/offline_cpu
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
From: Zhao Gongyi via ltp <ltp@lists.linux.it>
Reply-To: Zhao Gongyi <zhaogongyi@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

We need to check the return value of online_cpu() and offline_cpu()
although it is always success.

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
 .../hotplug/cpu_hotplug/functional/cpuhotplug02.sh   | 10 ++++++++--
 .../hotplug/cpu_hotplug/functional/cpuhotplug05.sh   |  9 +++++++--
 .../hotplug/cpu_hotplug/functional/cpuhotplug06.sh   |  5 ++++-
 .../hotplug/cpu_hotplug/functional/cpuhotplug07.sh   | 12 ++++++------
 4 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug02.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug02.sh
index f12aabc72..ba274db01 100755
--- a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug02.sh
+++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug02.sh
@@ -90,7 +90,10 @@ until [ $LOOP_COUNT -gt $HOTPLUG02_LOOPS ]; do
 	set_affinity ${SPIN_LOOP_PID} ${CPU_TO_TEST}

 	# Verify the process migrated to the CPU we intended it to go to
-	offline_cpu ${CPU_TO_TEST}
+	if ! offline_cpu ${CPU_TO_TEST}; then
+		tst_brkm TBROK "CPU${CPU_TO_TEST} cannot be offlined"
+	fi
+
 	NEW_CPU=`ps --pid=${SPIN_LOOP_PID} -o psr --no-headers`
 	if [ -z "${NEW_CPU}" ]; then
 		tst_brkm TBROK "PID ${SPIN_LOOP_PID} no longer running"
@@ -101,7 +104,10 @@ until [ $LOOP_COUNT -gt $HOTPLUG02_LOOPS ]; do
 	fi

 	# Turn the CPU back online just to see what happens.
-	online_cpu ${CPU_TO_TEST}
+	if ! online_cpu ${CPU_TO_TEST}; then
+		tst_brkm TBROK "CPU${CPU_TO_TEST} cannot be onlined"
+	fi
+
 	LOOP_COUNT=$((LOOP_COUNT+1))
 done

diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug05.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug05.sh
index 2feb8d9ff..1eb204f4e 100755
--- a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug05.sh
+++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug05.sh
@@ -36,7 +36,9 @@ EOF
 do_clean()
 {
 	pid_is_valid ${SAR_PID} && kill_pid ${SAR_PID}
-	online_cpu "$CPU_TO_TEST"
+	if ! online_cpu ${CPU_TO_TEST}; then
+		tst_brkm TBROK "CPU${CPU_TO_TEST} cannot be onlined"
+	fi
 }

 get_field()
@@ -149,7 +151,10 @@ until [ $LOOP_COUNT -gt $HOTPLUG05_LOOPS ]; do
 		tst_exit
 	fi

-	offline_cpu ${CPU_TO_TEST}
+	if ! offline_cpu ${CPU_TO_TEST}; then
+		tst_brkm TBROK "CPU${CPU_TO_TEST} cannot be offlined"
+	fi
+
 	kill_pid ${SAR_PID}

 	LOOP_COUNT=$((LOOP_COUNT+1))
diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug06.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug06.sh
index 319c66537..b9c1889d3 100755
--- a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug06.sh
+++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug06.sh
@@ -99,7 +99,10 @@ until [ $LOOP_COUNT -gt $HOTPLUG06_LOOPS ]; do
 		tst_exit
 	fi

-	online_cpu ${CPU_TO_TEST}
+	if ! online_cpu ${CPU_TO_TEST}; then
+		tst_brkm TBROK "CPU${CPU_TO_TEST} cannot be onlined"
+	fi
+
 	kill_pid ${TOP_PID}

 	LOOP_COUNT=$((LOOP_COUNT+1))
diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug07.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug07.sh
index 0d2dec7fe..af170f1cc 100755
--- a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug07.sh
+++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug07.sh
@@ -100,9 +100,9 @@ until [ $LOOP_COUNT -gt $HOTPLUG07_LOOPS ]; do
 	# Move spin_loop.sh to the CPU to offline.
 	set_affinity ${KCOMPILE_LOOP_PID} ${CPU_TO_TEST}

-	offline_cpu ${CPU_TO_TEST}
-	RC=$?
-	echo "Offlining cpu${CPU_TO_TEST}: Return Code = ${RC}"
+	if ! offline_cpu ${CPU_TO_TEST}; then
+		tst_brkm TBROK "CPU${CPU_TO_TEST} cannot be offlined"
+	fi

 	NEW_CPU=`ps --pid=${KCOMPILE_LOOP_PID} -o psr --no-headers`
 	if [ -z "${NEW_CPU}" ]; then
@@ -113,9 +113,9 @@ until [ $LOOP_COUNT -gt $HOTPLUG07_LOOPS ]; do
 		tst_exit
 	fi

-	online_cpu ${CPU_TO_TEST}
-	RC=$?
-	echo "Onlining cpu${CPU_TO_TEST}: Return Code = ${RC}"
+	if ! online_cpu ${CPU_TO_TEST}; then
+		tst_brkm TBROK "CPU${CPU_TO_TEST} cannot be onlined"
+	fi

 	LOOP_COUNT=$((LOOP_COUNT+1))

--
2.17.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
