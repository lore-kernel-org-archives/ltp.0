Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1OvNJ7-0002na-Da
	for ltp-list@lists.sourceforge.net; Tue, 14 Sep 2010 04:39:49 +0000
Received: from out19.sjc.mx.trendmicro.com ([216.99.131.76])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OvNJ5-00063U-TW
	for ltp-list@lists.sourceforge.net; Tue, 14 Sep 2010 04:39:49 +0000
Received: from relay02.sjc.mx.trendmicro.com (unknown [10.30.239.24])
	by out19.sjc.mx.trendmicro.com (Postfix) with ESMTP id 9BC7598046B
	for <ltp-list@lists.sourceforge.net>;
	Tue, 14 Sep 2010 04:39:41 +0000 (UTC)
Received: from smtp-gate.ryobi.co.jp (unknown [210.163.224.132])
	by relay02.sjc.mx.trendmicro.com (Postfix) with ESMTP id 2AA899585D
	for <ltp-list@lists.sourceforge.net>;
	Tue, 14 Sep 2010 04:39:40 +0000 (UTC)
Received: from 5109496 ([10.113.10.40]) by po.rsoa.ryobi.co.jp
	(Post.Office MTA v4.1.1 release 20090730
	ID# 201-058U1200L1200S0V41J) with ESMTP id jp
	for <ltp-list@lists.sourceforge.net>; Tue, 14 Sep 2010 13:39:39 +0900
From: "Mitani" <mitani@ryobi.co.jp>
Date: Tue, 14 Sep 2010 13:39:39 +0900
Message-ID: <000401cb53c6$d7a16620$86e43260$@co.jp>
MIME-Version: 1.0
Content-Language: ja
Subject: [LTP] POSIX "sched_yield/1-1.c" build failed
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

POSIX "open_posix_testsuite/conformance/interfaces/sched_yield/1-1.c" 
build failed in RHEL4.8 (x86, x86_64, ia64):
------------
conformance/interfaces/sched_yield/1-1 compile FAILED; SKIPPING In file
included from ../../../conformance/interfaces/sched_yield/1-1.c:35:
../../../include/posixtest.h:14:2: #error "Contains GNU-isms that need
fixing."
../../../conformance/interfaces/sched_yield/1-1.c: In function
`set_thread_affinity':
../../../conformance/interfaces/sched_yield/1-1.c:91: warning: implicit
declaration of function `pthread_setaffinity_np'
------------

This testset seems to test "sched_yield()", and uses "sched_setafinity()" 
for CPU fixing.
I tried to remove "_GNU_SOURCE" definition from "sched_yield/1-1.c".
But "sched_setafinity()" needs "_GNU_SOURCE".
"sched_setafinity()" is necessary for this testset, and I considered the
substitution for "sched_setafinity()".
But I don't have any ideas. There is no function to be substitute for
"sched_setafinity()" by POSIX conformity, I think.


Regards--

-Tomonori Mitani



------------------------------------------------------------------------------
Start uncovering the many advantages of virtual appliances
and start using them to simplify application deployment and
accelerate your shift to cloud computing.
http://p.sf.net/sfu/novell-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
