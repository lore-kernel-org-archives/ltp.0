Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <sumitbd@linsyssoft.com>) id 1OXx34-0007eQ-W5
	for ltp-list@lists.sourceforge.net; Sun, 11 Jul 2010 13:58:26 +0000
Received: from mail-px0-f175.google.com ([209.85.212.175])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OXx34-0002YA-1e
	for ltp-list@lists.sourceforge.net; Sun, 11 Jul 2010 13:58:26 +0000
Received: by pxi12 with SMTP id 12so623629pxi.34
	for <ltp-list@lists.sourceforge.net>;
	Sun, 11 Jul 2010 06:58:20 -0700 (PDT)
From: sumitbd@linsyssoft.com
Date: Sun, 11 Jul 2010 19:04:28 +0530
Message-ID: <1278855268.8660.44.camel@sumit>
Mime-Version: 1.0
Subject: [LTP] [PATCH 2/3] nfs02: testcases/network/nfs/nfs02/nfs02 script -
 bug fixing
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
To: ltp-list@lists.sourceforge.net


Hi,

Testcase "nfs02" fails with following message
"Test Failed: Removal of write permissions not honored on ascii.sm"
This is because ascii.sm has a rwx file permission for others when It
got installed. The script first tried to remove only write permission
for others and then it tests it with the r-- permission so test get
fails as it has r-x permission for others.

This is fixed with following patch.

Index: ltp-full-20100630/testcases/network/nfs/nfs02/nfs02
===================================================================
--- ltp-full-20100630.orig/testcases/network/nfs/nfs02/nfs02
+++ ltp-full-20100630/testcases/network/nfs/nfs02/nfs02
@@ -179,7 +179,7 @@ do_test3()
 {
 $trace_logic
    echo "do_test3 $TC "
-   chmod a-w $TCtmp/ascii.sm &
+   chmod a-wx $TCtmp/ascii.sm &
    wait $!
    ls -l $TCtmp/ascii.sm | grep "r--" 
    [ $? -eq 0 ] || end_testcase "Removal of write permissions not
honored on ascii.sm"


Thanks & Regards
Sumit Dhoot
System Administrator
Linsyssoft Technologies Pvt. Ltd.
sumitbd@linsyssoft.com



------------------------------------------------------------------------------
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
