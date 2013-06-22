Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1UqSLS-0006JI-7p
	for ltp-list@lists.sourceforge.net; Sat, 22 Jun 2013 18:15:30 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1UqSLQ-0001iq-FL
	for ltp-list@lists.sourceforge.net; Sat, 22 Jun 2013 18:15:30 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Sat, 22 Jun 2013 14:15:15 -0400
References: <1371729277-12450-1-git-send-email-alexey.kodanev@oracle.com>
In-Reply-To: <1371729277-12450-1-git-send-email-alexey.kodanev@oracle.com>
MIME-Version: 1.0
Message-Id: <201306221415.17130.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] tst_module: create new library functions for
	kernel modules
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0546718321859582273=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: Alexey Kodanev <alexey.kodanev@oracle.com>, vasily.isaenko@oracle.com

--===============0546718321859582273==
Content-Type: multipart/signed; boundary="nextPart5321927.aXMgjiqtG9";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart5321927.aXMgjiqtG9
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Thursday 20 June 2013 07:54:37 Alexey Kodanev wrote:
> +/*
> + * Check module existence.
> + *
> + * @res_path: if this pointer isn't NULL, found module's path will be
> + * written to it.
> + *
> + * In case of failure, test'll call cleanup_fn and exit with TCONF return
> + */
> +void tst_module_exist(void (*cleanup_fn)(void), const char *mod_name,
> +	char *res_path, size_t max_path);

i hate APIs like this.  they're so 1990 :P.

look at the getline() func and behave like that instead (take char **res_pa=
th=20
and size_t *max_path instead)

> +/* declared in tst_tmpdir.c */
> +const char *tst_get_startwd(void);

use a proper header instead.  extern func decls only leads to bit rot and h=
ard=20
to debug crashes.

> +	char buf[PATH_MAX];

PATH_MAX should be taken out back and shot.  there's no reason to use it=20
anymore when we have things like asprintf().  plus, it isn't portable --=20
there's no guarantee it'll be defined.  i know the irony complaining about=
=20
portability with PATH_MAX when asprintf() isn't in POSIX either, but the=20
difference is, we have an asprintf() fallback already in lib/, and we have =
code=20
using it today.

> +	char cmd[strlen(mod_path) + strlen(params) + 9];
> +	snprintf(cmd, sizeof(cmd), "insmod %s %s", mod_path, params);
> +
> +	if (system(cmd) !=3D 0) {

use fork()+execvp() instead.  there's no need to normalize to a string and=
=20
then run through a shell.

wonder if we should add a util func for this ...
=2Dmike

--nextPart5321927.aXMgjiqtG9
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJRxem1AAoJEEFjO5/oN/WBJuUQAJDrh2kySiXjKuF9Ap5Q8gij
sSmYs1lttVQD29fngHzy8EyXWbGpuENt75lJQETimZVxuNQMo1MhwbxdgTlEif3o
IDy9RmySFXteVcfqq95E7A56Rcj3g2cbk3ZOngh1tiVs1S9jHRDsAvs+FwR94gzM
gVk36Rp9ucq8qTY1BePm0KxSbYBQ5cUCmNTD78YAJfkqs73rbk/9c2SFIzifv6wK
vy2gbWqx/DH9bVZG4nIdXkHCYK1kaEyYBYUj984Clrogz+YSaqKdRRaYSPoNLtHv
yDA2Sn+9OJFkpDrigN5nRK7+2qF/BQoMyThcznxd/I7XalStu5TlcLegofCOGwpJ
oETJLhVoX3tHfYFYZ7OXBmMEUS+/lHCldWJMKPselLEfdKvUVF358ReDsPhanPWE
BpQOywDufc/a99kS3lKRnOk1HFqOJC87wT8T70svbVTxf8AbU1v2ms+TUqrLxz2g
UOOn4deXKjR/URNIxX0/5GpygeWRvbyK2+MUQ/rzssECs3yzO/hYAL58MA9VdYbL
ZPTPQwknhkdic9V8XS3fclMdlxlIihpcsrY0+iCJ6x29hAuGES/UB2jxJvCRtLMl
flFxsv6zF31S0Sy5mcOGyWTMvrDqohL9GgBqja0GTdplBJA5YMev254nB2gZh9ta
+HdGf0B17195bOurX5yc
=JEJJ
-----END PGP SIGNATURE-----

--nextPart5321927.aXMgjiqtG9--


--===============0546718321859582273==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
--===============0546718321859582273==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============0546718321859582273==--

