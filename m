Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1OTCt4-0004FD-RA
	for ltp-list@lists.sourceforge.net; Mon, 28 Jun 2010 11:52:30 +0000
Received: from e1.ny.us.ibm.com ([32.97.182.141])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OTCt0-0004U2-SP
	for ltp-list@lists.sourceforge.net; Mon, 28 Jun 2010 11:52:30 +0000
From: Subrata Modak <subrata@linux.vnet.ibm.com>
Date: Mon, 28 Jun 2010 17:22:18 +0530
Message-Id: <20100628115217.23913.32352.sendpatchset@subratamodak.linux.ibm.com>
Subject: [LTP] [PATCH] Remove files which does not have a dmesg entry
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
To: LTP List Members <ltp-list@lists.sf.net>
Cc: Mike Frysinger <vapier@gentoo.org>

Hi,

The recently introduced option:

-K DMESG_LOG_DIR
	Log Kernel messages generated for each test cases inside this directory,

when used will generate huge no. of files inside the DMESG_DIR. Many of
them will be ZERO size as we do not expect KERNEL MESSAGE to be generated
against all the LTP TESTS that we will run. It is better to prune them, and
let only those files exist which will have real entries. The following
patch fixes the same.

Signed-off-by: Subrata Modak <subrata@linux.vnet.ibm.com>,
---

--- ltp/runltp.orig	2010-06-28 10:02:42.000000000 +0530
+++ ltp/runltp	2010-06-28 10:21:04.000000000 +0530
@@ -858,6 +858,30 @@ main()
     cd ..
     echo "LTP Version: $version_date"
 
+	# DMESG_DIR will contain hell lot of files which will not have any entry
+	# since kernel message(s) will not be generated for every test. The zero size
+	# files will clog the directory. Lets keep only those fules which have real
+	# kernel message entries. If DMESG_DIR directroy is empty after test run, it
+	# will indicate that no kernel message was generated during test run
+
+	if [ $ALT_DMESG_OUT -eq 1 ] ; then
+		PWD=`pwd`
+		cd $DMESG_DIR
+		for dmesg_file in `ls`
+		do
+			dmesg_file_size=`wc -c $dmesg_file | cut -d ' ' -f1 | tr -d '\n'`
+			if [ $dmesg_file_size -eq 0 ]; then
+				rm -rf $dmesg_file
+			fi
+		done
+		cd $PWD
+	fi
+	if [ `ls -l $DMESG_DIR | wc -l` -ge 1 ]; then
+		echo "Kernel messages were generated for LTP tests $version_date"
+	else
+		echo "No Kernel messages were generated for LTP tests $version_date"
+	fi
+
     if [ "$ALT_HTML_OUT" -eq 1 ] ; then        #User wants the HTML output to be created, it then needs to be generated
        export LTP_VERSION=$version_date
        export TEST_START_TIME=$test_start_time

---
Regards--
Subrata


------------------------------------------------------------------------------
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
