Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1NDARg-0006QK-1t
	for ltp-list@lists.sourceforge.net; Wed, 25 Nov 2009 05:29:40 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NDARY-0006Ot-QS
	for ltp-list@lists.sourceforge.net; Wed, 25 Nov 2009 05:29:39 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Wed, 25 Nov 2009 00:33:22 -0500
References: <000001ca6d7c$63dc8890$2b9599b0$@co.jp>
	<364299f40911242117g6baf6281r1e7191a201d4203c@mail.gmail.com>
In-Reply-To: <364299f40911242117g6baf6281r1e7191a201d4203c@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <200911250033.23404.vapier@gentoo.org>
Subject: Re: [LTP] mbind01 test failed with after ltp-2009-11-12.tar.gz
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5075084736777917558=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net, Nate Straz <nate@refried.org>, Mitani <mitani@ryobi.co.jp>

--===============5075084736777917558==
Content-Type: multipart/signed; boundary="nextPart2661601.91sxTtq3aY";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2661601.91sxTtq3aY
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

On Wednesday 25 November 2009 00:17:16 Garrett Cooper wrote:
> --- regen.sh	19 Nov 2009 19:35:15 -0000	1.12
> +++ regen.sh	25 Nov 2009 05:12:13 -0000
> @@ -32,8 +32,13 @@ static void cleanup(void);
>  		tst_brkm(TCONF, cleanup, "syscall " #NR " not supported on your arch");
>  \\ errno = ENOSYS; \\
>  		__ret = -1; \\
> -	} else \\
> +	} else { \\
>  		__ret = syscall(NR, ##__VA_ARGS__); \\
> +		if (__ret == -1 && errno == ENOSYS) { \\
> +			tst_brkm(TCONF, cleanup, "syscall " #NR " not supported on your arch");
>  \\ +			errno = ENOSYS; \\
> +		} \\
> +	} \\
>  	__ret; \\
>  })
>  EOF

i'd prefer this change
--- testcases/kernel/include/regen.sh	9 Oct 2009 17:55:48 -0000	1.11
+++ testcases/kernel/include/regen.sh	25 Nov 2009 05:28:27 -0000
@@ -30,11 +30,12 @@ static void cleanup(void);
 #define syscall(NR, ...) ({ \\
 	int __ret; \\
 	if (NR == 0) { \\
-		tst_brkm(TCONF, cleanup, "syscall " #NR " not supported on your arch"); \\
 		errno = ENOSYS; \\
 		__ret = -1; \\
 	} else \\
 		__ret = syscall(NR, ##__VA_ARGS__); \\
+	if (__ret == -1 && errno == ENOSYS) \\
+		tst_brkm(TCONF, cleanup, "syscall " #NR " not supported on your arch"); \\
 	__ret; \\
 })
 EOF

-mike

--nextPart2661601.91sxTtq3aY
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.13 (GNU/Linux)

iQIcBAABAgAGBQJLDMGjAAoJEEFjO5/oN/WBcC4QAKDWBvPhiQWsWEfvWg9ZMwHO
iJMtj5dQYgPbNz6bmfYr2iRp8Xw/jy5ZNeV25ay56Cb4rkqJg6+6tvHQNMXl+cih
FxC6FA2IvuLksg0rY8cgS2abHRlBZ+CR447DkmDIDNpiw3vrwDirwj2q7nyfHWGD
ApUHp+oqgisLW2r0J1qu1yaYbdYNTdTDMuxrGtYdJM0eWevaRmgrWqvMyPuZf45I
QXwBA68S2gX41qNHz4QrT3Fxdjvxm0DfkqzqS3sL4t6wifNzm3To7MdOrxqLU28k
xFWG2xRPTRSpHG+MV+Pkg/swIlWqAbt2YiU8AAasEieJQ4No44ipLIBo4487C1wT
/qEfQl9i4225ROyI7RC8mykTfC/KTNP3nmuf0FxUjFfU2CCrKba9Dr2JbQ0bjN+C
2YwbKF4015hxqKiXk2Dw1VCgugSynWZRSTUxawUUJGiS+DiXld+uzRdemNge2mEG
ZlBG6QObsZXsfJ+ltWNi+VWwZWlxeIQKj7vzGmj7FHY4gVGchOG79dIhMs449NMo
A7d49KiETf9Cnilo9iz2FeDtlSpuYCHHHMYcrIUWJxKQBRpmiIRGMBf/jePRhUr2
e5CDexd8DRPo5eNiPwF7DQmD6XHaUsDtRR3/N6yR4m/Su7tvPRtyeq7mCOOAD9JV
U+zSj3aYZbYzLVD2B7/4
=QXVR
-----END PGP SIGNATURE-----

--nextPart2661601.91sxTtq3aY--


--===============5075084736777917558==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--===============5075084736777917558==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============5075084736777917558==--

