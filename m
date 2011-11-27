Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <nikola.ciprich@linuxbox.cz>) id 1RUlKM-0007B2-2Q
	for ltp-list@lists.sourceforge.net; Sun, 27 Nov 2011 20:27:54 +0000
Received: from gwu.lbox.cz ([62.245.111.132])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1RUlKK-00014c-M5
	for ltp-list@lists.sourceforge.net; Sun, 27 Nov 2011 20:27:54 +0000
Received: from linuxbox.linuxbox.cz (linuxbox.linuxbox.cz [10.76.66.10])
	by gwu.lbox.cz (Sendmail) with ESMTP id pARKCXqe009091
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Sun, 27 Nov 2011 21:12:33 +0100
Date: Sun, 27 Nov 2011 21:12:32 +0100
From: Nikola Ciprich <nikola.ciprich@linuxbox.cz>
Message-ID: <20111127201232.GB2268@nik-comp.lan>
MIME-Version: 1.0
Subject: [LTP] LTP: memcg_stress_test hanging whole box
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============7495298231299325873=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net


--===============7495298231299325873==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f2QGlHpHGjS2mn6Y"
Content-Disposition: inline


--f2QGlHpHGjS2mn6Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

I hope I won't be bothering with dumb question, but I wasn't able to find a=
ny solution to my problem...

I'm playing with LTP, and it works nice for me (few tests fail, but with ob=
vious reasons, which I will fix,
so this is Ok), but I'm having problem with memcg_stress test. It always al=
most immediately gets host machine to
heavy swapping, and never finishes... when I had 2GB of swap, machine usual=
ly got into totally unusable state,
when I lowered swap to 512M, I'm at least able to kill test after some time=
=2E..
I guess this is not expected behaviour, but my question is, what should I c=
heck to get this working properly?
I'm getting same results for latest x86_64 2.6.32.x and 3.0.x. Testing mach=
ine has 4 cores and 4GB of RAM.

Could somebody help me with that please?

with best regards

nikola ciprich

--=20
-------------------------------------
Ing. Nikola CIPRICH
LinuxBox.cz, s.r.o.
28. rijna 168, 709 01 Ostrava

tel.:   +420 596 603 142
fax:    +420 596 621 273
mobil:  +420 777 093 799

www.linuxbox.cz

mobil servis: +420 737 238 656
email servis: servis@linuxbox.cz
-------------------------------------

--f2QGlHpHGjS2mn6Y
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk7SmbAACgkQ3xdJJrLygV5KeQCfQL58j6tujZ7k4B3F6tC1qNHw
s58AoJUvW2LjSDnWJCi/7gFun/g4wx9u
=5J9x
-----END PGP SIGNATURE-----

--f2QGlHpHGjS2mn6Y--


--===============7495298231299325873==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
All the data continuously generated in your IT infrastructure 
contains a definitive record of customers, application performance, 
security threats, fraudulent activity, and more. Splunk takes this 
data and makes sense of it. IT sense. And common sense.
http://p.sf.net/sfu/splunk-novd2d
--===============7495298231299325873==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============7495298231299325873==--

