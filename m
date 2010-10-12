Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1P5kM8-0005b9-Th
	for ltp-list@lists.sourceforge.net; Tue, 12 Oct 2010 19:17:48 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1P5kM7-0000rj-Qg
	for ltp-list@lists.sourceforge.net; Tue, 12 Oct 2010 19:17:48 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Tue, 12 Oct 2010 15:15:06 -0400
References: <63954223.194911286892436382.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <63954223.194911286892436382.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Message-Id: <201010121515.07416.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] mmap/munmap /dev/zero
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============6568240308859840118=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: CAI Qian <caiqian@redhat.com>

--===============6568240308859840118==
Content-Type: multipart/signed; boundary="nextPart4086147.BxpzpKYFZv";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart4086147.BxpzpKYFZv
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Tuesday, October 12, 2010 10:07:16 CAI Qian wrote:
> +/* main setup function of test */
> +void setup();
> +/* cleanup function for the test */
> +void cleanup();
> +int mmapzero();

functins that take no args should be "(void)" and not "()"

> +int main(int ac, char **av)

use consistent style.  this should be "int argc" and "char *argv[]".

> +	if (msg !=3D (char *)NULL) {

useless cast

> +		if(TEST_RETURN !=3D 0)

need a space before the "("

> +	 x =3D mmap("/dev/zero", SIZE+SIZE-4096, PROT_READ|PROT_WRITE,
> +		 MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);

uhh, have you even checked this test ?  this mmap() makes absolutely no sen=
se=20
on so many levels.

> +	 if (x =3D=3D MAP_FAILED) {
> +		 perror("error");

make this perror() slightly less useless by replacing "error" with "mmap". =
=20
although, i wonder why you cant use any of the ltp helper functions for err=
or=20
reporting ... tests rarely (if ever) should be writing to stdout/stderr=20
themselves.

> +	 if (!fork()) {
> +		 munmap(x + SIZE+4096, SIZE-4096*2);
> +		 _exit(0);
> +	 }
> +	 if (!fork()) {
> +		 if (!fork()) {
> +			 munmap(x + SIZE+4096, SIZE-4096*2);
> +			 _exit(0);
> +		 }
> +		 munmap(x + SIZE+4096, SIZE-4096*2);
> +		 _exit(0);
> +	 }
> +	 munmap(x, SIZE+SIZE-4096);

fork() returns -1 on error which means this code misbehaves.

why are you using _exit() ?

munmap() returns a value you shouldbe checking.  blindly calling funcs does=
nt=20
accomplish much.

> + void cleanup()
> + {
> +	 /*
> +	  * remove the tmp directory and exit
> +	  */
> +	 TEST_CLEANUP;
> +	 tst_rmdir();
> +	 tst_exit();
> +
> + }

useless newline before the closing brace
=2Dmike

--nextPart4086147.BxpzpKYFZv
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iQIcBAABAgAGBQJMtLO7AAoJEEFjO5/oN/WBoDgP/2NNcIE/th1w+bInwC+vgUMQ
sXz3fTt5Nz/PrlMCOJHxOY3CWBBHsZKCWmV6MO8NEOcwvVrLlPkh7qotOon+6e/0
HWKZnLs5vn13C9TSRLvkhZgl0Q2nzUuzJ+br1H+IIvz9dZQyURqsMHoSbOdEbP47
LdIXCYFoE41cIhZ3uz+T6roEm7jh8RFsMNPbkRTi5S6UejnuIVyAy7tBE+2/PK30
TvVgJLoEhmPLJCw3rv633SzNac6m9JmHYD5nSCrzIEiL5tWfygAHfeqMnOiKDzbP
Uj80r1Xb1PcC8nyS5Jwsev6j2xZ21u5X9ZOY8aa+KUmg8W+87eZgIdyyKlz+CJej
HF4DXO2GbDJ9+ov6jvEYv4hdB5Z2cQeOGSdRhgfBD6q70n/BngSLfgxgtunRvLv0
CmpF1b5hNzxmiIgfryAW/cRR1rIoR+TVjVkUsih4MFnldW8PSdNxuTo0qhfXkkzn
ZhK4vk5F1caw+h9tE6Cre6AVmPgqdIqRww3IsOVjlFBBYxgZRmFvZgu3TsLPzKf8
q2V1mIaSym7JoHqAmQhekHX2dkN1tWLhr329OZFvJRBi0HE6pXsyT2MSyjw2LBk5
5FyaP2Js7l1XIsmZxK3YUQ7AWFO1nudNQ6b5atzgi3u0vYTtQxScyyBPgsrxlwH/
FyA/3YIIOhQHSS+ccQcB
=xwgz
-----END PGP SIGNATURE-----

--nextPart4086147.BxpzpKYFZv--


--===============6568240308859840118==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Beautiful is writing same markup. Internet Explorer 9 supports
standards for HTML5, CSS3, SVG 1.1,  ECMAScript5, and DOM L2 & L3.
Spend less time writing and  rewriting code and more time creating great
experiences on the web. Be a part of the beta today.
http://p.sf.net/sfu/beautyoftheweb
--===============6568240308859840118==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============6568240308859840118==--

