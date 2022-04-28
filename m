Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8436C433F5
	for <ltp@archiver.kernel.org>; Thu, 28 Apr 2022 20:42:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 55C493CA700
	for <ltp@archiver.kernel.org>; Thu, 28 Apr 2022 22:42:58 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 43BA03CA77E
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 22:40:49 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id BAE8B1000926
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 22:40:48 +0200 (CEST)
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 09ADA3F21D
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 20:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1651178448;
 bh=prfwd+MnCQFmmrOQXjXCEc88R5YsOsh0UeKs9Wocdyo=;
 h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=EC5Aq6eQdC2J54pIViRipsK7gFyBNlabGhaxybI8BqghYH8oiZhV0Jv3X9qJJ1NkN
 k5FgU/I6IdxyitvzuXeV16Gq5UCPTpPtP/tupjAf2JB02wJEj+wwFwkqYVO3gT80+K
 RYhJs3k5NKzrKRcT45MEDjZK1DJd/CFzgsw1j1Vn9L+wvYT8c4vp4mK3qAX0PQ0JIm
 dszVhloZO2brG2mRuK09T6nesA/nnizyN5CXemBqF5j9/0SlpxVUm7xtgJ5ysp2OUr
 7kSyIWefhmqipu7+81gFVtbp6cIacUSiqZ4OJ1IrhsqCI5XuStM/0Vho+6BRALXc5Q
 dYT2+f411L0Sg==
Received: by mail-pj1-f71.google.com with SMTP id
 o7-20020a17090a0a0700b001d93c491131so5756896pjo.6
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 13:40:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=prfwd+MnCQFmmrOQXjXCEc88R5YsOsh0UeKs9Wocdyo=;
 b=B7qyrzr6X0GuJh5WE1cd+1qF/1qyCzRV+sg6GIXgC3KijQveVVGoB2BzDbY82EiIB0
 kbzDHD0taa7D4/dxI3+GdUG9gLkCjXd/1KXFrqypnUkU4ALJVtoMT9x+xG9tSTCoI1Y1
 6ZuwbZVeDEmBXTG1EpXsgH01HhuXBFHQYN+iTYE91EsAz0yL61zVOlOCZIic/Hhlsdae
 NM/lpw3b9LoEMhid05Z4QRWkwr9jyxAa2/ANcrHWl1OrRBnOUIF4iFJGgnybzrgrZs+I
 bE68albACCfQKjE73tXl1lzdhLAOFRRqzzkbH3q+jOB4hNwXuxsWso7Kx0xH+fa2Vxj+
 JfwA==
X-Gm-Message-State: AOAM532+uWNaAaP/J2LABoV5FzoH46jHGNzBSAuqjwS8uiFNVlIoIl/s
 Djv20YkzIpHh1aZH1MntEDYv84mx6b3NRLYCMcOWno7tQeWrZW5DA/c3LJ4Ox+wwfoROQs0KUkf
 znvLX2hquCA4XdV1E8ggxXbnvGyI+
X-Received: by 2002:a05:6a02:105:b0:381:fd01:330f with SMTP id
 bg5-20020a056a02010500b00381fd01330fmr29048534pgb.483.1651178446144; 
 Thu, 28 Apr 2022 13:40:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwM+cFsDNk0Z0pGfWM9g3nTDwnM7vg61XkmQB00rkuNEy2cN3aQ3koDLCoYpRwsU38hUvDopQ==
X-Received: by 2002:a05:6a02:105:b0:381:fd01:330f with SMTP id
 bg5-20020a056a02010500b00381fd01330fmr29048514pgb.483.1651178445806; 
 Thu, 28 Apr 2022 13:40:45 -0700 (PDT)
Received: from luke-ubuntu.buildd (cpe-66-27-118-101.san.res.rr.com.
 [66.27.118.101]) by smtp.gmail.com with ESMTPSA id
 f63-20020a62db42000000b0050d35bcdbc0sm659027pfg.181.2022.04.28.13.40.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Apr 2022 13:40:45 -0700 (PDT)
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
To: ltp@lists.linux.it,
	rpalethorpe@suse.de,
	liwang@redhat.com
Date: Thu, 28 Apr 2022 13:39:38 -0700
Message-Id: <faee8a997b6c62161d2d7fb362fadbe7bf149a54.1651176646.git.luke.nowakowskikrijger@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1651176645.git.luke.nowakowskikrijger@canonical.com>
References: <cover.1651176645.git.luke.nowakowskikrijger@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 13/19] controllers: Update memcg_control_test to
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
