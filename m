Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1NiR2y-0004ba-6R
	for ltp-list@lists.sourceforge.net; Fri, 19 Feb 2010 11:29:24 +0000
Received: from e7.ny.us.ibm.com ([32.97.182.137])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NiR2t-0004xO-SV
	for ltp-list@lists.sourceforge.net; Fri, 19 Feb 2010 11:29:24 +0000
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by e7.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o1JBLh2P017217
	for <ltp-list@lists.sourceforge.net>; Fri, 19 Feb 2010 06:21:43 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o1JBT8bs1540180
	for <ltp-list@lists.sourceforge.net>; Fri, 19 Feb 2010 06:29:08 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o1JBT8ZR012079
	for <ltp-list@lists.sourceforge.net>; Fri, 19 Feb 2010 09:29:08 -0200
From: Subrata Modak <subrata@linux.vnet.ibm.com>
Date: Fri, 19 Feb 2010 16:59:04 +0530
Message-Id: <20100219112904.27416.55542.sendpatchset@subratamodak.linux.ibm.com>
Subject: [LTP] [PATCH] Fix LTP Scritps as per the new build/install system
	in place
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: LTP Mailing List <ltp-list@lists.sourceforge.net>

Hi,

Scripts under LTPROOT/testscripts/ need to access ltp-pan from some
other loaction now. Moreover there are scripts to run MATH and SYSCALL
tests which are not required as they can be directly run through
./runltp -f <math/runltp>
This patch fixes them. Probably the scripts need to be looked on
more to fix such anomalies.

Signed-off-by: Subrata Modak <subrata@linux.vnet.ibm.com>
---

diff -uprN ltp-full-20100131/testscripts.orig/diskio.sh ltp-full-20100131/testscripts/diskio.sh
--- ltp-full-20100131/testscripts.orig/diskio.sh	2010-02-19 16:20:05.000000000 +0530
+++ ltp-full-20100131/testscripts/diskio.sh	2010-02-19 16:20:27.000000000 +0530
@@ -27,7 +27,7 @@ export PATH="${PATH}:${LTPROOT}/testcase
  
 ${LTPROOT}/ver_linux
 
-${LTPROOT}/pan/ltp-pan -e -l /tmp/diskiopan.log -S -a ltpdiskio -n ltpdiskio -f ${LTPROOT}/runtest/io_floppy -f ${LTPROOT}/runtest/io_cd
+${LTPROOT}/bin/ltp-pan -e -l /tmp/diskiopan.log -S -a ltpdiskio -n ltpdiskio -f ${LTPROOT}/runtest/io_floppy -f ${LTPROOT}/runtest/io_cd
 
 if [ $? -eq "0" ]; then
   echo ltp-pan reported PASS
diff -uprN ltp-full-20100131/testscripts.orig/ltp-aiodio.sh ltp-full-20100131/testscripts/ltp-aiodio.sh
--- ltp-full-20100131/testscripts.orig/ltp-aiodio.sh	2010-02-19 16:20:05.000000000 +0530
+++ ltp-full-20100131/testscripts/ltp-aiodio.sh	2010-02-19 16:25:53.000000000 +0530
@@ -227,9 +227,9 @@ dd if=$file1 of=/test/aiodio/junkfile bs
 date
 echo "************ Running aio-stress tests " 
 echo "current working dir = ${PWD}"
-${LTPROOT}/bin/rand_lines -g ${LTPROOT}/runtest/ltp-aio-stress.part1 > ${TMPBASE}/ltp-aio-stress.part1
+${LTPROOT}/tools/rand_lines -g ${LTPROOT}/runtest/ltp-aio-stress.part1 > ${TMPBASE}/ltp-aio-stress.part1
 
-${LTPROOT}/pan/ltp-pan -e -S -a ltpaiostresspart1 -n ltp-aiostresspart1 -l ltpaiostress.logfile -o ltpaiostress.outfile -p -f ${TMPBASE}/ltp-aio-stress.part1 &
+${LTPROOT}/bin/ltp-pan -e -S -a ltpaiostresspart1 -n ltp-aiostresspart1 -l ltpaiostress.logfile -o ltpaiostress.outfile -p -f ${TMPBASE}/ltp-aio-stress.part1 &
 
 wait $!
 
@@ -239,9 +239,9 @@ echo ""
 
 if [ "$runExtendedStress" -eq 1 ];then
 echo "************ Running EXTENDED aio-stress tests " 
-${LTPROOT}/bin/rand_lines -g ${LTPROOT}/runtest/ltp-aio-stress.part2 > ${TMPBASE}/ltp-aio-stress.part2
+${LTPROOT}/tools/rand_lines -g ${LTPROOT}/runtest/ltp-aio-stress.part2 > ${TMPBASE}/ltp-aio-stress.part2
 
-${LTPROOT}/pan/ltp-pan -e -S -a ltpaiostresspart2 -n ltp-aiostresspart2 -l ltpaiostress.logfile -o ltpaiostress.outfile -p -f ${TMPBASE}/ltp-aio-stress.part2 &
+${LTPROOT}/bin/ltp-pan -e -S -a ltpaiostresspart2 -n ltp-aiostresspart2 -l ltpaiostress.logfile -o ltpaiostress.outfile -p -f ${TMPBASE}/ltp-aio-stress.part2 &
 
 wait $!
 sync
@@ -254,9 +254,9 @@ dd if=$file1 of=/test/aiodio/ff2      bs
 dd if=$file1 of=/test/aiodio/ff3      bs=512  conv=block,sync
 
 echo "************ Running aiocp tests " 
-${LTPROOT}/bin/rand_lines -g ${LTPROOT}/runtest/ltp-aiodio.part1 > ${TMPBASE}/ltp-aiodio.part1
+${LTPROOT}/tools/rand_lines -g ${LTPROOT}/runtest/ltp-aiodio.part1 > ${TMPBASE}/ltp-aiodio.part1
 
-${LTPROOT}/pan/ltp-pan -e -S -a ltpaiodiopart1 -n ltp-aiodiopart1 -l ltpaiodio1.logfile -o ltpaiodio1.outfile -p -f ${TMPBASE}/ltp-aiodio.part1 &
+${LTPROOT}/bin/ltp-pan -e -S -a ltpaiodiopart1 -n ltp-aiodiopart1 -l ltpaiodio1.logfile -o ltpaiodio1.outfile -p -f ${TMPBASE}/ltp-aiodio.part1 &
 
 wait $!
 sync
@@ -264,9 +264,9 @@ echo "************ End Running aiocp tes
 echo ""
 
 echo "************ Running aiodio_sparse tests " 
-${LTPROOT}/bin/rand_lines -g ${LTPROOT}/runtest/ltp-aiodio.part2 > ${TMPBASE}/ltp-aiodio.part2
+${LTPROOT}/tools/rand_lines -g ${LTPROOT}/runtest/ltp-aiodio.part2 > ${TMPBASE}/ltp-aiodio.part2
 
-${LTPROOT}/pan/ltp-pan -e -S -a ltpaiodiopart2 -n ltp-aiodiopart2 -l ltpaiodio2.logfile -o ltpaiodio2.outfile -p -f ${TMPBASE}/ltp-aiodio.part2 &
+${LTPROOT}/bin/ltp-pan -e -S -a ltpaiodiopart2 -n ltp-aiodiopart2 -l ltpaiodio2.logfile -o ltpaiodio2.outfile -p -f ${TMPBASE}/ltp-aiodio.part2 &
 
 wait $!
 sync
@@ -276,9 +276,9 @@ echo ""
 
 if [ "$runExtendedStress" -eq 1 ];then
 echo "************ Running fsx-linux tests "
-${LTPROOT}/bin/rand_lines -g ${LTPROOT}/runtest/ltp-aiodio.part3 > ${TMPBASE}/ltp-aiodio.part3
+${LTPROOT}/tools/rand_lines -g ${LTPROOT}/runtest/ltp-aiodio.part3 > ${TMPBASE}/ltp-aiodio.part3
 
-${LTPROOT}/pan/ltp-pan -e -S -a ltpaiodiopart3 -n ltp-aiodiopart3 -l ltpaiodio3.logfile -o ltpaiodio3.outfile -p -f ${TMPBASE}/ltp-aiodio.part3 &
+${LTPROOT}/bin/ltp-pan -e -S -a ltpaiodiopart3 -n ltp-aiodiopart3 -l ltpaiodio3.logfile -o ltpaiodio3.outfile -p -f ${TMPBASE}/ltp-aiodio.part3 &
 
 
 
@@ -295,8 +295,8 @@ dd if=$file1 of=/test/aiodio/file5      
 
  
 echo "************ Running dio_sparse & miscellaneous tests "
-${LTPROOT}/bin/rand_lines -g ${LTPROOT}/runtest/ltp-aiodio.part4 > ${TMPBASE}/ltp-aiodio.part4
-${LTPROOT}/pan/ltp-pan -e -S -a ltpaiodiopart4 -n ltp-aiodiopart4 -l ltpaiodio4.logfile -o ltpaiodio4.outfile -p -f ${TMPBASE}/ltp-aiodio.part4 &
+${LTPROOT}/tools/rand_lines -g ${LTPROOT}/runtest/ltp-aiodio.part4 > ${TMPBASE}/ltp-aiodio.part4
+${LTPROOT}/bin/ltp-pan -e -S -a ltpaiodiopart4 -n ltp-aiodiopart4 -l ltpaiodio4.logfile -o ltpaiodio4.outfile -p -f ${TMPBASE}/ltp-aiodio.part4 &
 
 wait $!
 sync
diff -uprN ltp-full-20100131/testscripts.orig/ltpfslvm.sh ltp-full-20100131/testscripts/ltpfslvm.sh
--- ltp-full-20100131/testscripts.orig/ltpfslvm.sh	2010-02-19 16:20:05.000000000 +0530
+++ ltp-full-20100131/testscripts/ltpfslvm.sh	2010-02-19 16:26:27.000000000 +0530
@@ -156,9 +156,9 @@ mount -v /dev/ltp_test_vg2/ltp_test_lv4 
 mount -v /dev/ram                       /test/growfiles/ramdisk                              
 
 echo "************ Running tests " 
-${LTPROOT}/bin/rand_lines -g ${LTPROOT}/runtest/lvm.part1 > ${TMPBASE}/lvm.part1
+${LTPROOT}/tools/rand_lines -g ${LTPROOT}/runtest/lvm.part1 > ${TMPBASE}/lvm.part1
 
-${LTPROOT}/pan/ltp-pan -e -S -a lvmpart1 -n lvmpart1 -l lvmlogfile -f ${TMPBASE}/lvm.part1 &
+${LTPROOT}/bin/ltp-pan -e -S -a lvmpart1 -n lvmpart1 -l lvmlogfile -f ${TMPBASE}/lvm.part1 &
 
 wait $!
 
@@ -188,9 +188,9 @@ mount -v -t ext3   /dev/$part4         /
 mount -v -t jfs    /dev/hdc1           /test/growfiles/jfs
 
 echo "************ Running EXT3 & JFS tests...  " 
-${LTPROOT}/bin/rand_lines -g ${LTPROOT}/runtest/lvm.part2 > ${TMPBASE}/lvm.part2
+${LTPROOT}/tools/rand_lines -g ${LTPROOT}/runtest/lvm.part2 > ${TMPBASE}/lvm.part2
 
-${LTPROOT}/pan/ltp-pan -e -S -a lvmpart2 -n lvmpart2 -l lvmlogfile -f ${TMPBASE}/lvm.part2 &
+${LTPROOT}/bin/ltp-pan -e -S -a lvmpart2 -n lvmpart2 -l lvmlogfile -f ${TMPBASE}/lvm.part2 &
 
 wait $!
 
diff -uprN ltp-full-20100131/testscripts.orig/ltpfsnolvm.sh ltp-full-20100131/testscripts/ltpfsnolvm.sh
--- ltp-full-20100131/testscripts.orig/ltpfsnolvm.sh	2010-02-19 16:20:05.000000000 +0530
+++ ltp-full-20100131/testscripts/ltpfsnolvm.sh	2010-02-19 16:28:03.000000000 +0530
@@ -116,9 +116,9 @@ mount -v /dev/$part4                    
 mount -v /dev/ram                       /test/growfiles/ramdisk                              
 
 echo "************ Running tests " 
-${LTPROOT}/../bin/rand_lines -g ${LTPROOT}/../runtest/lvm.part1 > ${TMPBASE}/lvm.part1
+${LTPROOT}/../tools/rand_lines -g ${LTPROOT}/../runtest/lvm.part1 > ${TMPBASE}/lvm.part1
 
-${LTPROOT}/../pan/ltp-pan -e -S -a lvmpart1 -n lvmpart1 -l lvmlogfile -f ${TMPBASE}/lvm.part1 &
+${LTPROOT}/../bin/ltp-pan -e -S -a lvmpart1 -n lvmpart1 -l lvmlogfile -f ${TMPBASE}/lvm.part1 &
 
 wait $!
 
@@ -138,9 +138,9 @@ mount -v -t ext3   /dev/$part4         /
 mount -v -t jfs    /dev/$part1         /test/growfiles/jfs
 
 echo "************ Running EXT3 & JFS tests...  " 
-${LTPROOT}/../bin/rand_lines -g ${LTPROOT}/../runtest/lvm.part2 > ${TMPBASE}/lvm.part2
+${LTPROOT}/../tools/rand_lines -g ${LTPROOT}/../runtest/lvm.part2 > ${TMPBASE}/lvm.part2
 
-${LTPROOT}/../pan/ltp-pan -e -S -a lvmpart2 -n lvmpart2 -l lvmlogfile -f ${TMPBASE}/lvm.part2 &
+${LTPROOT}/../bin/ltp-pan -e -S -a lvmpart2 -n lvmpart2 -l lvmlogfile -f ${TMPBASE}/lvm.part2 &
 
 wait $!
 
diff -uprN ltp-full-20100131/testscripts.orig/ltp-scsi_debug.sh ltp-full-20100131/testscripts/ltp-scsi_debug.sh
--- ltp-full-20100131/testscripts.orig/ltp-scsi_debug.sh	2010-02-19 16:20:05.000000000 +0530
+++ ltp-full-20100131/testscripts/ltp-scsi_debug.sh	2010-02-19 16:31:51.000000000 +0530
@@ -204,9 +204,9 @@ mount /dev/$part4 /test/growfiles/msdos
 
 echo "----- Running tests ----- " 
 echo "The test may take about 2 hours to finish..."
-${LTPROOT}/bin/rand_lines -g ${LTPROOT}/runtest/scsi_debug.part1 > ${TMPBASE}/scsi_debug
+${LTPROOT}/tools/rand_lines -g ${LTPROOT}/runtest/scsi_debug.part1 > ${TMPBASE}/scsi_debug
  
-${LTPROOT}/pan/ltp-pan -e -S -a scsi_debug -n scsi_debug -l ${TMPBASE}/fs-scsi_debug.log -o ${TMPBASE}/fs-scsi_debug.out -f ${TMPBASE}/scsi_debug 
+${LTPROOT}/bin/ltp-pan -e -S -a scsi_debug -n scsi_debug -l ${TMPBASE}/fs-scsi_debug.log -o ${TMPBASE}/fs-scsi_debug.out -f ${TMPBASE}/scsi_debug 
 
 wait $!
 
diff -uprN ltp-full-20100131/testscripts.orig/ltpstress.sh ltp-full-20100131/testscripts/ltpstress.sh
--- ltp-full-20100131/testscripts.orig/ltpstress.sh	2010-02-19 16:20:05.000000000 +0530
+++ ltp-full-20100131/testscripts/ltpstress.sh	2010-02-19 16:32:24.000000000 +0530
@@ -275,9 +275,9 @@ output1=${TMPBASE}/ltpstress.$$.output1
 output2=${TMPBASE}/ltpstress.$$.output2
 output3=${TMPBASE}/ltpstress.$$.output3
 
-${LTPROOT}/pan/ltp-pan -e -p -q -S -t ${hours}h -a stress1 -n stress1 -l $logfile -f ${TMP}/stress.part1 -o $output1 & 
-${LTPROOT}/pan/ltp-pan -e -p -q -S -t ${hours}h -a stress2 -n stress2 -l $logfile -f ${TMP}/stress.part2 -o $output2 &
-${LTPROOT}/pan/ltp-pan -e -p -q -S -t ${hours}h -a stress3 -n stress3 -l $logfile -f ${TMP}/stress.part3 -o $output3 &
+${LTPROOT}/bin/ltp-pan -e -p -q -S -t ${hours}h -a stress1 -n stress1 -l $logfile -f ${TMP}/stress.part1 -o $output1 & 
+${LTPROOT}/bin/ltp-pan -e -p -q -S -t ${hours}h -a stress2 -n stress2 -l $logfile -f ${TMP}/stress.part2 -o $output2 &
+${LTPROOT}/bin/ltp-pan -e -p -q -S -t ${hours}h -a stress3 -n stress3 -l $logfile -f ${TMP}/stress.part3 -o $output3 &
 
 echo "Running LTP Stress for $hours hour(s) using $(($memsize/1024)) Mb"
 echo ""
diff -uprN ltp-full-20100131/testscripts.orig/math.sh ltp-full-20100131/testscripts/math.sh
--- ltp-full-20100131/testscripts.orig/math.sh	2010-02-19 16:20:05.000000000 +0530
+++ ltp-full-20100131/testscripts/math.sh	1970-01-01 05:30:00.000000000 +0530
@@ -1,4 +0,0 @@
-#!/bin/sh
-cd `dirname $0`
-cd ..
-./runltp -f ${PWD}/runtest/math -q "$@"
diff -uprN ltp-full-20100131/testscripts.orig/networkstress.sh ltp-full-20100131/testscripts/networkstress.sh
--- ltp-full-20100131/testscripts.orig/networkstress.sh	2010-02-19 16:20:05.000000000 +0530
+++ ltp-full-20100131/testscripts/networkstress.sh	2010-02-19 16:38:21.000000000 +0530
@@ -124,10 +124,10 @@ if [ ${VERBOSE} = "yes" ]; then
 	cat $TMPDIR/network_stress.tests
 	${LTPROOT}/ver_linux
 	echo ""
-	echo ${LTPROOT}/pan/ltp-pan -e -l /tmp/netstress.log -S -a netstress -n netstress -f ${TMPDIR}/network_stress.tests
+	echo ${LTPROOT}/bin/ltp-pan -e -l /tmp/netstress.log -S -a netstress -n netstress -f ${TMPDIR}/network_stress.tests
 fi
 
-${LTPROOT}/pan/ltp-pan -e -l /tmp/netstress.log -S -a netstress -n netstress -f ${TMPDIR}/network_stress.tests
+${LTPROOT}/bin/ltp-pan -e -l /tmp/netstress.log -S -a netstress -n netstress -f ${TMPDIR}/network_stress.tests
 
 if [ $? -eq "0" ]; then
   echo ltp-pan reported PASS
diff -uprN ltp-full-20100131/testscripts.orig/networktests.sh ltp-full-20100131/testscripts/networktests.sh
--- ltp-full-20100131/testscripts.orig/networktests.sh	2010-02-19 16:20:05.000000000 +0530
+++ ltp-full-20100131/testscripts/networktests.sh	2010-02-19 16:38:55.000000000 +0530
@@ -119,10 +119,10 @@ if [ ${VERBOSE} = "yes" ]; then
     cat $CMDFILE
     ${LTPROOT}/ver_linux
     echo ""
-    echo ${LTPROOT}/pan/ltp-pan -e -l /tmp/netpan.log -S -a ltpnet -n ltpnet -f $CMDFILE
+    echo ${LTPROOT}/bin/ltp-pan -e -l /tmp/netpan.log -S -a ltpnet -n ltpnet -f $CMDFILE
 fi
 
-${LTPROOT}/pan/ltp-pan -e -l /tmp/netpan.log -S -a ltpnet -n ltpnet -f $CMDFILE
+${LTPROOT}/bin/ltp-pan -e -l /tmp/netpan.log -S -a ltpnet -n ltpnet -f $CMDFILE
 
 if [ $? -eq "0" ]; then
   echo ltp-pan reported PASS
diff -uprN ltp-full-20100131/testscripts.orig/runEALtests.sh ltp-full-20100131/testscripts/runEALtests.sh
--- ltp-full-20100131/testscripts.orig/runEALtests.sh	2010-02-19 16:20:05.000000000 +0530
+++ ltp-full-20100131/testscripts/runEALtests.sh	2010-02-19 16:42:25.000000000 +0530
@@ -186,14 +186,14 @@ fi
 # to execute.
 if [ -z $cmdfile ]
 then
-	cat ${LTPROOT}/../runtest/admin_tools > ${TMP}/alltests
+	cat ${LTPROOT}/runtest/admin_tools > ${TMP}/alltests
 else
     cat $cmdfile > ${TMP}/alltests
 fi
 
 if [ $run_netest -eq 1 ]
 then
-	cat ${LTPROOT}/../runtest/network_commands >> ${TMP}/alltests
+	cat ${LTPROOT}/runtest/network_commands >> ${TMP}/alltests
 fi
 
 # The fsx-linux tests use the SCRATCHDEV environment variable as a location
@@ -201,13 +201,13 @@ fi
 # these tests.  As a safeguard, this is disabled.
 unset SCRATCHDEV
 if [ -n "$SCRATCHDEV" ]; then
-  cat ${LTPROOT}/../runtest/fsx >> ${TMP}/alltests
+  cat ${LTPROOT}/runtest/fsx >> ${TMP}/alltests
 fi
 
 # display versions of installed software
-${LTPROOT}/../ver_linux
+${LTPROOT}/ver_linux
 
-${LTPROOT}/../pan/ltp-pan $quiet_mode -e -S $instances $duration -a $$ -n $$ $pretty_prt -f ${TMP}/alltests $logfile 
+${LTPROOT}/bin/ltp-pan $quiet_mode -e -S $instances $duration -a $$ -n $$ $pretty_prt -f ${TMP}/alltests $logfile 
 
 if [ $? -eq 0 ]; then
   echo ltp-pan reported PASS
diff -uprN ltp-full-20100131/testscripts.orig/runpan.sh ltp-full-20100131/testscripts/runpan.sh
--- ltp-full-20100131/testscripts.orig/runpan.sh	2010-02-19 16:20:05.000000000 +0530
+++ ltp-full-20100131/testscripts/runpan.sh	2010-02-19 16:42:45.000000000 +0530
@@ -14,7 +14,7 @@ cd /tmp/runpan-$$
 
 export PATH="${PATH}:${LTPROOT}/doio:${LTPROOT}/testcases/bin"
  
-${LTPROOT}/pan/ltp-pan -e $@ -a ltp -n ltp -f ${LTPROOT}/runtest/quickhit
+${LTPROOT}/bin/ltp-pan -e $@ -a ltp -n ltp -f ${LTPROOT}/runtest/quickhit
 
 if [ $? -eq "0" ]; then
   echo ltp-pan reported PASS
diff -uprN ltp-full-20100131/testscripts.orig/syscalls.sh ltp-full-20100131/testscripts/syscalls.sh
--- ltp-full-20100131/testscripts.orig/syscalls.sh	2010-02-19 16:20:05.000000000 +0530
+++ ltp-full-20100131/testscripts/syscalls.sh	1970-01-01 05:30:00.000000000 +0530
@@ -1,4 +0,0 @@
-#!/bin/sh
-cd `dirname $0`
-cd ..
-./runltp -f ${PWD}/runtest/syscalls -q "$@"
diff -uprN ltp-full-20100131/testscripts.orig/tpm_tools.sh ltp-full-20100131/testscripts/tpm_tools.sh
--- ltp-full-20100131/testscripts.orig/tpm_tools.sh	2010-02-19 16:20:05.000000000 +0530
+++ ltp-full-20100131/testscripts/tpm_tools.sh	2010-02-19 16:47:38.000000000 +0530
@@ -167,7 +167,7 @@ export P11_USER_PWD="P11 USER PWD"
 export NEW_P11_USER_PWD="NEW P11 USER PWD"
 
 echo "Running the tpm-tools testsuite..."
-$LTPROOT/pan/ltp-pan -d 5 -S -a $LTPROOT/results/tpm_tools -n ltp-tpm-tools -l $LTPROOT/results/tpm_tools.logfile -o $LTPROOT/results/tpm_tools.outfile -p -f $LTPROOT/runtest/tpm_tools
+$LTPROOT/bin/ltp-pan -d 5 -S -a $LTPROOT/results/tpm_tools -n ltp-tpm-tools -l $LTPROOT/results/tpm_tools.logfile -o $LTPROOT/results/tpm_tools.outfile -p -f $LTPROOT/runtest/tpm_tools
 
 echo "Done."
 exit 0

---
Regards--
Subrata


------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
