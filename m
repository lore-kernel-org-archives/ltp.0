Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1N6U9v-0002Ao-Ue
	for ltp-list@lists.sourceforge.net; Fri, 06 Nov 2009 19:07:43 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N6U9q-0000zH-Vw
	for ltp-list@lists.sourceforge.net; Fri, 06 Nov 2009 19:07:43 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Fri, 6 Nov 2009 15:09:02 -0400
References: <20091106095745.GA25377@basil.fritz.box>
	<200911060821.40182.vapier@gentoo.org>
	<364299f40911061004mbb02ed3lf02a33164890625a@mail.gmail.com>
In-Reply-To: <364299f40911061004mbb02ed3lf02a33164890625a@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <200911061409.03835.vapier@gentoo.org>
Subject: Re: [LTP] LTP 20091031 Makefiles totally broken?!?
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5598527361324322456=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net, Andi Kleen <andi@firstfloor.org>

--===============5598527361324322456==
Content-Type: multipart/signed; boundary="nextPart19379448.b0PmuPjyB6";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart19379448.b0PmuPjyB6
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Friday 06 November 2009 13:04:51 Garrett Cooper wrote:
> As I just wrote in the INSTALL file after the release (I apologize for
> not catching this beforehand, but all of the systems I use -- Fedora,
> Gentoo, RHEL 4 update 6, Ubuntu -- have make 3.81):

hrm, it sucks to not support make 3.80.  while make 3.81 has been out for=20
three years now, make 3.80 support would increase the coverage to 8 years. =
=20
but if you've looked at the situation and found 3.80 support to be non=20
trivial, i wont whine too loud.

> In order to compile and use pan, you must have bison/yacc, flex, and make
> 3.81+ installed.

if we're forcing make-3.81+, then make it explicit:
ifneq ($(findstring x3.7,x$(MAKE_VERSION)),)
NEED_NEWER_MAKE :=3D y
endif
ifeq ($(MAKE_VERSION),3.80)
NEED_NEWER_MAKE :=3D y
endif
ifeq ($(NEED_NEWER_MAKE),y)
$(error ..)
endif

also, i thought we were going to rename the top level Makefile to GNUmakefi=
le=20
and add a dummy Makefile that just spat out "sorry, ltp requires GNU make".
=2Dmike

--nextPart19379448.b0PmuPjyB6
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.13 (GNU/Linux)

iQIcBAABAgAGBQJK9HRPAAoJEEFjO5/oN/WB9tgP+gOJQwwIg0V8elR4ba8WHIrL
1wb9YjRj34qoLTUdNX9oYVuLRyydsTKjdnsSgwVFhlQOL4ipthVDnceq1P0X8JVy
pE0EqUsjjlySApLloBwf3tUPny/Kkw6iqVMdyB+O2OhUtpMlAa9SXzfSsadGgiol
h7Bz+U3N3yAOoprft7dylVXFMwBOuR47yaZ1/CtB0FDJDrorgVjfDbr+hwawuanM
fLE7x/OBPalBn4AtswpIp++CjDQIoLnxiI8H5g3pamdXoURL7gzCSPXDcYGPQ9Tv
kYg4iMOzGv71HuUKiFWNtLgUMvaH19knYqvvlpywLcK2DexiYWQ8yoRFSSom/ZmK
YY9qP0qYwQQf/sWdE/ZNPEwvm24uHEh/Al/pZzkqFQ+gDIeJCC6xgx2Hr+H7JJbn
gRR+YdVrXCX90/5BRAxUkCcHeeop0xHRjTCot/E0NCHIQS4lcpAkEpiRcSET+/Pr
bv45dLVjlI77hhjBZbx6/3/fC7tL4669y0gmOvOIzl/0BWq09FfQRaepDJidD10P
k2AFev8ErLYIpsDXgSVPMsNyVZ+mBJ8sPksFKeYpHvCT2BIQbM7uFjvMCQqgS/NO
8WEYsZ9nNcg4WtJ0OV+TNJoJJOUNST8lmSDnZO5gb3aKWYZQ6zpJy1ZHkC3V5Cxi
boIiD/5sUIHbftapJ7Ny
=4HmM
-----END PGP SIGNATURE-----

--nextPart19379448.b0PmuPjyB6--


--===============5598527361324322456==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--===============5598527361324322456==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============5598527361324322456==--

