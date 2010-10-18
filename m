Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1P7v4a-0005TM-ET
	for ltp-list@lists.sourceforge.net; Mon, 18 Oct 2010 19:08:40 +0000
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
	by mx2.suse.de (Postfix) with ESMTP id A3DD34844E
	for <ltp-list@lists.sourceforge.net>;
	Mon, 18 Oct 2010 21:08:31 +0200 (CEST)
Date: Mon, 18 Oct 2010 21:17:51 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20101018191751.GA15940@saboteur.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline
Subject: [LTP] [PATCH] fix dos end-of-line in modaltr.sh
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!
Following patch just converts modaltr.sh from dos to unix end-of-line
encoding; without this you just get:

bash$ ./modaltr.sh
bash: ./modaltr.sh: /bin/sh^M: bad interpreter: No such file or directory

Signed-off-by: Cyril Hrubis chrubis@suse.cz

-- 
Cyril Hrubis
chrubis@suse.cz

--wRRV7LY7NUeQGEoC
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="fix_modaltr_script_eol.patch"

Index: ltp-full-20100831/testcases/kernel/fs/fs-bench/modaltr.sh
===================================================================
--- ltp-full-20100831.orig/testcases/kernel/fs/fs-bench/modaltr.sh
+++ ltp-full-20100831/testcases/kernel/fs/fs-bench/modaltr.sh
@@ -1,124 +1,124 @@
-#!/bin/sh
-#To run this script the following is necessary 
-# 1.kernel should mtd support as module.
-# 2.kernel should hsve jffs2 support as module.
-# 3.kernel should have loopback device support .
-# 4.you should have fs-bench utility (http://h2np.net/tools/fs-bench-0.2.tar.gz)
-# 5.results will be copied to /tmp/log and /tmp/log1 files 
-
-#DESCRIPTION: This testscript creates a jffs2 file system type and tests the filesytem test
-#and places the log in the log directory.The file system test actually creates a tree of large
-#directories and performs the delete and random delete operations as per the filesystem stress 
-#algorithim and gives a report of real time ,user time,system time taken to perform the file
-#operations. 
-
-#script created  G.BANU PRAKASH (mailto:prakash.banu@wipro.com).
-#
-#   This program is free software;  you can redistribute it and/or modify
-#   it under the terms of the GNU General Public License as published by
-#   the Free Software Foundation; either version 2 of the License, or
-#   (at your option) any later version.
-#
-#   This program is distributed in the hope that it will be useful,
-#   but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#   the GNU General Public License for more details.
-#
-#   You should have received a copy of the GNU General Public License
-#   along with this program;  if not, write to the Free Software
-#   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
-#
-
-MTD_RAM=mtdram
-MTD_BLOCK=mtdblock
-JFFS2=jffs2
-LOOP=loop
-MTD_BLKDEVS=mtd_blkdevs
-ZLIB_DEFLATE=zlib_deflate
-ZLIB_INFLATE=zlib_inflate
-MTD_CORE=mtdcore
-MOUNT_DIR=/mnt
-LOG_DIR=/tmp/log
-LOG_DIR1=/tmp/log1
-HOME_DIR=/home
-BLOCK_DIR=/dev/mtdblock
-export PATH=$PATH:/sbin
-	if [ $(id -ru) -ne 0 ]; 
-then 
-	echo "must be root to run this"
-	exit
-fi
-
-
-
-lsmod |grep $MTD_RAM
-
-	if [ $? -ne 0 ]; 
-then
-	echo "inserting mtd ram and its dependencies"
-fi 
-modprobe $MTD_RAM  total_size=32768 erase_size=256  
-	if [ $? -ne 0 ]; 
-then
-	echo "check wheather MTD -mtdram is been compiled in the kernel" 
-fi
-lsmod |grep $MTD_BLOCK
-	if [ $? -ne 0 ]; then
-	echo "inserting mtdblock  and its dependencies" 
-fi
-modprobe $MTD_BLOCK
-	if [ $? -ne 0 ]; then
-	echo "check wheather mtdblock is been compiled in the kernel"
-fi
- 
-lsmod |grep $JFFS2 
-	if [ $? -ne 0 ]; then
-	echo "inserting jffs2  and its dependencies"
-fi
-modprobe $JFFS2 
-	if [ $? -ne 0 ]; then
-	echo "check wheather jffs2 is been compiled in the kernel"
-fi
-
-lsmod |grep $LOOP
-	if [ $? -ne 0 ]; then
-	echo "inserting loopback device module"
-fi
-modprobe $LOOP
-	if [ $? -ne 0 ]; then
-	echo "check wheather loopback device option is been compiled in the kernel"
-fi
-mkdir -p $BLOCK_DIR
-mknod $BLOCK_DIR/0 b 31 0 2>&1 > /dev/null
-mount -t jffs2 $BLOCK_DIR/0 $MOUNT_DIR 
-mount|grep $JFFS2 
-	if [ $? -eq 0 ]; then 
- echo "jffs2 mounted sucessfully"
-	else 
- echo "mount unsucessfull"
-fi
-cd $MOUNT_DIR 
-echo "This is will take long time "
-./test.sh    >log 2>&1
-./test2.sh    >log1 2>&1
-
-mv log   $LOG_DIR
-mv log1  $LOG_DIR1
-cd $HOME_DIR
-
-
-#cleanup 
-echo "unmounting $MOUNT_DIR "
-umount $MOUNT_DIR
-echo "removing the modules inserted"
-rmmod  $MTD_BLOCK
-rmmod  $MTD_BLKDEVS
-rmmod  $LOOP
-rmmod  $JFFS2
-rmmod  $ZLIB_DEFLATE
-rmmod  $ZLIB_INFLATE
-rmmod  $MTD_RAM
-rmmod  $MTD_CORE
-rm -rf /dev/mtdblock
-echo "TEST COMPLETE"
-echo "RESULTS LOGGED IN FILE  /tmp/log and /tmp/log1  "
+#!/bin/sh
+#To run this script the following is necessary
+# 1.kernel should mtd support as module.
+# 2.kernel should hsve jffs2 support as module.
+# 3.kernel should have loopback device support.
+# 4.you should have fs-bench utility (http://h2np.net/tools/fs-bench-0.2.tar.gz)
+# 5.results will be copied to /tmp/log and /tmp/log1 files
+
+#DESCRIPTION: This testscript creates a jffs2 file system type and tests the filesytem test
+#and places the log in the log directory.The file system test actually creates a tree of large
+#directories and performs the delete and random delete operations as per the filesystem stress
+#algorithim and gives a report of real time ,user time,system time taken to perform the file
+#operations.
+
+#script created  G.BANU PRAKASH (mailto:prakash.banu@wipro.com).
+#
+#   This program is free software;  you can redistribute it and/or modify
+#   it under the terms of the GNU General Public License as published by
+#   the Free Software Foundation; either version 2 of the License, or
+#   (at your option) any later version.
+#
+#   This program is distributed in the hope that it will be useful,
+#   but WITHOUT ANY WARRANTY;  without even the implied warranty of
+#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+#   the GNU General Public License for more details.
+#
+#   You should have received a copy of the GNU General Public License
+#   along with this program;  if not, write to the Free Software
+#   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+#
+
+MTD_RAM=mtdram
+MTD_BLOCK=mtdblock
+JFFS2=jffs2
+LOOP=loop
+MTD_BLKDEVS=mtd_blkdevs
+ZLIB_DEFLATE=zlib_deflate
+ZLIB_INFLATE=zlib_inflate
+MTD_CORE=mtdcore
+MOUNT_DIR=/mnt
+LOG_DIR=/tmp/log
+LOG_DIR1=/tmp/log1
+HOME_DIR=/home
+BLOCK_DIR=/dev/mtdblock
+export PATH=$PATH:/sbin
+	if [ $(id -ru) -ne 0 ];
+then
+	echo "must be root to run this"
+	exit
+fi
+
+
+
+lsmod |grep $MTD_RAM
+
+	if [ $? -ne 0 ];
+then
+	echo "inserting mtd ram and its dependencies"
+fi
+modprobe $MTD_RAM  total_size=32768 erase_size=256
+	if [ $? -ne 0 ];
+then
+	echo "check wheather MTD -mtdram is been compiled in the kernel"
+fi
+lsmod |grep $MTD_BLOCK
+	if [ $? -ne 0 ]; then
+	echo "inserting mtdblock  and its dependencies"
+fi
+modprobe $MTD_BLOCK
+	if [ $? -ne 0 ]; then
+	echo "check wheather mtdblock is been compiled in the kernel"
+fi
+
+lsmod |grep $JFFS2
+	if [ $? -ne 0 ]; then
+	echo "inserting jffs2  and its dependencies"
+fi
+modprobe $JFFS2
+	if [ $? -ne 0 ]; then
+	echo "check wheather jffs2 is been compiled in the kernel"
+fi
+
+lsmod |grep $LOOP
+	if [ $? -ne 0 ]; then
+	echo "inserting loopback device module"
+fi
+modprobe $LOOP
+	if [ $? -ne 0 ]; then
+	echo "check wheather loopback device option is been compiled in the kernel"
+fi
+mkdir -p $BLOCK_DIR
+mknod $BLOCK_DIR/0 b 31 0 2>&1 > /dev/null
+mount -t jffs2 $BLOCK_DIR/0 $MOUNT_DIR
+mount|grep $JFFS2
+	if [ $? -eq 0 ]; then
+ echo "jffs2 mounted sucessfully"
+	else
+ echo "mount unsucessfull"
+fi
+cd $MOUNT_DIR
+echo "This is will take long time"
+./test.sh    >log 2>&1
+./test2.sh    >log1 2>&1
+
+mv log   $LOG_DIR
+mv log1  $LOG_DIR1
+cd $HOME_DIR
+
+
+#cleanup
+echo "unmounting $MOUNT_DIR"
+umount $MOUNT_DIR
+echo "removing the modules inserted"
+rmmod  $MTD_BLOCK
+rmmod  $MTD_BLKDEVS
+rmmod  $LOOP
+rmmod  $JFFS2
+rmmod  $ZLIB_DEFLATE
+rmmod  $ZLIB_INFLATE
+rmmod  $MTD_RAM
+rmmod  $MTD_CORE
+rm -rf /dev/mtdblock
+echo "TEST COMPLETE"
+echo "RESULTS LOGGED IN FILE  /tmp/log and /tmp/log1"

--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Download new Adobe(R) Flash(R) Builder(TM) 4
The new Adobe(R) Flex(R) 4 and Flash(R) Builder(TM) 4 (formerly 
Flex(R) Builder(TM)) enable the development of rich applications that run
across multiple browsers and platforms. Download your free trials today!
http://p.sf.net/sfu/adobe-dev2dev
--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--wRRV7LY7NUeQGEoC--

