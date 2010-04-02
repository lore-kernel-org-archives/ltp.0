Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1NxXuR-0001SF-P9
	for ltp-list@lists.sourceforge.net; Fri, 02 Apr 2010 03:51:03 +0000
Received: from out03.sjc.mx.trendmicro.com ([216.99.131.7])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NxXuQ-0006rM-FR
	for ltp-list@lists.sourceforge.net; Fri, 02 Apr 2010 03:51:03 +0000
Received: from relay03.sjc.mx.trendmicro.com (unknown [10.30.239.22])
	by out03.sjc.mx.trendmicro.com (Postfix) with ESMTP id 2EA6D211016
	for <ltp-list@lists.sourceforge.net>;
	Fri,  2 Apr 2010 03:50:56 +0000 (UTC)
Received: from smtp-gate.ryobi.co.jp (unknown [210.163.224.132])
	by relay03.sjc.mx.trendmicro.com (Postfix) with ESMTP id 821473DD01B
	for <ltp-list@lists.sourceforge.net>;
	Fri,  2 Apr 2010 03:50:55 +0000 (UTC)
Received: from 5109496 ([10.113.10.40]) by po.rsoa.ryobi.co.jp
	(Post.Office MTA v4.1.1 release 20090730
	ID# 201-058U1200L1200S0V41J) with ESMTP id jp
	for <ltp-list@lists.sourceforge.net>; Fri, 2 Apr 2010 12:50:53 +0900
From: "Mitani" <mitani@ryobi.co.jp>
Date: Fri, 2 Apr 2010 12:50:53 +0900
Message-ID: <000401cad217$b1382d10$13a88730$@co.jp>
MIME-Version: 1.0
Content-Language: ja
Subject: [LTP] cap_bset_inh_bounds.c build failure
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

I tried to build by using yesterday's git in my system (RHEL4.8 x86).
 (ltp-dev-4837fee8a7c2de6a83c8927a574c792ca6dabe4e.tar.gz)
But build failed in "cap_bset_inh_bounds.c" with following message.
This is different from "cap_bounds_r.c"'s problem (another thread), I think

------------
gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
-I/home/LTP/ltp-dev-20100401-3/testcases/kernel/include
-I../../../../include -I../../../../include   -L../../../../lib
cap_bset_inh_bounds.c   -lltp -lcap -o cap_bset_inh_bounds
cap_bset_inh_bounds.c:124: error: syntax error before numeric constant
cap_bset_inh_bounds.c:124: warning: type defaults to `int' in declaration of
`tst_resm'
cap_bset_inh_bounds.c:124: error: conflicting types for 'tst_resm'
../../../../include/test.h:192: error: previous declaration of 'tst_resm'
was here
cap_bset_inh_bounds.c:124: error: conflicting types for 'tst_resm'
../../../../include/test.h:192: error: previous declaration of 'tst_resm'
was here
cap_bset_inh_bounds.c:124: warning: data definition has no type or storage
class
cap_bset_inh_bounds.c:129: warning: type defaults to `int' in declaration of
`tst_exit'
cap_bset_inh_bounds.c:129: error: conflicting types for 'tst_exit'
../../../../include/test.h:203: error: previous declaration of 'tst_exit'
was here
cap_bset_inh_bounds.c:129: error: conflicting types for 'tst_exit'
../../../../include/test.h:203: error: previous declaration of 'tst_exit'
was here
cap_bset_inh_bounds.c:129: warning: data definition has no type or storage
class
cap_bset_inh_bounds.c:130: error: syntax error before '}' token
------------

In this source, the pair of "ifdef" start/end and the pair of 
main() function's "parenthesis" are alternate, I think.


How about following patch?

Signed-off-by : Tomonori Mitani <mitani@ryobi.co.jp>

Index: ./testcases/kernel/security/cap_bound/cap_bset_inh_bounds.c
============
--- ./testcases/kernel/security/cap_bound/cap_bset_inh_bounds.c 2010-04-01
16:15:00.000000000 +0900
+++ ./testcases/kernel/security/cap_bound/cap_bset_inh_bounds.c.new
2010-04-01 17:27:23.000000000 +0900
@@ -39,11 +39,11 @@

 int errno;

+int main(int argc, char *argv[])
+{
 #if HAVE_SYS_CAPABILITY_H
 #if HAVE_DECL_PR_CAPBSET_READ && HAVE_DECL_PR_CAPBSET_DROP
 #ifdef HAVE_LIBCAP
-int main(int argc, char *argv[])
-{
        int ret = 1;
        cap_value_t v[1];
        cap_flag_value_t f;
============


Thank you--

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
