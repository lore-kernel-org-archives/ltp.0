Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1NRfe5-0006Md-LX
	for ltp-list@lists.sourceforge.net; Mon, 04 Jan 2010 05:38:25 +0000
Received: from out05.sjc.mx.trendmicro.com ([216.99.131.18])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NRfe4-00011Y-A1
	for ltp-list@lists.sourceforge.net; Mon, 04 Jan 2010 05:38:25 +0000
Received: from out04.sjc.mx.trendmicro.com (unknown [216.99.131.8])
	by out05.sjc.mx.trendmicro.com (Postfix) with ESMTP id BEF7A330228
	for <ltp-list@lists.sourceforge.net>;
	Mon,  4 Jan 2010 05:08:04 +0000 (UTC)
Received: from relay04.sjc.mx.trendmicro.com (unknown [10.30.239.23])
	by out04.sjc.mx.trendmicro.com (Postfix) with ESMTP id 802C958C43E
	for <ltp-list@lists.sourceforge.net>;
	Mon,  4 Jan 2010 05:07:58 +0000 (UTC)
Received: from smtp-gate.ryobi.co.jp (unknown [210.163.224.132])
	by relay04.sjc.mx.trendmicro.com (Postfix) with ESMTP id D163C1D7810
	for <ltp-list@lists.sourceforge.net>;
	Mon,  4 Jan 2010 05:07:57 +0000 (UTC)
Received: from 5109496 ([10.113.10.40]) by po.rsoa.ryobi.co.jp
	(Post.Office MTA v4.1.1 release 20090730
	ID# 201-058U1200L1200S0V41J) with ESMTP id jp
	for <ltp-list@lists.sourceforge.net>; Mon, 4 Jan 2010 14:07:56 +0900
From: "Mitani" <mitani@ryobi.co.jp>
Date: Mon, 4 Jan 2010 14:07:55 +0900
Message-ID: <000001ca8cfb$e04fb340$a0ef19c0$@co.jp>
MIME-Version: 1.0
Content-Language: ja
Subject: [LTP] nanosleep testcase problem
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

I want to wish you happy new year.


------

By the way, I found a new problem with the "nanosleep02" testcase.

"main()" function executes fork(), and child process calls "do_child()"
function.
"do_child()" function must be ended by "exit()". But in "nanosleep02"
testcase, there is a case in which "exit()" isn't executed.
Therefore, the child process lives after "do_child()" function, 
and it executes "wait()" function which must be executed in parent
process only.

Here is the patch fixes these problem:

============
--- nanosleep02.c	2009-12-23 02:35:13.000000000 +0900
+++ nanosleep02.c.new	2010-01-04 10:15:08.000000000 +0900
@@ -277,6 +277,9 @@
 		tst_resm(TPASS, "call succeeded");
 		exit(0);
 	}
+	
+	/* Everything is fine, exit normally */
+	exit(0);
 }
 
 /*
============


Regards--


-Tomonori Mitani



------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
