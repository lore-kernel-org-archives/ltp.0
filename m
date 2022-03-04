Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76D5AC4332F
	for <ltp@archiver.kernel.org>; Fri,  4 Mar 2022 23:20:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C60563CA400
	for <ltp@archiver.kernel.org>; Sat,  5 Mar 2022 00:20:30 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DB5E13CA3CC
 for <ltp@lists.linux.it>; Sat,  5 Mar 2022 00:18:48 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id BA7D5100076B
 for <ltp@lists.linux.it>; Sat,  5 Mar 2022 00:18:47 +0100 (CET)
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1C8963F1CB
 for <ltp@lists.linux.it>; Fri,  4 Mar 2022 23:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1646435927;
 bh=NN9Szc48xbKi3TWth6t2o2qja9gngr2U/Bradlf02bI=;
 h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=YXI7aNoOoTqID4vVn6tyBruL8v5U0PC5VmWhwkGY5guplzU7NVI29v+TK3TDS4b83
 t8CARbEMrD3PKYHKPall6eDm1RR8J5toUCfgysNGchZXY9A6wq7ZpxEBA1JFTUVKU7
 hW0PiJa683L+rvix5dASMg/37WHtKJhYoV2wfk18FuwxnbJ7vTZ+yjKQntT6sIyWdm
 bS0cFvje1QsRaDm0Fpjt65v/23hte0WTB7nGnAJ6bYrHuJaIEQcGbE84Q5cItkrZI1
 E9EsQjcMOnsclb/JyFejQc3mEEeYP2Q3gZoxQz7m/yWK34oQWu8eWiepe0QnPRvlYG
 IaNSkClfv/5CA==
Received: by mail-pl1-f199.google.com with SMTP id
 i7-20020a170902cf0700b0015163eb319eso5333954plg.18
 for <ltp@lists.linux.it>; Fri, 04 Mar 2022 15:18:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NN9Szc48xbKi3TWth6t2o2qja9gngr2U/Bradlf02bI=;
 b=LfzJD2bwjvQmWXnOhNhhwo/nL+hVIalcvW1k21EZdoHdle1b8kTAx5mPFbMV/aPZd6
 u3c37g6PJo5nGz2W2hY8E9icbGmidVztlrnVV1GO9PKmNunFdZKvfvL4UY9BVEF0qBsZ
 eSiHn+0tw0JZ0jM8NBPcRCe5JvxnCyUmZ87AGITmu4LDthjBwsN4w16i0lKJ4IgAZqVx
 WSIh5zD/Xy1y83uiOxsa7yxk2W+JCoJkgBZSd/0wbPkUhzNluv+1DUofDNNIfhn+okiq
 WbrVPulAK5O5LqTWLttP6dBWX80BHKFZ9hY6TSTjzFG96c6NoDk7qdEyWuHEhXVBJ5eV
 AZ+Q==
X-Gm-Message-State: AOAM532MIamQsETv1q8OXeqXhDLFiTz0kRmEYt8VypDqBdFU6NV+ase7
 1809ssb09vuKoByh3pQTUERJoogLXEOQvGPPI7a52B0U9xz96I5B6RCwITqrO4dq0BiyC1S2BV3
 LdABBw47uFOMj4163Nrr+G9s2GY+1
X-Received: by 2002:a17:90a:4b4c:b0:1be:e5da:dc89 with SMTP id
 o12-20020a17090a4b4c00b001bee5dadc89mr13200579pjl.45.1646435925026; 
 Fri, 04 Mar 2022 15:18:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx9jv/3BmvX7HRZrnWUS2a7zkxOIxrGj//TKwYPxaF3jq4+198pfia5dc0dxMgupKFyJn85RA==
X-Received: by 2002:a17:90a:4b4c:b0:1be:e5da:dc89 with SMTP id
 o12-20020a17090a4b4c00b001bee5dadc89mr13200541pjl.45.1646435924474; 
 Fri, 04 Mar 2022 15:18:44 -0800 (PST)
Received: from luke-ubuntu.. (cpe-66-27-118-101.san.res.rr.com.
 [66.27.118.101]) by smtp.gmail.com with ESMTPSA id
 h14-20020a63384e000000b00366ba5335e7sm5335760pgn.72.2022.03.04.15.18.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Mar 2022 15:18:43 -0800 (PST)
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
To: ltp@lists.linux.it,
	rpalethorpe@suse.de,
	liwang@redhat.com
Date: Fri,  4 Mar 2022 15:18:21 -0800
Message-Id: <88ed77723e5bc3e623e71980b0a3f73519c89eb4.1646434670.git.luke.nowakowskikrijger@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1646434670.git.luke.nowakowskikrijger@canonical.com>
References: <cover.1646434670.git.luke.nowakowskikrijger@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 11/16] controllers: Update memcg/regression/* to
 new test and cgroup lib
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

Update the tests in memcg/regression/* to use the new test lib and the
newer cgroup lib to enable testing when either v1 or v2 memory
controller is mounted. Only some tests still made sense to be testing
with the v2 memory controller, otherwise they were skipped.

Also updated to the newer SPDX license identifier.

Signed-off-by: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
---
v2: change version numbers to 2 instead of v2.
Update to use new cg_init() and test_cg variable in memcg_test_3.c

 .../memcg/regression/memcg_regression_test.sh | 202 +++++++++---------
 .../memcg/regression/memcg_test_1.c           |  40 ++--
 .../memcg/regression/memcg_test_2.c           |  24 +--
 .../memcg/regression/memcg_test_3.c           |  38 ++--
 .../memcg/regression/memcg_test_4.c           |  24 +--
 .../memcg/regression/memcg_test_4.sh          |  50 ++---
 6 files changed, 160 insertions(+), 218 deletions(-)

diff --git a/testcases/kernel/controllers/memcg/regression/memcg_regression_test.sh b/testcases/kernel/controllers/memcg/regression/memcg_regression_test.sh
index c91a4069e..9dcfb59d0 100755
--- a/testcases/kernel/controllers/memcg/regression/memcg_regression_test.sh
+++ b/testcases/kernel/controllers/memcg/regression/memcg_regression_test.sh
@@ -1,50 +1,18 @@
 #! /bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2009 FUJITSU LIMITED
+# Author: Li Zefan <lizf@cn.fujitsu.com>
+# Added memcg enable/disable functionality: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
 
-################################################################################
-##                                                                            ##
-## Copyright (c) 2009 FUJITSU LIMITED                                         ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-## Author: Li Zefan <lizf@cn.fujitsu.com>                                     ##
-## Added memcg enable/disable functinality: Rishikesh K Rajak                 ##
-##                                              <risrajak@linux.vnet.ibm.com  ##
-##                                                                            ##
-################################################################################
-
-cd $LTPROOT/testcases/bin
-
-export TCID="memcg_regression_test"
-export TST_TOTAL=4
-export TST_COUNT=1
-
-if [ "$(id -ru)" != 0 ]; then
-	tst_brkm TBROK ignored "Test must be run as root"
-	exit 0
-fi
-
-if [ "x$(grep -w memory /proc/cgroups | cut -f4)" != "x1" ]; then
-	tst_resm TCONF "Either memory resource controller kernel support absent"
-	tst_resm TCONF "or feature is not enabled; skipping all memcgroup testcases."
-        exit 0
-fi
-
-if tst_kvcmp -lt "2.6.30"; then
-	tst_brkm TBROK ignored "Test should be run with kernel 2.6.30 or newer"
-	exit 0
-fi
+TST_ID="memcg_regression_test"
+TST_CLEANUP=cleanup
+TST_SETUP=setup
+TST_TESTFUNC=test_
+TST_NEEDS_ROOT=1
+TST_NEEDS_CMDS="killall kill"
+TST_CNT=4
+
+. cgroup_lib.sh
 
 #buffer can rotate and number of found bugs can actually go down
 #so clear the buffer to avoid this
@@ -70,16 +38,16 @@ check_kernel_bug()
 
 	# some kernel bug is detected
 	if [ $new_bug -gt $nr_bug ]; then
-		tst_resm TFAIL "kernel BUG was detected!"
+		tst_res TFAIL "kernel BUG was detected!"
 	fi
 	if [ $new_warning -gt $nr_warning ]; then
-		tst_resm TFAIL "kernel WARNING was detected!"
+		tst_res TFAIL "kernel WARNING was detected!"
 	fi
 	if [ $new_null -gt $nr_null ]; then
-		tst_resm "kernel NULL pointer dereference!"
+		tst_res TWARN "kernel NULL pointer dereference!"
 	fi
 	if [ $new_lockdep -gt $nr_lockdep ]; then
-		tst_resm "kernel lockdep warning was detected!"
+		tst_res TWARN "kernel lockdep warning was detected!"
 	fi
 
 	nr_bug=$new_bug
@@ -89,10 +57,49 @@ check_kernel_bug()
 
 	echo "check_kernel_bug found something!"
 	dmesg
-	failed=1
 	return 0
 }
 
+setup()
+{
+	if tst_kvcmp -lt "2.6.30"; then
+		tst_brk TBROK "Test should be run with kernel 2.6.30 or newer"
+	fi
+
+	cgroup_require "memory"
+	cgroup_version=$(cgroup_get_version "memory")
+	mount_point=$(cgroup_get_mountpoint "memory")
+	test_dir=$(cgroup_get_test_path "memory")
+	task_list=$(cgroup_get_task_list "memory")
+	if [ "$cgroup_version" = "2" ]; then
+		memory_limit="memory.max"
+	else
+		memory_limit="memory.limit_in_bytes"
+	fi
+
+	[ "$cgroup_version" = "2" ] && ROD echo "+memory" \> "$test_dir/cgroup.subtree_control"
+
+	tst_res TINFO "test starts with cgroup version $cgroup_version"
+}
+
+cleanup()
+{
+	cleanup_testpath "$test_dir/0"
+	cgroup_cleanup
+}
+
+create_testpath()
+{
+	local path="$1"
+	[ ! -e "$path" ] && ROD mkdir "$path"
+}
+
+cleanup_testpath()
+{
+	local path="$1"
+	[ -e "$path" ] && ROD rmdir "$path"
+}
+
 #---------------------------------------------------------------------------
 # Bug:    The bug was, while forking mass processes, trigger memcgroup OOM,
 #         then NULL pointer dereference may be hit.
@@ -102,16 +109,19 @@ check_kernel_bug()
 #---------------------------------------------------------------------------
 test_1()
 {
-	mkdir memcg/0/
-	echo 0 > memcg/0/memory.limit_in_bytes
+	local test_path
+	test_path="$test_dir/0"
 
-	./memcg_test_1
+	create_testpath "$test_path"
+	ROD echo 0 > "$test_path/$memory_limit"
 
-	rmdir memcg/0/
+	./memcg_test_1 "$test_path/$task_list"
+
+	cleanup_testpath "$test_path"
 
 	check_kernel_bug
 	if [ $? -eq 1 ]; then
-		tst_resm TPASS "no kernel bug was found"
+		tst_res TPASS "no kernel bug was found"
 	fi
 }
 
@@ -124,19 +134,31 @@ test_1()
 #---------------------------------------------------------------------------
 test_2()
 {
+	local test_path
+
+	# for cgroup2 writing to memory.max first checks the new limit against the
+	# current usage and will start killing processes if oom, therefore we do not
+	# expect EBUSY to be returned by the shrink operation.
+	if [ "$cgroup_version" = "2" ]; then
+		tst_res TCONF "Cgroup v2 found, skipping test"
+		return
+	fi
+
+	test_path="$test_dir/0"
+
 	./memcg_test_2 &
 	pid1=$!
 	sleep 1
 
-	mkdir memcg/0
-	echo $pid1 > memcg/0/tasks
+	create_testpath "$test_path"
+	ROD echo $pid1 > "$test_path"/tasks
 
 	# let pid1 'test_2' allocate memory
 	/bin/kill -SIGUSR1 $pid1
 	sleep 1
 
 	# shrink memory
-	echo 1 > memcg/0/memory.limit_in_bytes 2>&1 &
+	echo 1 > "$test_path"/memory.limit_in_bytes 2>&1 &
 	pid2=$!
 
 	# check if 'echo' will exit and exit with failure
@@ -146,26 +168,25 @@ test_2()
 		if [ $? -ne 0 ]; then
 			wait $pid2
 			if [ $? -eq 0 ]; then
-				tst_resm TFAIL "echo should return failure"
-				failed=1
+				tst_res TFAIL "echo should return failure"
 				kill -9 $pid1 $pid2 > /dev/null 2>&1
 				wait $pid1 $pid2
-				rmdir memcg/0
+				cleanup_testpath "$test_path"
+				return
 			fi
 			break
 		fi
 	done
 
 	if [ $tmp -eq 5 ]; then
-		tst_resm TFAIL "'echo' doesn't exit!"
-		failed=1
+		tst_res TFAIL "'echo' doesn't exit!"
 	else
-		tst_resm TPASS "EBUSY was returned as expected"
+		tst_res TPASS "EBUSY was returned as expected"
 	fi
 
 	kill -9 $pid1 $pid2 > /dev/null 2>&1
 	wait $pid1 $pid2 > /dev/null 2>&1
-	rmdir memcg/0
+	cleanup_testpath "$test_path"
 }
 
 #---------------------------------------------------------------------------
@@ -176,19 +197,22 @@ test_2()
 #---------------------------------------------------------------------------
 test_3()
 {
-	mkdir memcg/0
-	for pid in `cat memcg/tasks`; do
-		echo $pid > memcg/0/tasks 2> /dev/null
+	local test_path
+	test_path="$test_dir/0"
+	create_testpath "$test_path"
+
+	for pid in $(cat "$mount_point/$task_list"); do
+		echo $pid > "$test_path/$task_list" 2> /dev/null
 	done
 
-	for pid in `cat memcg/0/tasks`; do
-		echo $pid > memcg/tasks 2> /dev/null
+	for pid in $(cat "$test_path/$task_list"); do
+		echo $pid > "$mount_point/$task_list" 2> /dev/null
 	done
-	rmdir memcg/0
+	cleanup_testpath "$test_path"
 
 	check_kernel_bug
 	if [ $? -eq 1 ]; then
-		tst_resm TPASS "no kernel bug was found"
+		tst_res TPASS "no kernel bug was found"
 	fi
 }
 
@@ -200,11 +224,15 @@ test_3()
 #---------------------------------------------------------------------------
 test_4()
 {
-	./memcg_test_4.sh
+	local test_path
+	test_path="$test_dir/0"
+	create_testpath "$test_path"
+
+	./memcg_test_4.sh "$cgroup_version" "$mount_point" "$test_path"
 
 	check_kernel_bug
 	if [ $? -eq 1 ]; then
-		tst_resm TPASS "no kernel bug was found"
+		tst_res TPASS "no kernel bug was found"
 	fi
 
 	# test_4.sh might be killed by oom, so do clean up here
@@ -212,31 +240,9 @@ test_4()
 	killall -9 memcg_test_4.sh 2> /dev/null
 
 	# if test_4.sh gets killed, it won't clean cgroup it created
-	rmdir memcg/0 2> /dev/null
+	cleanup_testpath "$test_path"
 
 	swapon -a
 }
 
-# main
-failed=0
-mkdir memcg/
-
-for cur in $(seq 1 $TST_TOTAL); do
-	export TST_COUNT=$cur
-
-	mount -t cgroup -o memory xxx memcg/
-	if [ $? -ne 0 ]; then
-		tst_resm TFAIL "failed to mount memory subsystem"
-		failed=1
-		continue
-	fi
-
-	test_$cur
-
-	umount memcg/
-done
-
-rmdir memcg/
-
-exit $failed
-
+tst_run
diff --git a/testcases/kernel/controllers/memcg/regression/memcg_test_1.c b/testcases/kernel/controllers/memcg/regression/memcg_test_1.c
index c7fb948fe..95f1aabb3 100644
--- a/testcases/kernel/controllers/memcg/regression/memcg_test_1.c
+++ b/testcases/kernel/controllers/memcg/regression/memcg_test_1.c
@@ -1,24 +1,6 @@
-/******************************************************************************/
-/*                                                                            */
-/* Copyright (c) 2009 FUJITSU LIMITED                                         */
-/*                                                                            */
-/* This program is free software;  you can redistribute it and/or modify      */
-/* it under the terms of the GNU General Public License as published by       */
-/* the Free Software Foundation; either version 2 of the License, or          */
-/* (at your option) any later version.                                        */
-/*                                                                            */
-/* This program is distributed in the hope that it will be useful,            */
-/* but WITHOUT ANY WARRANTY;  without even the implied warranty of            */
-/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  */
-/* the GNU General Public License for more details.                           */
-/*                                                                            */
-/* You should have received a copy of the GNU General Public License          */
-/* along with this program;  if not, write to the Free Software               */
-/* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    */
-/*                                                                            */
-/* Author: Li Zefan <lizf@cn.fujitsu.com>                                     */
-/*                                                                            */
-/******************************************************************************/
+// SPDX-License-Identifier: GPL-2.0-or-later
+// Copyright (c) 2009 FUJITSU LIMITED
+// Author: Li Zefan <lizf@cn.fujitsu.com>
 
 #include <stdio.h>
 #include <stdlib.h>
@@ -33,17 +15,25 @@
 
 #define FORKED_PROC_COUNT	10
 
-int main(void)
+int main(int argc, char *argv[])
 {
 	char buf[10];
 	int i;
 	int loop;
 	int pid;
+	int fd;
 	int size = getpagesize();
-	int fd = open("memcg/0/tasks", O_WRONLY);
 
-	if (fd < 0)
-		return 1;
+	if (argc != 2) {
+		perror("Invalid num of args");
+		exit(1);
+	}
+
+	fd = open(argv[1], O_WRONLY);
+	if (fd < 0) {
+		perror("Could not open tasklist");
+		exit(1);
+	}
 
 	for (loop = 0; loop < LOOP; loop++) {
 		for (i = 0; i < FORKED_PROC_COUNT; i++) {
diff --git a/testcases/kernel/controllers/memcg/regression/memcg_test_2.c b/testcases/kernel/controllers/memcg/regression/memcg_test_2.c
index 843b07816..c118d4559 100644
--- a/testcases/kernel/controllers/memcg/regression/memcg_test_2.c
+++ b/testcases/kernel/controllers/memcg/regression/memcg_test_2.c
@@ -1,24 +1,6 @@
-/******************************************************************************/
-/*                                                                            */
-/* Copyright (c) 2009 FUJITSU LIMITED                                         */
-/*                                                                            */
-/* This program is free software;  you can redistribute it and/or modify      */
-/* it under the terms of the GNU General Public License as published by       */
-/* the Free Software Foundation; either version 2 of the License, or          */
-/* (at your option) any later version.                                        */
-/*                                                                            */
-/* This program is distributed in the hope that it will be useful,            */
-/* but WITHOUT ANY WARRANTY;  without even the implied warranty of            */
-/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  */
-/* the GNU General Public License for more details.                           */
-/*                                                                            */
-/* You should have received a copy of the GNU General Public License          */
-/* along with this program;  if not, write to the Free Software               */
-/* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    */
-/*                                                                            */
-/* Author: Li Zefan <lizf@cn.fujitsu.com>                                     */
-/*                                                                            */
-/******************************************************************************/
+// SPDX-License-Identifier: GPL-2.0-or-later
+// Copyright (c) 2009 FUJITSU LIMITED
+// Author: Li Zefan <lizf@cn.fujitsu.com>
 
 #include <sys/mman.h>
 #include <signal.h>
diff --git a/testcases/kernel/controllers/memcg/regression/memcg_test_3.c b/testcases/kernel/controllers/memcg/regression/memcg_test_3.c
index 75a6e1545..81e1fc161 100644
--- a/testcases/kernel/controllers/memcg/regression/memcg_test_3.c
+++ b/testcases/kernel/controllers/memcg/regression/memcg_test_3.c
@@ -17,12 +17,10 @@
 #include <sys/types.h>
 #include <sys/mount.h>
 #include "tst_test.h"
+#include "tst_cgroup.h"
 
-#define MNTPOINT	"memcg"
-#define SUBDIR	"memcg/testdir"
-
-static int mount_flag;
 static volatile int sigcounter;
+static struct tst_cg_group *test_cg;
 
 static void sighandler(int sig LTP_ATTRIBUTE_UNUSED)
 {
@@ -48,9 +46,10 @@ static void do_test(void)
 		do_child();
 
 	while (sigcounter < 50000) {
-		if (access(SUBDIR, F_OK))
-			SAFE_MKDIR(SUBDIR, 0644);
-		rmdir(SUBDIR);
+		test_cg = tst_cg_group_mk(tst_cg, "test");
+
+		if (test_cg)
+			test_cg = tst_cg_group_rm(test_cg);
 	}
 
 	SAFE_KILL(cpid, SIGKILL);
@@ -61,32 +60,25 @@ static void do_test(void)
 
 static void setup(void)
 {
-	int ret;
-
-	SAFE_MKDIR(MNTPOINT, 0644);
+	struct tst_cg_opts opts;
+	memset(&opts, 0, sizeof(opts));
 
-	ret = mount("memcg", MNTPOINT, "cgroup", 0, "memory");
-	if (ret) {
-		if (errno == ENOENT)
-			tst_brk(TCONF | TERRNO, "memcg not supported");
-
-		tst_brk(TCONF | TERRNO, "mounting memcg failed");
-	}
-	mount_flag = 1;
+	tst_cg_require("memory", &opts);
+	tst_cg_init();
+	if (TST_CG_VER(tst_cg, "memory") != TST_CG_V1)
+		SAFE_CG_PRINT(tst_cg, "cgroup.subtree_control", "+memory");
 }
 
 static void cleanup(void)
 {
-	if (!access(SUBDIR, F_OK))
-		SAFE_RMDIR(SUBDIR);
+	if (test_cg)
+		test_cg = tst_cg_group_rm(test_cg);
 
-	if (mount_flag)
-		tst_umount(MNTPOINT);
+	tst_cg_cleanup();
 }
 
 static struct tst_test test = {
 	.needs_root = 1,
-	.needs_tmpdir = 1,
 	.forks_child = 1,
 	.min_kver = "2.6.24",
 	.setup = setup,
diff --git a/testcases/kernel/controllers/memcg/regression/memcg_test_4.c b/testcases/kernel/controllers/memcg/regression/memcg_test_4.c
index d714561ed..743c84108 100644
--- a/testcases/kernel/controllers/memcg/regression/memcg_test_4.c
+++ b/testcases/kernel/controllers/memcg/regression/memcg_test_4.c
@@ -1,24 +1,6 @@
-/******************************************************************************/
-/*                                                                            */
-/* Copyright (c) 2009 FUJITSU LIMITED                                         */
-/*                                                                            */
-/* This program is free software;  you can redistribute it and/or modify      */
-/* it under the terms of the GNU General Public License as published by       */
-/* the Free Software Foundation; either version 2 of the License, or          */
-/* (at your option) any later version.                                        */
-/*                                                                            */
-/* This program is distributed in the hope that it will be useful,            */
-/* but WITHOUT ANY WARRANTY;  without even the implied warranty of            */
-/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  */
-/* the GNU General Public License for more details.                           */
-/*                                                                            */
-/* You should have received a copy of the GNU General Public License          */
-/* along with this program;  if not, write to the Free Software               */
-/* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    */
-/*                                                                            */
-/* Author: Li Zefan <lizf@cn.fujitsu.com>                                     */
-/*                                                                            */
-/******************************************************************************/
+// SPDX-License-Identifier: GPL-2.0-or-later
+// Copyright (c) 2009 FUJITSU LIMITED
+// Author: Li Zefan <lizf@cn.fujitsu.com>
 
 #include <sys/mman.h>
 #include <err.h>
diff --git a/testcases/kernel/controllers/memcg/regression/memcg_test_4.sh b/testcases/kernel/controllers/memcg/regression/memcg_test_4.sh
index 620031366..8723abb2f 100755
--- a/testcases/kernel/controllers/memcg/regression/memcg_test_4.sh
+++ b/testcases/kernel/controllers/memcg/regression/memcg_test_4.sh
@@ -1,30 +1,21 @@
 #! /bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2009 FUJITSU LIMITED
+# Author: Li Zefan <lizf@cn.fujitsu.com>
 
-################################################################################
-##                                                                            ##
-## Copyright (c) 2009 FUJITSU LIMITED                                         ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-## Author: Li Zefan <lizf@cn.fujitsu.com>                                     ##
-##                                                                            ##
-################################################################################
-
-# attach current task to memcg/0/
-mkdir memcg/0
-echo $$ > memcg/0/tasks
+cgroup_version="$1"
+mount_point="$2"
+test_path="$3"
+
+if [ "$cgroup_version" = "2" ]; then
+	task_list="cgroup.procs"
+	memory_limit="memory.max"
+else
+	task_list="tasks"
+	memory_limit="memory.limit_in_bytes"
+fi
+
+echo $$ > "$test_path/$task_list"
 
 ./memcg_test_4 &
 pid=$!
@@ -35,14 +26,13 @@ sleep 1
 sleep 1
 
 # shrink memory, and then 80M will be swapped
-echo 40M > memcg/0/memory.limit_in_bytes
+echo 40M > "$test_path/$memory_limit"
 
 # turn off swap, and swapoff will be killed
 swapoff -a
 sleep 1
-echo $pid > memcg/tasks 2> /dev/null
-echo $$ > memcg/tasks 2> /dev/null
+echo $pid > "$mount_point/$task_list" 2> /dev/null
+echo $$ > "$mount_point/$task_list"  2> /dev/null
 
 # now remove the cgroup
-rmdir memcg/0
-
+rmdir "$test_path"
-- 
2.32.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
