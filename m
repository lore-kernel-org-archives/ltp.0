Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1RiB4g-0002Jk-EY
	for ltp-list@lists.sourceforge.net; Tue, 03 Jan 2012 20:35:10 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1RiB4f-0001ui-Qp
	for ltp-list@lists.sourceforge.net; Tue, 03 Jan 2012 20:35:10 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Tue, 3 Jan 2012 15:35:16 -0500
References: <4F030192.8030107@imgtec.com>
In-Reply-To: <4F030192.8030107@imgtec.com>
MIME-Version: 1.0
Message-Id: <201201031535.17342.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH 19/21] nfs/nfsstress/make_tree: Fix erroneous cast
	to void pointer
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============8938190473442914837=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: Markos Chandras <Markos.Chandras@imgtec.com>

--===============8938190473442914837==
Content-Type: multipart/signed; boundary="nextPart1535544.5vm16iGyAZ";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1535544.5vm16iGyAZ
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tuesday 03 January 2012 08:24:34 Markos Chandras wrote:
> Hi, please review the attached patch

NAK: this is how the pthread API works.  you aren't passing a value by=20
reference.  they used a pointer rather than "long" or something as it's har=
der=20
to fit a pointer into an integer rather than the other way around.

if you're getting a build time warning, try casting it to uintptr_t instead
=2Dmike

--nextPart1535544.5vm16iGyAZ
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJPA2aFAAoJEEFjO5/oN/WBejoP/jtzCMUUfx+5gBq2WxJsQrhh
snKok/hruJ90PGEhfiZ6OJSMEAhJGkwEnIFNMtCZA/iN+YN46GkbGNsUkZowQVmH
IbQk/3olHoJ2+irP2lGIqM4Lh89krdAxu6K3AMrjyuefsVxR85ATIpFYC/WP/9js
4wUEsNX2hME6b8nwWuz1y3YrU8/4pE8g8Uq4A0omijlD0QK3igC1SoVC2BfJ0QXa
Xm6ZO6q7IR2x27KdRIHR1W/wCX0kFxFYmrWrdVGb93UiSADoBSSNNBuBY/AyBITa
pEUBSEYjQ+0FpMM9ql7niwNuPEQlGYmxiZWMCBefbpInxj/rgdcqjlBUACIy6C+H
NqWZViNGmBR99NvaS27O22GQtktV2WDjN04KVNQdEA+geIXuI0KUrbzHeVk8Dhcf
GOqUCluNReL3qq2NvCfGo3t5n1OkF8V8y2P3X7s33VlIkOOyIpmYZImGjYlaGu54
jM9nScJiaqhTLwPICCekHd6KIas1T5UlLzGeu4GWF7nsedERZ3p2AeoVBpFJ4rbu
HsAHZwmRQb7XfxqrAagwpl9h/zK4dkaWypSYHcooQRPoZjvweoAsWNToESwpO5QV
6R7Qqlzbk0BhkNrXtyFdbQYiDpOhV9JBbiqyEGMzjG3H8A6Vw80tpehuLy92Yw/D
KExMYI5nXEbFJhhHh7bX
=E+fk
-----END PGP SIGNATURE-----

--nextPart1535544.5vm16iGyAZ--


--===============8938190473442914837==
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
--===============8938190473442914837==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============8938190473442914837==--

