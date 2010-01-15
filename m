Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1NVudu-0004AL-MX
	for ltp-list@lists.sourceforge.net; Fri, 15 Jan 2010 22:27:46 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NVudt-0003BT-P8
	for ltp-list@lists.sourceforge.net; Fri, 15 Jan 2010 22:27:46 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Fri, 15 Jan 2010 17:27:38 -0500
References: <364299f41001151349i4e7067fbu68994eaf719b46de@mail.gmail.com>
	<364299f41001151407s3e486c68rc8bd90db9898e20d@mail.gmail.com>
In-Reply-To: <364299f41001151407s3e486c68rc8bd90db9898e20d@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <201001151727.40629.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] Add make 3.80 $(abspath ) and $(realpath )
	emulation scripts
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============8134499672470316161=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>, Jiri Palecek <jirka@debian.org>, Andi Kleen <andi@firstfloor.org>, =?utf-8?q?=E7=A5=9E=E8=B0=B7=E6=9C=8B=E7=AF=84?= <mitani@ryobi.co.jp>

--===============8134499672470316161==
Content-Type: multipart/signed; boundary="nextPart1865112.4KutTmb3r5";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1865112.4KutTmb3r5
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Friday 15 January 2010 17:07:48 Garrett Cooper wrote:
> Shortly after I sent out this email, I received some helpful replies
> as to why my code wasn't working. It turns out that the curly bracket
> regexp quantifier operators available in many other popular
> implementations of regexps (perl, python, tcl) isn't supported in awk.
> Here's the new patch with less bloat.

the patch itself is word wrapped in the e-mail though :(

> +_abspath() {
> +	echo "$@" | awk '{ sub(/\/$/, ""); while (gsub(/\/\//, "/")) { };
> while (gsub(/\/[^\/]+\/\.\.\/?/, "/")) { }; while (gsub(/\/\.\//,
> "/")) { } print }'
> +}

it's easy to line wrap awk scripts, and this sucker really needs it

btw, this doesnt quite handle:
/a/b/c/.././

how about this (largely untested) sed:
sed -r -e 's:/+[.]/+:/:g' -e 's:(^|/+[^/]*)/+[.][.]/+:/:g' -e 's:/+$::'

> --- /dev/null	1 Jan 1970 00:00:00 -0000
> +++ tests/test_abspath.sh	15 Jan 2010 22:04:59 -0000
> +# NOTE (garrcoop): I usually don't use bashisms, but it was just easier =
to
> +# express these values as an array of values instead of one whacky long
> +# string.
> +test_strings=3D(     foo/bar /foo/bar /foo/../bar /foo/bar/../baz
> /foo/bar/../baz/ /foo/../bar/ /foo/../bar/.. /foo/../bar/../
> /foo/bar/../baz /foo/./bar /./foo/./bar /foo//bar //foo/bar
> //////foo/bar /foo/////bar )
> +expected_strings=3D( foo/bar /foo/bar /bar        /foo/baz
> /foo/baz         /bar         /              /               /foo/baz
>       /foo/bar   /foo/bar     /foo/bar  /foo/bar  /foo/bar
> /foo/bar )

probably be good if the source were better wrapped

however, two parallel arrays makes it hard to correlate the input/expected=
=20
values.  how about something like:
set -- \
	foo/bar:foo/bar \
	/foo/bar:/foo/bar \
	/foo/../bar:/bar \
	...........

then you can easily do:
for test in "$@" ; do
	input=3D${test%:*}
	expect=3D${test#*:}
	...
done

this should be POSIX and avoid /bin/bash
=2Dmike

--nextPart1865112.4KutTmb3r5
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iQIcBAABAgAGBQJLUOvcAAoJEEFjO5/oN/WBbQsQAJC1+lhMx0UL1TRIi4hxOrn6
GgXhOAXzjd7hQkdwPUtC28eOCHtJ/NQ0eX4uK89p00gfW+DpXfENC+TR78fjehCT
yvTipJHXaZRgC4eK3OJUT9bM3MtwpchFG9E4oAvAa1b8mQLooOf/z/ebyF5ZKfuy
vEfN+mRdMVWN6JnyR+PZ41NF1Xo7fEjnacuHfjuRJ1RbqeINyogXZfCUBVtpy4I5
ZItcgVG/6dTg3nEOuVFycZdLnXXABv0knhsEGYQmb/patxHSgRMpL6gpd16NLLZL
pU9x4+bXvK3F2vHc9xp9YCZJSl1p5324OrHdmzZpfO921ctGl+Oi4GWWKu0H6eav
307v0RhV+4BhC5eztULC5ChhbYzr5q2e80jJXQ4F610cH1FlAshQeZbwIDk5i8JE
uMa6y8cHfRuw2MNeWcW1oSvYfWIkwzw73ZFtcOoK5aH0fUwWrcWvCaFOXQ7vCbia
nFz7EEpHNOyIZRpJdwaOYXsYIAnIlrM1ZzSIjbrV66WAEN538K5Iq14UQtlfXZAg
cR8ua7D9JBAdjGLWGX9o6vVavaAtJv1+vjQDfE38WbvkzfnttWY878LutOktf9+X
tlqqk6mGINZU6B5NfojR8gvsulDbiDDFkGUbKAVgO8U+9qUyHD4P+Czg9YkaOLxV
zkZGWHBvfpnE71hxjhJC
=3lm7
-----END PGP SIGNATURE-----

--nextPart1865112.4KutTmb3r5--


--===============8134499672470316161==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Throughout its 18-year history, RSA Conference consistently attracts the
world's best and brightest in the field, creating opportunities for Conference
attendees to learn about information security's most important issues through
interactions with peers, luminaries and emerging and established companies.
http://p.sf.net/sfu/rsaconf-dev2dev
--===============8134499672470316161==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============8134499672470316161==--

