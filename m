Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PY4Ea-00024b-Qp
	for ltp-list@lists.sourceforge.net; Wed, 29 Dec 2010 22:11:04 +0000
Received: from mail-pv0-f175.google.com ([74.125.83.175])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PY4EZ-0003eh-TQ
	for ltp-list@lists.sourceforge.net; Wed, 29 Dec 2010 22:11:04 +0000
Received: by pvd12 with SMTP id 12so2065462pvd.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 29 Dec 2010 14:10:58 -0800 (PST)
References: <AANLkTi=TOy3i69CnLoZPK+rYqUQ_TfCQXmV=STzYop2i@mail.gmail.com>
In-Reply-To: <AANLkTi=TOy3i69CnLoZPK+rYqUQ_TfCQXmV=STzYop2i@mail.gmail.com>
Mime-Version: 1.0 (iPhone Mail 8C148)
Message-Id: <AAFECAC8-E32A-4241-B201-3EA5F0233FA1@gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Date: Wed, 29 Dec 2010 14:10:42 -0800
Subject: Re: [LTP] enable pwrite for 64 bits test
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1755138632091545156=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Vivi <violetleigh@gmail.com>
Cc: LTP mailing list <ltp-list@lists.sourceforge.net>


--===============1755138632091545156==
Content-Transfer-Encoding: 7bit
Content-Type: multipart/alternative;
	boundary=Apple-Mail-1--326644461


--Apple-Mail-1--326644461
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

This didn't add the runtest entire though.

Sent from my iPhone

On Dec 29, 2010, at 1:35 AM, Vivi <violetleigh@gmail.com> wrote:

> Enable ltp test of pwrite for 64 bit test.
>=20
> Bellow is the patch:
> --
> Index: testcases/kernel/syscalls/pwrite/Makefile
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- testcases/kernel/syscalls/pwrite/Makefile   (revision 161)
> +++ testcases/kernel/syscalls/pwrite/Makefile   (revision 183)
> @@ -19,5 +19,8 @@
>  top_srcdir             ?=3D ../../../..
>=20
>  include $(top_srcdir)/include/mk/testcases.mk
> +include $(abs_srcdir)/../utils/newer_64.mk
>=20
> +%_64: CPPFLAGS +=3D -D_FILE_OFFSET_BITS=3D64
> +
>  include $(top_srcdir)/include/mk/generic_leaf_target.mk
> --
>=20
>=20
>=20
> Best regards,
> Vivi Li
> --------------------------------------------------------------------------=
----
> Learn how Oracle Real Application Clusters (RAC) One Node allows customers=

> to consolidate database storage, standardize their database environment, a=
nd,=20
> should the need arise, upgrade to a full multi-node Oracle RAC database=20=

> without downtime or disruption
> http://p.sf.net/sfu/oracle-sfdevnl
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list

--Apple-Mail-1--326644461
Content-Transfer-Encoding: 7bit
Content-Type: text/html;
	charset=utf-8

<html><body bgcolor="#FFFFFF"><div>This didn't add the runtest entire though.<br><br>Sent from my iPhone</div><div><br>On Dec 29, 2010, at 1:35 AM, Vivi &lt;<a href="mailto:violetleigh@gmail.com">violetleigh@gmail.com</a>&gt; wrote:<br><br></div><div></div><blockquote type="cite"><div>Enable ltp test of pwrite for 64 bit test.<br><br>Bellow is the patch:<br>--<br>Index: testcases/kernel/syscalls/pwrite/Makefile<br>===================================================================<br>--- testcases/kernel/syscalls/pwrite/Makefile&nbsp;&nbsp; (revision 161)<br>

+++ testcases/kernel/syscalls/pwrite/Makefile&nbsp;&nbsp; (revision 183)<br>@@ -19,5 +19,8 @@<br>&nbsp;top_srcdir&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ?= ../../../..<br><br>&nbsp;include $(top_srcdir)/include/mk/<a href="http://testcases.mk" target="_blank">testcases.mk</a><br>
+include $(abs_srcdir)/../utils/<a href="http://newer_64.mk" target="_blank">newer_64.mk</a><br>
<br>+%_64: CPPFLAGS += -D_FILE_OFFSET_BITS=64<br>+<br>&nbsp;include $(top_srcdir)/include/mk/<a href="http://generic_leaf_target.mk" target="_blank">generic_leaf_target.mk</a><br>--<br><br><br><br>Best regards,<br>Vivi Li
</div></blockquote><blockquote type="cite"><div><span>------------------------------------------------------------------------------</span><br><span>Learn how Oracle Real Application Clusters (RAC) One Node allows customers</span><br><span>to consolidate database storage, standardize their database environment, and, </span><br><span>should the need arise, upgrade to a full multi-node Oracle RAC database </span><br><span>without downtime or disruption</span><br><span><a href="http://p.sf.net/sfu/oracle-sfdevnl">http://p.sf.net/sfu/oracle-sfdevnl</a></span></div></blockquote><blockquote type="cite"><div><span>_______________________________________________</span><br><span>Ltp-list mailing list</span><br><span><a href="mailto:Ltp-list@lists.sourceforge.net">Ltp-list@lists.sourceforge.net</a></span><br><span><a href="https://lists.sourceforge.net/lists/listinfo/ltp-list">https://lists.sourceforge.net/lists/listinfo/ltp-list</a></span><br></div></blockquote></body></html>
--Apple-Mail-1--326644461--


--===============1755138632091545156==
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
--===============1755138632091545156==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============1755138632091545156==--

