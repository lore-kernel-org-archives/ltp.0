Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <njoly@pasteur.fr>) id 1MyqeW-000679-77
	for ltp-list@lists.sourceforge.net; Fri, 16 Oct 2009 17:31:44 +0000
Received: from munster3.sis.pasteur.fr ([157.99.64.214])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MyqeN-0000jQ-PQ
	for ltp-list@lists.sourceforge.net; Fri, 16 Oct 2009 17:31:44 +0000
Date: Fri, 16 Oct 2009 19:15:58 +0200
From: Nicolas Joly <njoly@pasteur.fr>
Message-ID: <20091016171558.GA360691@medusa.sis.pasteur.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ZPt4rx8FFjLCG7dd"
Content-Disposition: inline
Subject: [LTP] Add x86_64 ppoll(2) syscall number
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: LTP list <ltp-list@lists.sf.net>


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Hi,

The attached patch add the ppoll(2) syscall number to the x86_64 list,
and make the corresponding testcase succeed.

Signed-off-by: Nicolas Joly <njoly@pasteur.fr>

njoly@xxx [syscalls/ppoll]> uname -a
Linux xxx 2.6.18-164.el5 #1 SMP Thu Sep 3 03:28:30 EDT 2009 x86_64 x86_64 x86_64 GNU/Linux
njoly@xxx [syscalls/ppoll]> ./ppoll01 
ppoll01     0  TINFO  :  (case00) START
EXPECT: return value(ret)=(N >= 0) errno=0 (Success)
RESULT: return value(ret)=       1 errno=0 (Success)
ppoll01     0  TINFO  :  (case00) END => OK
ppoll01     0  TINFO  :  (case01) START
EXPECT: return value(ret)=(N >= 0) errno=0 (Success)
RESULT: return value(ret)=       0 errno=0 (Success)
ppoll01     0  TINFO  :  (case01) END => OK
ppoll01     0  TINFO  :  (case02) START
EXPECT: return value(ret)=(N >= 0) errno=0 (Success)
RESULT: return value(ret)=       0 errno=0 (Success)
ppoll01     0  TINFO  :  (case02) END => OK
ppoll01     0  TINFO  :  (case03) START
EXPECT: return value(ret)=(N >= 0) errno=0 (Success)
RESULT: return value(ret)=       1 errno=0 (Success)
ppoll01     0  TINFO  :  (case03) END => OK
ppoll01     0  TINFO  :  (case04) START
EXPECT: return value(ret)=-1 errno=4 (Interrupted system call)
RESULT: return value(ret)=-1 errno=4 (Interrupted system call)
ppoll01     0  TINFO  :  (case04) END => OK
ppoll01     0  TINFO  :  (case05) START
EXPECT: return value(ret)=-1 errno=4 (Interrupted system call)
RESULT: return value(ret)=-1 errno=4 (Interrupted system call)
ppoll01     0  TINFO  :  (case05) END => OK
ppoll01     0  TINFO  :  (case06) START
EXPECT: return value(ret)=-1 errno=22 (Invalid argument)
RESULT: return value(ret)=-1 errno=22 (Invalid argument)
ppoll01     0  TINFO  :  (case06) END => OK
ppoll01     0  TINFO  :  (case07) START
EXPECT: return value(ret)=-1 errno=14 (Bad address)
RESULT: return value(ret)=-1 errno=14 (Bad address)
ppoll01     0  TINFO  :  (case07) END => OK
ppoll01     1  TPASS  :  ppoll01 call succeeded 

-- 
Nicolas Joly

Biological Software and Databanks.
Institut Pasteur, Paris.

--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ltp-ppollx86_64.diff"

Index: testcases/kernel/include/x86_64.in
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/include/x86_64.in,v
retrieving revision 1.12
diff -u -p -r1.12 x86_64.in
--- testcases/kernel/include/x86_64.in	20 Jul 2009 04:41:12 -0000	1.12
+++ testcases/kernel/include/x86_64.in	16 Oct 2009 17:08:25 -0000
@@ -30,6 +30,7 @@ symlinkat 266
 readlinkat 267
 fchmodat 268
 faccessat 269
+ppoll 271
 splice 275
 tee 276
 vmsplice 278

--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--ZPt4rx8FFjLCG7dd--

