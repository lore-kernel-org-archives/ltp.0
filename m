Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1O4Ygv-0008Cp-M8
	for ltp-list@lists.sourceforge.net; Wed, 21 Apr 2010 12:06:05 +0000
Received: from e8.ny.us.ibm.com ([32.97.182.138])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1O4Ygt-0008Ar-BV
	for ltp-list@lists.sourceforge.net; Wed, 21 Apr 2010 12:06:05 +0000
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
	by e8.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o3LBlWsS014330
	for <ltp-list@lists.sourceforge.net>; Wed, 21 Apr 2010 07:47:32 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o3LC5tqM176190
	for <ltp-list@lists.sourceforge.net>; Wed, 21 Apr 2010 08:05:55 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o3LC5tH4027460
	for <ltp-list@lists.sourceforge.net>; Wed, 21 Apr 2010 08:05:55 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
Date: Wed, 21 Apr 2010 17:35:50 +0530
Message-Id: <20100421120550.13534.21836.sendpatchset@subratamodak.linux.ibm.com>
Subject: [LTP] [PATCH] Fix Location Of GENHTML Inside RUNLTP
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

There are some bits and pieces of restructuring still left to be done.
runltp is not able to call genhtml properly due to change in location
of the same script. The following error will occur:

...
Generating HTML Output.....!!
Can't open perl script "/opt/ltp/tools/genhtml.pl": No such file or directory
...

Following patch fixes the same.

Signed-off-by: Subrata Modak <subrata@linux.vnet.ibm.com>
---

--- ltp-dev/runltp.orig	2010-04-21 22:48:58.223651440 +0530
+++ ltp-dev/runltp	2010-04-21 22:49:10.901783445 +0530
@@ -846,7 +846,7 @@ main()
        export TEST_OUTPUT_DIRECTORY="$LTPROOT/output"
        export TEST_LOGS_DIRECTORY=$LOGS_DIRECTORY
        echo "Generating HTML Output.....!!"
-       ( perl $LTPROOT/tools/genhtml.pl $LTPROOT/tools/html_report_header.txt test_start test_end test_output execution_status $OUTPUT_DIRECTORY  > $HTMLFILE; )   
+       ( perl $LTPROOT/bin/genhtml.pl $LTPROOT/tools/html_report_header.txt test_start test_end test_output execution_status $OUTPUT_DIRECTORY  > $HTMLFILE; )   
        echo "Generated HTML Output.....!!"
        echo "Location: $HTMLFILE";
 
---
Regards--
Subrata


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
