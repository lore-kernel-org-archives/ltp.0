Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1Y9WeW-0002oU-J6
	for ltp-list@lists.sourceforge.net; Fri, 09 Jan 2015 10:18:48 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Y9WeQ-0002nN-KY
	for ltp-list@lists.sourceforge.net; Fri, 09 Jan 2015 10:18:48 +0000
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t09AHn0l006243
	for <ltp-list@lists.sourceforge.net>; Fri, 9 Jan 2015 18:17:49 +0800
Message-ID: <1420798668.13049.6.camel@G08JYZSD130126.localdomain>
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Fri, 9 Jan 2015 18:17:48 +0800
MIME-Version: 1.0
Subject: [LTP] [PATCH 1/2] stress_floppy: Cleanup
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list <ltp-list@lists.sourceforge.net>

* Delete 'trace_logic' that is used to debug.

* Use 'test.sh' and 'tst_*'.

* Use 'tst_tmpdir' and 'tst_rmdir'.

* Use '$()' instead of '``'.

* Some cleanup.

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 testcases/kernel/io/stress_floppy/stress_floppy | 389 ++++++++++++------------
 1 file changed, 192 insertions(+), 197 deletions(-)

diff --git a/testcases/kernel/io/stress_floppy/stress_floppy b/testcases/kernel/io/stress_floppy/stress_floppy
index a635d64..853ec22 100755
--- a/testcases/kernel/io/stress_floppy/stress_floppy
+++ b/testcases/kernel/io/stress_floppy/stress_floppy
@@ -29,229 +29,227 @@
 #
 #
 #---------------------------------------------------------------------------
-#Uncomment line below for debug output
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
 
+TCdat=${TCdat:-$(pwd)}
 
-#SET VARIABLES
+TCID="io_floppy"
+TST_TOTAL=7
+. test.sh
 
-TCtmp=${TCtmp:-/tmp}
-TCdat=${TCdat:-`pwd`}
+setup()
+{
+	tst_tmpdir
+
+	tst_check_cmds fdformat tar dump cpio dd mkfs mkdosfs
+
+	TCtmp=$(pwd)
+}
+
+cleanup()
+{
+	tst_rmdir
+}
 
 
-test_for_device() {
-$trace_logic
-  cat /proc/devices | grep fd
-  if [ $? = 0 ]; then
-   num_device=`ls /dev | grep fd0 | wc -l`
-   if [ $num_device = 0 ]; then
-    echo "No floppy diskette drive available!"
-    exit 1
-   else
-    echo "Floppy diskette drive fd0 available."
-   fi
-  fi
+test_for_device()
+{
+	grep fd /proc/devices
+	if [ $? = 0 ]; then
+		num_device=$(ls /dev | grep fd0 | wc -l)
+		if [ $num_device = 0 ]; then
+			tst_brkm TCONF "No floppy diskette drive available!"
+		else
+			tst_resm TINFO "Floppy diskette drive fd0 available."
+		fi
+	else
+		tst_brkm TCONF "No floppy diskette drive available!"
+	fi
 }
 
-test_format() {
-$trace_logic
-echo "Testing format..."
-fdformat  /dev/fd0
-  if [ $? -ne 0 ]; then
-    echo "Format failed!"
-    exit 1
-  else
-    echo "Format successful."
-  fi
+test_format()
+{
+	tst_resm TINFO "Testing format..."
+	fdformat  /dev/fd0
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "Format failed!"
+	else
+		tst_resm TPASS "Format successful."
+	fi
 }
 
-test_tar() {
-$trace_logic
-for the_file in `echo 1K_file 10K_file 100K_file 1000K_file`
-do
-  echo "Testing $the_file tar..."
-  cd $TCdat
-  tar -cvf /dev/fd0 $the_file
-  if [ $? -ne 0 ]; then
-    echo "$the_file Tar write failed!"
-    exit 1
-  else
-    echo "$the_file Tar write passed."
-  fi
-  cd $TCtmp
-  if [ $? -ne 0 ]; then
-    echo "Could not change to /tmp directory!"
-    exit 1
-  fi
-  tar -xvf /dev/fd0
-  if [ $? -ne 0 ]; then
-    echo "$the_file Tar read failed!"
-    exit 1
-  else
-    echo "$the_file Tar read passed."
-  fi
-  diff $TCdat/$the_file $TCtmp/$the_file 2>&1 >/dev/null
-  if [ $? -ne 0 ]; then
-    echo "Diff of the $the_file tar files failed!"
-    exit 1
-  else
-    echo "Diff of the $the_file tar files passed."
-  fi
-  rm -f $TCtmp/$the_file
-done
+test_tar()
+{
+	for the_file in 1K_file 10K_file 100K_file 1000K_file
+	do
+		tst_resm TINFO "Testing $the_file tar..."
+		tar -C $TCdat -cvf /dev/fd0 $the_file
+		if [ $? -ne 0 ]; then
+			tst_resm TFAIL "$the_file Tar write failed!"
+			return
+		else
+			tst_resm TINFO "$the_file Tar write passed."
+		fi
+		tar -xvf /dev/fd0
+		if [ $? -ne 0 ]; then
+			tst_resm TFAIL "$the_file Tar read failed!"
+			return
+		else
+			tst_resm TINFO "$the_file Tar read passed."
+		fi
+		diff $TCdat/$the_file $the_file 2>&1 >/dev/null
+		if [ $? -ne 0 ]; then
+			tst_resm TFAIL "Diff of the $the_file tar files failed!"
+			return
+		else
+			tst_resm TINFO "Diff of the $the_file tar files passed."
+		fi
+		rm -f $the_file
+	done
+	tst_resm TPASS "test_tar: PASS."
 }
 
-test_dump() {
-$trace_logic
-echo "Testing dump/restore..."
-cp -r $TCdat/dumpdir $TCtmp
-if [ $? -ne 0 ]; then
-  echo "Could not create dumpdir directory in $TCtmp"
-  exit 1
-fi
+test_dump()
+{
+	tst_resm TINFO "Testing dump/restore..."
+	cp -r $TCdat/dumpdir ./
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "Could not create dumpdir directory in $TCtmp"
+		return
+	fi
 
-cd $TCtmp
-if [ $? -ne 0 ]; then
-  echo "Could not change to $TCtmp directory!"
-  exit 1
-fi
+	dump -f /dev/fd0 dumpdir
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "$the_file dump write failed!"
+		return
+	else
+		tst_resm TINFO "$the_file dump write passed."
+	fi
 
-dump -f /dev/fd0 dumpdir
-if [ $? -ne 0 ]; then
-  echo "$the_file dump write failed!"
-  exit 1
-else
-  echo "$the_file dump write passed."
-fi
+	rm -rf dumpdir
+	cd /
 
-rm -rf $TCtmp/dumpdir
-cd /
+	restore -v -r -f /dev/fd0 2>/dev/null
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "$the_file restore read failed!"
+		return
+	else
+		tst_resm TINFO "$the_file restore read passed."
+	fi
 
-restore -v -r -f /dev/fd0 2>/dev/null
-if [ $? -ne 0 ]; then
-  echo "$the_file restore read failed!"
-  exit 1
-else
-  echo "$the_file restore read passed."
-fi
+	cd -
 
-for the_file in `echo 1K_file 10K_file 100K_file`
-do
-  diff $TCtmp/dumpdir/$the_file /$TCdat/dumpdir/$the_file 2>&1 >/dev/null
-  if [ $? -ne 0 ]; then
-    echo "Diff of the $the_file backup files failed!"
-    exit 1
-  else
-    echo "Diff of the $the_file backup files passed."
-  fi
-done
-rm -rf $TCtmp/dumpdir
-rm -f $TCtmp/restoresymtable
+	for the_file in 1K_file 10K_file 100K_file
+	do
+		diff dumpdir/$the_file /$TCdat/$the_file 2>&1 >/dev/null
+		if [ $? -ne 0 ]; then
+			tst_resm TFAIL \
+				 "Diff of the $the_file backup files failed!"
+			return
+		else
+			tst_resm TINFO \
+				 "Diff of the $the_file backup files passed."
+		fi
+	done
+	tst_resm TPASS "test_dump: PASS."
+	rm -rf dumpdir
+	rm -f restoresymtable
 }
 
-test_cpio() {
-$trace_logic
-for the_file in `echo 1K_file 10K_file 100K_file 1000K_file`
-do
-  echo "Testing $the_file cpio..."
-  cd $TCdat
-  echo $the_file | cpio -o > /dev/fd0
-  if [ $? -ne 0 ]; then
-    echo "$the_file cpio write failed!"
-    exit 1
-  else
-    echo "$the_file cpio write passed."
-  fi
-  cd $TCtmp
-  if [ $? -ne 0 ]; then
-    echo "Could not change to $TCtmp directory!"
-    exit 1
-  fi
-  cpio -i < /dev/fd0
-  if [ $? -ne 0 ]; then
-    echo "$the_file cpio read failed!"
-    exit 1
-  else
-    echo "$the_file cpio read passed."
-  fi
-  diff $TCdat/$the_file $TCtmp/$the_file 2>&1 >/dev/null
-  if [ $? -ne 0 ]; then
-    echo "Diff of the $the_file cpio files failed!"
-    exit 1
-  else
-    echo "Diff of the $the_file cpio files passed."
-  fi
-  rm -f $TCtmp/$the_file
-done
+test_cpio()
+{
+	for the_file in 1K_file 10K_file 100K_file 1000K_file
+	do
+		tst_resm TINFO "Testing $the_file cpio..."
+		cd $TCdat
+		echo $the_file | cpio -o > /dev/fd0
+		if [ $? -ne 0 ]; then
+			tst_resm TFAIL "$the_file cpio write failed!"
+			return
+		else
+			tst_resm TINFO "$the_file cpio write passed."
+		fi
+		cd $TCtmp
+		if [ $? -ne 0 ]; then
+			tst_resm TFAIL "Could not change to $TCtmp directory!"
+			return
+		fi
+		cpio -i < /dev/fd0
+		if [ $? -ne 0 ]; then
+			tst_resm TFAIL "$the_file cpio read failed!"
+			return
+		else
+			tst_resm TINFO "$the_file cpio read passed."
+		fi
+		diff $TCdat/$the_file $the_file 2>&1 >/dev/null
+		if [ $? -ne 0 ]; then
+			tst_resm TFAIL \
+				 "Diff of the $the_file cpio files failed!"
+			return
+		else
+			tst_resm TINFO \
+				 "Diff of the $the_file cpio files passed."
+		fi
+		rm -f $the_file
+	done
+	tst_resm TPASS "test_cpio: PASS."
 }
 
-test_dd() {
-$trace_logic
-for the_file in `echo dd_file`
-do
-  echo "Testing $the_file dd..."
-  cd $TCdat
-  if [ $? -ne 0 ]; then
-    echo "Data file directory not found!"
-    exit 1
-  fi
-  dd if=$the_file of=/dev/fd0 ibs=1b obs=90b conv=sync
-  if [ $? -ne 0 ]; then
-    echo "$the_file dd write failed!"
-    exit 1
-  else
-    echo "$the_file dd write passed."
-  fi
-  cd $TCtmp
-  if [ $? -ne 0 ]; then
-    echo "Could not change to $TCtmp directory!"
-    exit 1
-  fi
-  dd if=/dev/fd0 of=$the_file ibs=90b obs=1b conv=sync
-  if [ $? -ne 0 ]; then
-    echo "$the_file dd read failed!"
-    exit 1
-  else
-    echo "$the_file dd read passed."
-  fi
-  diff $TCdat/$the_file $TCtmp/$the_file 2>&1 >/dev/null
-  if [ $? -ne 0 ]; then
-    echo "Diff of the $the_file dd files failed!"
-    exit 1
-  else
-    echo "Diff of the $the_file dd files passed."
-  fi
-  rm -f $TCtmp/$the_file
-done
+test_dd()
+{
+	for the_file in dd_file
+	do
+		tst_resm TINFO "Testing $the_file dd..."
+		dd if=$TCdat/$the_file of=/dev/fd0 ibs=1b obs=90b conv=sync
+		if [ $? -ne 0 ]; then
+			tst_resm TFAIL "$the_file dd write failed!"
+			return
+		else
+			tst_resm TINFO "$the_file dd write passed."
+		fi
+		dd if=/dev/fd0 of=$the_file ibs=90b obs=1b conv=sync
+		if [ $? -ne 0 ]; then
+			tst_resm TFAIL "$the_file dd read failed!"
+			return
+		else
+			tst_resm TINFO "$the_file dd read passed."
+		fi
+		diff $TCdat/$the_file $the_file 2>&1 >/dev/null
+		if [ $? -ne 0 ]; then
+			tst_resm TFAIL "Diff of the $the_file dd files failed!"
+			return
+		else
+			tst_resm TINFO "Diff of the $the_file dd files passed."
+		fi
+		rm -f $the_file
+	done
+	tst_resm TPASS "test_dd: PASS."
 }
 
 test_linuxformat()
 {
-$trace_logic
-echo Testing mkdosfs....
-mkfs -v /dev/fd0
-  if [ $? -ne 0 ]; then
-    echo "Linux (ext2) format failed!"
-    exit 1
-  else
-    echo "Linux (ext2) successful."
-  fi
+	tst_resm TINFO "Testing mkdosfs...."
+	mkfs -v /dev/fd0
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "Linux (ext2) format failed!"
+	else
+		tst_resm TPASS "Linux (ext2) successful."
+	fi
 }
 
 test_dosformat()
 {
-$trace_logic
-echo Testing mkdosfs....
-mkdosfs -v /dev/fd0
-  if [ $? -ne 0 ]; then
-    echo "Dosformat failed!"
-    exit 1
-  else
-    echo "Dosformat successful."
-  fi
+	tst_resm TINFO "Testing mkdosfs...."
+	mkdosfs -v /dev/fd0
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "Dosformat failed!"
+	else
+		tst_resm TPASS "Dosformat successful."
+	fi
 }
 
+setup
+
+TST_CLEANUP=cleanup
 
 test_for_device
 
@@ -263,7 +261,4 @@ test_dd
 test_linuxformat
 test_dosformat
 
-#If we made it this far, all tests passed.
-echo ""
-echo "stress_floppy: PASS"
-exit 0
+tst_exit
-- 
1.9.3




------------------------------------------------------------------------------
Dive into the World of Parallel Programming! The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
