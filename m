Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12F82C43334
	for <ltp@archiver.kernel.org>; Thu, 21 Jul 2022 20:55:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6C1083CA0ED
	for <ltp@archiver.kernel.org>; Thu, 21 Jul 2022 22:55:55 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E86513C9F90
 for <ltp@lists.linux.it>; Thu, 21 Jul 2022 22:53:27 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 31465600072
 for <ltp@lists.linux.it>; Thu, 21 Jul 2022 22:53:24 +0200 (CEST)
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7F3453F12C
 for <ltp@lists.linux.it>; Thu, 21 Jul 2022 20:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1658436802;
 bh=yKP7kfJs1CYjC5qgM5mXBz+mwGOARIMMLQLdQqZHGoY=;
 h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=cOpQAZtnIW5RyOBWA35vU+2g5rD27FaE62FX+nJBq2fdwI+wM8sU6br3GteUoAGXw
 OPaT1T/hnmtoiajc7JJKQp56yWeHOQQ+7ulZeL3w7PCVE30CespWszVAvLp5DNEPFW
 LQvov0K320QznMjOfQvlbgW90HHisVusL0l7sVtrixnIhWYRsNrurlwpfdNFTOc8t2
 uh51mMEQHDOehkJLA4OvvVevY/wxPlf86GOsMeAkzfNGvYtgx7CTF2Kr0lCAHShKFo
 tBxMk/bwWAPc3wRArprXVTRoXVYAN2nd+Wu60++kAu6vR/1vQuDBvvTqaPesbV3cbo
 vdHw6r8nBuzJA==
Received: by mail-pg1-f200.google.com with SMTP id
 o10-20020a655bca000000b00412787983b3so1351794pgr.12
 for <ltp@lists.linux.it>; Thu, 21 Jul 2022 13:53:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yKP7kfJs1CYjC5qgM5mXBz+mwGOARIMMLQLdQqZHGoY=;
 b=2WnYm964yllNrfCRSiiSrcF0dGCmSQTVj4qzBBtm82ejTBWluCTt5g5MOXiktBtAJT
 n33tXEyU1ER8UF/ffnt7dTuXLzk+bTFSE4bElpn5RTxV5xpdx0Zy2qh6m5iYqDEJ5gnA
 V26tuU4qxPSz8UEm8DA9X1XIVdtGLuXonppksvZPF7EOQp7U0SOCvOYesDNnFdHZg2ou
 chzNyc9hLGybkZQ4rXDZD4tSOmMOqR2F3iSaJWztx04FbqKS3juWK1L4XnclX7K3UeLA
 CCWmcbSRcViu8i+T5KEq4XeRjpRT4G+cmarYj9hTGsQH0tuvsRIpuR/qXF2ZPIhdoP9w
 mKmA==
X-Gm-Message-State: AJIora+MY1nV+/ATYf8bVaPoRd2JWVlk1e3U9+k/7LNFEeMQy35p6CgY
 lwQUXR7bwxmKXT80daSBQ3bT8B3+t8Qwi/Ma6dnKHouJMGpB3tmQHUFs8OuIOawwYzjOnG6HOHW
 8aGWRDUMfaQb3bdEBl+jLr4TV9s/4
X-Received: by 2002:a17:903:3011:b0:16c:3d34:fde4 with SMTP id
 o17-20020a170903301100b0016c3d34fde4mr123694pla.79.1658436801312; 
 Thu, 21 Jul 2022 13:53:21 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1ufBa/xKDauHw58mQ1jEIY3oy+phrXn0q6ndxgsJJo1Ck/nB82H7eh1S8bC3j8rLZfkxtQCpQ==
X-Received: by 2002:a17:903:3011:b0:16c:3d34:fde4 with SMTP id
 o17-20020a170903301100b0016c3d34fde4mr123664pla.79.1658436800742; 
 Thu, 21 Jul 2022 13:53:20 -0700 (PDT)
Received: from luke-ubuntu.buildd (cpe-75-80-146-43.san.res.rr.com.
 [75.80.146.43]) by smtp.gmail.com with ESMTPSA id
 c6-20020a656746000000b0041a4d5e7e5fsm1916364pgu.47.2022.07.21.13.53.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Jul 2022 13:53:20 -0700 (PDT)
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
To: ltp@lists.linux.it, rpalethorpe@suse.de, liwang@redhat.com, pvorel@suse.cz,
 chrubis@suse.cz
Date: Thu, 21 Jul 2022 13:52:21 -0700
Message-Id: <caab3f8e65b22bf00aa2fa1da9669c7f43df119d.1658433280.git.luke.nowakowskikrijger@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1658433280.git.luke.nowakowskikrijger@canonical.com>
References: <cover.1658433280.git.luke.nowakowskikrijger@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 11/18] controllers: Update cgroup_fj_* to use newer
 cgroup lib and test lib
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

Update the cgroup_fj_* tests to use the newer test lib and to use the
updated version of the cgroup lib which handles mounting and unmounting
for both v1 and v2 controllers.

The tests were modified to accommodate testing the v2 controller
interfaces where it still made sense, and in other places tests were
skipped as they were testing using specific parts of the v1 interface
that doesn't exist on v2 controllers.

Also updated the licensing info at the beginning of the file with SPDX
license identifier.

Signed-off-by: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
---
v2: Remove exist_subsystem() function.
Correct spelling mistakes in commit message.
Change version numbers to "2" instead of "v2"
v3: put cgroup_lib.sh include in bottom of file

 .../controllers/cgroup_fj/cgroup_fj_common.sh | 115 ++++--------
 .../cgroup_fj/cgroup_fj_function.sh           | 172 ++++++++++--------
 .../controllers/cgroup_fj/cgroup_fj_proc.c    |  24 +--
 .../controllers/cgroup_fj/cgroup_fj_stress.sh | 171 +++++++++--------
 4 files changed, 217 insertions(+), 265 deletions(-)

diff --git a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh
index 53ab637e8..6d5586534 100755
--- a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh
+++ b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh
@@ -1,43 +1,17 @@
 #!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) 2009 FUJITSU LIMITED                                         ##
-##  Author: Shi Weihua <shiwh@cn.fujitsu.com>                                 ##
-## Copyright (c) 2015 Cedric Hnyda <chnyda@suse.com>                          ##
-## Copyright (c) 2015-2016 Cyril Hrubis <chrubis@suse.cz>                     ##
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
-## along with this program;  if not, write to the Free Software Foundation,   ##
-## Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA           ##
-##                                                                            ##
-################################################################################
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2009 FUJITSU LIMITED
+# Copyright (c) 2015 Cedric Hnyda <chnyda@suse.com>
+# Copyright (c) 2015-2016 Cyril Hrubis <chrubis@suse.cz>
+# Author: Shi Weihua <shiwh@cn.fujitsu.com>
 
 for arg; do
     TCID="${TCID}_$arg"
 done
 
-. test.sh
-
-exist_subsystem()
-{
-    local subsystem="$1"
-    local exist=`grep -w $subsystem /proc/cgroups | cut -f1`
-
-    if [ -z "$exist" ]; then
-        tst_brkm TCONF "Subsystem $subsystem not supported"
-    fi
-}
+TST_NEEDS_CMDS="rmdir killall"
+TST_NEEDS_ROOT=1
+TST_NEEDS_TMPDIR=1
 
 attach_and_check()
 {
@@ -46,13 +20,13 @@ attach_and_check()
     local task
     shift
 
-    tst_resm TINFO "Attaching task $pid to $path"
+    tst_res TINFO "Attaching task $pid to $path"
 
-    ROD echo "$pid" \> "$path/tasks"
+    ROD echo "$pid" \> "$path/$task_list"
 
-    for task in $(cat "$path/tasks"); do
+    for task in $(cat "$path/$task_list"); do
         if [ "$task" -ne "$pid" ]; then
-            tst_resm TINFO "Unexpected pid $task in $path/tasks, expected $pid"
+            tst_res TINFO "Unexpected pid $task in $path/$task_list, expected $pid"
             return 1
         fi
     done
@@ -64,11 +38,13 @@ create_subgroup()
 {
     path="$1"
 
-    ROD mkdir "$path"
+    [ ! -d "$path" ] && ROD mkdir "$path"
 
     # cpuset.cpus and cpuset.mems must be initialized with suitable value
-    # before any pids are attached
-    if [ "$subsystem" = "cpuset" ]; then
+    # before any pids are attached.
+    # Only needs to be done for cgroup v1 as sets are inherited from parents
+    # by default in cgroup v2.
+    if [ "$cgroup_version" = "1" ] && [ "$subsystem" = "cpuset" ]; then
         if [ -e "$mount_point/cpus" ]; then
             ROD cat "$mount_point/cpus" \> "$path/cpus"
             ROD cat "$mount_point/mems" \> "$path/mems"
@@ -79,54 +55,27 @@ create_subgroup()
     fi
 }
 
-
-setup()
+common_setup()
 {
-    tst_require_root
-    tst_require_cmds killall
-
-    if [ ! -f /proc/cgroups ]; then
-        tst_brkm TCONF "Kernel does not support for control groups"
-    fi
-
-    exist_subsystem "$subsystem"
-
-    tst_tmpdir
-    TST_CLEANUP=cleanup
-
-    mount_point=`grep -w $subsystem /proc/mounts | grep -w "cgroup" | \
-	cut -f 2 | cut -d " " -f2`
-
-    if [ -z "$mount_point" ]; then
-        try_umount=1
-        mount_point="/dev/cgroup"
-	tst_resm TINFO "Subsystem $subsystem is not mounted, mounting it at $mount_point"
-        ROD mkdir $mount_point
-        ROD mount -t cgroup -o "$subsystem" "ltp_cgroup" "$mount_point"
-    else
-	tst_resm TINFO "Subsystem $subsystem is mounted at $mount_point"
-    fi
+    cgroup_require "$subsystem"
+    mount_point=$(cgroup_get_mountpoint "$subsystem")
+    start_path=$(cgroup_get_test_path "$subsystem")
+    cgroup_version=$(cgroup_get_version "$subsystem")
+    task_list=$(cgroup_get_task_list "$subsystem")
+
+    [ "$cgroup_version" = "2" ] && ROD echo "+$subsystem" \> "$start_path/cgroup.subtree_control"
+    tst_res TINFO "test starts with cgroup version $cgroup_version"
 }
 
-cleanup()
+common_cleanup()
 {
-    tst_rmdir
-
     killall -9 cgroup_fj_proc >/dev/null 2>&1
 
-    tst_resm TINFO "Removing all ltp subgroups..."
-
-    find "$mount_point/ltp/" -depth -type d -exec rmdir '{}' \;
+    tst_res TINFO "Removing all ltp subgroups..."
 
-    if [ -z "$try_umount" ]; then
-	return
-    fi
-
-    if grep -q "$mount_point" /proc/mounts; then
-        EXPECT_PASS umount "$mount_point"
-    fi
+    [ -d "$start_path" ] && find "$start_path" -depth -type d -exec rmdir '{}' \;
 
-    if [ -e "$mount_point" ]; then
-        EXPECT_PASS rmdir "$mount_point"
-    fi
+    cgroup_cleanup
 }
+
+. cgroup_lib.sh
diff --git a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh
index fc3ad1b63..0fde2d9c0 100755
--- a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh
+++ b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh
@@ -1,32 +1,16 @@
 #!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) 2009 FUJITSU LIMITED                                         ##
-##  Author: Shi Weihua <shiwh@cn.fujitsu.com>                                 ##
-## Copyright (c) 2015 Cedric Hnyda <chnyda@suse.com>                          ##
-## Copyright (c) 2015-2016 Cyril Hrubis <chrubis@suse.cz>                     ##
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
-## along with this program;  if not, write to the Free Software Foundation,   ##
-## Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA           ##
-##                                                                            ##
-################################################################################
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2009 FUJITSU LIMITED
+# Copyright (c) 2015 Cedric Hnyda <chnyda@suse.com>
+# Copyright (c) 2015-2016 Cyril Hrubis <chrubis@suse.cz>
+# Author: Shi Weihua <shiwh@cn.fujitsu.com>
 
 TCID="cgroup_fj_function2"
-TST_TOTAL=7
-
-. cgroup_fj_common.sh
+TST_TESTFUNC=test
+TST_SETUP=setup
+TST_CLEANUP=cleanup
+TST_CNT=9
+TST_POS_ARGS=1
 
 subsystem=$1
 
@@ -36,7 +20,7 @@ usage_and_exit()
     echo "  ./cgroup_fj_function2.sh subsystem"
     echo "example: ./cgroup_fj_function2.sh cpuset"
 
-    tst_brkm TBROK "$1"
+    tst_brk TBROK "$1"
 }
 
 if [ "$#" -ne "1" ]; then
@@ -46,49 +30,67 @@ fi
 # Move a task from group to group
 test1()
 {
+    # mv'ing cgroups is not available in cgroup2
+    if [ "$cgroup_version" = "2" ]; then
+        tst_res TCONF "Controller mounted on cgroup2 hierachy, skipping test"
+        return
+    fi
+
     if ! attach_and_check "$pid" "$start_path/ltp_1"; then
-         tst_resm TFAIL "Failed to attach task"
+         tst_res TFAIL "Failed to attach task"
          return
     fi
 
     if ! attach_and_check "$pid" "$start_path"; then
-         tst_resm TFAIL "Failed to attach task"
+         tst_res TFAIL "Failed to attach task"
          return
     fi
 
-    tst_resm TPASS "Task attached succesfully"
+    tst_res TPASS "Task attached succesfully"
 }
 
 # Group can be renamed with mv
 test2()
 {
+    # mv'ing cgroups is not available in cgroup2
+    if [ "$cgroup_version" = "2" ]; then
+        tst_res TCONF "Controller mounted on cgroup2 hierachy, skipping test"
+        return
+    fi
+
     create_subgroup "$start_path/ltp_2"
 
     if ! mv "$start_path/ltp_2" "$start_path/ltp_3"; then
-        tst_resm TFAIL "Failed to move $start_path/ltp_2 to $start_path/ltp_3"
+        tst_res TFAIL "Failed to move $start_path/ltp_2 to $start_path/ltp_3"
         rmdir "$start_path/ltp_2"
         return
     fi
 
     if ! rmdir "$start_path/ltp_3"; then
-        tst_resm TFAIL "Failed to remove $start_path/ltp_3"
+        tst_res TFAIL "Failed to remove $start_path/ltp_3"
         return
     fi
 
-    tst_resm TPASS "Successfully moved $start_path/ltp_2 to $start_path/ltp_3"
+    tst_res TPASS "Successfully moved $start_path/ltp_2 to $start_path/ltp_3"
 }
 
 # Group can be renamed with mv unless the target name exists
 test3()
 {
+    # mv'ing cgroups is not available in cgroup2
+    if [ "$cgroup_version" = "2" ]; then
+        tst_res TCONF "Controller mounted on cgroup2 hierachy, skipping test"
+        return
+    fi
+
     create_subgroup "$start_path/ltp_2"
 
     if mv "$start_path/ltp_2" "$start_path/ltp_1" > /dev/null 2>&1; then
-        tst_resm TFAIL "Moved $start_path/ltp_2 over existing $start_path/ltp_1"
+        tst_res TFAIL "Moved $start_path/ltp_2 over existing $start_path/ltp_1"
         return
     fi
 
-    tst_resm TPASS "Failed to move $start_path/ltp_2 over existing $start_path/ltp_1"
+    tst_res TPASS "Failed to move $start_path/ltp_2 over existing $start_path/ltp_1"
 
     ROD rmdir "$start_path/ltp_2"
 }
@@ -97,77 +99,104 @@ test3()
 test4()
 {
     if ! attach_and_check "$pid" "$start_path/ltp_1"; then
-        tst_resm TFAIL "Failed to attach $pid to $start_path/ltp_1"
+        tst_res TFAIL "Failed to attach $pid to $start_path/ltp_1"
         return
     fi
 
     if rmdir "$start_path/ltp_1" > /dev/null 2>&1; then
-        tst_resm TFAIL "Removed $start_path/ltp_1 which contains task $pid"
-        create_subgroup "$start_path/ltp_1"
+        tst_res TFAIL "Removed $start_path/ltp_1 which contains task $pid"
         return
     fi
 
-    tst_resm TPASS "Group $start_path/ltp_1 with task $pid cannot be removed"
+    tst_res TPASS "Group $start_path/ltp_1 with task $pid cannot be removed"
 }
 
 # Group with a subgroup cannot be removed
 test5()
 {
+    # We need to move the tasks back to root to create a subgroup
+    if [ "$cgroup_version" = "2" ]; then
+        for pid in $(cat "$start_path/ltp_1/$task_list"); do
+		    echo $pid > "$mount_point/$task_list" 2> /dev/null
+	    done
+
+        ROD echo "+$subsystem" \> "$start_path/ltp_1/cgroup.subtree_control"
+    fi
+
     create_subgroup "$start_path/ltp_1/a"
 
     if rmdir "$start_path/ltp_1" > /dev/null 2>&1; then
-        tst_resm TFAIL "Removed $start_path/ltp_1 which contains subdir 'a'"
+        tst_res TFAIL "Removed $start_path/ltp_1 which contains subdir 'a'"
         return
     fi
 
-    tst_resm TPASS "Dir $start_path/ltp_1 with subdir 'a' cannot be removed"
+    tst_res TPASS "Dir $start_path/ltp_1 with subdir 'a' cannot be removed"
 
     ROD rmdir "$start_path/ltp_1/a"
 
-    ROD echo "$pid" \> "$start_path/tasks"
+    [ "$cgroup_version" = "2" ] && ROD echo "-$subsystem" \> "$start_path/ltp_1/cgroup.subtree_control"
+    ROD echo "$pid" \> "$start_path/ltp_1/$task_list"
 }
 
 # Group cannot be moved outside of hierarchy
 test6()
 {
+    # mv'ing cgroups is not available in cgroup2
+    if [ "$cgroup_version" = "2" ]; then
+        tst_res TCONF "Controller mounted on cgroup2 hierachy, skipping test"
+        return
+    fi
+
     if mv "$start_path/ltp_1" "$PWD/ltp" > /dev/null 2>&1; then
-        tst_resm TFAIL "Subgroup $start_path/ltp_1 outside hierarchy to $PWD/ltp"
+        tst_res TFAIL "Subgroup $start_path/ltp_1 outside hierarchy to $PWD/ltp"
         return
     fi
 
-    tst_resm TPASS "Subgroup $start_path/ltp_1 cannot be moved to $PWD/ltp"
+    tst_res TPASS "Subgroup $start_path/ltp_1 cannot be moved to $PWD/ltp"
 }
 
 # Tasks file cannot be removed
 test7()
 {
-    if rm "$start_path/ltp_1/tasks" > /dev/null 2>&1; then
-        tst_resm TFAIL "Tasks file $start_path/ltp_1/tasks could be removed"
+    if rm "$start_path/ltp_1/$task_list" > /dev/null 2>&1; then
+        tst_res TFAIL "Tasks file $start_path/ltp_1/$task_list could be removed"
         return
     fi
 
-    tst_resm TPASS "Tasks file $start_path/ltp_1/tasks cannot be removed"
+    tst_res TPASS "Tasks file $start_path/ltp_1/tasks cannot be removed"
 }
 
 # Test notify_on_release with invalid inputs
 test8()
 {
+    # notify_on_release is not available in cgroup2 so skip the test
+    if [ "$cgroup_version" = "2" ]; then
+        tst_res TCONF "Controller mounted on cgroup2 hierachy, skipping test"
+        return
+    fi
+
     if echo "-1" > "$start_path/ltp_1/notify_on_release" 2>/dev/null; then
-        tst_resm TFAIL "Can write -1 to $start_path/ltp_1/notify_on_release"
+        tst_res TFAIL "Can write -1 to $start_path/ltp_1/notify_on_release"
         return
     fi
 
     if echo "ltp" > "$start_path/ltp_1/notify_on_release" 2>/dev/null; then
-        tst_resm TFAIL "Can write ltp to $start_path/ltp_1/notify_on_release"
+        tst_res TFAIL "Can write ltp to $start_path/ltp_1/notify_on_release"
         return
     fi
 
-    tst_resm TPASS "Cannot write invalid values to $start_path/ltp_1/notify_on_release"
+    tst_res TPASS "Cannot write invalid values to $start_path/ltp_1/notify_on_release"
 }
 
 # Test that notify_on_release can be changed
 test9()
 {
+    # notify_on_release is not available in cgroup2 so skip the test
+    if [ "$cgroup_version" = "2" ]; then
+        tst_res TCONF "Controller mounted on cgroup2 hierachy, skipping test"
+        return
+    fi
+
     local notify=$(ROD cat "$start_path/ltp_1/notify_on_release")
     local value
 
@@ -178,37 +207,30 @@ test9()
     fi
 
     if ! echo "$value" > "$start_path/ltp_1/notify_on_release"; then
-        tst_resm TFAIL "Failed to set $start_path/ltp_1/notify_on_release to $value"
+        tst_res TFAIL "Failed to set $start_path/ltp_1/notify_on_release to $value"
         return
     fi
 
     ROD echo "$notify" \> "$start_path/ltp_1/notify_on_release"
 
-    tst_resm TPASS "Set $start_path/ltp_1/notify_on_release to $value"
+    tst_res TPASS "Set $start_path/ltp_1/notify_on_release to $value"
 }
 
-setup
-
-cgroup_fj_proc&
-pid=$!
-
-start_path="$mount_point/ltp"
-
-create_subgroup "$start_path"
-create_subgroup "$start_path/ltp_1"
-
-test1
-test2
-test3
-test4
-test5
-test6
-test7
-test8
-test9
+setup()
+{
+    common_setup
+    cgroup_fj_proc&
+    pid=$!
+    create_subgroup "$start_path/ltp_1"
+}
 
-ROD kill -9 $pid
-wait $pid
-ROD rmdir "$start_path/ltp_1"
+cleanup()
+{
+    kill -9 $pid >/dev/null 2>&1
+    wait $pid >/dev/null 2>&1
+    rmdir "$start_path/ltp_1" >/dev/null 2>&1
+    common_cleanup
+}
 
-tst_exit
+. cgroup_fj_common.sh
+tst_run
diff --git a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_proc.c b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_proc.c
index 93bc8b744..e3c1153cb 100644
--- a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_proc.c
+++ b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_proc.c
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
-/* Author: Shi Weihua <shiwh@cn.fujitsu.com>                                  */
-/*                                                                            */
-/******************************************************************************/
+// SPDX-License-Identifier: GPL-2.0-or-later
+// Copyright (c) 2009 FUJITSU LIMITED
+// Author: Shi Weihua <shiwh@cn.fujitsu.com>
 
 #include <sys/types.h>
 #include <sys/wait.h>
diff --git a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_stress.sh b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_stress.sh
index 01c2517c9..d80b83bbd 100755
--- a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_stress.sh
+++ b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_stress.sh
@@ -1,32 +1,16 @@
 #!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) 2009 FUJITSU LIMITED                                         ##
-##  Author: Shi Weihua <shiwh@cn.fujitsu.com>                                 ##
-## Copyright (c) 2015 Cedric Hnyda <chnyda@suse.com>                          ##
-## Copyright (c) 2015-2016 Cyril Hrubis <chrubis@suse.cz>                     ##
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
-## along with this program;  if not, write to the Free Software Foundation,   ##
-## Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA           ##
-##                                                                            ##
-################################################################################
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2009 FUJITSU LIMITED
+# Copyright (c) 2015 Cedric Hnyda <chnyda@suse.com>
+# Copyright (c) 2015-2016 Cyril Hrubis <chrubis@suse.cz>
+# Author: Shi Weihua <shiwh@cn.fujitsu.com>
 
 TCID="cgroup_fj_stress"
-TST_TOTAL=1
-
-. cgroup_fj_common.sh
+TST_CNT=1
+TST_TESTFUNC=test
+TST_SETUP=setup
+TST_CLEANUP=cleanup
+TST_POS_ARGS=4
 
 subsystem="$1"
 subgroup_num="$2"
@@ -47,35 +31,9 @@ usage_and_exit()
     echo "      each - attach process to each subgroup"
     echo "example: ./cgroup_fj_stress.sh cpuset 1 1 one"
     echo
-    tst_brkm TBROK "$1"
+    tst_brk TBROK "$1"
 }
 
-if [ "$#" -ne "4" ]; then
-    usage_and_exit "Wrong number of parameters, expected 4"
-fi
-
-case $subgroup_num in
-    ''|*[!0-9]*) usage_and_exit "Number of subgroups must be positive integer";;
-    *) ;;
-esac
-
-case $subgroup_depth in
-    ''|*[!0-9]*) usage_and_exit "Depth of the subgroup tree must be positive integer";;
-    *) ;;
-esac
-
-case $attach_operation in
-    'none'|'one'|'each');;
-    *) usage_and_exit "Invalid attach operation: $attach_operation";;
-esac
-
-setup
-
-export TMPFILE=./tmp_tasks.$$
-
-count=0
-collected_pids=
-
 build_subgroups()
 {
     local cur_path="$1"
@@ -87,6 +45,12 @@ build_subgroups()
     fi
 
     create_subgroup "$cur_path"
+
+    # We can only attach processes to the leaves of the tree in cgroup v2 which
+    # means we need to enable the controllers everywhere inbetween.
+    if [ "$cgroup_version" = "2" ] && [ "$cur_depth" -ne "$subgroup_depth" ]; then
+        ROD echo "+$subsystem" \> "$cur_path/cgroup.subtree_control"
+    fi
     count=$((count+1))
 
     for i in $(seq 1 $subgroup_num); do
@@ -113,8 +77,10 @@ attach_task()
         pid="$ppid"
     fi
 
-    if ! attach_and_check "$pid" "$cur_path"; then
+    if [ "$cgroup_version" = "2" ] && [ $cur_depth -eq $subgroup_depth ] || [ "$cgroup_version" = "1" ]; then
+        if ! attach_and_check "$pid" "$cur_path"; then
             fail=1
+        fi
     fi
 
     for i in $(seq 1 $subgroup_num); do
@@ -123,46 +89,79 @@ attach_task()
     done
 
     if [ -n "$ppid" ]; then
-        if ! attach_and_check "$pid" "$cur_path"; then
-            fail=1
+        if [ "$cgroup_version" = "2" ] && [ $cur_depth -eq $subgroup_depth ] || [ "$cgroup_version" = "1" ]; then
+            if ! attach_and_check "$pid" "$cur_path"; then
+                fail=1
+            fi
         fi
     fi
 }
 
-start_path="$mount_point/ltp"
+setup()
+{
+    export TMPFILE=./tmp_tasks.$$
+    count=0
+    collected_pids=
+
+    case $subgroup_num in
+        ''|*[!0-9]*) usage_and_exit "Number of subgroups must be possitive integer";;
+        *) ;;
+    esac
+
+    case $subgroup_depth in
+        ''|*[!0-9]*) usage_and_exit "Depth of the subgroup tree must be possitive integer";;
+        *) ;;
+    esac
+
+    case $attach_operation in
+        'none'|'one'|'each');;
+        *) usage_and_exit "Invalid attach operation: $attach_operation";;
+    esac
+
+    common_setup
+}
 
-tst_resm TINFO "Creating subgroups ..."
+cleanup()
+{
+    common_cleanup
+}
+
+test()
+{
+    tst_res TINFO "Creating subgroups ..."
 
-build_subgroups "$start_path" 0
+    build_subgroups "$start_path" 0
 
-tst_resm TINFO "... mkdired $count times"
+    tst_res TINFO "... mkdired $count times"
 
-case $attach_operation in
-"one" )
-    cgroup_fj_proc &
-    pid=$!
+    case $attach_operation in
+    "one" )
+        cgroup_fj_proc &
+        pid=$!
 
-    tst_resm TINFO "Moving one task around"
-    attach_task "$start_path" 0 "$pid"
-    ROD kill -9 "$pid"
-    wait "$pid"
-    ;;
-"each" )
-    tst_resm TINFO "Attaching task to each subgroup"
-    attach_task "$start_path" 0
-    for pid in $collected_pids; do
+        tst_res TINFO "Moving one task around"
+        attach_task "$start_path" 0 "$pid"
         ROD kill -9 "$pid"
         wait "$pid"
-    done
-    ;;
-*  )
-    ;;
-esac
-
-if [ -n "$fail" ]; then
-    tst_resm TFAIL "Attaching tasks failed!"
-else
-    tst_resm TPASS "All done!"
-fi
-
-tst_exit
+        ;;
+    "each" )
+        tst_res TINFO "Attaching task to each subgroup"
+        attach_task "$start_path" 0
+        for pid in $collected_pids; do
+            ROD kill -9 "$pid"
+            wait "$pid"
+        done
+        ;;
+    *  )
+        ;;
+    esac
+
+    if [ -n "$fail" ]; then
+        tst_res TFAIL "Attaching tasks failed!"
+    else
+        tst_res TPASS "All done!"
+    fi
+}
+
+. cgroup_fj_common.sh
+tst_run
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
