Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1MfVH1-0000NA-71
	for ltp-list@lists.sourceforge.net; Mon, 24 Aug 2009 08:51:31 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MfVGs-0007Od-NE
	for ltp-list@lists.sourceforge.net; Mon, 24 Aug 2009 08:51:31 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Mon, 24 Aug 2009 04:51:12 -0400
References: <20090821.195739.1000278277145530969.caiqian@cclom.cn>
	<200908222352.42884.vapier@gentoo.org>
	<alpine.LRH.2.00.0908241040450.31587@vixen.sonytel.be>
In-Reply-To: <alpine.LRH.2.00.0908241040450.31587@vixen.sonytel.be>
MIME-Version: 1.0
Message-Id: <200908240451.14426.vapier@gentoo.org>
Subject: Re: [LTP] The Best Practice to Skip Syscall Tests
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============3486147234438492508=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: ltp-list@lists.sf.net

--===============3486147234438492508==
Content-Type: multipart/signed; boundary="nextPart1357472.fKTTx30blU";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1357472.fKTTx30blU
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Monday 24 August 2009 04:44:05 Geert Uytterhoeven wrote:
> On Sat, 22 Aug 2009, Mike Frysinger wrote:
> > On Saturday 22 August 2009 22:37:28 CAI Qian wrote:
> > > ENOSYS is the expected result if the kernel under test has no such
> > > implementation, so I would consider TPASS or TCONF.
> >
> > TPASS is wrong.  in another thread, people seemed to be OK with TCONF.
>
> Still, the summary only shows `FAIL' or `PASS'. What is it supposed to
> show for TCONF?

i think acct01 handles this OK:
        if (errno =3D=3D ENOSYS) {
            tst_resm(TCONF,
                 "BSD process accounting is not configured in this kernel."=
);
            tst_resm(TCONF, "Test will not run.");
            tst_exit();

although we could perhaps codify this nicely by adding a new=20
tst_missing_support() or similar function that would do this kind of thing.=
 =20
first argument would be an explanatory message like "BSD process accounting=
 is=20
not configured in this kernel".  any suggestions for a better function name=
 ?
=2Dmike

--nextPart1357472.fKTTx30blU
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iQIcBAABAgAGBQJKklSCAAoJEEFjO5/oN/WBn4EP/1X/X905iA3yBTzy12OYwpsj
ZdBSSxtdaN3N+xuv6T4H0CpVi3NkEwGJUTZpkz96pXASFhZRKa33HcL9KSdiB3sy
HU9gxh6NPlqciP2KCGKn4gTI0xzeEe1MF/6+jNlK5mW8VN1n/pisN273R1DRwG/8
O/YZrb5Oqyme+0VA05ep2cn9W5joUs2oYCrOyFWJqI3ZDep5gku1icGXD0+Nh6MS
ZJdZ28K6Bn6T9FlWRUjLh/2GQ8qq8n0lEy0GTzd7IosQxl5Fqb1i879KmQ2Roqkk
3WxOzqcMOvRGDxtUhdCHVYkrScN09aej09Y+kUEeik8kU2+18RnIpCfoh1jdwIxU
bTAqpJrPkok13VdyaPLbJ3/xBP5wXX8xSzCcMU47cZRFsIOwWeMWSM0L/p8L6x+r
fLyCEfZdf5q+byxphQmfyFPMoGbK8/ulKAwyHmjpnR9KKGpnYRr4QXXrwEC2XTU7
iHoIBSKWXN4i2149XuUtmWJ/Z3jnfstOZgqdfLn2lUBPDXsBNyV8skN8LzK9r9FI
b911BgtRX9g10/IvjKc+K/yxEMvwZ1k8sXFRro78xw868EGqSJFqE0mE+gqExUZH
kqF5vfry/olyv2+fTsSxLy7Tza3BW+JJMb4e1uFks9Hh/N+sXNEajkURA2RDVTXA
e3JeOX3uREKlQbVh4rVC
=UUMI
-----END PGP SIGNATURE-----

--nextPart1357472.fKTTx30blU--


--===============3486147234438492508==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--===============3486147234438492508==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============3486147234438492508==--

