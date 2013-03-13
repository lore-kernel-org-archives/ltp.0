Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1UFpJ7-0003iA-HP
	for ltp-list@lists.sourceforge.net; Wed, 13 Mar 2013 17:17:42 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1UFpJ4-0001Gn-AC
	for ltp-list@lists.sourceforge.net; Wed, 13 Mar 2013 17:17:41 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Wed, 13 Mar 2013 13:20:16 -0400
References: <1363183294-21203-1-git-send-email-markos.chandras@gmail.com>
In-Reply-To: <1363183294-21203-1-git-send-email-markos.chandras@gmail.com>
MIME-Version: 1.0
Message-Id: <201303131320.17542.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH 1/2] syscalls/getdents: Use getdents64 if
	SYS_getdents is not defined
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2182793227988590389=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============2182793227988590389==
Content-Type: multipart/signed; boundary="nextPart2505095.ihPMMsb5xc";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2505095.ihPMMsb5xc
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

On Wednesday 13 March 2013 10:01:34 Markos Chandras wrote:
> +#ifdef SYS_getdents
>  struct linux_dirent {
>  	unsigned long   d_ino;
>  	unsigned long   d_off;
>  	unsigned short  d_reclen;
>  	char            d_name[];
>  };
> +#else
> +/* Use the 64-bit definition */
> +struct linux_dirent {
> +	unsigned long long	d_ino;
> +	long long		d_off;
> +	unsigned short		d_reclen;
> +	unsigned char		d_type;
> +	char			d_name[0];

any reason for using [0] instead of [] ?
-mike

--nextPart2505095.ihPMMsb5xc
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJRQLVRAAoJEEFjO5/oN/WBw6wP/iIuRY5JQvJDRKRmwO6jXaUo
9UUIc51jMl7LKnlJ8YSM40xlcdqUKQ7mEgym/KVFLAI1RtOpkfH4jNK27n8owq+y
2IlI2orSeIigbnMGjsVDHbpi0ANHnfuLobN5bXIUJDHYbzXi1cDdzzMOiGHKzobq
GiyUgkNhZg8yUOWlovnCL5/KHIIqSDphi5kbASLndwdHVYhMPF5KftW30D58a/35
vvp6qyxKk4PM38UdU8rMta8hlS8Qx4/YHzRn/ZW1o3g6RYI+hjJsYQaYWqd0wmbg
zGv4TZJzbcSVV/nn7IhpxlezbcthLGsDAxqs7W8Ex7VkhBq20zP8uKJehVfUEJjk
xoTTV9tCVLcfX6FpGW5PQw1h0Qs7nmKxDiB1C/mADBWuE+sobid2scdmxOSffdn9
qYYh8FmeUzb311pZJwOoDYqX1lXEdqOX/8Fk/j9bprY7yiq9CH/TYp/qLnjl6rWw
FV9mSFKIHW2ldOSQzwvS3H7wVVdJeZHrPWVHUXfDkm4TfitaMyYK4QUQ/nFaEsoS
sXxzSJ1XobgXtFwYfsLg3/nHCMWSG9BcCNx4PxrCrQyZcDJtYnV9BpqvA7EKdk7i
+yQYfXvLc/Fts7dUh7mWRb39P3hGD4dTUU7eRz/vPeRti6KtKjGipFePqcVfjPBn
bJ+gKAIFrZtSUOY7YQWn
=0H2Z
-----END PGP SIGNATURE-----

--nextPart2505095.ihPMMsb5xc--


--===============2182793227988590389==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_mar
--===============2182793227988590389==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============2182793227988590389==--

