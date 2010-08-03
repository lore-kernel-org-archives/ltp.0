Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1Og9ED-0000Im-VQ
	for ltp-list@lists.sourceforge.net; Tue, 03 Aug 2010 04:35:49 +0000
Received: from out20.sjc.mx.trendmicro.com ([216.99.131.77])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Og9EC-0004I8-Je
	for ltp-list@lists.sourceforge.net; Tue, 03 Aug 2010 04:35:49 +0000
Received: from relay01.sjc.mx.trendmicro.com (unknown [10.30.239.25])
	by out20.sjc.mx.trendmicro.com (Postfix) with ESMTP id C257B98043E
	for <ltp-list@lists.sourceforge.net>;
	Tue,  3 Aug 2010 04:35:42 +0000 (UTC)
Received: from smtp-gate.ryobi.co.jp (unknown [210.163.224.132])
	by relay01.sjc.mx.trendmicro.com (Postfix) with ESMTP id 1AB54114B838
	for <ltp-list@lists.sourceforge.net>;
	Tue,  3 Aug 2010 04:35:41 +0000 (UTC)
Received: from 5109496 ([10.113.10.40]) by po.rsoa.ryobi.co.jp
	(Post.Office MTA v4.1.1 release 20090730
	ID# 201-058U1200L1200S0V41J) with ESMTP id jp
	for <ltp-list@lists.sourceforge.net>; Tue, 3 Aug 2010 13:35:39 +0900
From: "Mitani" <mitani@ryobi.co.jp>
Date: Tue, 3 Aug 2010 13:35:39 +0900
Message-ID: <000e01cb32c5$52f62400$f8e26c00$@co.jp>
MIME-Version: 1.0
Content-Language: ja
Subject: [LTP] OPEN_POSIX "lio_listio" build failed
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

I tried to build open_posix_testsuite testcases:

   make distclean
   make all

But several testcases failed to build.
I paid attention to some of build-failed testcases. They are in 
"lio_listio" directory.
------------
conformance/interfaces/lio_listio/1-1 compile FAILED
/tmp/ccaX2A2v.o: In function `main':
1-1.c:(.text+0x316): undefined reference to `lio_listio'
1-1.c:(.text+0x472): undefined reference to `aio_error'
1-1.c:(.text+0x48a): undefined reference to `aio_return'
collect2: ld returned 1 exit status
conformance/interfaces/lio_listio/10-1 compile FAILED
/tmp/ccIj5aUK.o: In function `main':
10-1.c:(.text+0x2ee): undefined reference to `lio_listio'
10-1.c:(.text+0x38e): undefined reference to `aio_error'
10-1.c:(.text+0x3a3): undefined reference to `aio_return'
collect2: ld returned 1 exit status
conformance/interfaces/lio_listio/11-1 compile FAILED
/tmp/cccIltt0.o: In function `main':
11-1.c:(.text+0x30a): undefined reference to `lio_listio'
11-1.c:(.text+0x3eb): undefined reference to `aio_error'
11-1.c:(.text+0x400): undefined reference to `aio_return'
collect2: ld returned 1 exit status
[...]
------------

I edited their Makefile as follows for trial:
============
---
a/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/Makefile
2010-08-02 14:10:31.000000000 +0900
+++
b/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/Makefile
2010-08-03 09:33:08.000000000 +0900
@@ -30,7 +30,7 @@
 # Submake make definitions.
 CFLAGS+=		
 LDFLAGS+=		
-LDLIBS+=		
+LDLIBS+=		-lrt
 
 INSTALL_TARGETS+=	1-1.run-test 10-1.run-test 11-1.run-test
12-1.run-test 13-1.run-test 14-1.run-test 15-1.run-test 16-1.run-test
17-1.run-test 18-1.run-test 19-1.run-test 2-1.run-test 20-1.run-test
21-1.run-test 22-1.run-test 23-1.run-test 24-1.run-test 25-1.run-test
3-1.run-test 4-1.run-test 5-1.run-test 6-1.run-test 7-1.run-test
8-1.run-test 9-1.run-test
 MAKE_TARGETS+=		1-1.run-test 10-1.run-test 11-1.run-test
12-1.run-test 13-1.run-test 14-1.run-test 15-1.run-test 16-1.run-test
17-1.run-test 18-1.run-test 19-1.run-test 2-1.run-test 20-1.run-test
21-1.run-test 22-1.run-test 23-1.run-test 24-1.run-test 25-1.run-test
3-1.run-test 4-1.run-test 5-1.run-test 6-1.run-test 7-1.run-test
8-1.run-test 9-1.run-test

============

After that, they succeeded to build.

But this Makefile cannot be edited because it is generated when "make all".
I think that "LDLIBS" file is necessary in "lio_listio" directory.


Regards--


-Tomonori Mitani



------------------------------------------------------------------------------
The Palm PDK Hot Apps Program offers developers who use the
Plug-In Development Kit to bring their C/C++ apps to Palm for a share
of $1 Million in cash or HP Products. Visit us here for more details:
http://p.sf.net/sfu/dev2dev-palm
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
