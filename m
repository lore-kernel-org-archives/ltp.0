Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1MbUfz-0002vQ-Qt
	for ltp-list@lists.sourceforge.net; Thu, 13 Aug 2009 07:24:43 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MbUfs-0001ro-EK
	for ltp-list@lists.sourceforge.net; Thu, 13 Aug 2009 07:24:43 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Thu, 13 Aug 2009 03:24:28 -0400
References: <364299f40907302333s61742580m5dba94b0a2e7afa5@mail.gmail.com>
	<20090731143544.GA9440@us.ibm.com>
In-Reply-To: <20090731143544.GA9440@us.ibm.com>
MIME-Version: 1.0
Message-Id: <200908130324.29506.vapier@gentoo.org>
Subject: Re: [LTP] Fix digsig so it passes -Wshadow
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============3211596425065182228=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============3211596425065182228==
Content-Type: multipart/signed; boundary="nextPart1639082.gSsuhKOsm3";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1639082.gSsuhKOsm3
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 31 July 2009 10:35:44 Serge E. Hallyn wrote:
> Quoting Garrett Cooper (yanegomi@gmail.com):
> > clone(2) is externally defined in sched.h, and as such
> > testcases/kernel/security/digsig/writeexec/libwritetest.c fails to
> > compile with -Wall due to a shadowed declaration.
> >
> > Signed-off-by: Garrett Cooper <yanegomi@gmail.com>
> >
> > --- writeexec/libwritetest.c	1 Nov 2005 16:09:43 -0000	1.1
> > +++ writeexec/libwritetest.c	31 Jul 2009 06:30:49 -0000
> > @@ -9,8 +9,6 @@
> >  #include <dlfcn.h>
> >  #include <wait.h>
> >
> > -int clone(int (*fn)(void *), void *child_stack, int flags, void *arg);
> > -
> >  int writer(void *data)
> >  {
> >  	int fd;
>
> Sure, as long as that's now the case on all distros.  Historically it
> hasn't been.  But if it's not we'll presumably hear about it.

except clone() is not safe to use directly as it isnt the same on all arche=
s. =20
we really need a wrapper for this in ltp.
=2Dmike

--nextPart1639082.gSsuhKOsm3
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iQIcBAABAgAGBQJKg7+tAAoJEEFjO5/oN/WBEPQP/2AFI8P3Xe44E5Mxdg/Hwk0f
kFkta4ViIQ8Jnp+r1GGOlujUeUbZcah32KMy25cJs1KP+mxShvrVInDgAzv0t6aV
i7ro4l2Pv+9WXdJBmlXYgbfLD8wyphEZFqz2x5XO+1RCEl/ZP/6bW7NN058c3wIW
aJh/zGZ+Y2s07iOtg1BTtrSU/5yNTVPHGiWsj1r6mQNxWtqaPDVtMWwFXuywA8Pj
/fbDcQc3xXIywEQVu/UDCoYo+GvLSMglGOSmdee+nOcleBmDE4/NAE4KX0TAcG2R
UAcHwX99rBnrrCooAIgDEoGpa0QpcwXamsImyc5kfCbcs+ydhvxgI9SNOe/VFTHD
IteqTp/k5OvSC1rSqhwMLV4WzrN7LUjaEZ7V+kWeJgMeEk/ag7c9DeSQVLS8wrhd
Z2ui+EIRLHx4lOnTcqHd4liLiSDg8ijmTi1VKvQ8yyUszrG++LYdGLPoAvX+EPkG
DpmWAGcqVbPQUQts27tgyiK0BRGG6PzfVJ3hE5mxelSg62Ib4LuLno0scW6DnhBe
Db2wfMCZLNmTIJAwQg0KbDssonEJE587jbR6lua6OzbCtSNCQgD4KUiN0usqfuYu
1AcLZBhg6f0s5TIpRgZYjzZIRrrcXkV2LQx2vPcjA/Nxx/f1tKmxa253MS/wDqTw
h0Y50AhR3kRcGN5t4wjV
=XDnl
-----END PGP SIGNATURE-----

--nextPart1639082.gSsuhKOsm3--


--===============3211596425065182228==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--===============3211596425065182228==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============3211596425065182228==--

