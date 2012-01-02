Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1RhoNP-0004oy-0P
	for ltp-list@lists.sourceforge.net; Mon, 02 Jan 2012 20:20:59 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1RhoNO-0003Gm-3q
	for ltp-list@lists.sourceforge.net; Mon, 02 Jan 2012 20:20:58 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Mon, 2 Jan 2012 15:20:57 -0500
References: <1325235186-20625-1-git-send-email-gaowanlong@cn.fujitsu.com>
In-Reply-To: <1325235186-20625-1-git-send-email-gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
Message-Id: <201201021520.58152.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] gitignore: ignore the files compiled
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1542267897752141684=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: Wanlong Gao <wanlong.gao@gmail.com>

--===============1542267897752141684==
Content-Type: multipart/signed; boundary="nextPart2128875.xdHuRoSyqu";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2128875.xdHuRoSyqu
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Friday 30 December 2011 03:53:06 Wanlong Gao wrote:
> +/testcases/kernel/syscalls/fork/fork13
> +/testcases/kernel/syscalls/getrusage/getrusage03
> +/testcases/kernel/syscalls/getrusage/getrusage03_child
> +/testcases/kernel/syscalls/mlock/mlock04
> +/testcases/kernel/syscalls/pwrite/pwrite01_64
> +/testcases/kernel/syscalls/pwrite/pwrite02_64
> +/testcases/kernel/syscalls/pwrite/pwrite03_64
> +/testcases/kernel/syscalls/pwrite/pwrite04_64
> +/testcases/kernel/syscalls/syslog/syslog11
> +/testcases/kernel/syscalls/syslog/syslog12
> +/testcases/kernel/syscalls/syslog/syslogtst

i merged these into the testcases/kernel/syscalls/.gitignore file.  the oth=
er=20
testcases/kernel/ ignores should get split up accordingly.
=2Dmike

--nextPart2128875.xdHuRoSyqu
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJPAhGqAAoJEEFjO5/oN/WByWwQANynykuo5PqgfwiVEluT3qH5
tlYtOJ8XsYOJh7kyYKrEWYZrJkKZAPFaO0d5PU4LO0R2xz5AyXZpuOOwlRDBkKnS
+1/X4Odf2LBHus5PyWToxhm3YeeCgqXZBfzCKFc0Hg5AVdZZgi2VFHA3Zt9rGxtt
4OUqVtT0RU8qWiAlOwoiXdZM+47J0UGz4leAYUsBYDYydnrmFI5ityZzIf9Rk2We
Xe5xqabg+G5mGpuPIdxRqIBzYeg87ninnetpfHmDKwyaH1T2Jd8uiIX4Kq2vzqLS
kO5mxtayKdsqPI91iMYyedj0D0o5zTSHFmA0YQYv9CztuwfbxZ2ayhQ9s4LdKAO2
RUDMdSwJOlLInPtEpgbUo+Yh4a8y5LE9VwxrZWePekkNGRRXokxvLki8dcNBiyOm
5St/x6FfAIxZfprfL1BLUwyeymxy9WpWHukxoj59TnuxGSGcfD39lNYDilG19g37
pxYKXRqEiAfAAX0OA4s5LP9UjFBquvaDdQCynqeXDK3NJTMT6oXs19dza58fMLNP
AWs5OQyQvSm9rKUz0ZKFHjtodTq5vf5bXTcXrA/WkVtQO1e9fXUg1nLUkD/vp6iR
3L7ZVz1S4LKlLKNYeygNk783t4AMuUjOxZ7sjJRyWIedPVSYk+eKz8gJ6ud3joM5
BHYiJBJYTp5CsfPf9meU
=YmIK
-----END PGP SIGNATURE-----

--nextPart2128875.xdHuRoSyqu--


--===============1542267897752141684==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Ridiculously easy VDI. With Citrix VDI-in-a-Box, you don't need a complex
infrastructure or vast IT resources to deliver seamless, secure access to
virtual desktops. With this all-in-one solution, easily deploy virtual 
desktops for less than the cost of PCs and save 60% on VDI infrastructure 
costs. Try it free! http://p.sf.net/sfu/Citrix-VDIinabox
--===============1542267897752141684==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============1542267897752141684==--

