Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E12A4C433EF
	for <ltp@archiver.kernel.org>; Thu, 21 Jul 2022 20:55:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 09C233C9111
	for <ltp@archiver.kernel.org>; Thu, 21 Jul 2022 22:55:31 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A8C473C9A4D
 for <ltp@lists.linux.it>; Thu, 21 Jul 2022 22:53:24 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E270E60047B
 for <ltp@lists.linux.it>; Thu, 21 Jul 2022 22:53:23 +0200 (CEST)
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6B49C3F128
 for <ltp@lists.linux.it>; Thu, 21 Jul 2022 20:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1658436803;
 bh=t9q8vTngw+lf9m2drUYy1fnybiOklT0CDNMyQah0THk=;
 h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=jFGOvj0aYZjh4bGObzrTIlD2zJI6TY5s1kvyz3wvXQ1AHs5QT98whmOlRHk6arUlq
 ljcUqD0CfJ2/BBPfDDPmJ6dDV2ODZOgL+BTog/tFVneOuYhLTNznJPZ1psOjpnvdPL
 Nr7qJ4meF4XcaNw5n5vPmgMsVjbrsFwY6IO0A5oH8rFGq3zTgVtrpavTzsTUdtVtz1
 AIKAYAeP3MqZsxQ/znaUtUm9dUsaTUuAMIa1EbC+tBJcKxx/uxFcWcAZ5aU1B+tgwT
 Z193u2COVVgur4HWVsjS7K7f9xea0Do10GNFlajROQv96pky2RotXbrT/raTr3mU7t
 ZQuRwS9kXKFTQ==
Received: by mail-pl1-f200.google.com with SMTP id
 k11-20020a170902ce0b00b0016a15fe2627so1658239plg.22
 for <ltp@lists.linux.it>; Thu, 21 Jul 2022 13:53:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=t9q8vTngw+lf9m2drUYy1fnybiOklT0CDNMyQah0THk=;
 b=cMBjXFvn7VyiGnGH02BTRBdO5qtoDGg02NjvILlcQ+TeDX0wZj2i/DQfB7+KBGDI8S
 JgchymqRhBOJKi1FUdGzA+zq87rZDP7Bz2aA9O+6nnLHYH1T3T1A0RuJqUI1brUKfVAj
 RHYTZGrr7ugVsBkYtuhIytu/zD+b82yMomTRmamGDIj/Zq3mZ7F9lCGyugi6WvzjSkPU
 xWnmejF8bf3RDtGZEBzQ4bO1W3k+qIEP4h0tB8ivmu9YXlTXg5Xjm9483OhcxQ8sNzSY
 Kayo9m6Q4ZPKriF96H6rwCbfcVpE/s/qCEJjwjAD4MRMOpe0uADq2mCkiG3CgOvs79p3
 0iQQ==
X-Gm-Message-State: AJIora+zCmOaBUS+KAC/uHKIhKGeVVqSR5Dtsq+SEw/Cfe6RQaceg3lK
 LYG4Fv8lFysUUEGg1nb8NHlLfkT/S3QTCIlGXPV3sMuTec2X0zdcXYBWNtGgaNGJKrVzpw+AJfv
 Codn9eGu5Hi4yC3ngVI+WWp1Yi3v9
X-Received: by 2002:a17:902:b191:b0:16c:64ef:ed86 with SMTP id
 s17-20020a170902b19100b0016c64efed86mr288590plr.63.1658436802592; 
 Thu, 21 Jul 2022 13:53:22 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1v6Ambio3FA+HBbXGFOtnvXJpn00xGs4eGQpTGDk8ZPyO0pv+twNsI1iD1CvUTmZiWLxz8gIg==
X-Received: by 2002:a17:902:b191:b0:16c:64ef:ed86 with SMTP id
 s17-20020a170902b19100b0016c64efed86mr288560plr.63.1658436802215; 
 Thu, 21 Jul 2022 13:53:22 -0700 (PDT)
Received: from luke-ubuntu.buildd (cpe-75-80-146-43.san.res.rr.com.
 [75.80.146.43]) by smtp.gmail.com with ESMTPSA id
 c6-20020a656746000000b0041a4d5e7e5fsm1916364pgu.47.2022.07.21.13.53.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Jul 2022 13:53:21 -0700 (PDT)
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
To: ltp@lists.linux.it, rpalethorpe@suse.de, liwang@redhat.com, pvorel@suse.cz,
 chrubis@suse.cz
Date: Thu, 21 Jul 2022 13:52:22 -0700
Message-Id: <ba1aad2658344e39a66af8da69855c1b41d96898.1658433280.git.luke.nowakowskikrijger@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1658433280.git.luke.nowakowskikrijger@canonical.com>
References: <cover.1658433280.git.luke.nowakowskikrijger@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 12/18] controllers: Update memcg_control_test to
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
v2: Change version numbers to 2 instead of v2
v3: put cgroup_lib.sh include in bottom of file

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
