Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1Oj0FP-0004pY-1A
	for ltp-list@lists.sourceforge.net; Wed, 11 Aug 2010 01:36:51 +0000
Received: from out01.sjc.mx.trendmicro.com ([216.99.131.5])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Oj0FN-0003I7-Iq
	for ltp-list@lists.sourceforge.net; Wed, 11 Aug 2010 01:36:50 +0000
Received: from relay01.sjc.mx.trendmicro.com (unknown [10.30.239.23])
	by out01.sjc.mx.trendmicro.com (Postfix) with ESMTP id 7D359239DCF
	for <ltp-list@lists.sourceforge.net>;
	Wed, 11 Aug 2010 01:36:43 +0000 (UTC)
Received: from smtp-gate.ryobi.co.jp (unknown [210.163.224.132])
	by relay01.sjc.mx.trendmicro.com (Postfix) with ESMTP id C439F114B811
	for <ltp-list@lists.sourceforge.net>;
	Wed, 11 Aug 2010 01:36:42 +0000 (UTC)
From: "Mitani" <mitani@ryobi.co.jp>
Date: Wed, 11 Aug 2010 10:36:40 +0900
Message-ID: <000301cb38f5$a5992050$f0cb60f0$@co.jp>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0004_01CB3941.1580C850"
Content-Language: ja
Subject: [LTP] [PATCH] fix "8-3-buildonly"
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
To: ltp-list@lists.sourceforge.net
Cc: =?iso-2022-jp?B?GyRCYUQ6QhsoQiAbJEI3cjtUGyhC?= <toza@ryobi.co.jp>

This is a multi-part message in MIME format.

------=_NextPart_000_0004_01CB3941.1580C850
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit

Hi,

I tried to build open_posix_testsuite testcases with latest git:
   ltp-dev-7c67a09a10268b5f9f503e0254f1f0f9f5ac2b69.tar.gz

Several testcases failed to build.
One of them is as follows:
------------
[...]
conformance/definitions/sched_h/8-3-buildonly compile FAILED
../../../conformance/definitions/sched_h/8-3-buildonly.c:24:2: error: #error
SCHED_SPORADIC not defined
[...]
------------


"8-3-buildonly.c" outputs "SCHED_SPORADIC not defined" message by 
condition:

------------(8-3-buildonly.c)
[...]
#include <sched.h>
#include <unistd.h>

#if (defined(_POSIX_SPORADIC_SERVER) && _POSIX_SPORADIC_SERVER != -1) \
    || (defined(_POSIX_THREAD_SPORADIC_SERVER) && \
        POSIX_THREAD_SPORADIC_SERVER != -1)

#ifndef SCHED_SPORADIC
#error SCHED_SPORADIC not defined
#endif

#endif
------------

I noticed that "POSIX_THREAD_SPORADIC_SERVER" parameter has not "_" 
in its top.


Signed-off-by: Tomonori Mitani <mitani@ryobi.co.jp>

============
---
a/testcases/open_posix_testsuite/conformance/definitions/sched_h/8-3-buildon
ly.c	2010-08-05 22:28:15.000000000 +0900
+++
b/testcases/open_posix_testsuite/conformance/definitions/sched_h/8-3-buildon
ly.c	2010-08-11 10:22:24.000000000 +0900
@@ -18,7 +18,7 @@
 
 #if (defined(_POSIX_SPORADIC_SERVER) && _POSIX_SPORADIC_SERVER != -1) \
     || (defined(_POSIX_THREAD_SPORADIC_SERVER) && \
-	POSIX_THREAD_SPORADIC_SERVER != -1)
+	_POSIX_THREAD_SPORADIC_SERVER != -1)
 
 #ifndef SCHED_SPORADIC
 #error SCHED_SPORADIC not defined
============

After applying above patch, "8-3-buildonly.c" succeeded to build.



Regards--


-Tomonori Mitani

------=_NextPart_000_0004_01CB3941.1580C850
Content-Type: application/octet-stream;
	name="8-3-buildonly.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="8-3-buildonly.patch"

--- =
a/testcases/open_posix_testsuite/conformance/definitions/sched_h/8-3-buil=
donly.c	2010-08-05 22:28:15.000000000 +0900=0A=
+++ =
b/testcases/open_posix_testsuite/conformance/definitions/sched_h/8-3-buil=
donly.c	2010-08-11 10:22:24.000000000 +0900=0A=
@@ -18,7 +18,7 @@=0A=
 =0A=
 #if (defined(_POSIX_SPORADIC_SERVER) && _POSIX_SPORADIC_SERVER !=3D -1) =
\=0A=
     || (defined(_POSIX_THREAD_SPORADIC_SERVER) && \=0A=
-	POSIX_THREAD_SPORADIC_SERVER !=3D -1)=0A=
+	_POSIX_THREAD_SPORADIC_SERVER !=3D -1)=0A=
 =0A=
 #ifndef SCHED_SPORADIC=0A=
 #error SCHED_SPORADIC not defined=0A=

------=_NextPart_000_0004_01CB3941.1580C850
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.net email is sponsored by 

Make an app they can't live without
Enter the BlackBerry Developer Challenge
http://p.sf.net/sfu/RIM-dev2dev 
------=_NextPart_000_0004_01CB3941.1580C850
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_NextPart_000_0004_01CB3941.1580C850--



