Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEFFEC433EF
	for <ltp@archiver.kernel.org>; Fri,  4 Mar 2022 23:20:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2D3B93CA3CB
	for <ltp@archiver.kernel.org>; Sat,  5 Mar 2022 00:20:05 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EF28F3CA405
 for <ltp@lists.linux.it>; Sat,  5 Mar 2022 00:18:46 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E7A29601F4D
 for <ltp@lists.linux.it>; Sat,  5 Mar 2022 00:18:45 +0100 (CET)
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 344473F5F9
 for <ltp@lists.linux.it>; Fri,  4 Mar 2022 23:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1646435925;
 bh=prfwd+MnCQFmmrOQXjXCEc88R5YsOsh0UeKs9Wocdyo=;
 h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=Ma8xNjB6rMhTzZ6l7CwLJDKF0knuO9sl2RmJid1TzCMpUpHQ+HiggKy0Uqe3QPa85
 VWXUBp4Igs+l0PaCc4HDVI5aTzczenyJmzVXNbrfESy4gwqlHdRslmIleuaC+FWy1R
 2a8gyp1xd7xpQvIWDSRUVfM6nwc7KGkQBDsXcOn8Df8QF1BcuBFFUGRbfTEspbhNoK
 1KE2Fk78UBY4Lsrj5bevwt/0CaJannvn3wPsV4/0Aw4RnR9P8eEyeaTmL5ZSRVxltb
 Qs56GAjyxt3jry4mCX2UtxcJ5pwe0pPML+BRLjSfvH6bvb9o+FqjOdf8FDxE1lFzhJ
 YtqztQu6DBBBA==
Received: by mail-pl1-f200.google.com with SMTP id
 l6-20020a170903120600b0014f43ba55f3so5358104plh.11
 for <ltp@lists.linux.it>; Fri, 04 Mar 2022 15:18:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=prfwd+MnCQFmmrOQXjXCEc88R5YsOsh0UeKs9Wocdyo=;
 b=mSCT+obc2pQ/sQP0v+hA5vD8SsnDlVrxXwAnsuFcspkcUAc9APuuHE9RvMPIwYi2mW
 QV8w+n/49ZDSgLPw9ly+DfU28kcAVjen3SFre08LeuxLac0F5induI6Uv3J0+9t5Tk8F
 3hDHoPojeILHkQVnUYscW82GYPQOczD9olnIFnUYqi7ESsAbsiQXH6sgjn+j0IcA53K3
 1lSguTJedJZC3rlVDTtuFYV44RbtLP7xo0hU51okWL5RgmtMq5wiPF7DRgti4rS6g1MN
 Vr1TmWtQnp+A6BAqOTHfCKbfFJBGkSzE7l0T00TzZ9Z6qiCG6B/ZA/ZCr9LkMqCiQGq1
 z95w==
X-Gm-Message-State: AOAM531A19raLr/EIbgQFOT8iUSKTZOpVE5ztDafd16E58i0m0DamQFM
 p2XqciD9oXUP+jxz0MN0wdrmiwPJYaS/ukbB4dskqRvgVwAOeIy459lLeUCGnm3A+LC6K7p13/J
 MfncRsCphuYiHbCHD8xP0/M6AW8vt
X-Received: by 2002:a63:de55:0:b0:374:2526:3596 with SMTP id
 y21-20020a63de55000000b0037425263596mr589543pgi.592.1646435923319; 
 Fri, 04 Mar 2022 15:18:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxR0q5A61l36kt6yE9fdeDxpxmbzwpdvNc6F0HDY8yl3qL8d1soHfjIT8V86s6y8MpCunXRaA==
X-Received: by 2002:a63:de55:0:b0:374:2526:3596 with SMTP id
 y21-20020a63de55000000b0037425263596mr589527pgi.592.1646435923005; 
 Fri, 04 Mar 2022 15:18:43 -0800 (PST)
Received: from luke-ubuntu.. (cpe-66-27-118-101.san.res.rr.com.
 [66.27.118.101]) by smtp.gmail.com with ESMTPSA id
 h14-20020a63384e000000b00366ba5335e7sm5335760pgn.72.2022.03.04.15.18.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Mar 2022 15:18:42 -0800 (PST)
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
To: ltp@lists.linux.it,
	rpalethorpe@suse.de,
	liwang@redhat.com
Date: Fri,  4 Mar 2022 15:18:20 -0800
Message-Id: <b971296c1781eafd8073e00101fc847f24922bde.1646434670.git.luke.nowakowskikrijger@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1646434670.git.luke.nowakowskikrijger@canonical.com>
References: <cover.1646434670.git.luke.nowakowskikrijger@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 10/16] controllers: Update memcg_control_test to
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
index 4d9f1bb5d..b6a1ca2ae 100644
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
+tst_run
-- 
2.32.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
