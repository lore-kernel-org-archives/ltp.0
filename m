Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1TOLI3-0003EN-56
	for ltp-list@lists.sourceforge.net; Wed, 17 Oct 2012 04:31:31 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1TOLI0-0001Td-T9
	for ltp-list@lists.sourceforge.net; Wed, 17 Oct 2012 04:31:31 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Wed, 17 Oct 2012 00:31:22 -0400
References: <20121015182122.GA6698@rei.suse.cz>
	<1350443616-20186-1-git-send-email-gaowanlong@cn.fujitsu.com>
In-Reply-To: <1350443616-20186-1-git-send-email-gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
Message-Id: <201210170031.23266.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] tools: add tst_ncpus/_max api to get number of
	CPUS
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============3356538324907189888=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============3356538324907189888==
Content-Type: multipart/signed; boundary="nextPart8136089.F3dtY0W7kS";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart8136089.F3dtY0W7kS
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Tuesday 16 October 2012 23:13:36 Wanlong Gao wrote:
> --- a/tools/apicmds/ltpapicmd.c
> +++ b/tools/apicmds/ltpapicmd.c
> @@ -266,6 +266,12 @@ int main(int argc, char *argv[])
>  		else if (exit_value > 0)
>  			exit_value =3D 2;
>  		exit(exit_value);
> +	} else if (strcmp(cmd_name, "tst_ncpus") =3D=3D 0) {
> +		long exit_ncpus =3D tst_ncpus();
> +		exit(exit_ncpus);
> +	} else if (strcmp(cmd_name, "tst_ncpus_max") =3D=3D 0) {
> +		long exit_ncpus_max =3D tst_ncpus_max();
> +		exit(exit_ncpus_max);
>  	}

i'm afraid exit() won't work.  the value is anded with 0xff which means if =
you=20
have a system with 4096 cpus, these will exit(0) and obviously that isn't w=
hat=20
you want :).  plus, extracting the value from the exit status is not normal=
=20
behavior in the shell scripting world.

simply write it to stdout instead:
	printf("%li\n", tst_ncpus());
=2Dmike

--nextPart8136089.F3dtY0W7kS
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJQfjSbAAoJEEFjO5/oN/WBKf0P/Rwuy0Sb8TzABtz4KtDuLd9Y
effCkh9m70COit+nom0J5YWnsInF3odvccBiVlS/nF1P7dQGpsJzfhb1ddbbVhMt
scqsei0cZFqK+KMoLrTpW1bl7iQUG23Iaxs3mbQ5awRjNBdzVl9zvd99jL3p52XS
F8nW/+HqySzSIoh6S0ul0ioqnOlGrB3PpZ/qA2Hu/JZqjkd9fWCoweQR0L9mi0BY
5M4hrsnchUi8FMRhg72Zzz2RLvg53j5qrAa/1I8OAhkAlnW+lVZslx4rC3C4ce6z
L65bpx2CibFZc+1s+wIj+l4XVZqFYhumdcDII/YRH7YjgGN5RoCvlNnSGPiycQ/B
+xolpeLi/SKuQl1FuMVU9vayM2SeISpPmKC441R92Y+IBzOqSJISovBQJItnJwax
rwPTDLXBqTLE8w2or7gakFVO0GTydihQMCRs+zbO7GoZoQ72Vgryr+DV6VW8adSC
pN7285tVp4h+a128PkfgajzdOHgNe8hNUcFAM91x51QI66f6XZgA1YumJKa/u1O9
w+4/Gzyk0w5LhndIWFD1u4Y41U5of8DKmrdHVD3UlRScerXPI9+G82MCNcqZYkBq
sEQrUzyzeD44vhjfnSVveXHkxFbZiMw2GUOKqvg94GXkX32bF8kZPaG8skSuvIy2
93X5xiRR2hKCd46HSQSg
=LJVW
-----END PGP SIGNATURE-----

--nextPart8136089.F3dtY0W7kS--


--===============3356538324907189888==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_sfd2d_oct
--===============3356538324907189888==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============3356538324907189888==--

