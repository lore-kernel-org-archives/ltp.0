Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1NVHiG-0006bi-0m
	for ltp-list@lists.sourceforge.net; Thu, 14 Jan 2010 04:53:40 +0000
Received: from out02.sjc.mx.trendmicro.com ([216.99.131.6])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NVHiE-0002Hf-FT
	for ltp-list@lists.sourceforge.net; Thu, 14 Jan 2010 04:53:39 +0000
Received: from relay01.sjc.mx.trendmicro.com (unknown [10.30.239.10])
	by out02.sjc.mx.trendmicro.com (Postfix) with ESMTP id AABE258C456
	for <ltp-list@lists.sourceforge.net>;
	Thu, 14 Jan 2010 04:53:31 +0000 (UTC)
Received: from smtp-gate.ryobi.co.jp (unknown [210.163.224.132])
	by relay01.sjc.mx.trendmicro.com (Postfix) with ESMTP id 00C13114B83B
	for <ltp-list@lists.sourceforge.net>;
	Thu, 14 Jan 2010 04:53:30 +0000 (UTC)
Received: from 5109496 ([10.113.10.40]) by po.rsoa.ryobi.co.jp
	(Post.Office MTA v4.1.1 release 20090730
	ID# 201-058U1200L1200S0V41J) with ESMTP id jp
	for <ltp-list@lists.sourceforge.net>; Thu, 14 Jan 2010 13:53:28 +0900
From: "Mitani" <mitani@ryobi.co.jp>
Date: Thu, 14 Jan 2010 13:53:28 +0900
Message-ID: <000901ca94d5$83797340$8a6c59c0$@co.jp>
MIME-Version: 1.0
Content-Language: ja
Subject: [LTP] cvs version 2010-01-14 make failed
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

I tried to make with 2010-01-14's cvs in RHEL4.8 (2.6.9-89.ELsmp).
But It failed in "mbind01.c" by following message.

------------
gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
-I/home/LTP/ltp-2010-01-12/testcases/kernel/include
-I/home/LTP/ltp-2010-01-12/testcases/kernel/syscalls/mbind/../utils/
-I../../../../include -I../../../../include   -L../../../../lib  mbind01.c
-lltp -lnuma -o mbind01
mbind01.c:184: error: `MPOL_DEFAULT' undeclared here (not in a function)
mbind01.c:184: error: initializer element is not constant
mbind01.c:184: error: (near initialization for `tcase[0].policy')
mbind01.c:188: error: initializer element is not constant
mbind01.c:188: error: (near initialization for `tcase[0]')
mbind01.c:190: error: initializer element is not constant
mbind01.c:190: error: (near initialization for `tcase[1].policy')
mbind01.c:194: error: initializer element is not constant
mbind01.c:194: error: (near initialization for `tcase[1]')
mbind01.c:196: error: `MPOL_BIND' undeclared here (not in a function)
mbind01.c:196: error: initializer element is not constant
mbind01.c:196: error: (near initialization for `tcase[2].policy')
mbind01.c:200: error: initializer element is not constant
mbind01.c:200: error: (near initialization for `tcase[2]')
mbind01.c:202: error: initializer element is not constant
mbind01.c:202: error: (near initialization for `tcase[3].policy')
mbind01.c:206: error: initializer element is not constant
mbind01.c:206: error: (near initialization for `tcase[3]')
mbind01.c:208: error: `MPOL_INTERLEAVE' undeclared here (not in a function)
mbind01.c:208: error: initializer element is not constant
mbind01.c:208: error: (near initialization for `tcase[4].policy')
mbind01.c:212: error: initializer element is not constant
mbind01.c:212: error: (near initialization for `tcase[4]')
mbind01.c:214: error: initializer element is not constant
mbind01.c:214: error: (near initialization for `tcase[5].policy')
mbind01.c:218: error: initializer element is not constant
mbind01.c:218: error: (near initialization for `tcase[5]')
mbind01.c:220: error: `MPOL_PREFERRED' undeclared here (not in a function)
mbind01.c:220: error: initializer element is not constant
mbind01.c:220: error: (near initialization for `tcase[6].policy')
mbind01.c:224: error: initializer element is not constant
mbind01.c:224: error: (near initialization for `tcase[6]')
mbind01.c:226: error: initializer element is not constant
mbind01.c:226: error: (near initialization for `tcase[7].policy')
mbind01.c:230: error: initializer element is not constant
mbind01.c:230: error: (near initialization for `tcase[7]')
mbind01.c:236: error: initializer element is not constant
mbind01.c:236: error: (near initialization for `tcase[8]')
mbind01.c:238: error: initializer element is not constant
mbind01.c:238: error: (near initialization for `tcase[9].policy')
mbind01.c:243: error: initializer element is not constant
mbind01.c:243: error: (near initialization for `tcase[9]')
mbind01.c:246: error: initializer element is not constant
mbind01.c:246: error: (near initialization for `tcase[10].policy')
mbind01.c:250: error: initializer element is not constant
mbind01.c:250: error: (near initialization for `tcase[10]')
mbind01.c: In function `do_test':
mbind01.c:309: error: `MPOL_F_ADDR' undeclared (first use in this function)
mbind01.c:309: error: (Each undeclared identifier is reported only once
mbind01.c:309: error: for each function it appears in.)
make[4]: *** [mbind01] Error 1
------------

Following version's cvs's bring same results.
 - 2010-01-08
 - 2010-01-12
 - 2010-01-13 


With 2009-12-21's cvs, I succeeded to make.
I took a difference of "mbind01.c" between "2009-12-21's cvs and 
2010-01-12's cvs.
In "mbind01.c", "#include "numaif.h" changed to #include "numa_helpers.h"

But the definition of "MPOL_DEFAULT" which was in "numaif.h" wasn't 
described in "numa_helpers.h". There isn't this definition anywhere.

I think that it may be necessary to copy the definitions of 
"MPOL_DEFAULT", "MPOL_BIND", etc... from "numaif.h".
I tried to apply following patch and succeeded to make:

============
--- numa_helpers.h.org  2010-01-13 14:15:35.000000000 +0900
+++ numa_helpers.h      2010-01-13 16:04:04.000000000 +0900
@@ -104,5 +104,18 @@
 }

 #endif
-
+#ifndef MPOL_DEFAULT
+   // Policies
+#  define MPOL_DEFAULT                  0
+#  define MPOL_PREFERRED                1
+#  define MPOL_BIND                     2
+#  define MPOL_INTERLEAVE               3
+   // Flags for get_mem_policy
+#  define MPOL_F_NODE                   (1<<0)
+#  define MPOL_F_ADDR                   (1<<1)
+   // Flags for mbind
+#  define MPOL_MF_STRICT                (1<<0)
+#  define MPOL_MF_MOVE                  (1<<1)
+#  define MPOL_MF_MOVE_ALL              (1<<2)
+#endif
 #endif
============


Regards--

-Tomonori Mitani



------------------------------------------------------------------------------
Throughout its 18-year history, RSA Conference consistently attracts the
world's best and brightest in the field, creating opportunities for Conference
attendees to learn about information security's most important issues through
interactions with peers, luminaries and emerging and established companies.
http://p.sf.net/sfu/rsaconf-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
