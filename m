Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1MNwGU-0001HP-4Z
	for ltp-list@lists.sourceforge.net; Mon, 06 Jul 2009 22:02:22 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MNwGO-00071q-4r
	for ltp-list@lists.sourceforge.net; Mon, 06 Jul 2009 22:02:20 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Mon, 6 Jul 2009 18:02:12 -0400
References: <4a413e9b.160bca0a.2226.fffff184SMTPIN_ADDED@mx.google.com>
	<364299f40907061045s567f00dbq7a198ef37fa438dc@mail.gmail.com>
In-Reply-To: <364299f40907061045s567f00dbq7a198ef37fa438dc@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <200907061802.13418.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] Fix some bashisms
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1617049985222032834=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: Jiri Palecek <jirka@debian.org>

--===============1617049985222032834==
Content-Type: multipart/signed; boundary="nextPart1670892.FbyFsbF4mG";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1670892.FbyFsbF4mG
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 06 July 2009 13:45:08 Garrett Cooper wrote:
> 2. All numeric test(1) comparisons could and should be switched from:
>
> command
> if [ $? =3D 0 ]; then
>
> to:
>
> if command; then
>
> for brevity.

that works the command is sufficiently short.  if it's a long command and/o=
r=20
has line wrappings itself, i find nesting it in the if statement makes the=
=20
situation much worse.

> 3. About &>
>
>    Redirecting Standard Output and Standard Error
>        Bash allows both the standard output (file descriptor 1) and
> the standard error output (file descriptor 2) to be redirected to the
> file whose name is the expansion of word with this construct.
>
>        There are two formats for redirecting standard output and standard
> error:
>
>               &>word
>        and
>
>               >&word
>
> The output redirection above captures all output (and most of the time
> you're capturing stdout, but losing stderr to the operating console,
> which can be undesirable). >& is more portable IIRC (it works with
> many ash variants, like FreeBSD's sh -- for sure -- and Solaris's sh
> -- IIRC), which makes it more ideal than &>.

what bash does doesnt matter.  the redirection used needs to be in POSIX:
http://www.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag=
_18_07

the "&>" form is not in POSIX, so should never be used.  the ">&" format=20
cannot be used in POSIX without a word argument (you didnt say it could, ju=
st=20
making sure things are kept explicit).
=2Dmike

--nextPart1670892.FbyFsbF4mG
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iQIcBAABAgAGBQJKUnRlAAoJEEFjO5/oN/WBUO4P/2UQCnDBGp6+mDGXE6XS1Fbs
clMSSG7xO3A/RL70qYZZQBaS7Af78OJJJ00bPtTBq51tBwdMmw55kTEVXS1t8ALC
9FbGL235phf4iQ2FkxRzNd84rfaIrUdVAxotG/x1FhI+oY3yOv4S1UgOBYjZX7Qx
NiEsGgaJk7AT82cF6iwdRUyP08/ywFtZR7KPAQUHQge5RcOQ8s9ZdQel3pmBVzum
kgM2zSR4/5xEsiiUwu1zXpCCr9yN9ldnRpeye/P2nq91quXtwVBBb4P06LCMOA04
ls4OSW8WO5rZ7cGn6e0x5glGSqnm7Di7C04cO/OsvsuQAgRnchdsBFBb+l5GW+x1
PvaxKC1EplDDY6N9TNdzV4heAsx9Tsi6z3FXpcGK20J+fMxS8jGb2iQmt0lpfQG5
jECQ4a1Hnmxi0f/zVuwPZ9BatmKnLQ1Ry2ll+vCQB+GvebzMZOwa4e59RCcv+uu8
pWsUG049ZimwM4jejG8CgQDxCYKW2m5qHUjKJanyAv+jocd3fzOyXObTnE1QqPnJ
cislRlG3WqW1NCXyKxZhWJ6944+khjEnvpML/Ce+9NTuTph9Agpzh/K9e6bY7Rdd
ipZlfeG9ZbU30iTIqCi+YCcHtOGA/Ne+OnElQhXv9hkUAB/J49aE2h3vKY3s/ZuV
o6u9s+MngLXSweYmHfuD
=OaXN
-----END PGP SIGNATURE-----

--nextPart1670892.FbyFsbF4mG--


--===============1617049985222032834==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--===============1617049985222032834==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============1617049985222032834==--

