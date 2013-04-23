Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1UUfof-00013y-7k
	for ltp-list@lists.sourceforge.net; Tue, 23 Apr 2013 16:11:37 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1UUfoe-0001d8-6d
	for ltp-list@lists.sourceforge.net; Tue, 23 Apr 2013 16:11:37 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Tue, 23 Apr 2013 12:11:26 -0400
References: <8a051675195eceda293d88d157163083d7886570.1366724682.git.jstancek@redhat.com>
In-Reply-To: <8a051675195eceda293d88d157163083d7886570.1366724682.git.jstancek@redhat.com>
MIME-Version: 1.0
Message-Id: <201304231211.28293.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] remove linux_syscall_numbers.h from tree
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0616652845213925619=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============0616652845213925619==
Content-Type: multipart/signed; boundary="nextPart6009561.Z7sHuvWZJU";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart6009561.Z7sHuvWZJU
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tuesday 23 April 2013 09:53:28 Jan Stancek wrote:
> It will be generated as part of the build by:
>   testcases/kernel/include/regen.sh

is keeping it in the tree a big deal ?  i think it's pretty common for peop=
le=20
to go into specific subdirs and run `make` and today, our subdirs don't dec=
lare=20
a dependency on this file so it'll get automatically regenerated (nor do i=
=20
think they should even bother).
=2Dmike

--nextPart6009561.Z7sHuvWZJU
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJRdrKwAAoJEEFjO5/oN/WBELsQAN+HdoyeSb02PxR98qqHFEiR
M191wW6JELudHT2uj/fVY+gwN0ldVeduaU5+Kn8THvsn8g8BPquqtE8VTTJ13fc+
mXgje67HkjhzE/xHbNoqXX7vrcjKB1/bg649gbBxmnglaCz/5LYztpvhnSs4s0uE
1385EacNQycBOWVtwd3Jth/9/pvYgm5htVh41ZidTtyIj9YjsIEkGA/BdXnnHgBx
rSXLxOW7V85AvOasayGVlgc5MZqnHUFpmnUDUoMYF13yNTkI/bkdw0e2FQU/pCLV
/v44dTrQpnMhjDG2vRslqOGwFbN9OTZ7tZ/xgQzU5ZndwSTPFlQdLCc05Bbg6ZWN
SFTcGWRq4y9yXTV/pmFwYJQ00kL0KBKsaN6xljDCVyac0rcYn5E/iV/HTUVKuF7+
iTWN+FwugA99b0lqqJpwM1P6ZG8lJxveFo7gaMT5U6XWXKijxYQXQP0Zkvqz8bch
QrblMur4qev00GQ1VPXphNtcyL2BwGv7xqoi8iq5FXWbLjh72GFnrzBD9viz8fRv
v4hoa8E0yoFZ0r8xLVO7xpNK5r89oCUm+wscmPv1FSlWG2f9Ey3zzchVJlgR62va
iza/1qL5CROY5xsbTuhvB1G6MIHo6iNVgCnZnV4JOMWPM5BcbqRrgqS0T0PKHH/J
ffR52wgEzEMyBMaGZE/9
=5qwZ
-----END PGP SIGNATURE-----

--nextPart6009561.Z7sHuvWZJU--


--===============0616652845213925619==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Try New Relic Now & We'll Send You this Cool Shirt
New Relic is the only SaaS-based application performance monitoring service 
that delivers powerful full stack analytics. Optimize and monitor your
browser, app, & servers with just a few lines of code. Try New Relic
and get this awesome Nerd Life shirt! http://p.sf.net/sfu/newrelic_d2d_apr
--===============0616652845213925619==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============0616652845213925619==--

