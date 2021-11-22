Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7329C433EF
	for <ltp@archiver.kernel.org>; Mon, 22 Nov 2021 14:14:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EDB9A3C8DB4
	for <ltp@archiver.kernel.org>; Mon, 22 Nov 2021 15:14:14 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E10DB3C0D0B
 for <ltp@lists.linux.it>; Mon, 22 Nov 2021 15:14:04 +0100 (CET)
Received: from mail.jv-coder.de (mail.jv-coder.de [5.9.79.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E12FC1400778
 for <ltp@lists.linux.it>; Mon, 22 Nov 2021 15:14:03 +0100 (CET)
Received: from ubuntu.localdomain (unknown [188.195.115.12])
 by mail.jv-coder.de (Postfix) with ESMTPSA id 4DED09F6A0;
 Mon, 22 Nov 2021 14:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jv-coder.de; s=dkim;
 t=1637590442; bh=/W36/tIwVaAXhMf2OiberCsEVv8b/Z/iim8mbiZbAtA=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=tTXHUAM+6kXbCg0zC1Sm6qlqPOtE4n3n04g7SxhWtxNzA/P8BrnwUtSMgpIvQmyr0
 /bKa9iswkGCdmMMgUoNVwaMWryllxuu8wStFEoHWh88RgZ5il3Csg499tbKqnSf08W
 nstuCN7j7XJBYhP7arVxRbiyvsMH7vAeB6ICo82E=
From: Joerg Vehlow <lkml@jv-coder.de>
To: ltp@lists.linux.it,
	rpalethorpe@suse.de
Date: Mon, 22 Nov 2021 15:13:55 +0100
Message-Id: <20211122141355.299621-1-lkml@jv-coder.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] cpuset_regression_test: Fix test,
 if cpuset groups exist already
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
Cc: Joerg Vehlow <joerg.vehlow@aox-tech.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Joerg Vehlow <joerg.vehlow@aox-tech.de>

Fix three errors:
 1. read -d is not posix, but not even required,
    because find and read work  line-based
 2. Setting cpuset.cpus to an empty string is not allowed.
    -> If there are cpuset groups defined already, we need at least to cpus.
    One is used for the test, the other one is used for existing groups.
 3. Existing cgroup hierarchies were not handled correctly.
    When setting  the cpuset.cpus, it must be done breadth-first, otherwise
    cpu constraints for parent groups can be violated.

Fixes: 6950e96eabb2 ("cpuset_regression_test: Allow running, if groups exist")
Signed-off-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
---

@Richard Sorry for so many bugs in the patch... I guess I way a bit tired


 .../cpuset/cpuset_regression_test.sh          | 84 ++++++++++++++++---
 1 file changed, 72 insertions(+), 12 deletions(-)

diff --git a/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh b/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh
index cc6bfdc64..f6447a656 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh
@@ -21,32 +21,80 @@ TST_MIN_KVER="3.18"
 LOCAL_MOUNTPOINT="cpuset_test"
 BACKUP_DIRECTORY="cpuset_backup"
 
+cpu_num=
 root_cpuset_dir=
 cpu_exclusive="cpuset.cpu_exclusive"
 cpus="cpuset.cpus"
 old_cpu_exclusive_value=1
 
-# cpuset_backup_and_update <backup_dir> <what> <value>
+# Check if there are cpuset groups
+cpuset_has_groups()
+{
+	local old_dir=$PWD
+	local result=0
+
+	find ${root_cpuset_dir} -mindepth 1 -type d -exec echo 1 \; -quit
+}
+
+# cpuset_find_breadth_first <what>
+# Do a breath first find of <what>
+cpuset_find_breadth_first()
+{
+	local what=$1
+
+	# Breath first find implementation:
+	# Use awk to prepend the length of the path, sort it
+	# and remove the length again.
+	# Since all commands work line-based,
+	# this works with meta characters and spaces.
+	find . -mindepth 2 -name ${what} | 
+	    awk '{print length($0) " " $0}' | 
+	    sort -n | cut -d " " -f 2-
+}
+
+# cpuset_backup_and_update <backup_dir> <what>
 # Create backup of the values of a specific file (<what>)
-# in all cpuset groups and set the value to <value>
+# in all cpuset groups and set the value to 1
 # The backup is written to <backup_dir> in the same structure
 # as in the cpuset filesystem
 cpuset_backup_and_update()
 {
 	local backup_dir=$1
 	local what=$2
-	local value=$3
 	local old_dir=$PWD
+	local cpu_max=$((cpu_num - 1))
+	local res
 
 	cd ${root_cpuset_dir}
-	find . -mindepth 2 -name ${what} -print0 |
-	while IFS= read -r -d '' file; do
+
+	# First do breath-first search and set all groups to use all cpus.
+	# Breath-first is important, because the parent groups
+	# must have all cpus assigned to a child group first
+	cpuset_find_breadth_first ${what} |
+	while read -r file; do
+		# Skip cgroups with no set cpuset
+		[ "$(cat "${file}")" = "" ] && continue
+
 		mkdir -p "$(dirname "${backup_dir}/${file}")"
 		cat "${file}" > "${backup_dir}/${file}"
-		echo "${value}" > "${file}"
+		echo "0-${cpu_max}" > "${file}" || exit 1
 	done
+	if [ $? -ne 0 ]; then
+		cd $old_dir
+	 	return 1
+	fi
+
+	# Now do depth first and limit the cpus to cpu 1
+	find . -depth -mindepth 2 -name ${what} |
+	while read -r file; do
+		[ "$(cat "${file}")" = "" ] && continue
+		echo "1" > "${file}"
+	done
+	res=$?
 
 	cd $old_dir
+
+	return $res
 }
 
 # cpuset_restore <backup_dir> <what>
@@ -59,8 +107,12 @@ cpuset_restore()
 	local old_dir=$PWD
 
 	cd ${backup_dir}
-	find . -mindepth 2 -name ${what} -print0 |
-	while IFS= read -r -d '' file; do
+
+	# Do a breath-first restore.
+	# This works, because cpusets set on parents, automatically
+	# limit the set for the child.
+	cpuset_find_breadth_first ${what} |
+	while read -r file; do
 		cat "${file}" > "${root_cpuset_dir}/${file}"
 	done
 
@@ -91,10 +143,18 @@ setup()
 		tst_brk TBROK "Both cpuset.cpu_exclusive and cpu_exclusive do not exist"
 	fi
 
-	# Ensure that no group explicitely uses a cpu,
-	# otherwise setting cpuset.cpus for the testgroup will fail
-	mkdir ${BACKUP_DIRECTORY}
-	cpuset_backup_and_update "${PWD}/${BACKUP_DIRECTORY}" ${cpus} ""
+	# Ensure that we can use cpu 0 exclusively
+	if [ "$(cpuset_has_groups)" = "1" ]; then
+		cpu_num=$(tst_getconf _NPROCESSORS_ONLN)
+		if [ $cpu_num -lt 2 ]; then
+			tst_brk TCONF "There are already cpuset groups, so at least two cpus are required."
+		fi
+
+		# Use cpu 1 for all existing cpuset cgroups
+		mkdir ${BACKUP_DIRECTORY}
+		cpuset_backup_and_update "${PWD}/${BACKUP_DIRECTORY}" ${cpus}
+		[ $? -ne 0 ] && tst_brk TBROK "Unable to prepare existing cpuset cgroups"
+	fi
 
 	old_cpu_exclusive_value=$(cat ${root_cpuset_dir}/${cpu_exclusive})
 	if [ "${old_cpu_exclusive_value}" != "1" ];then
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
