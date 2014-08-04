Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1XEDii-0006ts-Fe
	for ltp-list@lists.sourceforge.net; Mon, 04 Aug 2014 08:34:16 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XEDih-0001Yj-K6
	for ltp-list@lists.sourceforge.net; Mon, 04 Aug 2014 08:34:16 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Mon, 04 Aug 2014 04:34:09 -0400
Message-ID: <1419562.aEt90tPbov@vapier>
In-Reply-To: <1407139174-14098-1-git-send-email-gux.fnst@cn.fujitsu.com>
References: <1407139174-14098-1-git-send-email-gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] cgroup/cgroup_regression_test.sh: fix an issue
	about removing directories
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5204992778055450238=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net


--===============5204992778055450238==
Content-Type: multipart/signed; boundary="nextPart8582631.Eb52e7CZC0";
	micalg="pgp-sha1"; protocol="application/pgp-signature"


--nextPart8582631.Eb52e7CZC0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

On Mon 04 Aug 2014 15:59:34 Xing Gu wrote:
> -rmdir -p cgroup/*
> +if [ "$(ls -A cgroup/)" ]; then
> +=09rmdir -p cgroup/*
> +else
> +=09rmdir cgroup/
> +fi

one line:
find cgroup/ -maxdepth 1 -depth -exec rmdir {} +
=2Dmike
--nextPart8582631.Eb52e7CZC0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABAgAGBQJT30WBAAoJEEFjO5/oN/WBadAP/RQqQheqvmDBfBEws76VFhCm
mbWmafK68i9x8WksYsKyAJ4KZv8fYhsVIvEDQQjzFLFSTybLF2mcVunuuZE1b92F
MyhlKTvX7IjqoU8/w6QmFB7LknxaNaD5k8NBoWPC486OdmtfmA6XB7WffJUBOHfb
0rw2QKkj+RW03qbc8Nu6iuYsa1A2Fy5Kn8C9QKrIfM+nuaV2Y7uXRkt9GxHw7gUk
leGo0fPX3TSNo3ZdMJqQJmzuweScG496ymkI1Ugic8OPj4HitwaQM4h3JRa1kRVX
rVndzrJt6iEgiH1lU78Q4Nn2KsHNSOylff51g2NRULYrV69LOLVyQkpb7Eypk2nd
JM9WAKhxTS7sPf1J5JbyWkGbbjx2XTSnA2xfvsm+cLny8f8unON+ZpYjd2POG5HX
GVHzMBUuv83+lEUTLtv9YyyrJWE+E051qSFSeQ62uTWOlW6g+JbAVEK6zGT/to8C
3eTFFg28WCUn8sOEYMWZokKr54pbjsfnkQ1xJIL4EfxpnlnNP5JbVuUkmSc8bc12
cD6hkhdNb3cPtPdCYzim5vLsL2cqzzsHXxRVDBA88K7Nlc2yGYgAgi8kiy0Cr34J
7jMMAjTcnvwaQd+w4mzcKnQp19lI44pzn68Vt4BrBllapesfNI9jYOH+EiaBwWTT
bHG31vNxS6/tRelrm3+X
=aBhu
-----END PGP SIGNATURE-----

--nextPart8582631.Eb52e7CZC0--



--===============5204992778055450238==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Infragistics Professional
Build stunning WinForms apps today!
Reboot your WinForms applications with our WinForms controls. 
Build a bridge from your legacy apps to the future.
http://pubads.g.doubleclick.net/gampad/clk?id=153845071&iu=/4140/ostg.clktrk
--===============5204992778055450238==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============5204992778055450238==--


