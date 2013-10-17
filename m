Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <bjsprakash@gmail.com>) id 1VWiFp-0001dn-02
	for ltp-list@lists.sourceforge.net; Thu, 17 Oct 2013 07:44:21 +0000
Received: from mail-ie0-f169.google.com ([209.85.223.169])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1VWiFo-0007sF-78
	for ltp-list@lists.sourceforge.net; Thu, 17 Oct 2013 07:44:20 +0000
Received: by mail-ie0-f169.google.com with SMTP id ar20so3290051iec.14
	for <ltp-list@lists.sourceforge.net>;
	Thu, 17 Oct 2013 00:44:14 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 17 Oct 2013 13:14:14 +0530
Message-ID: <CAGcQJusNyFXzWp-4FXA9HSfgcHePQdGxGZHyY38jvym+iQ1cnA@mail.gmail.com>
From: prakash b <bjsprakash@gmail.com>
Subject: [LTP] LTP patch contribution.
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============7314051137752816062=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============7314051137752816062==
Content-Type: multipart/alternative; boundary=047d7b874c920134bc04e8eafc3e

--047d7b874c920134bc04e8eafc3e
Content-Type: text/plain; charset=ISO-8859-1

Hi ltp-list,

I would like to submit a minor patch to ltp/sourceforge.

To resolve abi related issues.

index c6226f8..6bc5863 100644
--- a/testcases/kernel/mem/lib/Makefile
+++ b/testcases/kernel/mem/lib/Makefile
@@ -20,7 +20,7 @@ top_srcdir            ?= ../../../..

 include $(top_srcdir)/include/mk/env_pre.mk

-CFLAGS                 := -I../include
+CFLAGS                 += -I../include
 INTERNAL_LIB           := libmem.a

 include $(top_srcdir)/testcases/kernel/include/lib.mk

Regards,
Prakash B

--047d7b874c920134bc04e8eafc3e
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi ltp-list,<div><br></div><div>I would like to submit a m=
inor patch to ltp/sourceforge.</div><div><br></div><div>To resolve abi rela=
ted issues.=A0<br></div><div><br></div><div><div>index c6226f8..6bc5863 100=
644</div>
<div>--- a/testcases/kernel/mem/lib/Makefile</div><div>+++ b/testcases/kern=
el/mem/lib/Makefile</div><div>@@ -20,7 +20,7 @@ top_srcdir =A0 =A0 =A0 =A0 =
=A0 =A0?=3D ../../../..</div><div>=A0</div><div>=A0include $(top_srcdir)/in=
clude/mk/<a href=3D"http://env_pre.mk">env_pre.mk</a></div>
<div>=A0</div><div>-CFLAGS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 :=3D -I../includ=
e</div><div>+CFLAGS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D -I../include</div>=
<div>=A0INTERNAL_LIB =A0 =A0 =A0 =A0 =A0 :=3D libmem.a</div><div>=A0</div><=
div>=A0include $(top_srcdir)/testcases/kernel/include/<a href=3D"http://lib=
.mk">lib.mk</a></div>
<div><br></div><div>Regards,</div><div>Prakash B</div>
</div></div>

--047d7b874c920134bc04e8eafc3e--


--===============7314051137752816062==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60135031&iu=/4140/ostg.clktrk
--===============7314051137752816062==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============7314051137752816062==--

