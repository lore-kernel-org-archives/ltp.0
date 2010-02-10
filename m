Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1Nf61s-0002Db-2P
	for ltp-list@lists.sourceforge.net; Wed, 10 Feb 2010 06:26:28 +0000
Received: from out03.sjc.mx.trendmicro.com ([216.99.131.7])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Nf61q-0005Cc-NW
	for ltp-list@lists.sourceforge.net; Wed, 10 Feb 2010 06:26:27 +0000
Received: from relay01.sjc.mx.trendmicro.com (unknown [10.30.239.28])
	by out03.sjc.mx.trendmicro.com (Postfix) with ESMTP id 4BBA42113AA
	for <ltp-list@lists.sourceforge.net>;
	Wed, 10 Feb 2010 06:26:20 +0000 (UTC)
Received: from smtp-gate.ryobi.co.jp (unknown [210.163.224.132])
	by relay01.sjc.mx.trendmicro.com (Postfix) with ESMTP id 99B93114B839
	for <ltp-list@lists.sourceforge.net>;
	Wed, 10 Feb 2010 06:26:19 +0000 (UTC)
Received: from 5109496 ([10.113.10.40]) by po.rsoa.ryobi.co.jp
	(Post.Office MTA v4.1.1 release 20090730
	ID# 201-058U1200L1200S0V41J) with ESMTP id jp
	for <ltp-list@lists.sourceforge.net>; Wed, 10 Feb 2010 15:26:17 +0900
From: "Mitani" <mitani@ryobi.co.jp>
Date: Wed, 10 Feb 2010 15:26:17 +0900
Message-ID: <000101caaa19$f3feb220$dbfc1660$@co.jp>
MIME-Version: 1.0
Content-Language: ja
Subject: [LTP] "check_netns_enabled.c" build failed with "2010-02-10" cvs
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

I tried to build with "2010-02-10" cvs in my systems.
I tried in RHEL5.4 (2.6.18-164.el5) and RHEL4.8 (2.6.9-89.ELsmp).
But "make" failed in "check_netns_enabled.c" as follows in RHEL4.8:
------------
gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
-I/home/LTP/ltp-2010-02-10/testcases/kernel/include
-I/home/LTP/ltp-2010-02-10/testcases/kernel/containers/netns/../libclone
-I../../../../include -I../../../../include
-L/home/LTP/ltp-2010-02-10/testcases/kernel/containers/netns/../libclone
-L../../../../lib  check_netns_enabled.c   -lltp -o check_netns_enabled
check_netns_enabled.c: In function `main':
check_netns_enabled.c:40: warning: implicit declaration of function
`unshare'
/tmp/cciXlXlf.o(.text+0x2c): In function `main':
/home/LTP/ltp-2010-02-10/testcases/kernel/containers/netns/check_netns_enabl
ed.c:40: undefined reference to `unshare'
collect2: ld returned 1 exit status
make[4]: *** [check_netns_enabled] Error 1
make[4]: Leaving directory
`/home/LTP/ltp-2010-02-10/testcases/kernel/containers/netns'
------------

"unshare()" function was supported after kernel 2.6.16.
Therefore, "make" of "check_netns_enabled.c" failed in RHEL4.8, I think.

I made patch and "make" succeeded:
============
--- ./testcases/kernel/containers/netns/check_netns_enabled.c   2008-09-19
21:17:10.000000000 +0900
+++ ./testcases/kernel/containers/netns/check_netns_enabled.c.new
2010-02-10 14:59:53.000000000 +0900
@@ -37,10 +37,12 @@
        if (tst_kvercmp(2,6,24) < 0)
                return 1;

+#ifdef HAVE_UNSHARE
         ret = unshare(flags);
        if ( ret < 0 ) {
                printf ("Error:Unshare syscall failed for network
namespace\n");
                return 3;
        }
+#endif
        return 0;
 }
============

I'm glad if I could get some opinions.


Thank you--


-Tomonori Mitani



------------------------------------------------------------------------------
SOLARIS 10 is the OS for Data Centers - provides features such as DTrace,
Predictive Self Healing and Award Winning ZFS. Get Solaris 10 NOW
http://p.sf.net/sfu/solaris-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
