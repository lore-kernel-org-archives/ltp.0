Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1N6Uvs-0005Hs-UL
	for ltp-list@lists.sourceforge.net; Fri, 06 Nov 2009 19:57:16 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N6Uvo-0006xZ-HN
	for ltp-list@lists.sourceforge.net; Fri, 06 Nov 2009 19:57:16 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Fri, 6 Nov 2009 15:58:36 -0400
References: <20091106095745.GA25377@basil.fritz.box>
	<200911061439.22257.vapier@gentoo.org>
	<20091106195036.GG819@basil.fritz.box>
In-Reply-To: <20091106195036.GG819@basil.fritz.box>
MIME-Version: 1.0
Message-Id: <200911061458.37702.vapier@gentoo.org>
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
Content-Type: multipart/mixed; boundary="===============7915407450684242212=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Andi Kleen <andi@firstfloor.org>
Cc: ltp-list@lists.sourceforge.net

--===============7915407450684242212==
Content-Type: multipart/signed; boundary="nextPart1608624.3kUslFsOnO";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1608624.3kUslFsOnO
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Friday 06 November 2009 14:50:36 Andi Kleen wrote:
> On Fri, Nov 06, 2009 at 03:39:21PM -0400, Mike Frysinger wrote:
> > On Friday 06 November 2009 14:13:43 Andi Kleen wrote:
> > > > I've considered adding a configure check for the make version. I'm
> > > > probably going to do it this weekend to avoid support issues like
> > > > these.
> > >
> > > That's not a solution.
> > >
> > > Please just fix the makefiles or revert this misguided change
> > > and give us working makefiles back.
> > >
> > > From a quick look at the mailing list archives that doesn't
> > > even seem to be the only problem with this "improvement".
> >
> > again, please stop wasting our time with your "revert it" comments.  it
> > isnt
>=20
> That's the standard strategy to fix regressions if the submitter
> is unwilling to fix newly introduced bugs.

your position on how to "fix" things is irrelevant here, nor is it helping =
in=20
any way.  drop it.

> > we can look at working around bugs in make-3.80 if/since there are a
> > number of people who would like this functionality.
>=20
> Are you saying that LTP as a project is not interested in fixing
>  regressions?

ive already made my position pretty clear in this statement.  support for o=
ld=20
versions of tools will continually be phased out over time.  the exact cut =
off=20
time will largely be dictated by the needs of the larger user base. =20
"cleverly" defining behavior as "regressions" notwithstanding.
=2Dmike

--nextPart1608624.3kUslFsOnO
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.13 (GNU/Linux)

iQIcBAABAgAGBQJK9H/tAAoJEEFjO5/oN/WBwSEP/1k7Q9zWBCosnulQQ/e22U0n
ekSrUQSoiaLwCSWwBeGdXi4aFAoOkMlnglgLVbME/mWfrPaCsAmJUF/1qUWaagAV
3aLpRjRU8oTedc2TR7n5j2NYitLHk6mB1/uwBJ/xNDR/Pz+dNDHYr8sBNj09buuE
DmMinMZ20WbxFReAYaY8+5g/ZIdLJwzLN3LWn/MS2jsO2ew/+R7VUtTGgXjrSSou
vE/PpharfmSxBQW80n6T3+vdT8e0Y85EVeHadipKDQh/mzUC6TVMMfd4x/6dIaBd
ah8NxQVYIK05+PZiNvnVPa6igdgJS9rUt/B2BALpDxo5Wq3veNSI6w5J6ENCB7yE
haYBaNUVFwdY1/OIRrnjbzb3XbB+PC/Fhf2dE1tooAPj3rHt1SHwjuPxub6CkSSD
VI1+6KVmy39L8u+lmtskDR6i5Hy7o3AwTM7WBaqJsEoIXtw6E/c4uhcZWiDhftDO
rBXYnCWcAOQAIly/OsdwY2WBmT0ifIuei6qVo1siRW2aHL3E6m6n59t25BnsVlfs
N2EjgMKjjfMoiz20OJgiEfHw1pGs6wpPN3K2qhW5WL3o9LAd3a7IVCm2iOILKOng
Saft8Ly7YmfPcz4hOh7IG5NvaTZpZ/Ps9QAcPyH+hehQ/La2BIyx1iIvmfHesrr6
rVEWNv0GHZbk9pna4jQ4
=ABZg
-----END PGP SIGNATURE-----

--nextPart1608624.3kUslFsOnO--


--===============7915407450684242212==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--===============7915407450684242212==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============7915407450684242212==--

