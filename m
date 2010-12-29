Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <violetleigh@gmail.com>) id 1PXsRd-0006EX-V8
	for ltp-list@lists.sourceforge.net; Wed, 29 Dec 2010 09:35:45 +0000
Received: from mail-gx0-f175.google.com ([209.85.161.175])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PXsRd-00013F-7V
	for ltp-list@lists.sourceforge.net; Wed, 29 Dec 2010 09:35:45 +0000
Received: by mail-gx0-f175.google.com with SMTP id 20so4618986gxk.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 29 Dec 2010 01:35:45 -0800 (PST)
MIME-Version: 1.0
Date: Wed, 29 Dec 2010 17:35:45 +0800
Message-ID: <AANLkTi=TOy3i69CnLoZPK+rYqUQ_TfCQXmV=STzYop2i@mail.gmail.com>
From: Vivi <violetleigh@gmail.com>
Subject: [LTP]  enable pwrite for 64 bits test
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2561423550501975394=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: LTP mailing list <ltp-list@lists.sourceforge.net>

--===============2561423550501975394==
Content-Type: multipart/alternative; boundary=0016e64651be1e19690498894b9c

--0016e64651be1e19690498894b9c
Content-Type: text/plain; charset=ISO-8859-1

Enable ltp test of pwrite for 64 bit test.

Bellow is the patch:
--
Index: testcases/kernel/syscalls/pwrite/Makefile
===================================================================
--- testcases/kernel/syscalls/pwrite/Makefile   (revision 161)
+++ testcases/kernel/syscalls/pwrite/Makefile   (revision 183)
@@ -19,5 +19,8 @@
 top_srcdir             ?= ../../../..

 include $(top_srcdir)/include/mk/testcases.mk
+include $(abs_srcdir)/../utils/newer_64.mk

+%_64: CPPFLAGS += -D_FILE_OFFSET_BITS=64
+
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
--



Best regards,
Vivi Li

--0016e64651be1e19690498894b9c
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Enable ltp test of pwrite for 64 bit test.<br><br>Bellow is the patch:<br>-=
-<br>Index: testcases/kernel/syscalls/pwrite/Makefile<br>=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>--- testcases/kernel/syscalls/pwrite/M=
akefile=A0=A0 (revision 161)<br>

+++ testcases/kernel/syscalls/pwrite/Makefile=A0=A0 (revision 183)<br>@@ -1=
9,5 +19,8 @@<br>=A0top_srcdir=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ?=3D ../.=
./../..<br><br>=A0include $(top_srcdir)/include/mk/<a href=3D"http://testca=
ses.mk" target=3D"_blank">testcases.mk</a><br>
+include $(abs_srcdir)/../utils/<a href=3D"http://newer_64.mk" target=3D"_b=
lank">newer_64.mk</a><br>
<br>+%_64: CPPFLAGS +=3D -D_FILE_OFFSET_BITS=3D64<br>+<br>=A0include $(top_=
srcdir)/include/mk/<a href=3D"http://generic_leaf_target.mk" target=3D"_bla=
nk">generic_leaf_target.mk</a><br>--<br><br><br><br>Best regards,<br>Vivi L=
i

--0016e64651be1e19690498894b9c--


--===============2561423550501975394==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Learn how Oracle Real Application Clusters (RAC) One Node allows customers
to consolidate database storage, standardize their database environment, and, 
should the need arise, upgrade to a full multi-node Oracle RAC database 
without downtime or disruption
http://p.sf.net/sfu/oracle-sfdevnl
--===============2561423550501975394==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============2561423550501975394==--

