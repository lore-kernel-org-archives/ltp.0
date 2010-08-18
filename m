Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1Olctv-0000fn-97
	for ltp-list@lists.sourceforge.net; Wed, 18 Aug 2010 07:17:31 +0000
Received: from out21.sjc.mx.trendmicro.com ([216.99.131.78])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Olcts-0006s8-UO
	for ltp-list@lists.sourceforge.net; Wed, 18 Aug 2010 07:17:31 +0000
Received: from relay04.sjc.mx.trendmicro.com (unknown [10.30.239.5])
	by out21.sjc.mx.trendmicro.com (Postfix) with ESMTP id 73A0A98044A
	for <ltp-list@lists.sourceforge.net>;
	Wed, 18 Aug 2010 07:17:22 +0000 (UTC)
Received: from smtp-gate.ryobi.co.jp (unknown [210.163.224.132])
	by relay04.sjc.mx.trendmicro.com (Postfix) with ESMTP id C85BB1D784A
	for <ltp-list@lists.sourceforge.net>;
	Wed, 18 Aug 2010 07:17:21 +0000 (UTC)
Message-ID: <000001cb3ea4$e05de680$a119b380$@co.jp>
From: "Mitani" <mitani@ryobi.co.jp>
Date: Wed, 18 Aug 2010 16:13:36 +0900
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="--=_NextPart_ST_16_13_37_Wednesday_August_18_2010_23024"
Content-Language: ja
Subject: [LTP] [PATCH] fix two "2-1.c" tests of POSIX
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

----=_NextPart_ST_16_13_37_Wednesday_August_18_2010_23024
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit

Hi,

I tried to build open_posix_testsuite testcases with latest git:
   ltp-dev-e8ad463baada21fb19f4c06f7dcab75c420ae373.tar.gz

Several testcases failed to build.
Two of them is as follows:
------------
[...]
conformance/interfaces/pthread_attr_setstack/2-1 compile FAILED
In file included from
../../../conformance/interfaces/pthread_attr_setstack/2-1.c:31:
../../../include/posixtest.h:14:2: error: #error "Contains GNU-isms that
need fixing."
[...]
conformance/interfaces/pthread_attr_setstacksize/2-1 compile FAILED
In file included from
../../../conformance/interfaces/pthread_attr_setstacksize/2-1.c:31:
../../../include/posixtest.h:14:2: error: #error "Contains GNU-isms that
need fixing."
[...]
------------

".../pthread_attr_setstack/2-1.c" and ".../include/posixtest.h" are 
as follows:
------------(.../pthread_attr_setstack/2-1.c)
[...]
#ifndef _GNU_SOURCE
#define _GNU_SOURCE
#endif
#include <pthread.h>
#include <limits.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <sys/param.h>
#include <errno.h>
#include <unistd.h>
#include "posixtest.h"
[...]
------------

------------(posixtest.h)
[...]
#if defined(_GNU_SOURCE)
#error "Contains GNU-isms that need fixing."
#elif defined(_BSD_SOURCE)
#error "Contains BSD-isms that need fixing."
#endif
[...]
------------

In above "2-1.c", "_GNU_SOURCE" is defined. After that, "posixtest.h" 
is included.
And, in "posixtest.h", if "_GNU_SOURCE" is defined, error occurs.

If "#ifndef _GNU_SOURCE" is arranged after a line of "posixtest.h",
error doesn't occur.
I confirmed that build succeeded by this revision and the test 
became PASS.

Another "2-1.c" is same as above testcase.


Signed-off-by: Tomonori Mitani <mitani@ryobi.co.jp>

============
---
a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setstac
k/2-1.c	2010-08-18 07:18:35.000000000 +0900
+++
b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setstac
k/2-1.c	2010-08-18 15:43:16.000000000 +0900
@@ -17,9 +17,6 @@
  *       provided by nptl, which is developed by Ulrich Drepper.
  */
 
-#ifndef _GNU_SOURCE
-#define _GNU_SOURCE
-#endif 
 #include <pthread.h>
 #include <limits.h>
 #include <stdio.h>
@@ -30,6 +27,10 @@
 #include <unistd.h>
 #include "posixtest.h"
 
+#ifndef _GNU_SOURCE
+#define _GNU_SOURCE
+#endif
+
 #define TEST "2-1"
 #define FUNCTION "pthread_attr_setstack"
 #define ERROR_PREFIX "unexpected error: " FUNCTION " " TEST ": "
---
a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setstac
ksize/2-1.c	2010-08-18 07:18:35.000000000 +0900
+++
b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setstac
ksize/2-1.c	2010-08-18 15:44:56.000000000 +0900
@@ -17,9 +17,6 @@
  *       provided by nptl, which is developed by Ulrich Drepper.
  */
 
-#ifndef _GNU_SOURCE
-#define _GNU_SOURCE
-#endif 
 #include <pthread.h>
 #include <limits.h>
 #include <stdio.h>
@@ -30,6 +27,10 @@
 #include <unistd.h>
 #include "posixtest.h"
 
+#ifndef _GNU_SOURCE
+#define _GNU_SOURCE
+#endif
+
 #define TEST "2-1"
 #define FUNCTION "pthread_attr_setstacksize"
 #define ERROR_PREFIX "unexpected error: " FUNCTION " " TEST ": "
============



Regards--


-Tomonori Mitani

----=_NextPart_ST_16_13_37_Wednesday_August_18_2010_23024
Content-Type: application/octet-stream;
	name="2-1.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="2-1.patch"

--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_se=
tstack/2-1.c=092010-08-18 07:18:35.000000000 +0900=0A+++ b/testcases/open_p=
osix_testsuite/conformance/interfaces/pthread_attr_setstack/2-1.c=092010-08=
-18 15:43:16.000000000 +0900=0A@@ -17,9 +17,6 @@=0A  *       provided by np=
tl, which is developed by Ulrich Drepper.=0A  */=0A =0A-#ifndef _GNU_SOURCE=
=0A-#define _GNU_SOURCE=0A-#endif =0A #include <pthread.h>=0A #include <lim=
its.h>=0A #include <stdio.h>=0A@@ -30,6 +27,10 @@=0A #include <unistd.h>=0A=
 #include "posixtest.h"=0A =0A+#ifndef _GNU_SOURCE=0A+#define _GNU_SOURCE=0A=
+#endif=0A+=0A #define TEST "2-1"=0A #define FUNCTION "pthread_attr_setstac=
k"=0A #define ERROR_PREFIX "unexpected error: " FUNCTION " " TEST ": "=0A--=
- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_sets=
tacksize/2-1.c=092010-08-18 07:18:35.000000000 +0900=0A+++ b/testcases/open=
_posix_testsuite/conformance/interfaces/pthread_attr_setstacksize/2-1.c=092=
010-08-18 15:44:56.000000000 +0900=0A@@ -17,9 +17,6 @@=0A  *       provided=
 by nptl, which is developed by Ulrich Drepper.=0A  */=0A =0A-#ifndef _GNU_=
SOURCE=0A-#define _GNU_SOURCE=0A-#endif =0A #include <pthread.h>=0A #includ=
e <limits.h>=0A #include <stdio.h>=0A@@ -30,6 +27,10 @@=0A #include <unistd=
=2Eh>=0A #include "posixtest.h"=0A =0A+#ifndef _GNU_SOURCE=0A+#define _GNU_=
SOURCE=0A+#endif=0A+=0A #define TEST "2-1"=0A #define FUNCTION "pthread_att=
r_setstacksize"=0A #define ERROR_PREFIX "unexpected error: " FUNCTION " " T=
EST ": "=0A
----=_NextPart_ST_16_13_37_Wednesday_August_18_2010_23024
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.net email is sponsored by 

Make an app they can't live without
Enter the BlackBerry Developer Challenge
http://p.sf.net/sfu/RIM-dev2dev 
----=_NextPart_ST_16_13_37_Wednesday_August_18_2010_23024
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

----=_NextPart_ST_16_13_37_Wednesday_August_18_2010_23024--

