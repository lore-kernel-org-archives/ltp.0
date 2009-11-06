Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1N6XYb-00063B-Jg
	for ltp-list@lists.sourceforge.net; Fri, 06 Nov 2009 22:45:25 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N6XYO-0006sa-OC
	for ltp-list@lists.sourceforge.net; Fri, 06 Nov 2009 22:45:20 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Fri, 6 Nov 2009 17:46:36 -0500
References: <20091106095745.GA25377@basil.fritz.box>
	<200911061612.11199.vapier@gentoo.org>
	<20091106214558.GJ819@basil.fritz.box>
In-Reply-To: <20091106214558.GJ819@basil.fritz.box>
MIME-Version: 1.0
Message-Id: <200911061746.37749.vapier@gentoo.org>
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
Content-Type: multipart/mixed; boundary="===============3377335124547309093=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Andi Kleen <andi@firstfloor.org>
Cc: ltp-list@lists.sourceforge.net, Nate Straz <nate@refried.org>

--===============3377335124547309093==
Content-Type: multipart/signed; boundary="nextPart3328393.2hKesTCpeE";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart3328393.2hKesTCpeE
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Friday 06 November 2009 16:45:58 Andi Kleen wrote:
> On Fri, Nov 06, 2009 at 04:12:10PM -0500, Mike Frysinger wrote:
> > On Friday 06 November 2009 16:02:25 Andi Kleen wrote:
> > > I'm also highly surprised that this doesn't work with autoconf -- I
> > > thought the whole point of autoconf was to generate portable makefile=
s,
> > > but in this case it seems to especially generate a non portable
> > > Makefile.
> >
> > that is not the point of autoconf at all; it has nothing to do with
> > makefiles. that is the point of automake -- which we specifically are n=
ot
> > using.  there are way too many Makefiles that would need to be generate=
d.
>=20
> True. So you guys just managed to write a very non portable Makefile on
>  your own.  Congratulations.

"portable" is not necessarily the same thing as "works around bugs in tools=
". =20
ignoring that, we are absolutely not "portable" -- GNU make is required.  t=
he=20
make feature set as defined by POSIX (and thus "portable") is too limited f=
or=20
our needs.
=2Dmike

--nextPart3328393.2hKesTCpeE
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.13 (GNU/Linux)

iQIcBAABAgAGBQJK9KdNAAoJEEFjO5/oN/WBMTMP/ijLMdygcA8f22OU73ZENHpN
h7nYtEp1BzCdqNdhzsFwHLZAwWZC/68QbdSSy+GLOXUYfXKzRf6A6Y5TRQSVUog+
e36mtHG1hB9zG0Jb8wSZjKqoJzWsSTpRnmhiVObGk9nuhhXG8qAd2UGTGkNIvHSH
sZfEDf8cKaD728FhA12frOC8vWazhEZH3yyZSJF69MApZOwESw7cRujHHPdSWs5G
RREe/PMtQoYd1i/SHM0quFQ/jp/vZaeHM6lr7ybLz7mxHodxMXKwjxXjy/QQKSJ8
7Ewv9FLdfC/SyqXbyK53OnQzYVzHwig4KpV4N2b1TD0RvDhw9rbbW3dtPojxBmSL
FCaSbu/N4JzTGD9oSevMeRALW2pxXXdZfocqlJbkh2q7nSHrHNmtnYAy3dp3Atb+
qKm1Om5w1JHl/lhO7hLgcL9QNSQWUnRriQPOyTSrNqbw4jFTDoUmKZg+AzDl6/xC
NS3N1h9XByDMOCwme1WCv3XpVxC4cjLSlo/5ehI/hxi3I9XrZw7BVXYJSJt4n4jx
SlaBf2cqLv6+UB5YNSALNiMC1JXHvMIhlOUQLWnV0B0oxVXXcVqVvYFexNVPjELQ
5UUDh2PQhjeAxJe1EXAm1BX5gLNkqgcuj2/HMdHh8XUDfelZgmuuubU05lNeeN01
oc/cupzHhAQDwpJXZXIG
=YWBU
-----END PGP SIGNATURE-----

--nextPart3328393.2hKesTCpeE--


--===============3377335124547309093==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--===============3377335124547309093==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============3377335124547309093==--

