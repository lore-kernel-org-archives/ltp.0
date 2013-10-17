Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <bjsprakash@gmail.com>) id 1VWiSM-00012w-I3
	for ltp-list@lists.sourceforge.net; Thu, 17 Oct 2013 07:57:18 +0000
Received: from mail-ie0-f176.google.com ([209.85.223.176])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1VWiSK-0006ZI-Nz
	for ltp-list@lists.sourceforge.net; Thu, 17 Oct 2013 07:57:18 +0000
Received: by mail-ie0-f176.google.com with SMTP id u16so3191444iet.7
	for <ltp-list@lists.sourceforge.net>;
	Thu, 17 Oct 2013 00:57:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAGcQJusNyFXzWp-4FXA9HSfgcHePQdGxGZHyY38jvym+iQ1cnA@mail.gmail.com>
References: <CAGcQJusNyFXzWp-4FXA9HSfgcHePQdGxGZHyY38jvym+iQ1cnA@mail.gmail.com>
Date: Thu, 17 Oct 2013 13:27:11 +0530
Message-ID: <CAGcQJuvyNDpE7vS19UChrPwK9fzMR74jigDYJ_7d6Ste0ONtAw@mail.gmail.com>
From: prakash b <bjsprakash@gmail.com>
Subject: [LTP] Fwd: LTP patch contribution.
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============3607037840338009006=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============3607037840338009006==
Content-Type: multipart/alternative; boundary=20cf307f31fe4a275604e8eb2add

--20cf307f31fe4a275604e8eb2add
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



-- 
pracash

--20cf307f31fe4a275604e8eb2add
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br><div class=3D"gmail_quote"><br><div dir=3D"ltr">Hi=
 ltp-list,<div><br></div><div>I would like to submit a minor patch to ltp/s=
ourceforge.</div><div><br></div><div>To resolve abi related issues.=A0<br><=
/div>
<div><br></div><div><div>index c6226f8..6bc5863 100644</div>
<div>--- a/testcases/kernel/mem/lib/Makefile</div><div>+++ b/testcases/kern=
el/mem/lib/Makefile</div><div>@@ -20,7 +20,7 @@ top_srcdir =A0 =A0 =A0 =A0 =
=A0 =A0?=3D ../../../..</div><div>=A0</div><div>=A0include $(top_srcdir)/in=
clude/mk/<a href=3D"http://env_pre.mk" target=3D"_blank">env_pre.mk</a></di=
v>

<div>=A0</div><div>-CFLAGS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 :=3D -I../includ=
e</div><div>+CFLAGS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D -I../include</div>=
<div>=A0INTERNAL_LIB =A0 =A0 =A0 =A0 =A0 :=3D libmem.a</div><div>=A0</div><=
div>=A0include $(top_srcdir)/testcases/kernel/include/<a href=3D"http://lib=
.mk" target=3D"_blank">lib.mk</a></div>

<div><br></div><div>Regards,</div><div>Prakash B</div>
</div></div>
</div><br><br clear=3D"all"><div><br></div>-- <br>pracash<br>
</div>

--20cf307f31fe4a275604e8eb2add--


--===============3607037840338009006==
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
--===============3607037840338009006==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============3607037840338009006==--

