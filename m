Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1WMntY-0002Dy-Ol
	for ltp-list@lists.sourceforge.net; Mon, 10 Mar 2014 00:16:40 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WMntX-0000gZ-Vr
	for ltp-list@lists.sourceforge.net; Mon, 10 Mar 2014 00:16:40 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Sun, 09 Mar 2014 20:16:38 -0400
Message-ID: <1511080.NMJad3AWfD@vapier>
In-Reply-To: <D29743B70598864B880A3BE89C6E96946FEA75@USCHMBX004.nsn-intra.net>
References: <D29743B70598864B880A3BE89C6E96946FEA75@USCHMBX004.nsn-intra.net>
MIME-Version: 1.0
Subject: Re: [LTP] Support needed for LINUX POSIX compliance test
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============7365387255592896366=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: "Bola, Pradeep (EXT-Tata Consultancy Ser - US/Arlington Heights)" <pradeep.bola.ext@nsn.com>


--===============7365387255592896366==
Content-Type: multipart/signed; boundary="nextPart1548854.oCaQHZbeKg";
	micalg="pgp-sha1"; protocol="application/pgp-signature"


--nextPart1548854.oCaQHZbeKg
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

On Wed 19 Feb 2014 02:33:32 Bola, Pradeep wrote:
> We are planning to use LTP for doing POSIX compliance test for one of=
 our
> project. LTP covers most of the LINUX POSIX functions.

i'm not sure how well suited LTP is to answering the question "my syste=
m=20
conforms to POSIX".  LTP tests a lot of interfaces and generally expect=
s Linux=20
behavior.

if you really care about POSIX compliance, then you should look at the =
POSIX=20
group as they have a testsuite available to verify compliance.  unfortu=
nately,=20
it's not free, but if you really are going for certification, you don't=
 really=20
have a choice.
=2Dmike
--nextPart1548854.oCaQHZbeKg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAABAgAGBQJTHQRmAAoJEEFjO5/oN/WBXtQQAKo0A+c/VFH1OWpuPB1hx/u1
/2KAcAK1VCvhBglfz0LIlqpr5pWZNsX/oD+IyFr7W4pOGseTuf5c7ij/QK7BuGIg
Gnl811tyJTr6gGWNbuQ9HtB9S/NNrbWTFX+tHzuYRDGFq3GpgGnsSGGBx0zr0SFr
/3HFFYo9SZ4GMj4Szj/FHaiM9ox7DAMnw/pnQkenpSieit5hq2BdgePzZwo2Xat9
laybRqgwdbJIrnhGhrfWzKvHewsazBleXZpUn4M/GPZcuiWrv1V+cHeplS7kihNY
vDMyIdisWvVH8eBqOlp9NTHJz6YwAEvr/9rOydnvND8rLlCqrGNuetzln8bdtyBh
bJSzcMiMTyn6yxTAXsLdmM/B+kETG/ll9N8d79Vi0kKidVbxoQxBBmdVKcxpWJCJ
R81jpbAcVQPb1XRkheO/nRViuB8oH7dSb7Ib9fGgWAXalnVvOzkehMYHJr3VNM4D
XQAAUMX+q4b5AgYW8xqtkZnRH16BeMsdTREwfQfuvgHHHdRRsiE58qhWJTyEvJBa
VukDcLK+ScMJZ0r/oPHXpixC+1g6BOdFbWXBvNunilvbMQydt93iQo8KhiwwXWxT
ZjkIOUTxUfdbEN8objSQyahkIxtfeBXcU83ZX1N8ovUbfDQlpH7UNpa8eWSSLc5o
LXJ/9Q0ndpGXQbjzF02H
=+q3O
-----END PGP SIGNATURE-----

--nextPart1548854.oCaQHZbeKg--



--===============7365387255592896366==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/13534_NeoTech
--===============7365387255592896366==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============7365387255592896366==--


