Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1RiB5v-0000E6-0w
	for ltp-list@lists.sourceforge.net; Tue, 03 Jan 2012 20:36:27 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1RiB5u-0004lp-9j
	for ltp-list@lists.sourceforge.net; Tue, 03 Jan 2012 20:36:26 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Tue, 3 Jan 2012 15:36:32 -0500
References: <4F03015B.5050700@imgtec.com>
	<CAGH67wS6fUzsZS2AjEtCJVkJXTYM8==1wfSaT=G63wfdw-etVw@mail.gmail.com>
In-Reply-To: <CAGH67wS6fUzsZS2AjEtCJVkJXTYM8==1wfSaT=G63wfdw-etVw@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <201201031536.33830.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH 18/21] network/lib6/asapi_06: pcmsg->cmsg_len is
	of type size_t
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============7177235684779640342=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: Markos Chandras <Markos.Chandras@imgtec.com>

--===============7177235684779640342==
Content-Type: multipart/signed; boundary="nextPart1707337.FcZ4LhOgka";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1707337.FcZ4LhOgka
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Tuesday 03 January 2012 14:33:05 Garrett Cooper wrote:
> On Tue, Jan 3, 2012 at 5:23 AM, Markos Chandras
>=20
> <Markos.Chandras@imgtec.com> wrote:
> > Hi, please review the attached patch
>=20
>     This is ok. While the stance here has been to follow the PRI*
> style format string qualifiers, this works and is pseudo standard
> across BSD, Linux, and probably a few other printf(3) implementations.

the PRI* stuff is for explicitly sized types (e.g. 8bit/16bit/32bit/64bit).=
  it=20
is not for [s]size_t types ... that's what the "z" length field of printf i=
s=20
designed for.
=2Dmike

--nextPart1707337.FcZ4LhOgka
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJPA2bRAAoJEEFjO5/oN/WBefEP/0Cm85IjOZ6LYjE3IYh1KVub
deS+3xpQonhpCRyeddbW/CtRng1ZQZVEHNhYB3FOm4QKPdtC6ZHf1uHscGsaEGg4
sVobxzB2T5gURZZirSGiFzh+DabJ2v4vWiC2A6cdsjlQaurbv699VToF7Muf8vcO
Dn1znhpATJ1g2v3/S1fAUABZ5ARYN+IMdExxaw+QBg9VgvyIE0xGoKFM6yJ6Em2w
gS4HLQW9wIXHfofyQEPsuFyP9gRkK4X08/S/X79vm2LJn1YBdSNc6SYNScZ2bpgG
WLgvzLiPywb5fH3t6AFwVshAfGN2hG7W2vPPLEryUKbWwkLgRZn8n6Kza27Mlb8h
bUqmBf5qvkdxz6857Bhk+p0DjNPT1q0+5TvQbSDViNeXtAnpw+Erz3g5n5N11E3a
mVfD1tN1w8Czd/pTFNU8DZ8WLr3dHNLwO+COGBPlv82J+jqx4ma6BIDg0rE5im5h
4fk5WbYQ+lFwsFjSLFJL0d3Uk2kuPx/hlN+ZDsBEIRPAs9DoNDQ5DAIXnkcjc2cA
NHwpTY5EiCXyNvS/p+LZe75JtYg9Ok2MYWp7nLHtF7bFFPGVJldtidCvk9yC/PwO
xvz0dZ3lxJSPaNj+p1uWo1SsjuFAKtI4PwEyKdks+sIQMSdwjkI25uJSosf/raOF
/Q7GAqirccP3KXdIZ9zn
=C6c/
-----END PGP SIGNATURE-----

--nextPart1707337.FcZ4LhOgka--


--===============7177235684779640342==
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
--===============7177235684779640342==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============7177235684779640342==--

