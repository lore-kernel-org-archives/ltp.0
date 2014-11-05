Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1Xlq74-0002Tg-T3
	for ltp-list@lists.sourceforge.net; Wed, 05 Nov 2014 02:14:22 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Xlq73-0007Lw-R1
	for ltp-list@lists.sourceforge.net; Wed, 05 Nov 2014 02:14:22 +0000
Received: from vapier.wh0rd.info (localhost [127.0.0.1])
	by smtp.gentoo.org (Postfix) with SMTP id 267CD34041C
	for <ltp-list@lists.sourceforge.net>;
	Wed,  5 Nov 2014 02:14:15 +0000 (UTC)
Date: Tue, 4 Nov 2014 21:14:15 -0500
From: Mike Frysinger <vapier@gentoo.org>
Message-ID: <20141105021415.GM5402@vapier.wh0rd.info>
References: <20141103201517.GA9814@tarantula.localdomain>
	<20141103214510.GI5402@vapier.wh0rd.info>
	<20141103221828.GD9814@tarantula.localdomain>
	<20141103225247.GJ5402@vapier.wh0rd.info>
	<20141104210118.GE12659@tarantula.localdomain>
MIME-Version: 1.0
In-Reply-To: <20141104210118.GE12659@tarantula.localdomain>
Subject: Re: [LTP] [PATCH] file_test: fix testcase for ppc64le
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============4742573844928103286=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net


--===============4742573844928103286==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Cqq5NadOW2RfLMJ/"
Content-Disposition: inline


--Cqq5NadOW2RfLMJ/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 04 Nov 2014 15:01, Jeffrey Bastian wrote:
> +# check for CPU endianness
> +TEST_ARCH=3DNULL
> +ENDIAN=3D$(echo -n I | od -to2 2>/dev/null |
> +             awk '{print substr($2,6,1); exit}' 2>/dev/null)

interesting idea.  there's a few issues with this code, but rather than get=
 into=20
that, why don't ew just rely on readelf and be done ?  i don't think we wan=
t to=20
maintain two code paths here.

> +    READELF=3D$(which readelf 2>/dev/null)
> +    ENDIAN=3D$($READELF -h $READELF 2>/dev/null | grep endian)
> +    if echo $ENDIAN | grep -q 'Data:.*big endian' ; then
> +        TEST_ARCH=3DMSB
> +    elif echo $ENDIAN | grep -q 'Data:.*little endian' ; then
> +        TEST_ARCH=3DLSB
> +    fi

you can simplify this a bit:
	READELF=3D$(which readelf 2>/dev/null)
	case $(${READELF} -h ${READELF}) in
	*Data:*"big endian"*)
		TEST_ARCH=3DMSB ;;
	*Data:*"little endian"*)
		TEST_ARCH=3DLSB ;;
	*) <throw an error> ;;
	esac
-mike

--Cqq5NadOW2RfLMJ/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUWYf3AAoJEEFjO5/oN/WBXqEP/AqnnI8UGGtxJUrEh4UN9sJn
nXWUasmf3AK7OseMYTDeqHQbwmAfBvnsuvd7U0H+cymIs22U797ctAsZTIFdoyiq
j20eudmyPeK0czfd5X/+E8takFCL9ExhCV7PTdfkB3jkhpwtTF1ijvzRY1EhjNgB
69a72Q3TEIbhzudTAKNl3a2ISB9JlD+QFMTjZ0keGmpj1Vr4qnXafQPKUYQEcPL+
+Ltpa1szUQkCOHJB9Vu/zLtRQzjdOvqQWVcJ00GpZIciFHsSc0C+tOuffiXBbvVi
qvFHezN2cYryyS3mdkVecPSrBfvy8lR9aX9NAPf//Vof6TclzsfYY+wY89j+fCUg
Sz+PbBb/DI31H02Qf/f+z7aZl62WEUJDoJJSVsBMR2K3UKlD4DI8SYVM29K8mkOl
9tlRJUg9Prmg8jlQNc6jJ24bGBxbfd9ph3++pzqlD7crQxlZAgL7Oz55aHfro/vT
hLUya3od+A02yLD0XJS/QbCWNNIG1KTuUCkQk4zdxL96crvGIdO38VDZjunfq589
+7L8Rm0/dsRLPuA62wLuNdSOc9+capUhtcVcb8Y+NBY0qCd7Nhm3GgqhDPh1WDDO
7gu38x/RfhqcOfM9V6W7udJTpZ2yKse0rEOozTFU4jQwlAHnlxUaYekl9pt8UodP
VXhUuKciFUhhUavFCipV
=kB0o
-----END PGP SIGNATURE-----

--Cqq5NadOW2RfLMJ/--


--===============4742573844928103286==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--===============4742573844928103286==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============4742573844928103286==--

