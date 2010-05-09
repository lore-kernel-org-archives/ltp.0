Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1OBBD2-00009i-Is
	for ltp-list@lists.sourceforge.net; Sun, 09 May 2010 18:26:36 +0000
Received: from e34.co.us.ibm.com ([32.97.110.152])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OBBD1-00006f-27
	for ltp-list@lists.sourceforge.net; Sun, 09 May 2010 18:26:36 +0000
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e34.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o49IJ6un028488
	for <ltp-list@lists.sourceforge.net>; Sun, 9 May 2010 12:19:06 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o49IQTSY164708
	for <ltp-list@lists.sourceforge.net>; Sun, 9 May 2010 12:26:29 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o49BQRYq013631
	for <ltp-list@lists.sourceforge.net>; Sun, 9 May 2010 05:26:28 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
Date: Sun, 09 May 2010 23:56:23 +0530
Message-Id: <20100509182623.15330.94891.sendpatchset@subratamodak.linux.ibm.com>
Subject: [LTP] [PATCH] Add an Option '-K' to Create dmesg logs for each test
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
To: Linux Test Project <ltp-list@lists.sourceforge.net>
Cc: Sachin P Sant <ssant@in.ibm.com>

Hi,

Recently while running LTP , i found that the system had generated many
kernel messages worth investigating. However, there was a loose gap to
find out which test exactly was responsible for that message.

So, i thought it could be worth to create a framework in LTP to log kernel
messages for each test, to pinpoint exact messages created per test, for
better debugging. The following patch adds a option to LTP and runs a
old style script ;-) to achieve that. All this is done at the runltp level
without any distrubance to ltp-pan. Messages can be logged at:
1) Absolute path(s) as specified by the user, else
2) Inside $LTPROOT/output/

Comments welcome.

Signed-off-by: Subrata Modak <subrata@linux.vnet.ibm.com>
---

--- runltp.orig	2010-05-09 23:15:27.000000000 +0530
+++ runltp	2010-05-09 23:44:53.000000000 +0530
@@ -131,6 +131,8 @@ usage() 
     -h              Help. Prints all available options.
     -i NUM_PROCS    Run LTP under additional background Load on IO Bus
                     [NUM_PROCS   = no. of processes creating IO Bus Load by spinning over sync()]
+    -K DMESG_LOG_DIR
+			Log Kernel messages generated for each test cases inside this directory 
     -l LOGFILE      Log results of test in a logfile.
     -m NUM_PROCS,CHUNKS,BYTES,HANGUP_FLAG
                     Run LTP under additional background Load on Main memory (Seperate by comma)
@@ -178,6 +180,7 @@ main()
     local ALT_DIR_RES=0
     local ALT_HTML_OUT=0
     local ALT_EMAIL_OUT=0
+    local ALT_DMESG_OUT=0
     local RUN_NETEST=0
     local RUN_REPEATED=0
     local QUIET_MODE=""
@@ -198,6 +201,7 @@ main()
     local OUTPUTFILE=""
     local HTMLFILE_NAME=""
     local HTMLFILE=""
+    local DMESG_DIR=""
     local EMAIL_TO=""
     local SCENFILES=""
     local TAG_RESTRICT_STRING=""
@@ -205,7 +209,7 @@ main()
     local DEFAULT_FILE_NAME_GENERATION_TIME=`date +"%Y_%b_%d-%Hh_%Mm_%Ss"`
     version_date=$(cat "$LTPROOT/Version")
 
-    while getopts a:c:C:d:D:f:F:ehi:g:l:m:M:Nno:pqr:s:S:t:T:w:x:b:B: arg
+    while getopts a:c:C:d:D:f:F:ehi:K:g:l:m:M:Nno:pqr:s:S:t:T:w:x:b:B: arg
     do  case $arg in
         a)  EMAIL_TO=$OPTARG
             ALT_EMAIL_OUT=1;;
@@ -308,6 +312,15 @@ main()
             $LTPROOT/testcases/bin/genload --io $NUM_PROCS >/dev/null 2>&1 &
             GENLOAD=1 ;;
     
+        K)  
+	    case $OPTARG in
+        	   /*)
+                	DMESG_DIR="$OPTARG-dmesg-output-`echo $$-``date +%X | tr -d ' '`";;
+	            *)
+        	        DMESG_DIR="$LTPROOT/output/$OPTARG-dmesg-output-`echo $$-``date +%X | tr -d ' '`";;
+	    esac
+            mkdir -p $DMESG_DIR
+            ALT_DMESG_OUT=1;;
         l)      
             LOGFILE_NAME="$OPTARG"
             case $OPTARG in
@@ -821,6 +834,13 @@ main()
 		fi
 	fi
 
+	if [ $ALT_DMESG_OUT -eq 1 ] ; then
+		#We want to print dmesg output for each test,lets do the trick inside the script
+		echo Enabling dmesg output logging for each test...
+		${LTPROOT}/bin/create_dmesg_entries_for_each_test.pl ${TMP}/alltests $DMESG_DIR > ${TMP}/alltests.tmp
+		cp ${TMP}/alltests.tmp ${TMP}/alltests
+		rm -rf ${TMP}/alltests.tmp
+	fi
     # Some tests need to run inside the "bin" directory.
     cd "${LTPROOT}/testcases/bin"
     "${LTPROOT}/bin/ltp-pan" $QUIET_MODE -e -S $INSTANCES $DURATION -a $$ -n $$ $PRETTY_PRT -f ${TMP}/alltests $LOGFILE $OUTPUTFILE $FAILCMDFILE
diff -uprN tools.orig/create_dmesg_entries_for_each_test.pl tools/create_dmesg_entries_for_each_test.pl
--- tools.orig/create_dmesg_entries_for_each_test.pl	1970-01-01 05:30:00.000000000 +0530
+++ tools/create_dmesg_entries_for_each_test.pl	2010-05-09 23:38:10.000000000 +0530
@@ -0,0 +1,74 @@
+#!/usr/bin/perl
+################################################################################
+##                                                                            ##
+## Copyright (c) International Business Machines  Corp., 2010                 ##
+##                                                                            ##
+## This program is free software;  you can redistribute it and/or modify      ##
+## it under the terms of the GNU General Public License as published by       ##
+## the Free Software Foundation; either version 2 of the License, or          ##
+## (at your option) any later version.                                        ##
+##                                                                            ##
+## This program is distributed in the hope that it will be useful, but        ##
+## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
+## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
+## for more details.                                                          ##
+##                                                                            ##
+## You should have received a copy of the GNU General Public License          ##
+## along with this program;  if not, write to the Free Software               ##
+## Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA    ##
+##                                                                            ##
+################################################################################
+#                                                                             ##
+# File :        create_dmesg_entries_for_each_test.pl			      ##
+#                                                                             ##
+# Usage:        create_dmesg_entries_for_each_test.pl\			      ##
+#		<LTP_COMMAND_FILE> <DMESG_DIRECTORY>			      ##
+#                                                                             ##
+# Description:  This is a simple perl script which will take ltp command file ##
+#		as input and then create a final command file which will have ##
+#		the following entries for each test tag:		      ##
+#		<tag_name__with_dmesg_entry> <test_binary_name>;\	      ##
+#		<save_dmesg_logs>			      		      ##
+#                                                                             ##
+# Author:       Subrata Modak <subrata@linux.vnet.ibm.com>                    ##
+#                                                                             ##
+# History:      May 09 2010 - Created - Subrata Modak.                        ##
+################################################################################
+
+my $command_file	= shift (@ARGV) || syntax();
+my $dmesg_dir		= shift (@ARGV) || syntax();
+
+sub syntax() {
+	print "syntax: create_dmesg_entries_for_each_test.pl <LTP_COMMAND_FILE> <DMESG_DIRECTORY>\n";
+	exit (1);
+}
+
+
+open (FILE, $command_file) || die "Cannot open file: $command_file\n";
+while ($line = <FILE>) {
+	if ($line =~ /^#/) {
+		print "$line";
+		next;
+	}
+	if ($line =~ /^\n$/) {
+		next;
+	}
+	chomp $line;
+	@tag_and_actual_command = split(/\ /, $line);
+
+	my $token_counter = 0;
+	my $tag_name = "";
+	foreach my $token (@tag_and_actual_command) {
+		if ($token_counter == 0 ) {
+			print $token . "__with_dmesg_entry" . " ";
+			print "dmesg -c 1>/dev/null 2>/dev/null;" . " ";
+			$token_counter++;
+			$tag_name = $token;
+			next;
+		}
+		print " " . $token . " ";
+	}
+	print "; dmesg > $dmesg_dir/$tag_name.dmesg.log \n";
+}
+close (FILE);
+

---
Regards--
Subrata


------------------------------------------------------------------------------

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
