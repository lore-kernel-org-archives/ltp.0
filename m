Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1NLhRm-0006bM-Hh
	for ltp-list@lists.sourceforge.net; Fri, 18 Dec 2009 18:21:02 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NLhRh-0002xF-Hg
	for ltp-list@lists.sourceforge.net; Fri, 18 Dec 2009 18:21:02 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Fri, 18 Dec 2009 13:21:09 -0500
References: <000001ca7d4d$e2a9e7e0$a7fdb7a0$@co.jp>
	<364299f40912151139s38bd457eg88c6908d805f6ab4@mail.gmail.com>
In-Reply-To: <364299f40912151139s38bd457eg88c6908d805f6ab4@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <200912181321.11305.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] fix compiling error on ia64 platform
	(ltp-full-20091130)
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5097041232035107728=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: Mitani <mitani@ryobi.co.jp>

--===============5097041232035107728==
Content-Type: multipart/signed; boundary="nextPart180181378.CTCM92g1rF";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart180181378.CTCM92g1rF
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Tuesday 15 December 2009 14:39:24 Garrett Cooper wrote:
> On Mon, Dec 14, 2009 at 10:14 PM, Mitani wrote:
> > I applied following Casper's patch to "ltp-2009-12-10" cvs,
> > then "make" succeeded in RHEL5.4 ia64 system:
> > http://www.mail-archive.com/ltp-list@lists.sourceforge.net/msg08991.html
> >
> > On the other hand, I used Repository's following sources,
> > but "make" failed.
> >  - "ptrace.h"   (Revision 1.9)
> >  - "ptrace04.c" (Revision 1.13)
> >
> > But, at least, I think that the Repository's revision about "ptrace04.c"
> > is right. And "ptrace04.c" of "ltp-2009-12-15" cvs is same one.
> >
> >
> > Today, I arranged Casper's "ptrace.h" patch for "ltp-2009-12-15" cvs
> > and applied it to this cvs, and "make" succeeded.
> >
> >
> > I tried following other systems as using this patch, and succeeded:
> >  - RHEL5.4(kernel : 2.6.18-164.el5) and x86 architecture
> >  - RHEL5.4(kernel : 2.6.18-164.el5) and x86_64 architecture
> >  - RHEL4.8(kernel : 2.6.9-89.ELsmp) and x86 architecture
>=20
> Until this issue is resolved (I ran into problems trying to use
> crossdev, so I'll have to manually inspect headers after I track down
> which versions are used in the Redhat distros specified), please
> remember that you _can_ always comment out the line which says:
>=20
> /* Define to 1 if you have the <asm/ptrace.h> header file. */
> #define HAVE_ASM_PTRACE_H 1
>=20
> Actually, I think I'll just remove that header check if the build
> passes unless Mike objects, because we really shouldn't be
> #include'ing asm/* headers without having a good reason to do so
> because it results in pain of this magnitude...

the linux/asm ptrace headers are the only place where register defines are=
=20
found.  the C library ptrace only includes common ptrace requests.
=2Dmike

--nextPart180181378.CTCM92g1rF
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.13 (GNU/Linux)

iQIcBAABAgAGBQJLK8gXAAoJEEFjO5/oN/WBZeoP/1MxaqZlDfgjVQXe5pT7NGX5
BBUR6iuPlXBASVcyDd5XsaZrEEAJqwRcIfnJF9QBVCYRInCAmin0TCcQh1CQ2MJ5
4tmm2+iTiPnwWfpGXd0NpV/Oa9ZxrCdfCuCOUIjCSS9n7OjnWu79vQbAOtTeINY4
jbgAZeirmeTvJ0yS9ZGMwS1SOXqdqf5/p67Bo6yAFtfCPfzVlf/97v/JgJqxuLWC
vxUhmGID0g0MBkzUpdl28WVGNE0VW01pg98BEOYqAxIe6Z+MW4W96CVdM4ausWc/
FhmdlZK15xbzdMaDE17XJunvJaIg7xKwhgXZODlM1UD7RLNx8pSKWGOzyrWlxkiW
fFeKkE95GH89/NlnMGMa8/79kjK/cMUWdK2fCn38QfXGucJS/2fOwYxJH7qb2GWX
Ehjc1peRiVLGKxuAaBpnzn69bIOd7K2pwiUG9tgum9JXripIydcIZj+AQMr2gsaH
fZDcsp8+fzofs/J3K61tnQx4KYyLz9YdcZYEDy1pj3G9GU6PGcOTHKB+p1qbRwrE
0y2kRlo88K+vA1eG7JyXid5SSag79cgBUnfBoG2v8SmnffI/XpwhTpUQIA1/G9Ha
V6Cm+pFZPAhvNL1xTX30TZFFuD4UfNBvdb8jiGHs+41Co89vkTBg+ETN0ttPUTIF
AIqJbQQDp/++qs4GsZO0
=CUsh
-----END PGP SIGNATURE-----

--nextPart180181378.CTCM92g1rF--


--===============5097041232035107728==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
--===============5097041232035107728==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============5097041232035107728==--

