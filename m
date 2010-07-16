Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <sumitbd@linsyssoft.com>) id 1OZe9i-0006Eh-Up
	for ltp-list@lists.sourceforge.net; Fri, 16 Jul 2010 06:12:18 +0000
Received: from mail-px0-f175.google.com ([209.85.212.175])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OZe9i-0008Cs-13
	for ltp-list@lists.sourceforge.net; Fri, 16 Jul 2010 06:12:18 +0000
Received: by pxi12 with SMTP id 12so923176pxi.34
	for <ltp-list@lists.sourceforge.net>;
	Thu, 15 Jul 2010 23:12:12 -0700 (PDT)
From: sumitbd@linsyssoft.com
Date: Fri, 16 Jul 2010 11:42:30 +0530
Message-ID: <1279260750.4313.2.camel@sumit>
Mime-Version: 1.0
Subject: [LTP] [PATCH 2/2] runtest/multicast: wrong TCsrc path exported for
 multicast tests
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

While running networktest for multicast ;  "mc_member" test displays the
following error message multiple times
"cat: /opt/ltp/testcases/inetwork/multicast/mc_menmber/ManyGroups: No
such file or directory". 
This is Because variable "TCsrc" is exported with incorrect path. Looks
like previously LTP test scripts installed and ran directly from source
directory . Now it installs mulicast test binary and script files to
"$LTPROOT/testcases/bin" directory. Hence the variable "TCsrc" needed to
be exported with above mentioned install path.

Signed-off-by:  Sumit Dhoot <sumitbd@linsyssoft.com>

Index: ltp-full-20100630/runtest/multicast
===================================================================
--- ltp-full-20100630.orig/runtest/multicast
+++ ltp-full-20100630/runtest/multicast
@@ -3,6 +3,6 @@
# PLEASE READ THE README FILE IN /multicast BEFORE RUNNING THESE.
#
mc_cmds mc_cmds
-mc_commo export TCsrc=$LTPROOT/testcases/network/multicast/mc_commo;
mc_commo
-mc_member export TCsrc=$LTPROOT/testcases/network/multicast/mc_member;
mc_member
-mc_opts export TCsrc=$LTPROOT/testcases/network/multicast/mc_opts;
mc_opts
+mc_commo export TCsrc=$LTPROOT/testcases/bin; mc_commo
+mc_member export TCsrc=$LTPROOT/testcases/bin; mc_member
+mc_opts export TCsrc=$LTPROOT/testcases/bin; mc_opts 


------------------------------------------------------------------------------
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
