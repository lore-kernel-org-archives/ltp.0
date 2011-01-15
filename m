Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Pdyr4-0005Tl-BG
	for ltp-list@lists.sourceforge.net; Sat, 15 Jan 2011 05:39:14 +0000
Received: from mail-wy0-f175.google.com ([74.125.82.175])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1Pdyr2-0003gq-4l
	for ltp-list@lists.sourceforge.net; Sat, 15 Jan 2011 05:39:14 +0000
Received: by wyb40 with SMTP id 40so3415858wyb.34
	for <ltp-list@lists.sourceforge.net>;
	Fri, 14 Jan 2011 21:39:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <AANLkTi=TOy3i69CnLoZPK+rYqUQ_TfCQXmV=STzYop2i@mail.gmail.com>
References: <AANLkTi=TOy3i69CnLoZPK+rYqUQ_TfCQXmV=STzYop2i@mail.gmail.com>
Date: Fri, 14 Jan 2011 21:39:05 -0800
Message-ID: <AANLkTi=MC-shYNCszhz=8=nBg_J26_X5iBG-rcw05L7O@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Vivi <violetleigh@gmail.com>
Cc: LTP mailing list <ltp-list@lists.sourceforge.net>

On Wed, Dec 29, 2010 at 1:35 AM, Vivi <violetleigh@gmail.com> wrote:
> Enable ltp test of pwrite for 64 bit test.
>
> Bellow is the patch:
> --
> Index: testcases/kernel/syscalls/pwrite/Makefile
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- testcases/kernel/syscalls/pwrite/Makefile=A0=A0 (revision 161)
> +++ testcases/kernel/syscalls/pwrite/Makefile=A0=A0 (revision 183)
> @@ -19,5 +19,8 @@
> =A0top_srcdir=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ?=3D ../../../..
>
> =A0include $(top_srcdir)/include/mk/testcases.mk
> +include $(abs_srcdir)/../utils/newer_64.mk
>
> +%_64: CPPFLAGS +=3D -D_FILE_OFFSET_BITS=3D64
> +
> =A0include $(top_srcdir)/include/mk/generic_leaf_target.mk

I applied your patch, but there are a lot of warnings w.r.t. 64-bit
compilation that need fixing now. Please provide another patch to fix
that.
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Protect Your Site and Customers from Malware Attacks
Learn about various malware tactics and how to avoid them. Understand =

malware threats, the impact they can have on your business, and how you =

can protect your company and customers by using code signing.
http://p.sf.net/sfu/oracle-sfdevnl
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
