Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1YZZbo-0002Jf-1A
	for ltp-list@lists.sourceforge.net; Sun, 22 Mar 2015 06:43:40 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YZZbm-0006jm-SZ
	for ltp-list@lists.sourceforge.net; Sun, 22 Mar 2015 06:43:40 +0000
Date: Sun, 22 Mar 2015 02:43:33 -0400
From: Mike Frysinger <vapier@gentoo.org>
Message-ID: <20150322064333.GM4504@vapier>
References: <756183AD4F83414184BA6A0635785E70A55C4B3C@LGEVEXMBAPSVC1.LGE.NET>
	<1848532869.446726.1426839071051.JavaMail.zimbra@redhat.com>
	<756183AD4F83414184BA6A0635785E70A55C4BDC@LGEVEXMBAPSVC1.LGE.NET>
	<1985883687.604987.1426857226768.JavaMail.zimbra@redhat.com>
	<550C296E.3080109@st.com>
MIME-Version: 1.0
In-Reply-To: <550C296E.3080109@st.com>
Subject: Re: [LTP] MAP_LOCKED issue in mmap with MAP_ANYNOMOUS
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0254047966518508536=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Carmelo Amoroso <carmelo.amoroso@st.com>
Cc: ltp-list@lists.sourceforge.net


--===============0254047966518508536==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XQ/JOjNzrAcf1KaA"
Content-Disposition: inline


--XQ/JOjNzrAcf1KaA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 20 Mar 2015 15:06, Carmelo Amoroso wrote:
> On 3/20/2015 2:13 PM, Jan Stancek wrote:
> > It seems that MAP_LOCKED can now silently fail.
> >
> > https://lkml.org/lkml/2015/1/19/28
> > http://marc.info/?l=3Dlinux-mm&m=3D142122902313315&w=3D2
>=20
> I hit exactly the same issue on CA9 based platform when moved from=20
> kernel 3.10.53 to 3.10.65
>=20
> > Those posts contain also kernel commit IDs that are likely responsible
> > for same problem you see.
>=20
> So, should the LTP be updated accordingly ?

if the kernel has changed behavior, LTP needs to adapt to it (assuming the=
=20
kernel people changed the behavior on purpose)
-mike

--XQ/JOjNzrAcf1KaA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVDmSVAAoJEEFjO5/oN/WBWfkP/RfG3hnZLUdLRlilNCEKuCSQ
8EoD1rVMO9A3skL+LRPq2+GHHHbWng43L+o+ZzPcLzcC3oO+ykuKLkZ1rMb34UuT
ABMM2mOfOhBiCcn1O1tJz6Ot5DPsJgfZfOZSkMf/AmafgP2ovCpXY5yJrYl37SvU
F+VPZSGjOTG+V1dWm3hak++2o1EHEYxZjzMNZ8w6iVmKCriDezSLWaAesEkGcn1c
1GPU3vinYtxl/vdRJpqCy2LBMbiKp3OXkCgz5DwKiH8NPnarEQste0/DeNUSspJ3
jd/uPbHILzLGuYz0lSO+3XLdaPOS7s/YKKX/CB4gEKaJjeoXEH0YeNFMwSr9Na4a
OESsmWF8M9nb2YIkGWPzevaOxbJcVryyGVLVYLqFKqPTAtwYSVTLs7LFJc+2cYnV
niSNsxhHPBkk2VBpPr/DgJhUCBhoSppB+k6wkMoCRXfBpexY5NGeZGI2rYedVrmx
uoJAD5L8Ma2/vFPSIHLzT/XOAbOlMkZH0TQv5ZzIUV1Sp2ORgKWdTwmIqEb1Rgyh
H0KVM+PxrHu85rSXtKOSOoWd9DzxDcbOjLFlaM5O0C66DwmvrqNGzYOweCA4gF2F
380b6cpLsDy87LcxTg5G4mNq/K92yUyz+5jEL/dZjaezO+0I3sIBIIUVFgEvsce0
QwGffuFwrfD7kXAQBcoZ
=0Ucd
-----END PGP SIGNATURE-----

--XQ/JOjNzrAcf1KaA--


--===============0254047966518508536==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
--===============0254047966518508536==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============0254047966518508536==--

