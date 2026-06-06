Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10DD8CD8C8C
	for <ltp@archiver.kernel.org>; Sat,  6 Jun 2026 14:33:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4F55C3E487E
	for <ltp@archiver.kernel.org>; Sat,  6 Jun 2026 16:33:35 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4057D3E5FCA
 for <ltp@lists.linux.it>; Sat,  6 Jun 2026 16:32:00 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E6B3B1A00163
 for <ltp@lists.linux.it>; Sat,  6 Jun 2026 16:31:58 +0200 (CEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 656Do1fK048509 for <ltp@lists.linux.it>; Sat, 6 Jun 2026 14:31:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=nyYlSHkvKylMF3qn2
 Joi7XBX0DhUbp6Wenm/0F/T+6E=; b=mQSoN0mH0tMiH8+xWUqm8zB8wx8OS7ixu
 q09DqGQTNzGZEKSzDAKKGoUsa1erG5xI94MJzsxyVkCggs1Tlwf040kf/k91+l1j
 ORxHLUNU/pz+BDlEJgK7xoMpzAf7iBQ903Z9RfjejrHVchqk+do6cFlqDs2iHn5f
 +rr6iJsfZqVan8/hHIEyfw2Y6PAEpmvmiSgF1AJUjmxnrh0OsI58P8PsfkeLyAJH
 0Z8EIVDpucmAw91FqvBj9TnPw7KkPTpBy2l3bZ34M3SUsFFZt/vEGMGZ/zjzr/gU
 ek25cxhygpjWWcLSw2oU3nuElai8pycvC6eMumETh6N2Wun2dSANg==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb6sh84s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sat, 06 Jun 2026 14:31:57 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 656EJamJ001158
 for <ltp@lists.linux.it>; Sat, 6 Jun 2026 14:31:56 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egb7kp0t8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sat, 06 Jun 2026 14:31:56 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 656EVqSb51380734
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 6 Jun 2026 14:31:53 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C277420043;
 Sat,  6 Jun 2026 14:31:52 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0B43120040;
 Sat,  6 Jun 2026 14:31:52 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.127.204])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sat,  6 Jun 2026 14:31:51 +0000 (GMT)
From: Praveen K Pandey <praveen@linux.ibm.com>
To: ltp@lists.linux.it
Date: Sat,  6 Jun 2026 20:01:33 +0530
Message-ID: <20260606143133.89156-6-praveen@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260606143133.89156-1-praveen@linux.ibm.com>
References: <20260606143133.89156-1-praveen@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ga1HgqRQ0sm1a6eAofWlWDh098wE37z6
X-Proofpoint-GUID: ga1HgqRQ0sm1a6eAofWlWDh098wE37z6
X-Authority-Analysis: v=2.4 cv=ZbEt8MVA c=1 sm=1 tr=0 ts=6a242f5d cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=mDV3o1hIAAAA:8 a=omOdbC7AAAAA:8 a=20KFwNOVAAAA:8
 a=DEjTvvicV2kvzwgV7XYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA2MDE0NCBTYWx0ZWRfX+QjVhwRMtJEm
 z6/6ccz1q+TbSXVmcGVyiHLyPO9YGiF6DwjjbAxWDiGJ2f5aa1RSSCpLIhkcGesUmoI6/WCRfd6
 CweAGZjIryUeMjSe7Oc5XdMMUHEHK1+jeiYWD1DHRp2V/2zsyTdfj5NzytGQzzPXEPuBFEKucZV
 njysogFtE3a0FOTP4Wb0hZ1Kh/eO9bUyMlkvAfDfNt/NnpNH+xgT994pdRtPkjIYL2t39nk88Lh
 cmLcRFartKF5PsdeBY8sP/k01MWE8pWM62XzHWELb0s4s3pIgTTxoxiwpNK6sB3AzubUjz/sIwg
 NFxiHXq3qhOTGDjBuDaglL2gkm/F/JlBzUrXJ1f1KBex6UWy1juTix/4ABVhAaXlQWbiN7DnkOo
 aXq0Gq97nXauAU+Q2lcQaxYFQFLTyxkEtQgcRHsbjYOpRr7x3//Cg6uuo7koxIXPczL6E7HvfVC
 QOg9q4JUjghs5JTYsKQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-06_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1011 adultscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606060144
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [LTP PATCH 5/5] ftrace: Remove obsolete shell scripts from
 ftrace_stress folder
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

The ftrace_stress_test.c implementation provides all the functionality
of the individual shell scripts in the ftrace_stress/ folder, but with
better performance, error handling, and maintainability.

The C implementation uses pthreads to run all stress tests concurrently
in a single process, eliminating the need for 18 separate shell scripts.

This removal simplifies the codebase and reduces maintenance burden.
---
 .../ftrace_stress/ftrace_buffer_size_kb.sh    |  45 -------
 .../ftrace_stress/ftrace_current_tracer.sh    |  32 -----
 .../ftrace_stress/ftrace_ftrace_enabled.sh    |  38 ------
 .../ftrace_function_profile_enabled.sh        |  38 ------
 .../ftrace_stress/ftrace_set_event.sh         |  46 -------
 .../ftrace_stress/ftrace_set_ftrace_filter.sh | 119 ------------------
 .../ftrace_stress/ftrace_set_ftrace_pid.sh    |  37 ------
 .../ftrace_stress/ftrace_stack_max_size.sh    |  27 ----
 .../ftrace_stress/ftrace_stack_trace.sh       |  35 ------
 .../ftrace_test/ftrace_stress/ftrace_trace.sh |  25 ----
 .../ftrace_stress/ftrace_trace_clock.sh       |  27 ----
 .../ftrace_stress/ftrace_trace_options.sh     |  58 ---------
 .../ftrace_stress/ftrace_trace_pipe.sh        |  45 -------
 .../ftrace_stress/ftrace_trace_stat.sh        |  38 ------
 .../ftrace_stress/ftrace_tracing_cpumask.sh   |  91 --------------
 .../ftrace_stress/ftrace_tracing_enabled.sh   |  38 ------
 .../ftrace_tracing_max_latency.sh             |  27 ----
 .../ftrace_stress/ftrace_tracing_on.sh        |  38 ------
 18 files changed, 804 deletions(-)
 delete mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_buffer_size_kb.sh
 delete mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_current_tracer.sh
 delete mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_ftrace_enabled.sh
 delete mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_function_profile_enabled.sh
 delete mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_set_event.sh
 delete mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_set_ftrace_filter.sh
 delete mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_set_ftrace_pid.sh
 delete mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_stack_max_size.sh
 delete mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_stack_trace.sh
 delete mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace.sh
 delete mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_clock.sh
 delete mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_options.sh
 delete mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_pipe.sh
 delete mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_stat.sh
 delete mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_tracing_cpumask.sh
 delete mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_tracing_enabled.sh
 delete mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_tracing_max_latency.sh
 delete mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_tracing_on.sh

diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_buffer_size_kb.sh b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_buffer_size_kb.sh
deleted file mode 100755
index 665291406..000000000
--- a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_buffer_size_kb.sh
+++ /dev/null
@@ -1,45 +0,0 @@
-#! /bin/sh
-
-###############################################################################
-#                                                                             #
-# Copyright (c) 2010 FUJITSU LIMITED                                          #
-#                                                                             #
-# This program is free software; you can redistribute it and/or modify it     #
-# under the terms of the GNU General Public License as published by the Free  #
-# Software Foundation; either version 2 of the License, or (at your option)   #
-# any later version.                                                          #
-#                                                                             #
-# Author: Li Zefan <lizf@cn.fujitsu.com>                                      #
-#                                                                             #
-###############################################################################
-
-LOOP=200
-
-# Use up to 10% of free memory
-free_mem=`cat /proc/meminfo | grep '^MemFree' | awk '{ print $2 }'`
-cpus=`tst_ncpus`
-
-step=$(( $free_mem / 10 / $LOOP / $cpus ))
-
-if [ $step -eq 0 ]; then
-	step=1
-	LOOP=50
-fi
-
-while true; do
-	new_size=1
-	i=0
-	while [ $i -lt $LOOP ]; do
-		echo $new_size > "$TRACING_PATH"/buffer_size_kb
-		new_size=$(( $new_size + $step ))
-		i=$((i + 1))
-	done
-
-	i=0
-	while [ $i -lt $LOOP ]; do
-		new_size=$(( $new_size - $step ))
-		echo $new_size > "$TRACING_PATH"/buffer_size_kb
-		i=$((i + 1))
-	done
-	sleep 1
-done
diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_current_tracer.sh b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_current_tracer.sh
deleted file mode 100755
index 104b57750..000000000
--- a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_current_tracer.sh
+++ /dev/null
@@ -1,32 +0,0 @@
-#! /bin/sh
-
-###############################################################################
-#                                                                             #
-# Copyright (c) 2010 FUJITSU LIMITED                                          #
-#                                                                             #
-# This program is free software; you can redistribute it and/or modify it     #
-# under the terms of the GNU General Public License as published by the Free  #
-# Software Foundation; either version 2 of the License, or (at your option)   #
-# any later version.                                                          #
-#                                                                             #
-# Author: Li Zefan <lizf@cn.fujitsu.com>                                      #
-#                                                                             #
-###############################################################################
-
-LOOP=200
-
-while true; do
-	i=0
-	while [ $i -lt $LOOP ]; do
-		for tracer in `cat "$TRACING_PATH"/available_tracers`
-		do
-			if [ "$tracer" = mmiotrace ]; then
-				continue
-			fi
-
-			echo $tracer > "$TRACING_PATH"/current_tracer 2> /dev/null
-		done
-		i=$((i + 1))
-	done
-	sleep 1
-done
diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_ftrace_enabled.sh b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_ftrace_enabled.sh
deleted file mode 100755
index c6f8b48df..000000000
--- a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_ftrace_enabled.sh
+++ /dev/null
@@ -1,38 +0,0 @@
-#! /bin/sh
-
-###############################################################################
-#                                                                             #
-# Copyright (c) 2010 FUJITSU LIMITED                                          #
-#                                                                             #
-# This program is free software; you can redistribute it and/or modify it     #
-# under the terms of the GNU General Public License as published by the Free  #
-# Software Foundation; either version 2 of the License, or (at your option)   #
-# any later version.                                                          #
-#                                                                             #
-# Author: Li Zefan <lizf@cn.fujitsu.com>                                      #
-#                                                                             #
-###############################################################################
-
-MAX_LOOP=1500
-count=0
-
-while true; do
-	count=$(( $count + 1 ))
-	i=0
-	while [ $i -lt $MAX_LOOP ]; do
-		echo 0 > /proc/sys/kernel/ftrace_enabled
-		echo 1 > /proc/sys/kernel/ftrace_enabled
-		i=$((i + 1))
-	done
-
-	enable=$(( $count % 3 ))
-
-	if [ $enable -eq 0 ]; then
-		echo 1 > /proc/sys/kernel/ftrace_enabled
-	else
-		echo 0 > /proc/sys/kernel/ftrace_enabled
-	fi
-
-	sleep 1
-done
-
diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_function_profile_enabled.sh b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_function_profile_enabled.sh
deleted file mode 100755
index 7687420c7..000000000
--- a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_function_profile_enabled.sh
+++ /dev/null
@@ -1,38 +0,0 @@
-#! /bin/sh
-
-###############################################################################
-#                                                                             #
-# Copyright (c) 2010 FUJITSU LIMITED                                          #
-#                                                                             #
-# This program is free software; you can redistribute it and/or modify it     #
-# under the terms of the GNU General Public License as published by the Free  #
-# Software Foundation; either version 2 of the License, or (at your option)   #
-# any later version.                                                          #
-#                                                                             #
-# Author: Li Zefan <lizf@cn.fujitsu.com>                                      #
-#                                                                             #
-###############################################################################
-
-MAX_LOOP=1500
-count=0
-
-
-while true; do
-	count=$(( $count + 1 ))
-	i=0
-	while [ $i -lt $MAX_LOOP ]; do
-		echo 0 > "$TRACING_PATH"/function_profile_enabled 2> /dev/null
-		echo 1 > "$TRACING_PATH"/function_profile_enabled 2> /dev/null
-		i=$((i + 1))
-	done
-
-	enable=$(( $count % 3 ))
-
-	if [ $enable -eq 0 ]; then
-		echo 1 > "$TRACING_PATH"/function_profile_enabled 2> /dev/null
-	else
-		echo 0 > "$TRACING_PATH"/function_profile_enabled 2> /dev/null
-	fi
-
-	sleep 1
-done
diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_set_event.sh b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_set_event.sh
deleted file mode 100755
index 9a79b4201..000000000
--- a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_set_event.sh
+++ /dev/null
@@ -1,46 +0,0 @@
-#! /bin/sh
-
-###############################################################################
-#                                                                             #
-# Copyright (c) 2010 FUJITSU LIMITED                                          #
-#                                                                             #
-# This program is free software; you can redistribute it and/or modify it     #
-# under the terms of the GNU General Public License as published by the Free  #
-# Software Foundation; either version 2 of the License, or (at your option)   #
-# any later version.                                                          #
-#                                                                             #
-# Author: Li Zefan <lizf@cn.fujitsu.com>                                      #
-#                                                                             #
-###############################################################################
-
-while true; do
-	i=0
-	while [ $i -lt 100 ]; do
-		echo 1 > "$TRACING_PATH"/events/enable
-		echo 0 > "$TRACING_PATH"/events/enable
-		i=$((i + 1))
-	done
-
-	for dir in `ls $TRACING_PATH/events/`; do
-		if [ ! -d $dir -o "$dir" = ftrace ]; then
-			continue;
-		fi
-
-		i=0
-		while [ $i -lt 20 ]; do
-			echo 1 > "$TRACING_PATH"/events/$dir/enable
-			echo 0 > "$TRACING_PATH"/events/$dir/enable
-			i=$((i + 1))
-		done
-	done
-
-	for event in `cat $TRACING_PATH/available_events`; do
-		# ftrace event sys is special, skip it
-		if echo "$event" | grep "ftrace:*"; then
-			continue
-		fi
-		echo $event >> "$TRACING_PATH"/set_event
-	done
-
-	sleep 1
-done
diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_set_ftrace_filter.sh b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_set_ftrace_filter.sh
deleted file mode 100755
index af6ec9f05..000000000
--- a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_set_ftrace_filter.sh
+++ /dev/null
@@ -1,119 +0,0 @@
-#! /bin/sh
-###########################################################################
-##                                                                       ##
-## Copyright (c) 2015, Red Hat Inc.                                      ##
-##                                                                       ##
-## This program is free software: you can redistribute it and/or modify  ##
-## it under the terms of the GNU General Public License as published by  ##
-## the Free Software Foundation, either version 3 of the License, or     ##
-## (at your option) any later version.                                   ##
-##                                                                       ##
-## This program is distributed in the hope that it will be useful,       ##
-## but WITHOUT ANY WARRANTY; without even the implied warranty of        ##
-## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the          ##
-## GNU General Public License for more details.                          ##
-##                                                                       ##
-## You should have received a copy of the GNU General Public License     ##
-## along with this program. If not, see <http://www.gnu.org/licenses/>.  ##
-##                                                                       ##
-## Author: Chunyu Hu <chuhu@redhat.com>                                  ##
-##                                                                       ##
-###########################################################################
-
-. test.sh
-
-triggers="traceon traceoff enable_event disable_event snapshot \
-	 dump cpudump stacktrace module function"
-nr_triggers=$(echo ${triggers} | wc -w)
-
-module_pick()
-{
-	nr_module=$(lsmod | wc -l)
-	pick_one=$(tst_random 1 $nr_module)
-	picked_module=$(lsmod | awk "{if (NR == $pick_one) {print \$1}}")
-}
-
-filter_file=$TRACING_PATH/available_filter_functions
-nr_functions=$(awk 'END{print NR}' $filter_file)
-
-function_pick()
-{
-	if [ -f $filter_file ]; then
-		local pick_one=$(tst_random 1 $nr_functions)
-		picked_function=$(awk "{if (NR == $pick_one) {print \$1}}" $filter_file)
-		echo $picked_function
-	else
-		echo "\*sched\*"
-	fi
-}
-
-event_pick()
-{
-	local events_file=$TRACING_PATH/available_events
-	if [ -f $events_file ]; then
-		nr_events=$(awk 'END{print NR}' $events_file)
-		local pick_one=$(tst_random 1 $nr_events)
-		picked_event=$(awk "{if (NR == $pick_one) {print \$0}}" $events_file)
-		echo "$picked_event"
-	else
-		echo "sched:sched_switch"
-	fi
-}
-
-filter_formatter()
-{
-	function_str=$(function_pick)
-	count=$(tst_random 0 2)
-
-	case $1 in
-	traceon|traceoff|snapshot|dump|cpudump|stacktrace)
-		trigger=$1
-		;;
-	enable_event|disable_event)
-		event_sys_name=$(event_pick)
-		trigger=$1:$event_sys_name
-		;;
-	module)
-		module_pick
-		echo ":mod:$picked_module"
-		return
-		;;
-	function)
-		echo "$function_str"
-		return
-		;;
-	*)
-		trigger=$1
-		;;
-	esac
-
-	if [ $count -gt 0 ]; then
-		trigger=$trigger:$count
-	fi
-	echo $function_str:$trigger
-}
-
-signal_handler()
-{
-	tst_exit
-}
-
-trap signal_handler SIGTERM
-
-while true; do
-	# Here try to check if a race caused issue can be hit.
-	cat $TRACING_PATH/set_ftrace_filter > /dev/null
-
-	trigger_index=$(tst_random 1 $nr_triggers)
-	trigger_name=$(echo $triggers | awk "{print \$$trigger_index}")
-	filter_format=$(filter_formatter $trigger_name)
-
-	echo "$filter_format" > $TRACING_PATH/set_ftrace_filter
-	[ $? -ne 0 ] && tst_resm TFAIL "$0: setup filter <$filter_format> failed"
-
-	sleep 2
-
-	echo "!$filter_format" > $TRACING_PATH/set_ftrace_filter
-	[ $? -ne 0 ] && tst_resm TFAIL "$0: remove filter <$filter_format> failed"
-done
-
diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_set_ftrace_pid.sh b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_set_ftrace_pid.sh
deleted file mode 100755
index fd42de4f3..000000000
--- a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_set_ftrace_pid.sh
+++ /dev/null
@@ -1,37 +0,0 @@
-#! /bin/sh
-
-###############################################################################
-#                                                                             #
-# Copyright (c) 2010 FUJITSU LIMITED                                          #
-#                                                                             #
-# This program is free software; you can redistribute it and/or modify it     #
-# under the terms of the GNU General Public License as published by the Free  #
-# Software Foundation; either version 2 of the License, or (at your option)   #
-# any later version.                                                          #
-#                                                                             #
-# Author: Li Zefan <lizf@cn.fujitsu.com>                                      #
-#                                                                             #
-###############################################################################
-
-LOOP=300
-
-while true; do
-	j=0
-	while [ $j -lt $LOOP ]; do
-		k=1
-		while [ $k -le $NR_PIDS ]; do
-			str="\$pid$k"
-			eval echo $str >> "$TRACING_PATH"/set_ftrace_pid
-			k=$((k + 1))
-		done
-
-		if ! echo > "$TRACING_PATH"/set_ftrace_pid >/dev/null 2>&1; then
-			if ! echo -1 > "$TRACING_PATH"/set_ftrace_pid >/dev/null 2>&1; then
-				tst_resm TBROK "Cannot disable set_ftrace_pid!"
-				exit 1
-			fi
-		fi
-		j=$((j + 1))
-	done
-	sleep 1
-done
diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_stack_max_size.sh b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_stack_max_size.sh
deleted file mode 100755
index 0842929aa..000000000
--- a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_stack_max_size.sh
+++ /dev/null
@@ -1,27 +0,0 @@
-#! /bin/sh
-
-###############################################################################
-#                                                                             #
-# Copyright (c) 2010 FUJITSU LIMITED                                          #
-#                                                                             #
-# This program is free software; you can redistribute it and/or modify it     #
-# under the terms of the GNU General Public License as published by the Free  #
-# Software Foundation; either version 2 of the License, or (at your option)   #
-# any later version.                                                          #
-#                                                                             #
-# Author: Li Zefan <lizf@cn.fujitsu.com>                                      #
-#                                                                             #
-###############################################################################
-
-MAX_STACK_SIZE=8192
-
-while true; do
-	i=0
-	while [ $i -lt $MAX_STACK_SIZE ]; do
-		echo $i > "$TRACING_PATH"/stack_max_size
-		cat "$TRACING_PATH"/stack_max_size > /dev/null
-		i=$((i + 1))
-	done
-	sleep 1
-done
-
diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_stack_trace.sh b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_stack_trace.sh
deleted file mode 100755
index 4c16a0a1d..000000000
--- a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_stack_trace.sh
+++ /dev/null
@@ -1,35 +0,0 @@
-#! /bin/sh
-
-###############################################################################
-#                                                                             #
-# Copyright (c) 2010 FUJITSU LIMITED                                          #
-#                                                                             #
-# This program is free software; you can redistribute it and/or modify it     #
-# under the terms of the GNU General Public License as published by the Free  #
-# Software Foundation; either version 2 of the License, or (at your option)   #
-# any later version.                                                          #
-#                                                                             #
-# Author: Li Zefan <lizf@cn.fujitsu.com>                                      #
-#                                                                             #
-###############################################################################
-
-LOOP=400
-
-while true; do
-	i=0
-	while [ $i -lt $LOOP ]; do
-		cat "$TRACING_PATH"/stack_trace > /dev/null
-		i=$((i + 1))
-	done
-
-	sleep 1
-
-	i=0
-	while [ $i -lt $LOOP ]; do
-		echo 0 > /proc/sys/kernel/stack_tracer_enabled
-		echo 1 > /proc/sys/kernel/stack_tracer_enabled
-		i=$((i + 1))
-	done
-
-	sleep 1
-done
diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace.sh b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace.sh
deleted file mode 100755
index 7c45f504a..000000000
--- a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace.sh
+++ /dev/null
@@ -1,25 +0,0 @@
-#! /bin/sh
-
-###############################################################################
-#                                                                             #
-# Copyright (c) 2010 FUJITSU LIMITED                                          #
-#                                                                             #
-# This program is free software; you can redistribute it and/or modify it     #
-# under the terms of the GNU General Public License as published by the Free  #
-# Software Foundation; either version 2 of the License, or (at your option)   #
-# any later version.                                                          #
-#                                                                             #
-# Author: Li Zefan <lizf@cn.fujitsu.com>                                      #
-#                                                                             #
-###############################################################################
-
-LOOP=200
-
-i=0;
-while true; do
-	while [ $i -lt $LOOP ]; do
-		cat "$TRACING_PATH"/trace > /dev/null
-		i=$((i + 1))
-	done
-	sleep 1
-done
diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_clock.sh b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_clock.sh
deleted file mode 100755
index 50329c684..000000000
--- a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_clock.sh
+++ /dev/null
@@ -1,27 +0,0 @@
-#! /bin/sh
-
-###############################################################################
-#                                                                             #
-# Copyright (c) 2010 FUJITSU LIMITED                                          #
-#                                                                             #
-# This program is free software; you can redistribute it and/or modify it     #
-# under the terms of the GNU General Public License as published by the Free  #
-# Software Foundation; either version 2 of the License, or (at your option)   #
-# any later version.                                                          #
-#                                                                             #
-# Author: Li Zefan <lizf@cn.fujitsu.com>                                      #
-#                                                                             #
-###############################################################################
-
-LOOP=400
-
-while true; do
-	i=0
-	while [ $i -lt $LOOP ]; do
-		echo local > "$TRACING_PATH"/trace_clock
-		echo global > "$TRACING_PATH"/trace_clock
-		i=$((i + 1))
-	done
-	sleep 1
-done
-
diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_options.sh b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_options.sh
deleted file mode 100755
index 95da3f6c7..000000000
--- a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_options.sh
+++ /dev/null
@@ -1,58 +0,0 @@
-#! /bin/sh
-
-###############################################################################
-#                                                                             #
-# Copyright (c) 2010 FUJITSU LIMITED                                          #
-#                                                                             #
-# This program is free software; you can redistribute it and/or modify it     #
-# under the terms of the GNU General Public License as published by the Free  #
-# Software Foundation; either version 2 of the License, or (at your option)   #
-# any later version.                                                          #
-#                                                                             #
-# Author: Li Zefan <lizf@cn.fujitsu.com>                                      #
-#                                                                             #
-###############################################################################
-
-. test.sh
-
-LOOP=200
-
-while true; do
-	j=0
-	while [ $j -lt $LOOP ]; do
-		trace_options="$(ls $TRACING_PATH/options/)"
-		# enable the nop_test_refuse can cause an
-		# 'write error: Invalid argument'. So don't test it.
-		trace_options="$(echo $trace_options | sed 's/test_nop_refuse//')"
-		nr_trace_options=$(echo "${trace_options}" | wc -w)
-
-		option_index=$(tst_random 1 $nr_trace_options)
-		option=$(echo "$trace_options" | awk "{print \$$option_index}")
-		i=0
-		while [ $i -lt $nr_trace_options ]; do
-			n=$(tst_random 0 1)
-			opt_f="$TRACING_PATH"/options/$option
-			ret_val=0
-			if [ $n -eq 0 ]; then
-				operation="setup"
-			else
-				operation="clear"
-			fi
-			# On old kernel, some trace option dirs
-			# won't be made if the option has nothing
-			# to do with the current tracer. But on newer
-			# kernel(4.4-rc1), all option dirs will be made.
-			# So here check it to avoid 'Permision denied'
-			if [ -f $opt_f ]; then
-				echo $n > $opt_f
-				ret_val=$?
-			fi
-
-			if [ $ret_val -ne 0 ]; then
-				tst_resm TFAIL "$0: $operation trace option $option failed"
-			fi
-			i=$((i + 1))
-		done
-		j=$((j + 1))
-	done
-done
diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_pipe.sh b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_pipe.sh
deleted file mode 100755
index 7d49745ba..000000000
--- a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_pipe.sh
+++ /dev/null
@@ -1,45 +0,0 @@
-#! /bin/sh
-
-###############################################################################
-#                                                                             #
-# Copyright (c) 2010 FUJITSU LIMITED                                          #
-#                                                                             #
-# This program is free software; you can redistribute it and/or modify it     #
-# under the terms of the GNU General Public License as published by the Free  #
-# Software Foundation; either version 2 of the License, or (at your option)   #
-# any later version.                                                          #
-#                                                                             #
-# Author: Li Zefan <lizf@cn.fujitsu.com>                                      #
-#                                                                             #
-###############################################################################
-
-kill_this_pid()
-{
-	kill -KILL $this_pid
-	wait $this_pid
-	exit 0
-}
-
-trap kill_this_pid SIGUSR1
-
-LOOP=20
-
-while true; do
-	i=0
-	while [ $i -lt $LOOP ]; do
-		cat "$TRACING_PATH"/trace_pipe > /dev/null &
-		this_pid=$!
-
-		tst_sleep 200000us
-
-		kill -INT $this_pid
-		wait $this_pid
-
-		this_pid=0
-
-		tst_sleep 200000us
-
-		i=$((i + 1))
-	done
-	sleep 2
-done
diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_stat.sh b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_stat.sh
deleted file mode 100755
index f7177c988..000000000
--- a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_stat.sh
+++ /dev/null
@@ -1,38 +0,0 @@
-#! /bin/sh
-
-###############################################################################
-#                                                                             #
-# Copyright (c) 2010 FUJITSU LIMITED                                          #
-#                                                                             #
-# This program is free software; you can redistribute it and/or modify it     #
-# under the terms of the GNU General Public License as published by the Free  #
-# Software Foundation; either version 2 of the License, or (at your option)   #
-# any later version.                                                          #
-#                                                                             #
-# Author: Li Zefan <lizf@cn.fujitsu.com>                                      #
-#                                                                             #
-###############################################################################
-
-LOOP=200
-
-should_skip=0
-nr_cpus=`tst_ncpus`
-
-if [ ! -e "$TRACING_PATH"/function_profile_enabled ]; then
-        should_skip=1
-fi
-
-while true; do
-	if [ $should_skip -eq 1 ]; then
-		sleep 2
-		continue
-	fi
-	cpu=$(tst_random 0 $((nr_cpus - 1)))
-	i=0;
-	while [ $i -lt $LOOP ]; do
-		cat "$TRACING_PATH"/trace_stat/function${cpu} > /dev/null 2>&1
-		i=$((i + 1))
-	done
-
-	sleep 1
-done
diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_tracing_cpumask.sh b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_tracing_cpumask.sh
deleted file mode 100755
index aeb0d92f8..000000000
--- a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_tracing_cpumask.sh
+++ /dev/null
@@ -1,91 +0,0 @@
-#! /bin/sh
-
-###########################################################################
-##                                                                       ##
-## Copyright (c) 2015, Red Hat Inc.                                      ##
-##                                                                       ##
-## This program is free software: you can redistribute it and/or modify  ##
-## it under the terms of the GNU General Public License as published by  ##
-## the Free Software Foundation, either version 3 of the License, or     ##
-## (at your option) any later version.                                   ##
-##                                                                       ##
-## This program is distributed in the hope that it will be useful,       ##
-## but WITHOUT ANY WARRANTY; without even the implied warranty of        ##
-## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the          ##
-## GNU General Public License for more details.                          ##
-##                                                                       ##
-## You should have received a copy of the GNU General Public License     ##
-## along with this program. If not, see <http://www.gnu.org/licenses/>.  ##
-##                                                                       ##
-## Author: Chunyu Hu <chuhu@redhat.com>                                  ##
-##                                                                       ##
-###########################################################################
-
-. test.sh
-nr_cpus=`tst_ncpus`
-
-# the 32 bit integer count 32 cpus. One integer is not
-# enough to store the cpu mask for nr_cpu > 32.
-if [ $nr_cpus -gt 32 ]; then
-	group_cnt=$((nr_cpus / 32))
-	range=31
-	rem=$((nr_cpus % 32))
-	if [ $rem -ne 0 ]; then
-		range_last=$((rem -1))
-	fi
-else
-	group_cnt=1
-	range=$((nr_cpus - 1))
-fi
-
-get_test_cpumask()
-{
-	mask=""
-
-	local i=0
-	while [ $i -lt $group_cnt ]; do
-		# select count of cpu in one group, include the duplicate.
-		local set_cnt=$(tst_random 1 $((range + 1)))
-
-		local c=0
-		local temp_mask=0
-		while [ $c -lt $set_cnt ]; do
-			local group_cpuid=$(tst_random 1 $range)
-			temp_mask=$((temp_mask | $((1 << $group_cpuid))))
-			c=$((c + 1))
-		done
-
-		if  [ $i = 0 ]; then
-			mask=`echo $temp_mask | awk '{printf "%x",$0}'`
-		else
-			mask=$mask","`echo $temp_mask | awk '{printf "%x",$0}'`
-		fi
-
-		i=$((i + 1))
-	done
-
-	if [ $group_cnt -gt 1  ]; then
-		set_cnt=$(tst_random 1 $((range_last +1)))
-		c=0;
-		temp_mask=0
-		while [ $c -lt $set_cnt ]; do
-			local group_cpuid=$(tst_random 1 $range_last)
-			temp_mask=$((temp_mask | $((1 << $group_cpuid))))
-			c=$((c + 1))
-		done
-		mask=`echo $temp_mask | awk '{printf "%x",$0}'`
-	fi
-
-	echo "$mask"
-}
-
-signal_handler()
-{
-	tst_exit
-}
-
-trap signal_handler SIGTERM SIGKILL
-
-while true; do
-	get_test_cpumask > $TRACING_PATH/tracing_cpumask
-done
diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_tracing_enabled.sh b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_tracing_enabled.sh
deleted file mode 100755
index 9e0f5a7cf..000000000
--- a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_tracing_enabled.sh
+++ /dev/null
@@ -1,38 +0,0 @@
-#! /bin/sh
-
-###############################################################################
-#                                                                             #
-# Copyright (c) 2010 FUJITSU LIMITED                                          #
-#                                                                             #
-# This program is free software; you can redistribute it and/or modify it     #
-# under the terms of the GNU General Public License as published by the Free  #
-# Software Foundation; either version 2 of the License, or (at your option)   #
-# any later version.                                                          #
-#                                                                             #
-# Author: Li Zefan <lizf@cn.fujitsu.com>                                      #
-#                                                                             #
-###############################################################################
-
-MAX_LOOP=1500
-count=0
-
-while true; do
-	count=$(( $count + 1 ))
-	i=0
-	while [ $i -lt $MAX_LOOP ]; do
-		echo 0 > "$TRACING_PATH"/tracing_enabled
-		echo 1 > "$TRACING_PATH"/tracing_enabled
-		i=$((i + 1))
-	done
-
-	enable=$(( $count % 3 ))
-
-	if [ $enable -eq 0 ]; then
-		echo 0 > "$TRACING_PATH"/tracing_enabled
-	else
-		echo 1 > "$TRACING_PATH"/tracing_enabled
-	fi
-
-	sleep 1
-done
-
diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_tracing_max_latency.sh b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_tracing_max_latency.sh
deleted file mode 100755
index 4ad88910c..000000000
--- a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_tracing_max_latency.sh
+++ /dev/null
@@ -1,27 +0,0 @@
-#! /bin/sh
-
-###############################################################################
-#                                                                             #
-# Copyright (c) 2010 FUJITSU LIMITED                                          #
-#                                                                             #
-# This program is free software; you can redistribute it and/or modify it     #
-# under the terms of the GNU General Public License as published by the Free  #
-# Software Foundation; either version 2 of the License, or (at your option)   #
-# any later version.                                                          #
-#                                                                             #
-# Author: Li Zefan <lizf@cn.fujitsu.com>                                      #
-#                                                                             #
-###############################################################################
-
-MAX_LATENCY=100000
-
-while true; do
-	i=0
-	while [ $i -lt $MAX_LATENCY ]; do
-		echo $i > "$TRACING_PATH"/tracing_max_latency
-		i=$((i + 400))
-	done
-
-	sleep 1
-
-done
diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_tracing_on.sh b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_tracing_on.sh
deleted file mode 100755
index 5ae9d762c..000000000
--- a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_tracing_on.sh
+++ /dev/null
@@ -1,38 +0,0 @@
-#! /bin/sh
-
-###############################################################################
-#                                                                             #
-# Copyright (c) 2010 FUJITSU LIMITED                                          #
-#                                                                             #
-# This program is free software; you can redistribute it and/or modify it     #
-# under the terms of the GNU General Public License as published by the Free  #
-# Software Foundation; either version 2 of the License, or (at your option)   #
-# any later version.                                                          #
-#                                                                             #
-# Author: Li Zefan <lizf@cn.fujitsu.com>                                      #
-#                                                                             #
-###############################################################################
-
-MAX_LOOP=1500
-count=0
-
-while true; do
-	count=$(( $count + 1 ))
-	i=0
-	while [ $i -lt $MAX_LOOP ]; do
-		echo 0 > "$TRACING_PATH"/tracing_on
-		echo 1 > "$TRACING_PATH"/tracing_on
-		i=$((i + 1))
-	done
-
-	enable=$(( $count % 3 ))
-
-	if [ $enable -eq 0 ]; then
-		echo 0 > "$TRACING_PATH"/tracing_on
-	else
-		echo 1 > "$TRACING_PATH"/tracing_on
-	fi
-
-	sleep 1
-done
-
-- 
2.50.1 (Apple Git-155)


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
