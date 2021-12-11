Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22659C433EF
	for <ltp@archiver.kernel.org>; Mon, 13 Dec 2021 08:40:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ECC613C89CE
	for <ltp@archiver.kernel.org>; Mon, 13 Dec 2021 09:40:14 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 127BF3C00B4
 for <ltp@lists.linux.it>; Sat, 11 Dec 2021 17:56:00 +0100 (CET)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 747E52001D6
 for <ltp@lists.linux.it>; Sat, 11 Dec 2021 17:55:58 +0100 (CET)
Received: by smtp.gentoo.org (Postfix, from userid 559)
 id 3F277342D13; Sat, 11 Dec 2021 16:55:56 +0000 (UTC)
Date: Sat, 11 Dec 2021 11:56:03 -0500
From: Mike Frysinger <vapier@gentoo.org>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <YbTYI2iKkopqLIjx@vapier>
Mail-Followup-To: Petr Vorel <pvorel@suse.cz>,
 Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it,
 Jan Stancek <jstancek@redhat.com>, Li Wang <liwang@redhat.com>,
 Xiao Yang <yangx.jy@cn.fujitsu.com>,
 Yang Xu <xuyang2018.jy@fujitsu.com>,
 Richard Palethorpe <rpalethorpe@suse.com>,
 Alexey Kodanev <aleksei.kodanev@bell-sw.com>,
 Enji Cooper <yaneurabeya@gmail.com>
References: <20211210134556.26091-1-pvorel@suse.cz> <YbN8abgFFb3RTq38@yuki>
 <YbTBgHwZQEigF/1v@pevik>
MIME-Version: 1.0
In-Reply-To: <YbTBgHwZQEigF/1v@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 13 Dec 2021 09:40:04 +0100
Subject: Re: [LTP] [PATCH 1/1] doc/maintainer: Add policy for new
 functionality
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: Richard Palethorpe <rpalethorpe@suse.com>,
 Xiao Yang <yangx.jy@cn.fujitsu.com>, ltp@lists.linux.it
Content-Type: multipart/mixed; boundary="===============2031157344=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>


--===============2031157344==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eByfOaBB8gNqNUln"
Content-Disposition: inline


--eByfOaBB8gNqNUln
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 11 Dec 2021 16:19, Petr Vorel wrote:
> > > Suggested-by: Cyril Hrubis <chrubis@suse.cz>
> > > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > > ---
> > >  doc/maintainer-patch-review-checklist.txt | 3 +++
> > >  1 file changed, 3 insertions(+)
>=20
> > > diff --git a/doc/maintainer-patch-review-checklist.txt b/doc/maintain=
er-patch-review-checklist.txt
> > > index c7bb47810..4e2b267ac 100644
> > > --- a/doc/maintainer-patch-review-checklist.txt
> > > +++ b/doc/maintainer-patch-review-checklist.txt
> > > @@ -34,6 +34,9 @@ New test should
> > >    GPL-2.0-or-later; the licence for test (e.g. GPL-2.0) should not c=
hange
> > >    unless test is completely rewritten
> > >  * Old copyrights should be kept unless test is completely rewritten
> > > +* Tests for new functionality in mainline kernel should be merged af=
ter final
> > > +  release of kernel which contains that functionality (it's not enou=
gh when the
> > > +  feature gets into rc1, because it can be reverted in later rc if p=
roblematic).
>=20
> > Sounds reasonable to me, but ideally this should be acked by the rest of
> > the maintainers.
>=20
> Sure, this can wait :).

seems fine
-mike

--eByfOaBB8gNqNUln
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEuQK1JxMl+JKsJRrUQWM7n+g39YEFAmG02CMACgkQQWM7n+g3
9YGQahAAulx+ebixwoCXcPYC99Kzchvq0z+qAAiXNc+Q4d+mSYtcvzJYxPCGvkTf
uoYAn2yu5IAi9MNdtPCpWjTDP/zV9WldYKtYfSIh7do4vCYdxfxtQj2GrU1gp4FV
sQHL22kIoYShw/a13eISnPvoxs71HCOecIy7hC3SctjLuacZp/FyM9tXy58BeG0H
/Ij1qfBgMd9UwKwcdzflGH4h71SvK9g3zV+xOwrOuUjCbiM/gs9myiJWvZPazfwZ
leFJd6XnOQYpiuwvJQQ/lKNCGHqoXCziAYwkCXx+zQs5qKoeboLgu3lFqFQcbqpB
l45HGb7AnmR5CopIQV4uK6Mo7YgtMrK04M5vbM2khpkbO9CViwe+XXxkL/F+X6LO
dbDkHl45WWU06C1bOm8PIQa9BsROCMjUxxt7VJFnTtYpBB42XrgF25VVPhvD6wtr
DZw4Mo4AZHbv6D1Le7S6VCBNfsSAaUBlwddFbVLS5UIfTmeAFw7ByHYNyhfQkSVK
yH/0+1bjUAW0njd8bGyAvZxJ0pQnZ9BIghGSAbOKoePrhbh7JtBfSaPwT/O3c04A
QnOuz6bxljBYYrkPrZc55NAG+sthao4L7tK51GzL7ix1Ky5hBqIe999YmKZYdOOV
znI+EMwQGkaOfOwiMWJxTuzDQgc+bRX540BBon14o3wKc71tsoA=
=mni5
-----END PGP SIGNATURE-----

--eByfOaBB8gNqNUln--

--===============2031157344==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============2031157344==--
