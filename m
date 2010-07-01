Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1OUMzo-0008MW-RF
	for ltp-list@lists.sourceforge.net; Thu, 01 Jul 2010 16:52:16 +0000
Received: from e5.ny.us.ibm.com ([32.97.182.145])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OUMzn-0006r7-Vf
	for ltp-list@lists.sourceforge.net; Thu, 01 Jul 2010 16:52:16 +0000
From: Subrata Modak <subrata@linux.vnet.ibm.com>
Date: Thu, 01 Jul 2010 22:22:07 +0530
Message-Id: <20100701165206.23119.26070.sendpatchset@subratamodak.linux.ibm.com>
Subject: [LTP] [PATCH v3] Remove files which does not have a dmesg entry
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

[PATCH v3] Remove files which does not have a dmesg entry

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

--- ltp/runltp.orig	2010-07-01 20:51:15.000000000 +0530
+++ ltp/runltp	2010-07-01 22:19:53.000000000 +0530
@@ -858,6 +858,21 @@ main()
     cd ..
     echo "LTP Version: $version_date"
 
+	# $DMESG_DIR is used to cache messages obtained from dmesg after a test run.
+	# Proactively reap all of the 0-byte files in $DMESG_DIR as they have zero value
+	# and only clutter up the filesystem.
+
+	if [ $ALT_DMESG_OUT -eq 1 ] ; then
+		if find "$DMESG_DIR" -size 0 -exec rm {} + ; then
+			echo "cd to $DMESG_DIR failed: $?"
+		fi
+		if [ -n "$(ls "$DMESG_DIR")" ] ; then
+			echo "Kernel messages were generated for LTP tests $version_date"
+		else
+			echo "No Kernel messages were generated for LTP tests $version_date"
+		fi
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
