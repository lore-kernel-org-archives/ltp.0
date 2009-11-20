Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1NBQfZ-0002D6-1V
	for ltp-list@lists.sourceforge.net; Fri, 20 Nov 2009 10:24:49 +0000
Received: from smtp-gate3.ryobi.co.jp ([210.163.224.134])
	by 3b2kzd1.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1NBQfR-0002Oz-Dq
	for ltp-list@lists.sourceforge.net; Fri, 20 Nov 2009 10:24:49 +0000
Received: from 5109496 ([10.113.10.40]) by po.rsoa.ryobi.co.jp
	(Post.Office MTA v4.1.1 release 20090730
	ID# 201-058U1200L1200S0V41J) with ESMTP id jp
	for <ltp-list@lists.sourceforge.net>; Fri, 20 Nov 2009 19:24:30 +0900
From: "Mitani" <mitani@ryobi.co.jp>
Date: Fri, 20 Nov 2009 19:24:30 +0900
Message-ID: <000401ca69cb$a521e520$ef65af60$@co.jp>
MIME-Version: 1.0
Content-Language: ja
Subject: [LTP] build failure with 2009-11-20 cvs
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

I ran "make" in RHEL4.8 (Kernel release : 2.6.9-89.ELsmp) with
ltp-2009-11-20.tar.gz.
But it failed with following error message.
./configure has been done before make.

------------
make[4]: Entering directory
`/home/mitani/LTP/ltp-2009-11-20/testcases/kernel/containers/m
qns'
gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
-I/home/mitani/LTP/ltp-2009-11-20/test
cases/kernel/include
-I/home/mitani/LTP/ltp-2009-11-20/testcases/kernel/containers/mqns/..
/libclone -I../../../../include -I../../../../include
-L/home/mitani/LTP/ltp-2009-11-20/
testcases/kernel/containers/mqns/../libclone -L../../../../lib  mqns_01.c
-lpthread -lrt
-lclone -lltp -o mqns_01
/home/mitani/LTP/ltp-2009-11-20/testcases/kernel/include/linux_syscall_numbe
rs.h:19: warni
ng: 'cleanup' declared `static' but never defined
/home/mitani/LTP/ltp-2009-11-20/testcases/kernel/containers/mqns/../libclone
/libclone.a(li
bclone.o)(.text+0xef): In function `do_unshare_tests':
/home/mitani/LTP/ltp-2009-11-20/testcases/kernel/containers/libclone/libclon
e.c:59: undefi
ned reference to `cleanup'
collect2: ld returned 1 exit status
make[4]: *** [mqns_01] Error 1
make[4]: Leaving directory
`/home/mitani/LTP/ltp-2009-11-20/testcases/kernel/containers/mq
ns'
make[3]: *** [all] Error 2
make[3]: Leaving directory
`/home/mitani/LTP/ltp-2009-11-20/testcases/kernel/containers'
make[2]: *** [all] Error 2
make[2]: Leaving directory
`/home/mitani/LTP/ltp-2009-11-20/testcases/kernel'
make[1]: *** [all] Error 2
make[1]: Leaving directory `/home/mitani/LTP/ltp-2009-11-20/testcases'
make: *** [testcases-all] Error 2
------------


I use make 3.81, autoconf 2.61, automake 1.10.2, and m4 1.4.7.

Can I get some advice?


Regards--

-Tomonori Mitani




------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
