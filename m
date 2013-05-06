Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1UZNlV-0002zM-NK
	for ltp-list@lists.sourceforge.net; Mon, 06 May 2013 15:55:49 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1UZNlU-0005y5-Ba
	for ltp-list@lists.sourceforge.net; Mon, 06 May 2013 15:55:49 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Mon, 6 May 2013 11:55:43 -0400
References: <1367833278-18177-1-git-send-email-alexey.kodanev@oracle.com>
In-Reply-To: <1367833278-18177-1-git-send-email-alexey.kodanev@oracle.com>
MIME-Version: 1.0
Message-Id: <201305061155.44681.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] New core test of hardlinks and symlinks
	restrictions added in Linux 3.6. Disabled by default in Linux 3.7.
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============3401289351048866385=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: Alexey Kodanev <alexey.kodanev@oracle.com>

--===============3401289351048866385==
Content-Type: multipart/signed; boundary="nextPart2150571.l7AfC2xZLk";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2150571.l7AfC2xZLk
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Monday 06 May 2013 05:41:18 Alexey Kodanev wrote:
> +#define BASE_DIR_NUM		(USERS_NUM+1)

spaces around that +

> +#define MAX_ENTITIES		(MAX_FILES_CREATED*BASE_DIR_NUM)

spaces around that *

> +static const char *file_postfix =3D ".hs";

for const strings you don't modify the pointer, use []:
	static const char file_postfix[] =3D ".hs";

> +option_t options[] =3D {

static, and probably const

> +static int cwd_offset;

you assign the return value of strlen() to this, so it should be size_t

> +static const char *hrdlink_proc_path	=3D
> +static const char *symlink_proc_path	=3D=20

same thing wrt to * vs []

> +static void setup(int ac, char **av);

please use instead for argv:
	char *argv[]

> +int main(int ac, char **av)

same here

> +	if (tst_kvercmp(3, 7, 0) < 0) {
> +		tst_brkm(TCONF, &cleanup,
> +		"Test must be run with kernel 3.7 or newer");

unwrap, or indent the string one more level
=2Dmike

--nextPart2150571.l7AfC2xZLk
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJRh9KAAAoJEEFjO5/oN/WB5dUP/0Xu1fdV6mpxq9zAl82Ay4ue
psQUeNQWgrw7o7tzusaVOTwpuJ+xONRIHvtlL++tykeX1djTg8qTxjsujlSRPeyp
ChdKiaPIfdifeo8FMn+z/3S0b522KLF1KOG/Ex6gHjps/LFt9iobSMwUhbfO8oaq
KxldR8pX/IBUP6iHKd9QJJZ8oYFg0NtjNd6qkpJ8cFk4gZ49nmDuydVCdvV8vTRB
U8nS3q7sp+k0/WwCOpUqCuyqWsEyJeFw1DBauSQ7qJO9hOD+8l+Q/4TtoxTO098t
qlMdLSMwlmoHH5L5WJju1RISAFdptEreGQqfNgMeEiczdEq260xjs9jWVl3Ma1DE
UWn4GWGLuVmQWoUscneOMJrQosweqZ2LTSY7DPWRp1BtO1UQMy66jUx2TNK+xQhY
Fbm+GdSAYsCwpsumYlCwF2wkJ9YCTXUOXVmeBTM/RLHxUblkWUOkERGDRSZXoLDI
y1wAGiFK/uVjhsgDuSLdF8qw0+tIvhQiFrqoUAynJXUl7Z+vylmBmpAmsBFTEFqQ
T8FljZVtWg8hbZQsAvJ28JOgruwXy1/5aGpvQ/qzLUhemYboGFBEOPcFmrgZ47Vh
y82YOGXyeYw0LzVdJKldH0tICsBs564+++kkA/R3XVEGnadKvy+sQH+sPzOBhm0V
5pcSGwAKCfEg//MO0aN4
=RDfK
-----END PGP SIGNATURE-----

--nextPart2150571.l7AfC2xZLk--


--===============3401289351048866385==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Introducing AppDynamics Lite, a free troubleshooting tool for Java/.NET
Get 100% visibility into your production application - at no cost.
Code-level diagnostics for performance bottlenecks with <2% overhead
Download for free and get started troubleshooting in minutes.
http://p.sf.net/sfu/appdyn_d2d_ap1
--===============3401289351048866385==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============3401289351048866385==--

