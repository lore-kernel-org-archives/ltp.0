Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1Ri9Wn-0007wZ-50
	for ltp-list@lists.sourceforge.net; Tue, 03 Jan 2012 18:56:05 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Ri9Wm-00074e-AC
	for ltp-list@lists.sourceforge.net; Tue, 03 Jan 2012 18:56:05 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Tue, 3 Jan 2012 13:56:10 -0500
References: <4F02CC46.9000106@imgtec.com>
In-Reply-To: <4F02CC46.9000106@imgtec.com>
MIME-Version: 1.0
Message-Id: <201201031356.11319.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH 03/21] test.h/tst_brkm: Drop
	__attribute__((noreturn)) since tst_brk can return to caller
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1457769592430490458=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net, yanegomi@gmail.com
Cc: Markos Chandras <Markos.Chandras@imgtec.com>

--===============1457769592430490458==
Content-Type: multipart/signed; boundary="nextPart2634812.SVp9i9r1u3";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2634812.SVp9i9r1u3
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tuesday 03 January 2012 04:37:10 Markos Chandras wrote:
> Hi, please review the attached patch

the tst_brk() API has gotten annoying.  it is designed to not return to the=
=20
original caller which is why it had the "noreturn" attribute.  but Garret r=
e-
rewrote it to be re-entrant presumably so the cleanup() func could itself c=
all=20
tst_brk().  but i'm not sure how useful that actually is in practice ...

Garret: could you comment on the actual use cases here ?
=2Dmike

--nextPart2634812.SVp9i9r1u3
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJPA09LAAoJEEFjO5/oN/WBL64QAIM5iMvkiYoKwJ1cZfdVaeuH
4OPOnZClun7l6Nhi+OU47w7yoBC+xLwGEPbca60BUuOcW1MPMoLWI0uQr5idn4E2
LDoNynMgDk+Mgx2FKA/mFSzPPQI/QkbZ8uI22R94T7bTLcDA/iUkbTaKpcMK2Peb
lppIpCIAT+16T5TiofmxjewUlE6Oa/MisOG0WR6JkGng3+ZFS9lRpif/dshbJ7hx
qCaDe9CcPyZGjUmRrjpDErKj07qRCDRETsKHYd3lYSPuXkqwfcHB7TlwTbsh4+SV
kHP3wBT6uOTscDHOLCQHbA770Wg0mAIo6dBRibb1cOhXTskPC1A41PABFaPc3hlv
H8aak6NVfzn0AEBlQYAmnqELRgpiyrQboawEoe6Ng6SuOaAWhcVj2UWzCls2H0g7
nKcJRK8FeNQyrwnF4CxIsrnQlZaJ9bTRxSiAJux9+h3JwvSQSiTC8bIYrvZgbVml
0pCjm827YDYOCXYeJITEg5cQszkNQSapvCqqgUac62CufeA5LEVtTgCxcGyFO80E
CVeYR+9k62QsAHHIdqp2rr5UwSTCQB1usbSkVzPKleF42VTA9ORGbofdLmnHeSOF
NAeFEzVB8uVo+yYxqlRtHhPULqXjuTEQU+9XluafN3OqrzVsMQvPrwMR4h1oq+Oh
UFslh0gnpD4uyuGurpl4
=xC4B
-----END PGP SIGNATURE-----

--nextPart2634812.SVp9i9r1u3--


--===============1457769592430490458==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Write once. Port to many.
Get the SDK and tools to simplify cross-platform app development. Create 
new or port existing apps to sell to consumers worldwide. Explore the 
Intel AppUpSM program developer opportunity. appdeveloper.intel.com/join
http://p.sf.net/sfu/intel-appdev
--===============1457769592430490458==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============1457769592430490458==--

