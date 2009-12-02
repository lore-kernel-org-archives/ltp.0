Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1NFkZ5-0002xv-Eo
	for ltp-list@lists.sourceforge.net; Wed, 02 Dec 2009 08:27:59 +0000
Received: from smtp-gate3.ryobi.co.jp ([210.163.224.134])
	by sfi-mx-1.v28.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1NFkYy-0000fP-DI
	for ltp-list@lists.sourceforge.net; Wed, 02 Dec 2009 08:27:59 +0000
Received: from 5109496 ([10.113.10.40]) by po.rsoa.ryobi.co.jp
	(Post.Office MTA v4.1.1 release 20090730
	ID# 201-058U1200L1200S0V41J) with ESMTP id jp
	for <ltp-list@lists.sourceforge.net>; Wed, 2 Dec 2009 17:27:41 +0900
From: "Mitani" <mitani@ryobi.co.jp>
Date: Wed, 2 Dec 2009 17:27:41 +0900
Message-ID: <000001ca7329$50744150$f15cc3f0$@co.jp>
MIME-Version: 1.0
Content-Language: ja
Subject: [LTP] iogen01 test failed with after ltp-2009-11-24.tar.gz
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

Following failure occurred in "iogen01" when I execute "runltp" using 
ltp-2009-11-24.tar.gz. (Kernel : 2.6.18-164.el5)
like that:
-----------------------------
sh: rwtest.sh: command not found
-----------------------------

Similer failure occured since for ltp-2009-11-24.tar.gz, and now too.

There isn't "rwtest.sh" that cause this error.

So, It may be correct that the scenario for iogen01 in
"${LTPROOT}/runtest/fs"
is "rwtest", I think.
Because, "rwtest" is a shell script that is a wrapper of iogen and doio.

Following shows my revise draft.
====================================
--- fs	2009-10-19 03:01:18.000000000 +0900
+++ fs.new	2009-12-02 16:28:59.000000000 +0900
@@ -37,7 +37,7 @@
 
 #must be run as root
 #iogen01 iogen -i 120s -s read,write 500b:doio.f1.$$ 1000b:doio.f2.$$ |
doio -akv -n 2
-iogen01 export LTPROOT; rwtest.sh -N iogen01 -i 120s -s read,write -Da -Dv
-n 2 500b:doio.f1.$$ 1000b:doio.f2.$$
+iogen01 export LTPROOT; rwtest -N iogen01 -i 120s -s read,write -Da -Dv -n
2 500b:doio.f1.$$ 1000b:doio.f2.$$
 
 fs_inod01 fs_inod $TMP 10 10 10
 linker01 linktest.sh 1000 1000
====================================

Can I get opinion that my revision is right or not?


Thank you--

-Tomonori Mitani



------------------------------------------------------------------------------
Join us December 9, 2009 for the Red Hat Virtual Experience,
a free event focused on virtualization and cloud computing. 
Attend in-depth sessions from your desk. Your couch. Anywhere.
http://p.sf.net/sfu/redhat-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
