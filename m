Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1VoRQi-00087M-6b
	for ltp-list@lists.sourceforge.net; Thu, 05 Dec 2013 05:24:52 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VoRQg-00037W-FF
	for ltp-list@lists.sourceforge.net; Thu, 05 Dec 2013 05:24:52 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Thu, 5 Dec 2013 00:24:49 -0500
References: <529FF665.9000004@cn.fujitsu.com>
In-Reply-To: <529FF665.9000004@cn.fujitsu.com>
MIME-Version: 1.0
Message-Id: <201312050024.50466.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH 1/3] fcntl/fcntl29.c: add F_DUPFD_CLOEXEC test for
	fcntl(2)
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2966347888216872280=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============2966347888216872280==
Content-Type: multipart/signed; boundary="nextPart33018647.EWC1NdsB76";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart33018647.EWC1NdsB76
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Wednesday 04 December 2013 22:43:33 Xiaoguang Wang wrote:
> +#if defined(F_DUPFD_CLOEXEC)
> ...
> +#else
> +
> +int main(int ac, char **av)
> +{
> +	tst_brkm(TCONF, NULL, "This test can only run on kernels"
> +		 "that are 2.6.24 and higher");
> +}
> +#endif

an ifdef test on a define provided by the C library is not a good marker to=
=20
control kernel version functionality

> +			TEST(fcntl(test_fd, F_DUPFD_CLOEXEC, dup_fd));
> +			if (TEST_RETURN < 0) {
> +				tst_brkm(TFAIL | TTERRNO, cleanup, "fcntl "
> +					 "test F_DUPFD_CLOEXEC failed");
> +			}

what happens when you run this on an older kernel ?  should you be doing a=
=20
runtime kernel version test here ?
=2Dmike

--nextPart33018647.EWC1NdsB76
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJSoA4iAAoJEEFjO5/oN/WBecUP/3Mqt2sXc7+htluU8zlMOGE+
NCP7UWPU/KnCrzcTMqsw2oWM6rgImULq0EdwmavvwKZn4+g+aK2mFH5skdc4T7Bc
qOQHf9Q94S5GuxiKeol7becJrNzuRY26LRFO81+okivw7NDJYSRQVxVpL0X9tnTq
HSluoiibJ366Kb3zFenKIWo/kFVpnS3nV/ULqBCJr5SUJAiehYzv5qA3BDffUa3d
s7ENvPmkTAVLKKbYpalq2MUzF88wCLwYYgWzQu4E6xPTphwSymSCI2O1PqFtFvGD
0LpK6aQrlAv9ZZbH4N5ubl9mJmtnKpktQhSzE9ZQG5iXsB+3qz3o1VoVURbLjjNP
P+8p8S3ngZ6yoYyJfYPhkFj0VGQaWiole78d/zV/3gbk/jpTTKv281ISP1l4+xA0
tm0tlZaA2XPhDz+kkespTondCj7D8PhrfCRUIzBglB5EsDPYaNm75qEsQSNCgN4D
9fMjJXtPcMApWYVwyEa4GA/ewugl1Od+XbdOh9bnl3xve5VySaloxsy+XXXVQo95
9emx5CUyvUegpEv6bfy1AF8H9XZ+yZ9BS1jMJkXSTUvMt9wLs6z48L5sbXDNl4pm
WvhUBjR9he/ib0ollhFIO7rvKUFVKvrNJLBETB/Sgue8vmPIEjzY/OuXiEhLul65
tfc9HSPF7Yku9ecYplOP
=s8FR
-----END PGP SIGNATURE-----

--nextPart33018647.EWC1NdsB76--


--===============2966347888216872280==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Sponsored by Intel(R) XDK 
Develop, test and display web and hybrid apps with a single code base.
Download it for free now!
http://pubads.g.doubleclick.net/gampad/clk?id=111408631&iu=/4140/ostg.clktrk
--===============2966347888216872280==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============2966347888216872280==--

