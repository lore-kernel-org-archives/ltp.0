Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1MJDG6-0007G4-53
	for ltp-list@lists.sourceforge.net; Tue, 23 Jun 2009 21:10:26 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MJDG5-0005V1-31
	for ltp-list@lists.sourceforge.net; Tue, 23 Jun 2009 21:10:26 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Tue, 23 Jun 2009 17:10:21 -0400
References: <4a413b73.9c13f30a.3059.ffffe109SMTPIN_ADDED@mx.google.com>
In-Reply-To: <4a413b73.9c13f30a.3059.ffffe109SMTPIN_ADDED@mx.google.com>
MIME-Version: 1.0
Message-Id: <200906231710.22047.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] Use present autoconf test for asm/ldt.h in
	set_thread_area* tests to prevent build failures
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============6226627192143731810=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: "Jiri Palecek > (none)" <"<jirka"@debian.gentoo.org>

--===============6226627192143731810==
Content-Type: multipart/signed; boundary="nextPart13420538.yxaRUJCCII";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart13420538.yxaRUJCCII
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 19 June 2009 10:12:15 Jiri Palecek > wrote:
> -#include <stdio.h>
> -#include <errno.h>
> -#include <linux/unistd.h>
> -#include <asm/ldt.h>
> -
>  /* Harness Specific Include Files. */
>  #include "test.h"
>  #include "usctest.h"
>  #include "linux_syscall_numbers.h"
> -
> -/* Extern Global Variables */
> -extern int Tst_count;           /* counter for tst_xxx routines.       =
=20
> */ -extern char *TESTDIR;           /* temporary dir created by
> tst_tmpdir() */ +#include "config.h"
>
>  /* Global Variables */
>  char *TCID =3D "set_thread_area01";  /* Test program identifier.*/
>  int  testno;
>  int  TST_TOTAL =3D 2;                   /* total number of tests in this
> file.   */
>
> +#if defined HAVE_ASM_LDT_H
> +#include <stdio.h>
> +#include <errno.h>
> +#include <linux/unistd.h>
> +#include <asm/ldt.h>

moving asm/ldt.h behind the ifdef makes sense, but none of the others do. =
=20
there is no point in delaying the other includes and in general, all includ=
es=20
should come first ... there shouldnt be definitions before them.  less like=
ly=20
to get bitten in the ass with clashes.
=2Dmike

--nextPart13420538.yxaRUJCCII
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iQIcBAABAgAGBQJKQUS9AAoJEEFjO5/oN/WBxXcQAJJRfcC0K7cvlb7l7AOk2WgU
aGqgOnJ6AOrNmRBa3mYMsjBjhpyrPIeIYBjof6FUqDrpyAAAwuclOF+OxOi/V+0z
0kwSYivksiPDAz/R9VaGrLw/5Doy6SivdtR0tXcfMlJuUK0dBx9PkWFWMAIeqH9P
j+rt/uqtGo+20uSCZTb2q4C1T8fxyyFeDf2RsygANSIk4BKBUg3hBj7q5dKH968K
qw9UyYb5UXzGaBbs4u58Um59xck/okZZfi8aVgMAB4qGG5Sx2NA3s5QCzk+EtW1O
NANjqAgpXx6tPYQXF5ddT1wl7U3BAg5M2UDIQ6IzMSIxct8ylBF5OhlvkdxOjLMI
yMhUvHuYT3MysieokHj7SQGNKh83kmOj/jMz1Aj4h7qW37IatwofujHQLad+g/gw
AX0l5yQJK90m4/Is3lHVagEqwl9NTJO98Vr9855VLnXht8JErd5/QerEh7xUpE9B
e/O5kRC0dwx6rcktCsWfXMoAj2q91won15UH7YC67DOcmk2ss7iz9vZQeaekHB6Y
/ioaTVJuRZJx59i7Q3D6tVGhMwZcr0bGebWOwlMTH7Ni0pXhcgF2XbdgzmLuTcAg
GHtyUCvnR+SZxwtkyqMkFaZ8QZ75+rtgssCiyMPU5HUhZs6TCjVZUTC9O7oWN+Db
BuruB2l/RUKmqNAFbksK
=idzd
-----END PGP SIGNATURE-----

--nextPart13420538.yxaRUJCCII--


--===============6226627192143731810==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--===============6226627192143731810==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============6226627192143731810==--

