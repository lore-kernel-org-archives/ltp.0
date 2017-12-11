From: Wang Long <wanglong19@meituan.com>
Date: Mon, 11 Dec 2017 12:23:35 -0500
Subject: [LTP] [PATCH 1/2] adjust io-throttle testcases
In-Reply-To: <1513013016-22819-1-git-send-email-wanglong19@meituan.com>
References: <1513013016-22819-1-git-send-email-wanglong19@meituan.com>
Message-ID: <1513013016-22819-2-git-send-email-wanglong19@meituan.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The current io-throttle testcases only can running on the very
old kernel which has the old block io cgroup interface. and the
cgroup name has renamed to blkio from blockio.

This patch update them.

Signed-off-by: Wang Long <wanglong19@meituan.com>
---
 .../io-throttle/io_throttle_testplan.txt           | 11 ++----
 .../controllers/io-throttle/myfunctions-io.sh      | 43 +++++++++++++---------
 .../io-throttle/run_io_throttle_test.sh            | 41 ++++++++-------------
 3 files changed, 45 insertions(+), 50 deletions(-)

diff --git a/testcases/kernel/controllers/io-throttle/io_throttle_testplan.txt b/testcases/kernel/controllers/io-throttle/io_throttle_testplan.txt
index fa5b85b..b726e40 100644
--- a/testcases/kernel/controllers/io-throttle/io_throttle_testplan.txt
+++ b/testcases/kernel/controllers/io-throttle/io_throttle_testplan.txt
@@ -21,15 +21,12 @@ limitations:
 Each test is considered passed only if the I/O limitations above are respected.
 
 Currently the following different scenarios are tested:
-- 1 single stream per cgroup using leaky-bucket I/O throttling
-- 1 single stream per cgroup using token-bucket I/O throttling
-- 2 parallel streams per cgroup using leaky-bucket I/O throttling
-- 2 parallel streams per cgroup using token-bucket I/O throttling
-- 4 parallel streams per cgroup using leaky-bucket I/O throttling
-- 4 parallel streams per cgroup using token-bucket I/O throttling
+- 1 single stream per cgroup I/O throttling
+- 2 parallel streams per cgroup I/O throttling
+- 4 parallel streams per cgroup I/O throttling
 
 For any other information please refer to
-Documentation/controllers/io-throttle.txt in kernel documentation.
+Documentation/cgroup-v1/blkio-controller.txt in kernel documentation.
 
 Questions?
 ----------
diff --git a/testcases/kernel/controllers/io-throttle/myfunctions-io.sh b/testcases/kernel/controllers/io-throttle/myfunctions-io.sh
index bf4bb2b..b604520 100755
--- a/testcases/kernel/controllers/io-throttle/myfunctions-io.sh
+++ b/testcases/kernel/controllers/io-throttle/myfunctions-io.sh
@@ -19,27 +19,34 @@
 #
 # usage . myfunctions.sh
 
+mounted=1
+
 setup()
 {
 	# create testcase cgroups
-	if [ -e /dev/blockioctl ]; then
-		echo "WARN: /dev/blockioctl already exist! overwriting."
-		cleanup
-	fi
-	mkdir /dev/blockioctl
-	mount -t cgroup -o blockio cgroup /dev/blockioctl
-	if [ $? -ne 0 ]; then
-		echo "ERROR: could not mount cgroup filesystem " \
-			" on /dev/blockioctl. Exiting test."
-		cleanup
-		exit 1
+	mount_point=`grep -w blkio /proc/mounts | cut -f 2 | cut -d " " -f2`
+	if [ "$mount_point" = "" ]; then
+		mounted=0
+		mount_point=/dev/cgroup
 	fi
+
+	if [ "$mounted" -eq "0" ]; then
+		mkdir -p $mount_point
+		mount -t cgroup -o blkio none $mount_point
+		if [ $? -ne 0 ]; then
+			echo "ERROR: could not mount cgroup filesystem " \
+			" on $mount_point. Exiting test."
+			cleanup
+			exit 1
+		fi
+        fi
+
 	for i in `seq 1 3`; do
-		if [ -e /dev/blockioctl/cgroup-$i ]; then
-			rmdir /dev/blockioctl/cgroup-$i
+		if [ -e $mount_point/cgroup-$i ]; then
+			rmdir $mount_point/cgroup-$i
 			echo "WARN: earlier cgroup-$i found and removed"
 		fi
-		mkdir /dev/blockioctl/cgroup-$i
+		mkdir $mount_point/cgroup-$i
 		if [ $? -ne 0 ]; then
 			echo "ERROR: could not create cgroup-$i" \
 				"Check your permissions. Exiting test."
@@ -53,9 +60,11 @@ cleanup()
 {
 	echo "Cleanup called"
 	for i in `seq 1 3`; do
-		rmdir /dev/blockioctl/cgroup-$i
+		rmdir $mount_point/cgroup-$i
 		rm -f /tmp/cgroup-$i.out
 	done
-	umount /dev/blockioctl
-	rmdir /dev/blockioctl
+	if [ "$mounted" -eq "0" ]; then
+		umount $mount_point
+		rmdir $mount_point
+	fi
 }
diff --git a/testcases/kernel/controllers/io-throttle/run_io_throttle_test.sh b/testcases/kernel/controllers/io-throttle/run_io_throttle_test.sh
index c855fd0..7e591be 100755
--- a/testcases/kernel/controllers/io-throttle/run_io_throttle_test.sh
+++ b/testcases/kernel/controllers/io-throttle/run_io_throttle_test.sh
@@ -25,12 +25,15 @@
 trap cleanup SIGINT
 
 BUFSIZE=16m
-DATASIZE=64m
+DATASIZE=320m
 
 setup
 
-# get the device name of the entire mounted block device
+# get the major and minor device type of the entire mounted block device
 dev=`df -P . | sed '1d' | cut -d' ' -f1 | sed 's/[p]*[0-9]*$//'`
+dev_major=`stat -L -c %t $dev`
+dev_minor=`stat -L -c %T $dev`
+devtype=`printf "%d:%d" 0x$dev_major 0x$dev_minor`
 
 # evaluate device bandwidth
 export MYGROUP=
@@ -49,22 +52,13 @@ for i in `seq 1 3`; do
 done
 
 for tasks in 1 2 4; do
-for strategy in 0 1; do
-	# set bw limiting rules
-	if [ -f /dev/blockioctl/blockio.bandwidth ]; then
-		io_throttle_file=blockio.bandwidth
-	elif [ -f /dev/blockioctl/blockio.bandwidth-max ]; then
-		io_throttle_file=blockio.bandwidth-max
-	else
-		echo "ERROR: unknown kernel ABI. Exiting test."
-		cleanup
-		exit 1
-	fi
 	for i in `seq 1 3`; do
 		limit=$(($phys_bw * 1024 / `echo 2^$i | bc`))
 		IOBW[$i]=$(($limit / 1024))
-		/bin/echo $dev:$limit:$strategy:$limit > \
-			/dev/blockioctl/cgroup-$i/${io_throttle_file}
+		/bin/echo "$devtype $limit" > \
+			$mount_point/cgroup-$i/blkio.throttle.read_bps_device
+		/bin/echo "$devtype $limit" > \
+			$mount_point/cgroup-$i/blkio.throttle.write_bps_device
 		if [ $? -ne 0 ]; then
 			echo "ERROR: could not set i/o bandwidth limit for cgroup-$i. Exiting test."
 			cleanup
@@ -79,14 +73,10 @@ for strategy in 0 1; do
 		stream="streams"
 	fi
 	echo -n ">> testing $tasks parallel $stream per cgroup "
-	if [ $strategy -eq 0 ]; then
-		echo "(leaky-bucket i/o throttling)"
-	else
-		echo "(token-bucket i/o throttling)"
-	fi
+	echo ""
 	for i in `seq 1 3`; do
 		MYGROUP=cgroup-$i
-		/bin/echo $$ > /dev/blockioctl/$MYGROUP/tasks
+		/bin/echo $$ > $mount_point/$MYGROUP/tasks
 		if [ $? -ne 0 ]; then
 			echo "ERROR: could not set i/o bandwidth limit for cgroup-$i. Exiting test."
 			cleanup
@@ -96,7 +86,7 @@ for strategy in 0 1; do
 		./iobw -direct $tasks $BUFSIZE $DATASIZE > /tmp/$MYGROUP.out &
 		PID[$i]=$!
 	done
-	/bin/echo $$ > /dev/blockioctl/tasks
+	/bin/echo $$ > $mount_point/tasks
 
 	# wait for children completion
 	for i in `seq 1 3`; do
@@ -104,7 +94,7 @@ for strategy in 0 1; do
 		wait ${PID[$i]}
 		ret=$?
 		if [ $ret -ne 0 ]; then
-			echo "ERROR: error code $ret during test $tasks.$strategy.$i. Exiting test."
+			echo "ERROR: error code $ret during test $tasks.$i. Exiting test."
 			cleanup
 			exit 1
 		fi
@@ -112,12 +102,11 @@ for strategy in 0 1; do
 		diff=$((${IOBW[$i]} - $iorate))
 		echo "($MYGROUP) i/o-bw ${IOBW[$i]} KiB/s, i/o-rate $iorate KiB/s, err $diff KiB/s"
 		if [ ${IOBW[$i]} -ge $iorate ]; then
-			echo "TPASS   Block device I/O bandwidth controller: test $tasks.$strategy.$i PASSED";
+			echo "TPASS   Block device I/O bandwidth controller: test $tasks.$i PASSED";
 		else
-			echo "TFAIL   Block device I/O bandwidth controller: test $tasks.$strategy.$i FAILED";
+			echo "TFAIL   Block device I/O bandwidth controller: test $tasks.$i FAILED";
 		fi
 	done
 done
-done
 
 cleanup
-- 
1.8.3.1

