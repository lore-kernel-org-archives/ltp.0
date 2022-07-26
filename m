Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1576C00144
	for <ltp@archiver.kernel.org>; Tue, 26 Jul 2022 22:15:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8E50E3C2824
	for <ltp@archiver.kernel.org>; Wed, 27 Jul 2022 00:15:10 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 039933C2297
 for <ltp@lists.linux.it>; Wed, 27 Jul 2022 00:14:16 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 60B471400747
 for <ltp@lists.linux.it>; Wed, 27 Jul 2022 00:14:15 +0200 (CEST)
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 64EAC3F12F
 for <ltp@lists.linux.it>; Tue, 26 Jul 2022 22:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1658873653;
 bh=09PLHaH2fA6Q9kLpKKswDghZk0sUAqN4tNNvv4jx4Ak=;
 h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=IKe6a/KjRRvQ42Pqnwhav23UplFo8vZXqk3dLwsJK5q7W9Axz64L50Vk9UXy22j1t
 FS8fHQlDIXndM1qW0OOHJdUQeOT1aMnyIZz/Euaa8QUs2IGqJoNniYgHeVBHu/0n5U
 nRqiDFZdu2ct6UChXgfw/QAwDMkP/pCGdypU1iZuIUqkOBnN6i7oW+g3WG9SykIRwx
 mm+Rs3dHgYAoMuhJ4pG0YFuSUXyLs1QByNjtYfrLPV0cNizd9AuYpCdoQRQe6WPSJw
 6JwoSn654NMWR16uzKQp1sigaY7K9k7z1XOLd1s8PZGrzHaKs4agH3YYdv1zAZ6auH
 lWFxi6IR6caHA==
Received: by mail-pl1-f198.google.com with SMTP id
 u4-20020a170902e5c400b0016d6a70a282so4661809plf.10
 for <ltp@lists.linux.it>; Tue, 26 Jul 2022 15:14:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc;
 bh=09PLHaH2fA6Q9kLpKKswDghZk0sUAqN4tNNvv4jx4Ak=;
 b=FlVixIXbLNDMcNc39w+eN26uMFBo656YwpKibGIDb9F7+yV722N7/2p78ywUzihkjm
 8DSdoFDeYpW+NSUVW4QcmsMna3lfBpN81xnbW+M9uvwvCevj+GsI6pQ8maI+kwXUtz56
 w7XSGAHqDkNTLUdVtjZsj+As4Q+7oJc9ZbfCFsnQUpUxfuA0vBfZxBsNzdcTpwIa83C6
 yj21QQQBd5xtn0UA76PTfEbZzotf1q1o4qAxoyAmsp/23x4nppPBurY1yhMpYNXRJxB2
 qBSsaZkKFvTYRqgAFwu0COkMNdzeAiaDAKRiYw61YIHjBTFiirqVTZJMo9s+OCE63tIl
 Tt0A==
X-Gm-Message-State: AJIora82lH9lyKPJVBpWjbhTeJG/uSess9caDZg8JSeOqHNBEw5ASTp/
 atBzl3SYQzSdVccX9dWUAHfYG1sQ4pSWWHyFozPi0bneB0IxxszlUNaCzJAmUDbcLMon20pQ5y9
 428Eg2DP5tKlHMPjYyx+5m1pq2voC
X-Received: by 2002:a05:6a00:1708:b0:52b:c765:9688 with SMTP id
 h8-20020a056a00170800b0052bc7659688mr19036300pfc.19.1658873650858; 
 Tue, 26 Jul 2022 15:14:10 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1u8ISjrfD6mAmSua8DqapNQeNLFGS0sKGGFzKhWQTgw+BMVw7vDwwOVMl0+oglNnAspMS48iA==
X-Received: by 2002:a05:6a00:1708:b0:52b:c765:9688 with SMTP id
 h8-20020a056a00170800b0052bc7659688mr19036277pfc.19.1658873650543; 
 Tue, 26 Jul 2022 15:14:10 -0700 (PDT)
Received: from luke-ubuntu.buildd (cpe-75-80-146-43.san.res.rr.com.
 [75.80.146.43]) by smtp.gmail.com with ESMTPSA id
 a13-20020a1709027e4d00b0015e9f45c1f4sm12069308pln.186.2022.07.26.15.14.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Jul 2022 15:14:10 -0700 (PDT)
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
To: ltp@lists.linux.it, rpalethorpe@suse.de, liwang@redhat.com, pvorel@suse.cz,
 chrubis@suse.cz
Date: Tue, 26 Jul 2022 15:13:20 -0700
Message-Id: <c2327a9e47ece60ffb9cb5b7c7473788cdceb859.1658872195.git.luke.nowakowskikrijger@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1658872195.git.luke.nowakowskikrijger@canonical.com>
References: <cover.1658872195.git.luke.nowakowskikrijger@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 04/10] controllers: Update memcg_control_test to
 newer test lib and cgroup lib
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

Update memcg_control_test to use the newer test lib and to use the newer
cgroup lib which enables the memory v1 and v2 controller to be tested.

Also updated to newer SPDX license identifier.

Signed-off-by: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
---
v3->v6: None

 .../controllers/memcg/control/mem_process.c   |  28 +---
 .../memcg/control/memcg_control_test.sh       | 149 +++++-------------
 2 files changed, 39 insertions(+), 138 deletions(-)

diff --git a/testcases/kernel/controllers/memcg/control/mem_process.c b/testcases/kernel/controllers/memcg/control/mem_process.c
index 6c1b36ca6..8ecabb272 100644
--- a/testcases/kernel/controllers/memcg/control/mem_process.c
+++ b/testcases/kernel/controllers/memcg/control/mem_process.c
@@ -1,28 +1,6 @@
-/*****************************************************************************/
-/*                                                                           */
-/*  Copyright (c) 2010 Mohamed Naufal Basheer                                */
-/*                                                                           */
-/*  This program is free software;  you can redistribute it and/or modify    */
-/*  it under the terms of the GNU General Public License as published by     */
-/*  the Free Software Foundation; either version 2 of the License, or        */
-/*  (at your option) any later version.                                      */
-/*                                                                           */
-/*  This program is distributed in the hope that it will be useful,          */
-/*  but WITHOUT ANY WARRANTY;  without even the implied warranty of          */
-/*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                */
-/*  the GNU General Public License for more details.                         */
-/*                                                                           */
-/*  You should have received a copy of the GNU General Public License        */
-/*  along with this program;  if not, write to the Free Software             */
-/*  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA  */
-/*                                                                           */
-/*  File:    mem_process.c                                                   */
-/*                                                                           */
-/*  Purpose: act as a memory hog for the memcg_control tests                 */
-/*                                                                           */
-/*  Author:  Mohamed Naufal Basheer <naufal11@gmail.com >                    */
-/*                                                                           */
-/*****************************************************************************/
+// SPDX-License-Identifier: GPL-2.0-or-later
+// Copyright (c) 2010 Mohamed Naufal Basheer
+// Author: Mohamed Naufal Basheer
 
 #include <sys/types.h>
 #include <sys/mman.h>
diff --git a/testcases/kernel/controllers/memcg/control/memcg_control_test.sh b/testcases/kernel/controllers/memcg/control/memcg_control_test.sh
index 4d9f1bb5d..f96ed3abb 100644
--- a/testcases/kernel/controllers/memcg/control/memcg_control_test.sh
+++ b/testcases/kernel/controllers/memcg/control/memcg_control_test.sh
@@ -1,45 +1,14 @@
 #!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2010 Mohamed Naufal Basheer
+# Author: Mohamed Naufal Basheer
 
-################################################################################
-##                                                                            ##
-##   Copyright (c) 2010 Mohamed Naufal Basheer                                ##
-##                                                                            ##
-##   This program is free software;  you can redistribute it and/or modify    ##
-##   it under the terms of the GNU General Public License as published by     ##
-##   the Free Software Foundation; either version 2 of the License, or        ##
-##   (at your option) any later version.                                      ##
-##                                                                            ##
-##   This program is distributed in the hope that it will be useful,          ##
-##   but WITHOUT ANY WARRANTY;  without even the implied warranty of          ##
-##   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                ##
-##   the GNU General Public License for more details.                         ##
-##                                                                            ##
-##   You should have received a copy of the GNU General Public License        ##
-##   along with this program;  if not, write to the Free Software             ##
-##   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA  ##
-##                                                                            ##
-##                                                                            ##
-##   File:    memcg_control_test.sh                                           ##
-##                                                                            ##
-##   Purpose: Implement various memory controller tests                       ##
-##                                                                            ##
-##   Author:  Mohamed Naufal Basheer <naufal11@gmail.com>                     ##
-##                                                                            ##
-################################################################################
-
-if [ "x$(grep -w memory /proc/cgroups | cut -f4)" != "x1" ]; then
-	echo "WARNING:"
-	echo "Either kernel does not support memory resource controller or feature not enabled"
-	echo "Skipping all memcg_control testcases...."
-	exit 0
-fi
-
-export TCID="memcg_control"
-export TST_TOTAL=1
-export TST_COUNT=0
-
-export TMP=${TMP:-/tmp}
-cd $TMP
+TST_TESTFUNC=test
+TST_SETUP=setup
+TST_CLEANUP=cleanup
+TST_CNT=1
+TST_NEEDS_ROOT=1
+TST_NEEDS_TMPDIR=1
 
 PAGE_SIZE=$(tst_getconf PAGESIZE)
 
@@ -47,20 +16,14 @@ TOT_MEM_LIMIT=$PAGE_SIZE
 ACTIVE_MEM_LIMIT=$PAGE_SIZE
 PROC_MEM=$((PAGE_SIZE * 2))
 
-TST_PATH=$PWD
-STATUS_PIPE="$TMP/status_pipe"
-
-PASS=0
-FAIL=1
+STATUS_PIPE="status_pipe"
 
 # Check if the test process is killed on crossing boundary
 test_proc_kill()
 {
-	cd $TMP
 	mem_process -m $PROC_MEM &
-	cd $OLDPWD
 	sleep 1
-	echo $! > tasks
+	ROD echo $! > "$test_dir/$task_list"
 
 	#Instruct the test process to start acquiring memory
 	echo m > $STATUS_PIPE
@@ -77,87 +40,47 @@ test_proc_kill()
 }
 
 # Validate the memory usage limit imposed by the hierarchically topmost group
-testcase_1()
+test1()
 {
-	TST_COUNT=1
-	tst_resm TINFO "Test #1: Checking if the memory usage limit imposed by the topmost group is enforced"
+	cd $TST_TMPDIR
+
+	tst_res TINFO "Test #1: Checking if the memory usage limit imposed by the topmost group is enforced"
 
-	echo "$ACTIVE_MEM_LIMIT" > $TST_PATH/mnt/$TST_NUM/memory.limit_in_bytes
-	echo "$TOT_MEM_LIMIT" > $TST_PATH/mnt/$TST_NUM/memory.memsw.limit_in_bytes
+	ROD echo "$ACTIVE_MEM_LIMIT" > "$test_dir/$memory_limit"
+	ROD echo "$TOT_MEM_LIMIT" > "$test_dir/$memsw_memory_limit"
 
-	mkdir sub
-	(cd sub
 	KILLED_CNT=0
 	test_proc_kill
 
 	if [ $PROC_MEM -gt $TOT_MEM_LIMIT ] && [ $KILLED_CNT -eq 0 ]; then
-		result $FAIL "Test #1: failed"
+		tst_res TFAIL "Test #1: failed"
 	else
-		result $PASS "Test #1: passed"
-	fi)
-	rmdir sub
+		tst_res TPASS "Test #1: passed"
+	fi
 }
 
-# Record the test results
-#
-# $1: Result of the test case, $PASS or $FAIL
-# $2: Output information
-result()
+setup()
 {
-	RES=$1
-	INFO=$2
-
-	if [ $RES -eq $PASS ]; then
-		tst_resm TPASS "$INFO"
+	cgroup_require "memory"
+	cgroup_version=$(cgroup_get_version "memory")
+	test_dir=$(cgroup_get_test_path "memory")
+	task_list=$(cgroup_get_task_list "memory")
+
+	if [ "$cgroup_version" = "2" ]; then
+		memory_limit="memory.max"
+		memsw_memory_limit="memory.swap.max"
 	else
-		: $((FAILED_CNT += 1))
-		tst_resm TFAIL "$INFO"
+		memory_limit="memory.limit_in_bytes"
+		memsw_memory_limit="memory.memsw.limit_in_bytes"
 	fi
-}
 
-cleanup()
-{
-	if [ -e $TST_PATH/mnt ]; then
-		umount $TST_PATH/mnt 2> /dev/null
-		rm -rf $TST_PATH/mnt
-	fi
+	tst_res TINFO "Test starts with cgroup version $cgroup_version"
 }
 
-do_mount()
+cleanup()
 {
-	cleanup
-
-	mkdir $TST_PATH/mnt
-	mount -t cgroup -o memory cgroup $TST_PATH/mnt 2> /dev/null
-	if [ $? -ne 0 ]; then
-		tst_brkm TBROK NULL "Mounting cgroup to temp dir failed"
-		rmdir $TST_PATH/mnt
-		exit 1
-	fi
+	cgroup_cleanup
 }
 
-do_mount
-
-echo 1 > mnt/memory.use_hierarchy 2> /dev/null
-
-FAILED_CNT=0
-
-TST_NUM=1
-while [ $TST_NUM -le $TST_TOTAL ]; do
-	mkdir $TST_PATH/mnt/$TST_NUM
-	(cd $TST_PATH/mnt/$TST_NUM && testcase_$TST_NUM)
-	rmdir $TST_PATH/mnt/$TST_NUM
-	: $((TST_NUM += 1))
-done
-
-echo 0 > mnt/memory.use_hierarchy 2> /dev/null
-
-cleanup
-
-if [ "$FAILED_CNT" -ne 0 ]; then
-	tst_resm TFAIL "memcg_control: failed"
-	exit 1
-else
-	tst_resm TPASS "memcg_control: passed"
-	exit 0
-fi
+. cgroup_lib.sh
+tst_run
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
