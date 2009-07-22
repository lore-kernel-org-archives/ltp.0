Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1MTVsi-0004yj-SR
	for ltp-list@lists.sourceforge.net; Wed, 22 Jul 2009 07:04:52 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MTVsU-0003bG-A5
	for ltp-list@lists.sourceforge.net; Wed, 22 Jul 2009 07:04:47 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Wed, 22 Jul 2009 03:04:32 -0400
References: <20090721.182542.1000278277145531816.caiqian@cclom.cn>
	<200907220122.33944.vapier@gentoo.org>
	<124D1FD0-1C6A-40D0-9754-DD87A3CF27DC@gmail.com>
In-Reply-To: <124D1FD0-1C6A-40D0-9754-DD87A3CF27DC@gmail.com>
MIME-Version: 1.0
Message-Id: <200907220304.33267.vapier@gentoo.org>
Subject: Re: [LTP] LTP Intermediate Release for JULY 2009 Build Failures
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============3069074160563942231=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

--===============3069074160563942231==
Content-Type: multipart/signed; boundary="nextPart1644445.Gd9KouDsEq";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1644445.Gd9KouDsEq
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 22 July 2009 02:52:25 Garrett Cooper wrote:
> On Jul 21, 2009, at 10:22 PM, Mike Frysinger wrote:
> > On Wednesday 22 July 2009 01:01:34 Garrett Cooper wrote:
> >> On Tue, Jul 21, 2009 at 9:38 PM, Garrett Cooper wrote:
> >>> On Tue, Jul 21, 2009 at 2:28 PM, Mike Frysinger wrote:
> >>>> On Tuesday 21 July 2009 10:21:44 Garrett Cooper wrote:
> >>>>> I was tempted to fix the format string error, but I don't know
> >>>>> what
> >>>>> the potential implications are of switching the data type from
> >>>>> u_int64_t to unsigned long long...
> >>>>
> >>>> dont do that.  just use the proper format string from inttypes.h.
> >>>> uint64_t f;
> >>>> printf("f =3D %"PRIu64"\n", f);
> >>
> >> -       fprintf(stdout, "[%u] wait completed on %d: count=3D%llu\n",
> >> +       fprintf(stdout, "[%u] wait completed on %d: count=3D%lu64\n",
> >>                getpid(), fd, cntr);
> >
> > umm, you sure that's right ?  seems to me it'll output the number
> > followed by
> > the string "64".  i think you need to look at my example again (and
> > take
> > notice of the quote marks).
>
> Your suggestion didn't compile and unfortunately the testcase appears
> to be broken. I'll retest when I get home.

did you include inttypes.h ?  i'm pretty sure your proposed change would (1=
)=20
fix warnings for one arch size, (2) add warnings for the other arch size, a=
nd=20
(3) add a spurious "64" string to the output.
=2Dmike

--nextPart1644445.Gd9KouDsEq
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iQIcBAABAgAGBQJKZroBAAoJEEFjO5/oN/WBTuIQAKAgJL0gg7R4M0Xx5pZ9crgV
XplDJiQZbMW7fJyzz+XDYCANBeIP1eijS1c7rDxhM3W7s+OV6r9h0KNAy4oUHNa9
qRq5Ec/7WOpHW9beM2kGLVJNpY2rUgGa61Cy++GHC9H8VLFVo0CPC2I+RDzSM9kg
jM4iX620riK6/YYAfci42Ge+ujawQHZm59V2p5c4vF9f9CEUcr5kzEmy8MvXJK99
ikMTyJbT/fHVcPHnyAfbf5ymGN+xaGFR03MnS5wbLlzzxD5glQ61rXAOaDS4Ekzr
l36qzW7r8jP2bP95lbZJq7qjq8j5wn68KTfrEh5QzUXCPDOkPgkf2e/CvWax2sZJ
zLqjRSobRXO9bxvZ17SlEemzFp+JCAQjixvCr2BL7n/yoGqfWdn13xw/8INmuZ9S
5PiheKPOQF0LfYmUAyJfhEgTDDh5FcEQ3opCNagyYzBewlPz2D66/PocinDlm+4H
8NlN4gHKbLCPj2uwmE3hVQQbQt7C19Cm+WyvUsDYo/dXwfw3z4H4WGlDOdrlGOQb
DRlsV1NfFftb8JFZf1TeBz4pp+h3SJdMJYDjoOtDKmS+Jv9hTZo5ZCayu8w3XeoC
8zy9LE96QCtF7H+2+um19Rrrzt4rldlfaM2EC92RlTJep13xaEe015QphO2aIe+O
oKrq/QdhzDf4jMJrlYMo
=xgzY
-----END PGP SIGNATURE-----

--nextPart1644445.Gd9KouDsEq--


--===============3069074160563942231==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--===============3069074160563942231==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============3069074160563942231==--

