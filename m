Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1OTKZw-0004MU-SB
	for ltp-list@lists.sourceforge.net; Mon, 28 Jun 2010 20:05:16 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OTKZs-0000Ek-PS
	for ltp-list@lists.sourceforge.net; Mon, 28 Jun 2010 20:05:16 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Mon, 28 Jun 2010 15:54:56 -0400
References: <20100628115217.23913.32352.sendpatchset@subratamodak.linux.ibm.com>
	<AANLkTim8L2Ea9GnBKlvipbCbdWvXyPanpomq7L3ncb_S@mail.gmail.com>
In-Reply-To: <AANLkTim8L2Ea9GnBKlvipbCbdWvXyPanpomq7L3ncb_S@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <201006281554.57264.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] Remove files which does not have a dmesg entry
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============4436917605684426726=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: LTP List Members <ltp-list@lists.sf.net>

--===============4436917605684426726==
Content-Type: multipart/signed; boundary="nextPart2752999.ctgfEpn1ZU";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2752999.ctgfEpn1ZU
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Monday, June 28, 2010 15:53:11 Garrett Cooper wrote:
> On Mon, Jun 28, 2010 at 4:52 AM, Subrata Modak wrote:
> > +       if [ $ALT_DMESG_OUT -eq 1 ] ; then
> > +               PWD=3D`pwd`
>=20
> Please use a different variable name. This obfuscates the meaning of
> the shell set value.

use a `find` as i suggested and changing dir isnt necessary.  it replaces t=
he=20
entire body of the if statement.
=2Dmike

--nextPart2752999.ctgfEpn1ZU
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)

iQIcBAABAgAGBQJMKP4RAAoJEEFjO5/oN/WBTq4QAIEb6IpPg+TllbPbP0YAejwF
c+aVDHN3UNEvjiT3DBAHztG7jUsnhyvAbNJ9nMK0oQrmaarx5eTQgLX70mAI+zU5
hpQCeUre/zAc/3iuOPE6qLOMgCTaUWWOi+Z7YVTileW0YUkAapoPPt59h3pwM0fH
O8re0MPlnmn3EMUFcLEQ9bO6zAaAskPeeoX4z0rBQu3BqOjTQWoQNGIev1D2FUvC
FkAG2PmqipoOQm+3/71bA5mwhBaAE17S1F6J8iHeJfN3h48mf7N+Z/U/RKkeJTSx
kHZYg65+r9jM17sueXqIG8tIsNHpVbHbxS1POVfYF8rRdexcWpi2M8f8PYe9x1oc
6TcccpBOuxY/NJ7un1i1UKlMUarFR0A0IEDAsMZoAPL10clk5HXAiOlGjFjPGl+g
CC8a9irM5xQwHn/UkEjoB2+mA67l+nXh7Ni2p0u95lWoNeTTRi0EbrVQGIRAbMhB
zWFucimfKbGZuOyyq6YAlMf01PA3nsfGKP57eQsKW3TTk1Zw3F67NuKZVFh1AxPj
gfnjuVdLY/T7kTFeaQvDS7pFZ+tlUH3CwXjeFc1s/j8inirtIN4Sp9klDEPm340S
jw6FXEs0Qi3MZwUn6nm2RQZTwjmu55Gndsn+kG3cAbJROa4ZmnD4Y6GQ1RSFiY8c
MhMgDf0AggfiOBCCz6dA
=gKnK
-----END PGP SIGNATURE-----

--nextPart2752999.ctgfEpn1ZU--


--===============4436917605684426726==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
--===============4436917605684426726==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============4436917605684426726==--

