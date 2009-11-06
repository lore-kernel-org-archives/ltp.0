Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1N6UrF-00049q-EU
	for ltp-list@lists.sourceforge.net; Fri, 06 Nov 2009 19:52:29 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N6Ur7-0008Qb-62
	for ltp-list@lists.sourceforge.net; Fri, 06 Nov 2009 19:52:29 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Fri, 6 Nov 2009 15:53:44 -0400
References: <20091106095745.GA25377@basil.fritz.box>
	<200911061439.22257.vapier@gentoo.org>
	<364299f40911061144w73d5d382i6c7b9832ddab99a6@mail.gmail.com>
In-Reply-To: <364299f40911061144w73d5d382i6c7b9832ddab99a6@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <200911061453.45863.vapier@gentoo.org>
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
Content-Type: multipart/mixed; boundary="===============0410083951199103954=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net, Andi Kleen <andi@firstfloor.org>

--===============0410083951199103954==
Content-Type: multipart/signed; boundary="nextPart1321223.WEYVEE1Db0";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1321223.WEYVEE1Db0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Friday 06 November 2009 14:44:11 Garrett Cooper wrote:
> On Fri, Nov 6, 2009 at 11:39 AM, Mike Frysinger wrote:
> > On Friday 06 November 2009 14:13:43 Andi Kleen wrote:
> >> > I've considered adding a configure check for the make version. I'm
> >> > probably going to do it this weekend to avoid support issues like
> >> > these.
> >>
> >> That's not a solution.
> >>
> >> Please just fix the makefiles or revert this misguided change
> >> and give us working makefiles back.
> >>
> >> From a quick look at the mailing list archives that doesn't
> >> even seem to be the only problem with this "improvement".
> >
> > again, please stop wasting our time with your "revert it" comments.  it
> > isnt going to happen.  especially considering you apparently have no
> > signficant plans in helping maintain the huge code base that is LTP.
> >
> > we can look at working around bugs in make-3.80 if/since there are a
> > number of people who would like this functionality.
>=20
> I'll see whether or not there are other ways to skin the proverbial
> can to get make 3.80 to work, but the problem is that what I'm going
> to be providing in make <3.81 will be hacks, not solutions to fill in
> functional gaps.

let's at least start out with the known bugs/limitations and see how/if eac=
h=20
can be addressed.

sticking things behind something like this should be fine too:
ifeq ($(MAKE_VERSION),3.80)
# screw you make!
=2E..
endif
=2Dmike

--nextPart1321223.WEYVEE1Db0
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.13 (GNU/Linux)

iQIcBAABAgAGBQJK9H7JAAoJEEFjO5/oN/WB5ZUP/AhUl9ZCbuMd7DC9GfKurHa+
YkxQTTpin0ZKjyxscbecsZ1EFH172WOrF0V486CX/smwjuv34hx+xvE2/0w2DJPF
MHgiydTl121v9fKAa0rbVxAXM2YkSwBH5RRW3an+aWASMo1BrRr02kdyaKUapAYy
naDwyQ21MA1PanpS5vt387fzb7jon9dIBcqY9cwXQZuAcsa/LgjesjlmTuHtR3uh
uvIjVfrAD+Oekl2XFPbjGQMaw/6oPrkPbHm+5IkvFZXHAg7z6Ysg+um07K62Eysc
9vpVAI6IrUPiYtbcAGW/rpMGdia+QHRnhOmRTnWPAYNwnZ9ngiOkLlI36NWkBcn5
E1Cjp2/lSkh9hHXf4QrgaKSEKtrUyL9JPZ8ItTGjyiHfIcfFJiZN6ScyWXqyUM4Y
mLVH4JnzWEyX8jVakxKD3AlUM+FkJYxOwXHCGy5BEbAdRlNOjW/Arg1Cs46MAm++
AkT9N5Dl82Cfqq6z8GRP/IoLTJ0KRcvK/uFOsW2BlVPvmw8rySK4eqcc3whf3eYu
OR2Hnah/CDU/Z+ipIIzsv1XsDSSETHe/4lGRMxwGyB9bTPWtbDeHvsT9hlMAJa3H
fV2yxJfe7/VE9t4t547k+yuT+VUZ9BnMaFDrNEcCOQ/cNERqXdp9gchQitirT27o
1bliLWAmblacgYHHkc1z
=qW38
-----END PGP SIGNATURE-----

--nextPart1321223.WEYVEE1Db0--


--===============0410083951199103954==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--===============0410083951199103954==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============0410083951199103954==--

