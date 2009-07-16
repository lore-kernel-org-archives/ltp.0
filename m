Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <hyei@mvista.com>) id 1MRZDi-0002gX-IS
	for ltp-list@lists.sourceforge.net; Thu, 16 Jul 2009 22:14:30 +0000
Received: from gateway-1237.mvista.com ([63.81.120.158])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MRZDb-0000UE-C1
	for ltp-list@lists.sourceforge.net; Thu, 16 Jul 2009 22:14:30 +0000
Received: from svexch01.mvista.com (svexch01.mvista.com [10.0.0.82])
	by hermes.mvista.com (Postfix) with ESMTP id 15A791B063
	for <ltp-list@lists.sourceforge.net>;
	Thu, 16 Jul 2009 15:14:20 -0700 (PDT)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01CA0662.50B78948"
Date: Thu, 16 Jul 2009 15:11:06 -0700
Message-ID: <8368651DACC1964480F951191B94A078E49483@svexch01.mvista.com>
From: "Henry Yei" <hyei@mvista.com>
Subject: [LTP] [PATCH] network/lb6/Makefile, mips,
	mips-el toolchain needs explicit RANLIB call to build
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

This is a multi-part message in MIME format.

------_=_NextPart_001_01CA0662.50B78948
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

This patch fixes the following build error on mips, mips-el toolchain: =
"runcc.a: could not read symbols: Archive has no index; run ranlib to =
add one."

Signed-off-by: Henry Yei <hyei@mvista.com>

--- ltp-full-20090531/testcases/network/lib6/Makefile	2009-01-22 =
01:26:10.000000000 -0800
+++ ltp/testcases/network/lib6/Makefile	2009-07-16 14:53:58.215774700 =
-0700
@@ -39,3 +39,4 @@
=20
 runcc.a: runcc.o
 	ar cr runcc.a runcc.o
+	$(RANLIB) runcc.a




Other architectures don't need this patch, if anyone who more familiar =
with mips and knows why, please enlighten me.


Actual error output this patch fixes:
make[3]: Entering directory `/ltp-full-20090531/testcases/network/lib6'
gcc -mel -g -O2 -I../../../include -g -D_GNU_SOURCE   -c -o runcc.o =
runcc.c
ar cr runcc.a runcc.o
gcc -mel -g -O2 -I../../../include -g -D_GNU_SOURCE    asapi_01.c =
runcc.a -L../../../lib runcc.a -lltp -lpthread  -o asapi_01
runcc.a: could not read symbols: Archive has no index; run ranlib to add =
one
collect2: ld returned 1 exit status


Henry Yei
MontaVista Software, Inc.
hyei@mvista.com


=20

------_=_NextPart_001_01CA0662.50B78948
Content-Type: application/octet-stream;
	name="lib6-Makefile.patch"
Content-Transfer-Encoding: base64
Content-Description: lib6-Makefile.patch
Content-Disposition: attachment;
	filename="lib6-Makefile.patch"

LS0tIGx0cC1mdWxsLTIwMDkwNTMxL3Rlc3RjYXNlcy9uZXR3b3JrL2xpYjYvTWFrZWZpbGUJMjAw
OS0wMS0yMiAwMToyNjoxMC4wMDAwMDAwMDAgLTA4MDAKKysrIGx0cC90ZXN0Y2FzZXMvbmV0d29y
ay9saWI2L01ha2VmaWxlCTIwMDktMDctMTYgMTQ6NTM6NTguMjE1Nzc0NzAwIC0wNzAwCkBAIC0z
OSwzICszOSw0IEBACiAKIHJ1bmNjLmE6IHJ1bmNjLm8KIAlhciBjciBydW5jYy5hIHJ1bmNjLm8K
KwkkKFJBTkxJQikgcnVuY2MuYQo=

------_=_NextPart_001_01CA0662.50B78948
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have
the opportunity to enter the BlackBerry Developer Challenge. See full prize  
details at: http://p.sf.net/sfu/Challenge
------_=_NextPart_001_01CA0662.50B78948
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------_=_NextPart_001_01CA0662.50B78948--

