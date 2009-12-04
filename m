Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1NGdPP-0003k7-C5
	for ltp-list@lists.sourceforge.net; Fri, 04 Dec 2009 19:01:39 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NGdPJ-0002jq-0e
	for ltp-list@lists.sourceforge.net; Fri, 04 Dec 2009 19:01:39 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Fri, 4 Dec 2009 14:06:40 -0500
References: <4b1940f3.8413f30a.2877.6a27SMTPIN_ADDED@mx.google.com>
In-Reply-To: <4b1940f3.8413f30a.2877.6a27SMTPIN_ADDED@mx.google.com>
MIME-Version: 1.0
Message-Id: <200912041406.40770.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] Don't install datafiles with executable mode
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============7764805595064489542=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: Jiri Palecek <jpalecek@web.de>

--===============7764805595064489542==
Content-Type: multipart/signed; boundary="nextPart1291942.lH64Olir3t";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1291942.lH64Olir3t
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Friday 04 December 2009 11:58:13 Jiri Palecek wrote:
> the makefiles install all files with executable mode by default. This pat=
ch
>  changes it for some of the Makefiles, that install data files, which
>  should IMHO not be executable. The change makes INSTALL_MODE decide the
>  actual mode when it is expanded inside the install rule (depending on $@,
>  which is the install target name).

that's pretty fugly way to go about it.  let's go the more natural route an=
d=20
have the common code default to $(INSTALL_MODE_$@) and if that's unset, use=
=20
the default $(INSTALL_MODE).
=2Dmike

--nextPart1291942.lH64Olir3t
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.13 (GNU/Linux)

iQIcBAABAgAGBQJLGV3AAAoJEEFjO5/oN/WBoisQAKeR3YnmuVpKhZss2ZCxH2QN
xRbZ6pbDpSCM9zjnhx+bYo56ou9jvpzoSGei4bavbhK3GJezp5y/VLmd+h/WR6wS
hVLUuP3opUygejmjqj/i0jn54J4ZQH2PzF0BpmInO/KVzrAtkUHeqduFGC1ELamV
dCSD2OpvzYYmEoMqaDCZCJiw2s9krCqpMtoH2Xst+u/wqldjPNFkaLxgK7qFDM36
p5MToFd89J+ALi3HGrvnLmsyN4u6Rq4nYWJz0n8pJHSOarNZyNjVlt2E3vUx0XQk
Y81QvIdeiv9fqHBMQOkZeRgpznGZYztiZ39H5YpwcRROu+nkqpFUF/nMY2q+Wl91
LIVDnBfCLsbG5OhCHR8GXIKd2T6WsgBl2PK9vpYWgPooX+b6nZyosxtI/4+OmxqX
by66UigZ6O5GttLFEyIi4xr/AORbVTmuVEszvTP9/R//f4sYJiKluI8c2vilBVIz
ndT6p7loIE/BXYF94lsWMtIpI5YLF6xg09iit1xed/a4mnAW2XwkwTA7ktkUzw4z
bdqRaLFA8I7hZP6HWrMnGl2AGqbWSAUA65Ip4UPBBPlEph+NAPhrEc8cGPQ7yJAM
vQrb1nzXOJyiSUK8nW0Y+mAqVCGTquzLYO2QisCda4P7gBaoyAKdprohxz9Yw68X
/r3eMLiZ4LmwFQ5wx+YG
=mNVG
-----END PGP SIGNATURE-----

--nextPart1291942.lH64Olir3t--


--===============7764805595064489542==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Join us December 9, 2009 for the Red Hat Virtual Experience,
a free event focused on virtualization and cloud computing. 
Attend in-depth sessions from your desk. Your couch. Anywhere.
http://p.sf.net/sfu/redhat-sfdev2dev
--===============7764805595064489542==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============7764805595064489542==--

