Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FF37C433F5
	for <ltp@archiver.kernel.org>; Wed, 24 Nov 2021 08:04:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B6A5F3C65EF
	for <ltp@archiver.kernel.org>; Wed, 24 Nov 2021 09:04:31 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0B3813C08AA
 for <ltp@lists.linux.it>; Wed, 24 Nov 2021 09:04:22 +0100 (CET)
Received: from mail.jv-coder.de (mail.jv-coder.de [5.9.79.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1A40A2009C1
 for <ltp@lists.linux.it>; Wed, 24 Nov 2021 09:04:21 +0100 (CET)
Received: from ubuntu.localdomain (unknown [188.192.64.76])
 by mail.jv-coder.de (Postfix) with ESMTPSA id 3DBD59FA78;
 Wed, 24 Nov 2021 08:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jv-coder.de; s=dkim;
 t=1637741060; bh=w1ozTqRAmEeE2KpZ2idRq+9kABn5V5ClpO9xjHNkcjI=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=CH5LKDzhySCeqzFmkCIqbPd5LUwOoMhXhmPJmfjhKaJgzWch/i0orUNOADD5wpIwn
 XzcVYCUIFTPpZiwynpOnxko5hOKNPmEOoyA+KCq2dQpE1sQjt4FyUcWxosTL5X5FRA
 7NgIOwUQXhyFiR9AxScKkKut2FLO10Md6v3CBjRg=
From: Joerg Vehlow <lkml@jv-coder.de>
To: ltp@lists.linux.it,
	rpalethorpe@suse.de
Date: Wed, 24 Nov 2021 09:04:13 +0100
Message-Id: <20211124080413.768368-1-lkml@jv-coder.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] cpuset_regression_test: Fix test,
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
    because find and read work line-based
 2. Setting cpuset.cpus to an empty string is not allowed.
    -> If there are cpuset groups defined already, we need at least two cpus.
    One is used for the test, the other one is used for existing groups.
 3. Existing cgroup hierarchies were not handled correctly.
    When setting the cpuset.cpus, it must be done first for parent groups,
    otherwise cpu constraints for can be violated.

Fixes: 6950e96eabb2 ("cpuset_regression_test: Allow running, if groups exist")
Signed-off-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
---

Changes to v1:
 - Renamed breadth-first to parent-first
 - find -depth does not really do a depth-first search, so
   I also added cpuset_find_child_first
 - Resetting of backuped cpuset values could fail for nested child
   groups with cpu constraints. This is fixed by also resetting all
   groups to all cpus before restoring the backup 
 - Removed inline comments 


 .../cpuset/cpuset_regression_test.sh          | 86 ++++++++++++++++---
 1 file changed, 74 insertions(+), 12 deletions(-)

diff --git a/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh b/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh
index cc6bfdc64..a6806b7b0 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh
@@ -21,32 +21,79 @@ TST_MIN_KVER="3.18"
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
+	find ${root_cpuset_dir} -mindepth 1 -type d -exec echo 1 \; -quit
+}
+
+# cpuset_find_parent_first <what>
+# Do a parent first find of <what>
+cpuset_find_parent_first()
+{
+	local what=$1
+
+	find . -mindepth 2 -name ${what} |
+	    awk '{print length($0) " " $0}' |
+	    sort -n | cut -d " " -f 2-
+}
+
+# cpuset_find_child_first <what>
+# Do a child first find of <what>
+cpuset_find_child_first()
+{
+	local what=$1
+
+	find . -mindepth 2 -name ${what} |
+	    awk '{print length($0) " " $0}' |
+	    sort -nr | cut -d " " -f 2-
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
+
+	cpuset_find_parent_first ${what} |
+	while read -r file; do
+		[ "$(cat "${file}")" = "" ] && continue
+
 		mkdir -p "$(dirname "${backup_dir}/${file}")"
 		cat "${file}" > "${backup_dir}/${file}"
-		echo "${value}" > "${file}"
+		echo "0-$cpu_max" > "${file}" || exit 1
+	done
+	if [ $? -ne 0 ]; then
+		cd $old_dir
+		return 1
+	fi
+
+	cpuset_find_child_first ${what} |
+	while read -r file; do
+		[ "$(cat "${file}")" = "" ] && continue
+		echo "1" > "${file}"
 	done
+	res=$?
 
 	cd $old_dir
+
+	return $res
 }
 
 # cpuset_restore <backup_dir> <what>
@@ -57,10 +104,17 @@ cpuset_restore()
 	local backup_dir=$1
 	local what=$2
 	local old_dir=$PWD
+	local cpu_max=$((cpu_num - 1))
 
 	cd ${backup_dir}
-	find . -mindepth 2 -name ${what} -print0 |
-	while IFS= read -r -d '' file; do
+
+	cpuset_find_parent_first ${what} |
+	while read -r file; do
+		echo "0-$cpu_max" > "${root_cpuset_dir}/${file}"
+	done
+
+	cpuset_find_child_first ${what} |
+	while read -r file; do
 		cat "${file}" > "${root_cpuset_dir}/${file}"
 	done
 
@@ -91,10 +145,18 @@ setup()
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
