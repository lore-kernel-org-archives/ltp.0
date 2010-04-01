Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1NxFXC-00060x-JH
	for ltp-list@lists.sourceforge.net; Thu, 01 Apr 2010 08:13:50 +0000
Received: from out01.sjc.mx.trendmicro.com ([216.99.131.5])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NxFX9-00078U-Lx
	for ltp-list@lists.sourceforge.net; Thu, 01 Apr 2010 08:13:50 +0000
Received: from relay03.sjc.mx.trendmicro.com (unknown [10.30.239.22])
	by out01.sjc.mx.trendmicro.com (Postfix) with ESMTP id 507B8239DD9
	for <ltp-list@lists.sourceforge.net>;
	Thu,  1 Apr 2010 08:13:41 +0000 (UTC)
Received: from smtp-gate.ryobi.co.jp (unknown [210.163.224.132])
	by relay03.sjc.mx.trendmicro.com (Postfix) with ESMTP id A25443DD022
	for <ltp-list@lists.sourceforge.net>;
	Thu,  1 Apr 2010 08:13:40 +0000 (UTC)
Received: from 5109496 ([10.113.10.40]) by po.rsoa.ryobi.co.jp
	(Post.Office MTA v4.1.1 release 20090730
	ID# 201-058U1200L1200S0V41J) with ESMTP id jp
	for <ltp-list@lists.sourceforge.net>; Thu, 1 Apr 2010 17:13:39 +0900
From: "Mitani" <mitani@ryobi.co.jp>
Date: Thu, 1 Apr 2010 17:13:39 +0900
Message-ID: <000001cad173$3c32b200$b4981600$@co.jp>
MIME-Version: 1.0
Content-Language: ja
Subject: [LTP] cap_bounds_r.c build failure
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

I tried to build by using yesterday's git.
 (ltp-dev-02719d6f7e5cb252c0fcbfbaf26208d7196e46f2.tar.gz)
But build failed in "cap_bounds_r.c" with following message.

------------
gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
-I/home/LTP/ltp-dev-20100401/testcases/kernel/include -I../../../../include
-I../../../../include   -L../../../../lib  cap_bounds_r.c   -lltp -lcap -o
cap_bounds_r
cap_bounds_r.c: In function `main':
cap_bounds_r.c:46: error: `CAP_LAST_CAP' undeclared (first use in this
function)
cap_bounds_r.c:46: error: (Each undeclared identifier is reported only once
cap_bounds_r.c:46: error: for each function it appears in.)
make[4]: *** [cap_bounds_r] Error 1
------------

I tried to today's git, but it failed, too.
 (ltp-dev-44fba94453ca4f446cde4db08b0a760862b55cfa.tar.gz)


I referd this source's diff in following URL.
http://ltp.git.sourceforge.net/git/gitweb.cgi?p=ltp/ltp-dev.git;a=commitdiff
;h=6e3dd83d9f575d98d76b8b3f642ad6e8793dbdfc

"CAP_LAST_CAP" definition is deleted with other definitions in this 
revision.
But "CAP_LAST_CAP" is still used after edited version.

"The editor may have deleted too much to make this source simple?"
I think. ;-)


There is same problem in "cap_bounds_rw.c", too.


How about following patch?


Signed-off-by: Tomonori Mitani <mitani@ryobi.co.jp>

Index: ./testcases/kernel/security/cap_bound/cap_bounds_r.c
============
--- ./testcases/kernel/security/cap_bound/cap_bounds_r.c        2010-03-31
22:44:52.000000000 +0900
+++ ./testcases/kernel/security/cap_bound/cap_bounds_r.c.new    2010-04-01
15:43:01.000000000 +0900
@@ -32,6 +32,13 @@
 #include <sys/prctl.h>
 #include <test.h>

+#if HAVE_SYS_CAPABILITY_H
+#ifndef CAP_LAST_CAP
+#warning out-of-date capability.h does not define CAP_LAST_CAP
+#define CAP_LAST_CAP 28  /* be ultra-conservative */
+#endif
+#endif
+
 char *TCID = "cap_bounds_r";
 int TST_TOTAL=1;

============

Index: ./testcases/kernel/security/cap_bound/cap_bounds_rw.c
============
--- ./testcases/kernel/security/cap_bound/cap_bounds_rw.c       2010-03-31
22:44:52.000000000 +0900
+++ ./testcases/kernel/security/cap_bound/cap_bounds_rw.c.new   2010-04-01
15:44:39.000000000 +0900
@@ -31,6 +31,13 @@
 #include <sys/prctl.h>
 #include <test.h>

+#if HAVE_SYS_CAPABILITY_H
+#ifndef CAP_LAST_CAP
+#warning out-of-date capability.h does not define CAP_LAST_CAP
+#define CAP_LAST_CAP 28  /* be ultra-conservative */
+#endif
+#endif
+
 char *TCID = "cap_bounds_rw";
 int TST_TOTAL=1;

============


Regards--

-Tomonori Mitani



------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
