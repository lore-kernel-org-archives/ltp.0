Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1RiArA-0003OS-Ph
	for ltp-list@lists.sourceforge.net; Tue, 03 Jan 2012 20:21:12 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1RiAr9-0004GQ-Td
	for ltp-list@lists.sourceforge.net; Tue, 03 Jan 2012 20:21:12 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Tue, 3 Jan 2012 15:21:17 -0500
References: <4F02E420.5040100@imgtec.com>
In-Reply-To: <4F02E420.5040100@imgtec.com>
MIME-Version: 1.0
Message-Id: <201201031521.18371.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH 12/21] syscalls/{getcontext,
	profil}: Move test.h header and TCID variable to the top
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============4893999968626189943=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: Markos Chandras <Markos.Chandras@imgtec.com>

--===============4893999968626189943==
Content-Type: multipart/signed; boundary="nextPart1391253.d9ovRAZXNA";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1391253.d9ovRAZXNA
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tuesday 03 January 2012 06:18:56 Markos Chandras wrote:
> Hi, please review the attached patch

the test.h header should be after all system includes.  moving it before th=
em=20
is not a good idea.  so NAK this patch.
=2Dmike

--nextPart1391253.d9ovRAZXNA
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJPA2M+AAoJEEFjO5/oN/WBQKMP/j4bJNPSGhEefRL0coKc8O1b
keDmJiRrIBJOaVNNVLYWB5qkinURX5EnS0p7Nr5YAn/+bVAuzh/N5E+hQtJoto8m
JKNrh2y+hKXdFb2g85C1IS8omHJHvXvla3DxArJrjYW7+xQadl4CfEodF44CUWhU
9qI7O3gzZfDmwZN387x2jSt5yzczlBW6/gr+B78SX2LS+1YfTTNkKTG5t+6oSfAO
e0tWBounTkNl+6gRf6yT19uMjbzgSz5yxPHmMNfStxeCnUcYxEb3w7iHlNB8OzDd
1+QilzkvdKbZGAw/BWii9IWFh6w7CjChn0yN7mZMdEHy+IvRc9V4BtqyEkgHFZrW
NV34hLQT/XN0Y7A/j48YTWk3UI27vsG/cz/jGv9RFbGvpiuskGMtls/0IGzMmT1f
jbygxjWJ75vg+QnHboCZ+XR1RqwTvSyYrukBjpEGs2gxb3LSKXYFTk6hZDq9vJKk
zqziyznmSG21l4bIoVLrSXq5L5kVtrZ6UUtco5zbcsP2tuozXY4gMABCcX6i5QvH
YZKnTju5gnUYkwIdvcdAxOce8xr8X0c3VZCW9HqVYQte7FiYAOpv1KW+rB8u/TA0
V1uPgLlh2HkTxUEIdmljqSe2rg5hSg5WV+PAnkRbHDBX6b3Xl4IKIyYKPyJNPNSz
13s2Bw1tLuX9fFRUha8C
=DvMl
-----END PGP SIGNATURE-----

--nextPart1391253.d9ovRAZXNA--


--===============4893999968626189943==
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
--===============4893999968626189943==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============4893999968626189943==--

