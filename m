Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 007F9CD8C8E
	for <ltp@archiver.kernel.org>; Mon,  8 Jun 2026 05:52:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7FEA53E2B49
	for <ltp@archiver.kernel.org>; Mon,  8 Jun 2026 07:51:59 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8E8C63E2FBC
 for <ltp@lists.linux.it>; Mon,  8 Jun 2026 07:50:30 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8791E601B06
 for <ltp@lists.linux.it>; Mon,  8 Jun 2026 07:50:27 +0200 (CEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6573jNWQ2688319
 for <ltp@lists.linux.it>; Mon, 8 Jun 2026 05:50:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=tM9dTmwdXW8l9q1Pq
 P2Gymjwh5QYI4XaqX/G3SjiPQ0=; b=rxnRSfzdGbdqttlNsPbx9GTmxraGQZpju
 fUTVHldY3pSI5hzRUUAn3LhrROAKqOFlWJSw2XnEl2dIighPhQUb8p4/e0O3AUpf
 yoLIJc8L+WBZVjPGbCVa5MuKK4ABhN0zOA/nbHiENjHF6hQ2RYSKbfR/Jz4DTmNT
 rV9VWJj8zBH2zd43sQwiHOQeh/qdRCFfdx696HrqRs+X921+AnPoUpe2Xt0Bt9ft
 AwebzJP2UGEMOtlx8sPzVBOmqLSqjoOGoZ2SlfwLDtp1AXRoLuFIGR98D1yrE4AV
 Cw6TVeGaptqpeeDugkUt9K1KUbGAXSvYPKqMmeZFtKnsj4nG7djXQ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4em9ydwun8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Mon, 08 Jun 2026 05:50:25 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6585nhbV010037
 for <ltp@lists.linux.it>; Mon, 8 Jun 2026 05:50:24 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4emwvpv593-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Mon, 08 Jun 2026 05:50:24 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6585oKRc34144684
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 8 Jun 2026 05:50:21 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D193C2004E;
 Mon,  8 Jun 2026 05:50:20 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E30B020043;
 Mon,  8 Jun 2026 05:50:19 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.59.193])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  8 Jun 2026 05:50:19 +0000 (GMT)
From: Praveen K Pandey <praveen@linux.ibm.com>
To: ltp@lists.linux.it
Date: Mon,  8 Jun 2026 11:20:00 +0530
Message-ID: <20260608055000.97154-6-praveen@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260608055000.97154-1-praveen@linux.ibm.com>
References: <20260608055000.97154-1-praveen@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA0OSBTYWx0ZWRfX5DDIpAAID1FF
 OYGnMND7bIDC4h+e9jnWoluSNKWfs0sFzYzUpr5VpcwbV/KzMRAbEpk8tK7yNN6ZES/lkZqlUBX
 ZzmZudwST5ESAVqnYJrMwp9cG+YDh7a3xkjVvDs7NnA3lywFRE/M4UtrDzenyZpDMmBtkb54gc2
 Hu1PJwKeOAD1Tt/dBg4wR0IyOV75n9Fg9Az7yy6L2ipdy+r0ApyqUb3+u8WMwB/sixt7sg8re4b
 qPwbHzAxm1G3UqQxfSFoPslES/yI43pkTdKW3KNmGSTVtxKsaJIU43gx1r4znJKPCx+mGJREwoj
 tQ3pifyLSKe+L5yS3RmT3/L0J5drcpseNZtPlSYEDapNPrGCsOuxOslj7IOv9Hp+gSRY4pvtS36
 NrXyIaBVEm+VT4+rTo+G2KR0+34isWKn7LhId2uTuMiRSjcTkEeSTqQck72WkkMdPSzobXiURRp
 eMyifOXuzln0kLI82oQ==
X-Authority-Analysis: v=2.4 cv=QKhYgALL c=1 sm=1 tr=0 ts=6a265821 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=mDV3o1hIAAAA:8 a=VnNF1IyMAAAA:8 a=omOdbC7AAAAA:8
 a=20KFwNOVAAAA:8 a=ZtHy18rBVLDLlMXXZOMA:9 a=4igKEMDFYJo9P7Gc:21
X-Proofpoint-GUID: iX-p99JalSXLwk4EqUoKkwvRHQz_tTlP
X-Proofpoint-ORIG-GUID: iX-p99JalSXLwk4EqUoKkwvRHQz_tTlP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_01,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080049
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [LTP PATCH v4 5/5] ftrace: Remove obsolete shell test files
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

Remove the old shell-based test implementations that have been
converted to C:
- ftrace_lib.sh
- ftrace_regression01.sh
- ftrace_regression02.sh
- ftrace_stress_test.sh
- ftrace_stress/*.sh (19 stress test scripts)

These are replaced by the new C implementations using LTP new API.

Signed-off-by: Praveen K Pandey <praveen@linux.ibm.com>
---
 .../kernel/tracing/ftrace_test/ftrace_lib.sh  | 180 ------------------
 .../ftrace_test/ftrace_regression01.sh        |  83 --------
 .../ftrace_test/ftrace_regression02.sh        |  63 ------
 .../ftrace_stress/ftrace_buffer_size_kb.sh    |  45 -----
 .../ftrace_stress/ftrace_current_tracer.sh    |  32 ----
 .../ftrace_stress/ftrace_ftrace_enabled.sh    |  38 ----
 .../ftrace_function_profile_enabled.sh        |  38 ----
 .../ftrace_stress/ftrace_set_event.sh         |  46 -----
 .../ftrace_stress/ftrace_set_ftrace_filter.sh | 119 ------------
 .../ftrace_stress/ftrace_set_ftrace_pid.sh    |  37 ----
 .../ftrace_stress/ftrace_stack_max_size.sh    |  27 ---
 .../ftrace_stress/ftrace_stack_trace.sh       |  35 ----
 .../ftrace_test/ftrace_stress/ftrace_trace.sh |  25 ---
 .../ftrace_stress/ftrace_trace_clock.sh       |  27 ---
 .../ftrace_stress/ftrace_trace_options.sh     |  58 ------
 .../ftrace_stress/ftrace_trace_pipe.sh        |  45 -----
 .../ftrace_stress/ftrace_trace_stat.sh        |  38 ----
 .../ftrace_stress/ftrace_tracing_cpumask.sh   |  91 ---------
 .../ftrace_stress/ftrace_tracing_enabled.sh   |  38 ----
 .../ftrace_tracing_max_latency.sh             |  27 ---
 .../ftrace_stress/ftrace_tracing_on.sh        |  38 ----
 .../tracing/ftrace_test/ftrace_stress_test.sh | 121 ------------
 22 files changed, 1251 deletions(-)
 delete mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_lib.sh
 delete mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_regression01.sh
 delete mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_regression02.sh
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
 delete mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress_test.sh

diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_lib.sh b/testcases/kernel/tracing/ftrace_test/ftrace_lib.sh
deleted file mode 100755
index 5f8f8a2c4..000000000
--- a/testcases/kernel/tracing/ftrace_test/ftrace_lib.sh
+++ /dev/null
@@ -1,180 +0,0 @@
-#!/bin/sh
-
-###########################################################################
-##                                                                       ##
-## Copyright (c) 2010 FUJITSU LIMITED                                    ##
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
-## Author: Li Zefan <lizf@cn.fujitsu.com>                                ##
-##                                                                       ##
-###########################################################################
-
-. test.sh
-
-ftrace_test_init()
-{
-	export TPATH="$PWD"
-	export SPATH="$TPATH/ftrace_stress"
-
-	if grep -q debugfs /proc/mounts; then
-		export DEBUGFS_PATH=/sys/kernel/debug/
-		export TRACING_PATH="$DEBUGFS_PATH/tracing"
-		debugfs_def_mounted=1
-	else
-		tst_tmpdir
-		export DEBUGFS_PATH="$PWD/debugfs"
-		export TRACING_PATH="$PWD/debugfs/tracing"
-		mkdir $DEBUGFS_PATH
-		mount -t debugfs xxx $DEBUGFS_PATH
-	fi
-
-	TST_CLEANUP=clean_up
-
-	trap clean_up_exit INT
-
-	tst_require_root
-
-	# Check to see tracing feature is supported or not
-	if [ ! -d $TRACING_PATH ]; then
-		tst_brkm TCONF "Tracing is not supported. Skip the test..."
-	fi
-
-	save_old_setting
-}
-
-test_interval=$1
-
-save_old_setting()
-{
-	cd $TRACING_PATH
-
-	old_trace_options=`cat trace_options`
-	old_tracing_on=`cat tracing_on`
-	old_buffer_size=`cat buffer_size_kb`
-	old_tracing_cpumask=`cat tracing_cpumask`
-
-	if [ -e tracing_cpumask ]; then
-		old_tracing_cpumask=`cat tracing_cpumask`
-	fi
-
-	if [ -e tracing_enabled ]; then
-		old_tracing_enabled=`cat tracing_enabled`
-	fi
-
-	if [ -e stack_max_size ]; then
-		old_stack_tracer_enabled=`cat /proc/sys/kernel/stack_tracer_enabled`
-	fi
-
-	if [ -e "/proc/sys/kernel/ftrace_enabled" ]; then
-		old_ftrace_enabled=`cat /proc/sys/kernel/ftrace_enabled`
-	fi
-
-	if [ -e "function_profile_enabled" ]; then
-		old_profile_enabled=`cat function_profile_enabled`
-	fi
-
-	setting_saved=1
-
-	cd - > /dev/null
-}
-
-restore_old_setting()
-{
-	if [ ! "$setting_saved" = 1 ]; then
-		return
-	fi
-
-	cd $TRACING_PATH
-
-	echo nop > current_tracer
-	echo 0 > events/enable
-	if [ -e tracing_max_latency ]; then
-		echo 0 > tracing_max_latency
-	fi
-
-	if [ -e tracing_cpumask ]; then
-		echo $old_tracing_cpumask > tracing_cpumask
-	fi
-
-	if [ -e trace_clock ]; then
-		echo local > trace_clock
-	fi
-
-	if [ -e "function_pofile_enabled" ]; then
-		echo $old_profile_enabled > function_profile_enabled
-	fi
-
-	if [ -e "/proc/sys/kernel/ftrace_enabled" ]; then
-		echo $old_ftrace_enabled > /proc/sys/kernel/ftrace_enabled
-	fi
-
-	if [ -e stack_max_size ]; then
-		echo $old_stack_tracer_enabled > /proc/sys/kernel/stack_tracer_enabled
-		echo 0 > stack_max_size
-	fi
-
-	echo $old_buffer_size > buffer_size_kb
-	echo $old_tracing_on > tracing_on
-
-	if [ -e tracing_enabled ]; then
-		echo $old_tracing_enabled > tracing_enabled
-	fi
-
-	for option in $old_trace_options; do
-		echo $option > trace_options 2> /dev/null
-	done
-
-	echo > trace
-
-	if [ -f set_ftrace_filter ]; then
-		echo  > set_ftrace_filter
-	fi
-
-	cd - > /dev/null
-}
-
-clean_up_mount()
-{
-	if [ ! "$debugfs_def_mounted" = "1" ]; then
-		umount $DEBUGFS_PATH
-		rmdir $DEBUGFS_PATH
-	fi
-}
-
-clean_up()
-{
-	restore_old_setting
-	clean_up_mount
-}
-
-clean_up_exit()
-{
-	restore_old_setting
-	clean_up_mount
-	exit 1
-}
-
-test_begin()
-{
-	start_time=`date +%s`
-}
-
-test_wait()
-{
-	# run the test for $test_interval secs
-	tst_sleep ${test_interval}s
-}
-
-ftrace_test_init
diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_regression01.sh b/testcases/kernel/tracing/ftrace_test/ftrace_regression01.sh
deleted file mode 100755
index d6969cfc6..000000000
--- a/testcases/kernel/tracing/ftrace_test/ftrace_regression01.sh
+++ /dev/null
@@ -1,83 +0,0 @@
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
-## Author: Li Wang <liwang@redhat.com>                                   ##
-##                                                                       ##
-###########################################################################
-##                                                                       ##
-## Summary:  panic while using userstacktrace                            ##
-##                                                                       ##
-## BUG: unable to handle kernel paging request at 00000000417683c0       ##
-##      IP: [<ffffffff8105c834>] update_curr+0x124/0x1e0                 ##
-##      PGD 41a796067 PUD 0                                              ##
-##      Thread overran stack, or stack corrupted                         ##
-##      Oops: 0000 [#1] SMP                                              ##
-##      last sysfs file: ../system/cpu/cpu15/cache/index2/shared_cpu_map ##
-##                                                                       ##
-## The bug was fixed by:                                                 ##
-##      1dbd195 (tracing: Fix preempt count leak)                        ##
-##                                                                       ##
-###########################################################################
-
-export TCID="ftrace_regression01"
-export TST_TOTAL=1
-
-. ftrace_lib.sh
-
-LOOP=10
-
-TSTACK_TRACE_PATH="/proc/sys/kernel/stack_tracer_enabled"
-EXC_PAGE_FAULT_ENABLE="$TRACING_PATH/events/exceptions/page_fault_kernel/enable"
-MM_PAGE_FAULT_ENABLE="$TRACING_PATH/events/kmem/mm_kernel_pagefault/enable"
-
-ftrace_userstacktrace_test()
-{
-	if [ ! -e "$TSTACK_TRACE_PATH" ]; then
-		tst_brkm TCONF "Stack Tracer is not cofigured in This kernel"
-	fi
-
-	for i in $(seq $LOOP); do
-		echo 1 >  $TSTACK_TRACE_PATH
-		echo userstacktrace > $TRACING_PATH/trace_options
-		grep -q "^userstacktrace"  $TRACING_PATH/trace_options
-		if [ $? -ne 0 ]; then
-			tst_brkm TBROK "Failed to set userstacktrace"
-		fi
-
-		if [ -f "$EXC_PAGE_FAULT_ENABLE" ]; then
-			exc_page_fault_enable=`cat $EXC_PAGE_FAULT_ENABLE`
-			echo 1 > $EXC_PAGE_FAULT_ENABLE
-		else
-			mm_page_fault_enable=`cat $MM_PAGE_FAULT_ENABLE`
-			echo 1 > $MM_PAGE_FAULT_ENABLE
-		fi
-	done
-
-	if [ -f "$EXC_PAGE_FAULT_ENABLE" ]; then
-		echo "$exc_page_fault_enable" > $EXC_PAGE_FAULT_ENABLE
-	else
-		echo "$mm_page_fault_enable" > $MM_PAGE_FAULT_ENABLE
-	fi
-
-	tst_resm TPASS "Finished running the test"
-}
-
-ftrace_userstacktrace_test
-
-tst_exit
diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_regression02.sh b/testcases/kernel/tracing/ftrace_test/ftrace_regression02.sh
deleted file mode 100755
index 3c32f219e..000000000
--- a/testcases/kernel/tracing/ftrace_test/ftrace_regression02.sh
+++ /dev/null
@@ -1,63 +0,0 @@
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
-## Author: Li Wang <liwang@redhat.com>                                   ##
-##                                                                       ##
-###########################################################################
-##                                                                       ##
-## Summary: check signal:signal_generate gives 2 more fields: grp res    ##
-##                                                                       ##
-## This testcase is writing for signal events change:                    ##
-##       6c303d3 tracing: let trace_signal_generate() report more info...##
-##       163566f tracing: send_sigqueue() needs trace_signal_generate()  ##
-##                                                                       ##
-###########################################################################
-
-export TCID="ftrace_regression02"
-export TST_TOTAL=1
-
-. ftrace_lib.sh
-
-ftrace_signal_test()
-{
-	# Set envent
-	echo 'signal:signal_generate' > $TRACING_PATH/set_event
-	echo 1 > $TRACING_PATH/tracing_on
-	echo > $TRACING_PATH/trace
-
-	# just to generate trace
-	for i in $(seq 100); do
-		ls -l /proc > /dev/null 2>&1
-	done
-
-	grep -q 'grp=[0-9] res=[0-9]' $TRACING_PATH/trace
-	if [ $? -eq 0 ]; then
-		tst_resm TPASS "finished running the test."
-	else
-		tst_resm TFAIL "running the test failed, please check log message."
-	fi
-}
-
-if tst_kvcmp -lt "3.2"; then
-	tst_brkm TCONF "The test should be run in kernels >= 3.2.0 Skip the test..."
-fi
-
-ftrace_signal_test
-
-tst_exit
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
diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress_test.sh b/testcases/kernel/tracing/ftrace_test/ftrace_stress_test.sh
deleted file mode 100755
index 159ba1a66..000000000
--- a/testcases/kernel/tracing/ftrace_test/ftrace_stress_test.sh
+++ /dev/null
@@ -1,121 +0,0 @@
-#! /bin/sh
-
-###########################################################################
-##                                                                       ##
-## Copyright (c) 2010 FUJITSU LIMITED                                    ##
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
-## Author: Li Zefan <lizf@cn.fujitsu.com>                                ##
-##                                                                       ##
-###########################################################################
-
-export TCID="ftrace-stress-test"
-export TST_TOTAL=1
-export TST_COUNT=1
-
-. ftrace_lib.sh
-
-test_targets=" \
-trace_pipe current_tracer ftrace_enabled function_profile_enabled \
-set_event set_ftrace_pid stack_max_size stack_trace trace trace_clock \
-trace_options trace_stat tracing_enabled tracing_max_latency \
-tracing_on function_profile_enabled buffer_size_kb tracing_cpumask \
-set_ftrace_filter"
-
-get_skip_targets()
-{
-	NR_PIDS=0
-	for target in ${test_targets}; do
-		if [ ! -e $TRACING_PATH/$target ] &&
-			[ ! -e /proc/sys/kernel/$target ]; then
-			eval skip_$target=1
-			tst_resm TINFO "$target is not supported. Skip it."
-		else
-			eval skip_$target=0
-			NR_PIDS=$((NR_PIDS + 1))
-		fi
-	done
-	# Export it before sub case is lanuched.
-	export NR_PIDS
-}
-
-should_skip_target()
-{
-	local skip_var=skip_$1
-	eval local skip_val=\$${skip_var}
-	[ "$skip_val" = 1 ]
-}
-
-test_kill()
-{
-	tst_resm TINFO "killing ${pid0}"
-	kill -USR1 ${pid0}
-	wait ${pid0}
-
-	local p=1;
-	while [ $p -lt $NR_PIDS ]; do
-		local pid_var=pid${p}
-		eval local kill_pid=\$${pid_var}
-		tst_resm TINFO "killing ${kill_pid}"
-		kill -KILL $kill_pid
-		wait ${kill_pid}
-		p=$((p + 1))
-	done
-}
-
-test_stress()
-{
-	local index=0;
-
-	tst_resm TINFO "Test targets: ${test_targets}"
-
-	get_skip_targets
-	for target in ${test_targets}; do
-		if should_skip_target $target; then
-			continue
-		fi
-		sh ftrace_${target}.sh &
-		eval pid${index}=$!
-		tst_resm TINFO "Start pid${index}=$! $SPATH/ftrace_${target}.sh"
-		index=$((index + 1))
-	done
-	export_pids
-}
-
-export_pids()
-{
-	local p=0
-	while [ $p -lt $NR_PIDS ]; do
-		export pid${p}
-		p=$((p + 1))
-	done
-}
-
-cd ftrace_stress/
-# ----------------------------
-tst_resm TINFO "Ftrace Stress Test Begin"
-
-test_begin
-
-test_stress
-
-test_wait
-
-test_kill
-
-tst_resm TINFO "Finished running the test. Run dmesg to double-check for bugs"
-
-tst_exit
-
-- 
2.50.1

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
