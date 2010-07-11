Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <sumitbd@linsyssoft.com>) id 1OXwqK-0002pP-14
	for ltp-list@lists.sourceforge.net; Sun, 11 Jul 2010 13:45:16 +0000
Received: from mail-pv0-f175.google.com ([74.125.83.175])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OXwqJ-0007uD-2f
	for ltp-list@lists.sourceforge.net; Sun, 11 Jul 2010 13:45:15 +0000
Received: by pvg13 with SMTP id 13so1590969pvg.34
	for <ltp-list@lists.sourceforge.net>;
	Sun, 11 Jul 2010 06:45:09 -0700 (PDT)
From: sumitbd@linsyssoft.com
Date: Sun, 11 Jul 2010 19:08:18 +0530
Message-ID: <1278855498.8660.48.camel@sumit>
Mime-Version: 1.0
Subject: [LTP] [PATCH 3/3] runtest/nfs: TCbin path not exported for few tests
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

While running networktest for nfs; nfsstress &  nfsstat01 test gets
fail. Because TCbin is not exported with required path. Following
patch fixed the above problem.

Index: ltp-full-20100630/runtest/nfs
===================================================================
--- ltp-full-20100630.orig/runtest/nfs
+++ ltp-full-20100630/runtest/nfs
@@ -6,10 +6,10 @@ nfs01 export VERSION SOCKET_TYPE; TCbin=
 nfs02 export VERSION SOCKET_TYPE; TCbin=$LTPROOT/testcases/bin nfs02
 nfs03 export VERSION SOCKET_TYPE; TCbin=$LTPROOT/testcases/bin nfs03
 nfs04 export VERSION SOCKET_TYPE; TCbin=$LTPROOT/testcases/bin nfs04
-nfslock01 export VERSION; nfslock01
+nfslock01 export VERSION; TCbin=$LTPROOT/testcases/bin nfslock01
 
 # This will run 1 thread on 20 directories with 50 files in each.
-nfsstress export VERSION SOCKET_TYPE; nfsstress 20 50 1
+nfsstress export VERSION SOCKET_TYPE; TCbin=$LTPROOT/testcases/bin
nfsstress 20 50 1
 
 nfsstat01 export VERSION; TCbin=$LTPROOT/testcases/bin nfsstat01
 nfsx-linux export VERSION SOCKET_TYPE; TCbin=$LTPROOT/testcases/bin
fsx.sh


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
