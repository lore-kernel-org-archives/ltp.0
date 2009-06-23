Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1MJDRD-00080Q-Sd
	for ltp-list@lists.sourceforge.net; Tue, 23 Jun 2009 21:21:55 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MJDRB-0002eg-UQ
	for ltp-list@lists.sourceforge.net; Tue, 23 Jun 2009 21:21:55 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Tue, 23 Jun 2009 17:21:50 -0400
References: <4a413e95.8d13f30a.1199.ffffdccbSMTPIN_ADDED@mx.google.com>
In-Reply-To: <4a413e95.8d13f30a.1199.ffffdccbSMTPIN_ADDED@mx.google.com>
MIME-Version: 1.0
Message-Id: <200906231721.51688.vapier@gentoo.org>
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
Content-Type: multipart/mixed; boundary="===============6676215414405064763=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: "Jiri Palecek > (none)" <"<jirka"@debian.gentoo.org>

--===============6676215414405064763==
Content-Type: multipart/signed; boundary="nextPart1288412.26nTEhm4er";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1288412.26nTEhm4er
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sunday 31 May 2009 17:27:51 Jiri Palecek > wrote:
> -echo -e "Completed running Default LTP\n\n"
> +echo "Completed running Default LTP"
> +echo
> +echo

use printf, not bloat the file with echos

> -echo "Distro type is: $tvar \n"
> +echo "Distro type is: $tvar"
>

these are not equivalent

> --- a/testcases/commands/unzip/unzip_tests.sh
> +++ b/testcases/commands/unzip/unzip_tests.sh
> @@ -62,7 +62,6 @@ chk_ifexists()
>  # 				- non-zero on failure.
>  cleanup()
>  {
> -	popd
>  	# remove all the temporary files created by this test.
>  	tst_resm TINFO "CLEAN: removing \"$LTPTMP\""
>  	rm -fr "$LTPTMP"
> @@ -90,7 +89,6 @@ init()
>  	# create the temporary directory used by this testcase
>  	LTPTMP=3D`mktemp -d -t $$.XXXXXX` || tst_resm TBROK "Unable to create
> temporary directory with: mktemp -d $$.XXXXXX" trap "cleanup" 0
> -	pushd "$LTPTMP"
>
>  	# check if commands tst_*, unzip, awk, etc exists.
>  	chk_ifexists INIT tst_resm  || return $RC

umm, you remove the push/popd, but dont replace it with proper cd statement=
s ? =20
i'm guessing you didnt test this change.

> --- a/testcases/kernel/containers/netns/delchild.sh
> +++ b/testcases/kernel/containers/netns/delchild.sh
> -    kill -9 $sshpid $pid > /dev/null 2>&1
> +    kill -s KILL $sshpid $pid > /dev/null 2>&1

this isnt a bashism, this is a crappy kill implementation

>  for tttype in `ls /dev/tty*`
>  do
> -device_no=3D${tttype:8}
> +device_no=3D${tttype##/dev/tty}
> ...
>  for tttype in `ls /dev/tty*`
>  do
> -device_no=3D${tttype:8}
> +device_no=3D${tttype##/dev/tty}

using the greedy expansion (##) doesnt make much sense.  really should be #.

> -    let step_errors=3D"$step_errors + 1"
> +    step_errors=3D$(($step_errors + 1))
> -        let i=3D"$i + 1"
> +        i=3D$(($i + 1))
> -            let k=3D"$k + 1"
> +            k=3D$(($k + 1))
> -        let j=3D"$j + 1"
> +        j=3D$(($j + 1))
> .....

this syntax sucks.  please use something like:
: $(( step_errors +=3D 1))

> -    echo $"fs_inod on $TCtmp finished."
> +    echo "fs_inod on $TCtmp finished."

these are not equivalent, but i doubt this shell script is using the bash=20
gettext function in the first place, so it's fine
=2Dmike

--nextPart1288412.26nTEhm4er
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iQIcBAABAgAGBQJKQUdvAAoJEEFjO5/oN/WB54kP/RTcPxfy3uRZmjPfPTIB0+aB
zFj9g+aeoRhErUJ8z0maIS2YC1AdHbssXKDfxfmlQWGDgSfzOO6aXFW6UME/5QDK
fpzOTRi3lD2MGCJ8KSFyPblYZY76kAYCeT4GKz2s/8dXU+I0j1yEZIxBcQTbq9OM
lpmuwV5+WOI74NRrcv1OYSV4qS7+RzuFmhpgM5Y83frTNlI6lx3BAi7gt0wAg8VC
No/MC9H/3VicMo1T/rzfqvQSr/2H+Xd6cdSo2CTGwa5TenVwnB8dOq0RpxrK/mUk
QdFp3HBXF5XJGbwrYNkiI7DKfsmS1gjG4obi6X7ZJh1Trjc25PDKTy7Vsrr0cYvv
GLO3iKola9JHlhQ+SsiG0mI+l5n8iz1GSqBd1QU5Q5chchicx5LiEp2uoMiTQqyk
PoyW6Opn5VwYSlhobCb2U0bWzXZd3I9gDyQVuW8NUcs7yD172jOnNW0AkrUOPCdk
6N58i5mVxaMOhoZ4M4R1sPod01sIidj4cjDJGQIF0J4lVFrCvIB3SBLiNbwTIWVu
MdkX1R49Nnk6m0sfaDU+L66NJvsUw1NyyHBi1BWR69CPlbDgAsxZOcLJX/Mmmxyy
TgCpO+BvEqihgDFrKS+eYjg9Cu4blMystlwy30oqz27Nw10V4W0Is98uKn/hzEmn
GUXZysMuu7oAVjm27eNJ
=Dftf
-----END PGP SIGNATURE-----

--nextPart1288412.26nTEhm4er--


--===============6676215414405064763==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--===============6676215414405064763==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============6676215414405064763==--

