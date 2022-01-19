Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B214C433F5
	for <ltp@archiver.kernel.org>; Wed, 19 Jan 2022 14:46:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C0E463C968E
	for <ltp@archiver.kernel.org>; Wed, 19 Jan 2022 15:46:15 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C25C23C969B
 for <ltp@lists.linux.it>; Wed, 19 Jan 2022 15:44:33 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id EC6B2600445
 for <ltp@lists.linux.it>; Wed, 19 Jan 2022 15:44:32 +0100 (CET)
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6004C3F31F
 for <ltp@lists.linux.it>; Wed, 19 Jan 2022 14:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1642603472;
 bh=aVBfGJPm4h44Iv3l0UVNavYn0ogGg62jye0v6hZGYCY=;
 h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=ajYtrnq9Vf0Jny11BrdclPPbGPoiKHOu1BDSpY/yVD+iQdGZzUKc1sHL4inhcZb9y
 ZcsgLVC0YXETu4vb4vrlAJDB5MvMTu0jdwyWttp5nKpIBwb8Ni9wSnugDw3HGeeU25
 pKNCvBWlLMoAscZpRG4allKB5oMYaRqDOQTftVn9puZfoehhA3Ij3zHcrKR8npUuCr
 lzZT8hJUvjyLs1me+NHGnJXkM3EHLWR0tqOw8fCjHzad66b4knWxsIuJ5aQ1zG5OPp
 oRT6RT20Cn/sVu6JqpD1FTPbiyzwDOpmgFBkb5lgESuv2kGS+V7a8+8gT/+oA+g2VF
 bHtB0twqib1mw==
Received: by mail-lf1-f69.google.com with SMTP id
 v7-20020a056512048700b0042d99b3a962so1712593lfq.23
 for <ltp@lists.linux.it>; Wed, 19 Jan 2022 06:44:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=aVBfGJPm4h44Iv3l0UVNavYn0ogGg62jye0v6hZGYCY=;
 b=ugTtOV2uCYb5A62/xVfPG8tXsYo9HfdBUDVHHaP/LpbVzagxglG+QvholW6k6+b0s8
 Q8xdptO9TUMaHDHqlokRqRkmRnRN/AQQHL01nGQ89FCX+EYG/DA0Ay/8JPElty8Tf9qb
 X6xGqLW3xBqH6MTKUGbRNyVKy7sGUXA7a3l066f3xAYGv2kyKagMztVlYrj/rKQ0vrNg
 omU6RQ/1bORfniu/ksMf4PhTJ4WpUR1Fsr2GB7NsegD8OTdZ95Ikb6E1v6XIAZt+VA/2
 R1NENdvPR3bjguNQNI0KDOe7wPlvl9Gwv+wKHHGMDpAMZweUR/BVoIZoggxB2T3hATqw
 7YFg==
X-Gm-Message-State: AOAM532wfQBUHvYXfuozeA5U2g7o2rByTJ9qNHBkCjqyGk7/iqUF8MUr
 PfmNi+jTX/hrnYi63D6Ej46Yxue2X8Yam6puzVbYcWjT4m26QRXuEKitX1mswnO+wV0Sz1sBmdS
 srt5med5R8T5JF2fi7cUKvGpma5TV
X-Received: by 2002:a2e:1553:: with SMTP id 19mr25207814ljv.108.1642603471205; 
 Wed, 19 Jan 2022 06:44:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzxyi7TqHRuMsXQqZ+67j95YuA95ZCO8rodXRr10wED+MaHpijVkUdDNWl9T1rylRzuNbwtkQ==
X-Received: by 2002:a2e:1553:: with SMTP id 19mr25207790ljv.108.1642603470839; 
 Wed, 19 Jan 2022 06:44:30 -0800 (PST)
Received: from lukenow-XPS-13-9380.. (d83-110.icpnet.pl. [77.65.83.110])
 by smtp.gmail.com with ESMTPSA id bt18sm2036843lfb.50.2022.01.19.06.44.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jan 2022 06:44:30 -0800 (PST)
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
To: ltp@lists.linux.it,
	rpalethorpe@suse.de,
	liwang@redhat.com
Date: Wed, 19 Jan 2022 06:44:12 -0800
Message-Id: <3b78e25c8eba247d0ce2d99cbbdcaeba7994e26c.1642601554.git.luke.nowakowskikrijger@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1642601554.git.luke.nowakowskikrijger@canonical.com>
References: <cover.1642601554.git.luke.nowakowskikrijger@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 10/16] controllers: Update memcg_control_test to newer
 test lib and cgroup lib
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
 .../controllers/memcg/control/mem_process.c   |  28 +---
 .../memcg/control/memcg_control_test.sh       | 150 +++++-------------
 2 files changed, 40 insertions(+), 138 deletions(-)

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
index 4d9f1bb5d..66316a9f9 100644
--- a/testcases/kernel/controllers/memcg/control/memcg_control_test.sh
+++ b/testcases/kernel/controllers/memcg/control/memcg_control_test.sh
@@ -1,45 +1,16 @@
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
+
+. cgroup_lib.sh
 
 PAGE_SIZE=$(tst_getconf PAGESIZE)
 
@@ -47,20 +18,14 @@ TOT_MEM_LIMIT=$PAGE_SIZE
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
@@ -77,87 +42,46 @@ test_proc_kill()
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
+	cgroup_v=$(cgroup_get_version "memory")
+	test_dir=$(cgroup_get_test_path "memory")
+	task_list=$(cgroup_get_task_list "memory")
+
+	if [ "$cgroup_v" = "V2" ]; then
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
+	tst_res TINFO "Test starts with cgroup $cgroup_v"
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
+tst_run
-- 
2.32.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
