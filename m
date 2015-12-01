From: Yuan Sun <sunyuan3@huawei.com>
Date: Tue, 1 Dec 2015 11:30:46 +0800
Subject: [LTP] [PATCH V2] controllers:new testcase blkio1
Message-ID: <1448940646-32392-1-git-send-email-sunyuan3@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Yuan Sun <sunyuan3@huawei.com>
---
 runtest/controllers                               |  2 +
 testcases/kernel/controllers/blkio/blkio_setup.sh | 81 +++++++++++++++++++
 testcases/kernel/controllers/blkio/blkio_test1.sh | 94 +++++++++++++++++++++++
 3 files changed, 177 insertions(+)
 create mode 100755 testcases/kernel/controllers/blkio/blkio_setup.sh
 create mode 100755 testcases/kernel/controllers/blkio/blkio_test1.sh

diff --git a/runtest/controllers b/runtest/controllers
index 8033928..4fded75 100644
--- a/runtest/controllers
+++ b/runtest/controllers
@@ -367,3 +367,5 @@ cpuset_memory_spread	cpuset_memory_spread_testset.sh
 cpuset_regression_test cpuset_regression_test.sh
 
 cgroup_xattr	cgroup_xattr
+
+blkio1 blkio_test1.sh
diff --git a/testcases/kernel/controllers/blkio/blkio_setup.sh b/testcases/kernel/controllers/blkio/blkio_setup.sh
new file mode 100755
index 0000000..38caba4
--- /dev/null
+++ b/testcases/kernel/controllers/blkio/blkio_setup.sh
@@ -0,0 +1,81 @@
+#!/bin/bash
+# usage ./blkio_setup.sh
+
+################################################################################
+#  Copyright (c) Huawei Technologies Co., Ltd., 2015                           #
+#                                                                              #
+#  This program is free software;  you can redistribute it and/or modify       #
+#  it under the terms of the GNU General Public License as published by        #
+#  the Free Software Foundation; either version 2 of the License, or           #
+#  (at your option) any later version.                                         #
+#                                                                              #
+#  This program is distributed in the hope that it will be useful,             #
+#  but WITHOUT ANY WARRANTY;  without even the implied warranty of             #
+#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                   #
+#  the GNU General Public License for more details.                            #
+#                                                                              #
+#  You should have received a copy of the GNU General Public License           #
+#  along with this program.                                                    #
+#                                                                              #
+################################################################################
+################################################################################
+# Precaution:   Avoid system use by other applications/users to get fair and   #
+#               appropriate results (avoid unnecessary killing of applicatio)  #
+#                                                                              #
+################################################################################
+
+mounted=1
+
+# The cleanup function
+cleanup()
+{
+	tst_resm TINFO "removing created directories"
+	rmdir $testpath
+	tst_release_device
+	if [ "$mounted" -ne 1 ]; then
+		tst_resm TINFO "Umounting blkio"
+		umount $mount_point
+		rmdir $mount_point
+	fi
+}
+
+setup()
+{
+	tst_require_root
+	tst_tmpdir
+
+	grep -q -w blkio /proc/cgroups
+	if [ $? -ne 0 ]; then
+		tst_brkm TCONF "blkio not supported on this system"
+	fi
+
+	mount_point=`grep -w blkio /proc/mounts | cut -f 2 | \
+		cut -d " " -f2`
+	tst_resm TINFO "blkio: $mount_point"
+	if [ "$mount_point" = "" ]; then
+		mounted=0
+		mount_point=/dev/cgroup
+	fi
+
+	TST_CLEANUP=cleanup
+	testpath=$mount_point/ltp_$TCID
+	if [ -d $testpath ];then
+		rmdir $testpath
+	fi
+
+	if [ "$mounted" -eq "0" ]; then
+		ROD mkdir -p $mount_point
+		ROD mount -t cgroup -oblkio none $mount_point
+	fi
+	ROD mkdir $testpath
+
+	tst_acquire_device
+}
+
+# The usage of the script file
+usage()
+{
+	echo "Could not start blkio controller test";
+	echo "usage: run_blkio_test.sh <TEST_NUM>";
+	echo "Skipping the start blkio controller test...";
+}
diff --git a/testcases/kernel/controllers/blkio/blkio_test1.sh b/testcases/kernel/controllers/blkio/blkio_test1.sh
new file mode 100755
index 0000000..745b8d2
--- /dev/null
+++ b/testcases/kernel/controllers/blkio/blkio_test1.sh
@@ -0,0 +1,94 @@
+#!/bin/bash
+#############################################################################
+#  Copyright (c) Huawei Technologies Co., Ltd., 2015                        #
+#                                                                           #
+#  This program is free software;  you can redistribute it and/or modify    #
+#  it under the terms of the GNU General Public License as published by     #
+#  the Free Software Foundation; either version 2 of the License, or        #
+#  (at your option) any later version.                                      #
+#                                                                           #
+#  This program is distributed in the hope that it will be useful,          #
+#  but WITHOUT ANY WARRANTY;  without even the implied warranty of          #
+#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                #
+#  the GNU General Public License for more details.                         #
+#                                                                           #
+#############################################################################
+#                                                                           #
+# Description: This case is to test blkio which restrict the speed to       #
+#               1MB/s.                                                      #
+#                                                                           #
+#############################################################################
+
+
+export TCID="blkio_test1";
+export TST_TOTAL=1;
+export TST_COUNT=1;
+
+tst_kvercmp 2 6 30  2> /dev/null
+if [ $? -eq 0 ]; then
+        tst_brkm TCONF ignored \
+		"Test should be run with kernel 2.6.30 or newer"
+fi
+
+. test.sh
+. blkio_setup.sh
+
+tst_resm TINFO "BLKIO CONTROLLER TESTING";
+tst_resm TINFO "RUNNING SETUP.....";
+setup;
+
+tst_resm TINFO "TEST STARTED: Please avoid using system while this \
+	test executes";
+
+ROD echo $$ > ${testpath}/tasks
+
+#Limit the speed within 1MB/s.
+#echo "8:0  1048576" > $cg_path/ltp_group_1/blkio.throttle.read_bps_device
+echo "`stat -c %t:%T ${TST_DEVICE}` 1048576" > \
+	${testpath}/blkio.throttle.read_bps_device
+
+hdparm --direct -t ${TST_DEVICE} | grep 'Timing O_DIRECT disk reads' | \
+	sed 's/^.*= //' > hdparm_log
+speed=`awk '{print $1}' hdparm_log`
+unit=`awk '{print $2}' hdparm_log | sed 's/\/sec//'`
+
+if [ "$unit" = "MB" ];then
+	speed=`echo $speed \* 1024 | bc`
+elif [ "$unit" = "GB" ];then
+	speed=`echo $speed \* 1024 \* 1024 | bc`
+fi
+
+tst_resm TINFO "speed=$speed"
+result=`echo "$speed <= 1024.0" | bc`
+if [ $result -ne 1 ];then
+	cleanup
+	tst_brkm TFAIL \
+		"TFAIL the speed should be less than or equal to 1MB/s"
+fi
+
+#Disable the speed limitation.
+major_minor=`stat -c %t:%T ${TST_DEVICE}`
+tst_resm TINFO "TST_DEVICE=${TST_DEVICE} major_minor=${major_minor}"
+echo "${major_minor} 0  1048576" > $testpath/blkio.throttle.read_bps_device
+hdparm --direct -t ${TST_DEVICE} | grep 'Timing O_DIRECT disk reads' | \
+	sed 's/^.*= //' > hdparm_log
+speed=`awk '{print $1}' hdparm_log`
+unit=`awk '{print $2}' hdparm_log | sed 's/\/sec//'`
+
+if [ "$unit" = "MB" ];then
+	speed=`echo $speed \* 1024 | bc`
+elif [ "$unit" = "GB" ];then
+	speed=`echo $speed \* 1024 \* 1024 | bc`
+fi
+
+tst_resm TINFO "speed=${speed}"
+
+result=`echo "$speed > 1024.0" | bc`
+if [ $result -ne 1 ];then
+	cleanup
+	tst_brkm TFAIL "TFAIL the speed should be more than 1MB/s"
+fi
+
+cleanup
+tst_resm TPASS "${TCID} PASSED"
+
-- 
1.9.1

