Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1NDMFD-00066W-Ua
	for ltp-list@lists.sourceforge.net; Wed, 25 Nov 2009 18:05:35 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NDMF7-0006gN-2m
	for ltp-list@lists.sourceforge.net; Wed, 25 Nov 2009 18:05:33 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Wed, 25 Nov 2009 13:09:21 -0500
References: <1259156195-13056-1-git-send-email-avagin@gmail.com>
In-Reply-To: <1259156195-13056-1-git-send-email-avagin@gmail.com>
MIME-Version: 1.0
Message-Id: <200911251309.22834.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] tst_res: save errno at the begin,
	otherwise it may be rewritten
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============7262363109040212018=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Andrew Vagin <avagin@gmail.com>
Cc: ltp-list@lists.sf.net

--===============7262363109040212018==
Content-Type: multipart/signed; boundary="nextPart3572276.ejt761LI6v";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart3572276.ejt761LI6v
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit

On Wednesday 25 November 2009 08:36:35 Andrew Vagin wrote:
> it may do fprinf for example.

it seems a little paranoid, but i dont see any harm in the change
-mike

--nextPart3572276.ejt761LI6v
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.13 (GNU/Linux)

iQIcBAABAgAGBQJLDXLSAAoJEEFjO5/oN/WBcggP/A57BWQS9p2jMsFFeUO/W7Qz
0DWGMBvu8Bds+tihipwOIXv0BJVU2pmxNXQBCr8Th2PeLNj5EThYNwKl6g2neOz7
blwqxsGJHmJ8gTZv0rJIqc4aHbJi+4JOeX83wWp6QEvOKDOQ94vDwMSYPX5WEjPS
yjqYBJHreiNqXu1Accm1+c3RmvylWCmQsWMW3EQpjWgMMSwwyLItezUSrP//3lqe
esHKIwYWHSGYUauR+t+iXYP3XF5VpqeThLHA8sBC1nhwwWSqR9Ll2nyC9NkuVs59
JfR/b+Y1BLV5sW9dSQCnSGD6WyHR4hN6fRpshXrkolROnMPvqnt8tYnhxm7w/JZ1
duJ/OoNWJRMtyMFXqZJoPIQN+2twJdlLM2tGX+fa62NgV11lp4ydZdPoyqEYVaqH
ATHWEvEehjBBVz/4DanM+doKZ7OrTk9GCgMLBZu30nVrbgV2hh3U9FcVgs1obtC7
x33Q0MwJrSs8s+QQk6QizQ8uH2UvyQ7Ab8SoFPPZUAxHwrZlRB8+FYVeR8e3spOD
tEjlg7TS4Jv+RMfMxFeagL55rQ0kh0E8ef9c0rZ3Y8YeHZKAKkbndeWHDw+K5kGq
R6xGxEv4U72Ih2Ctdqpis2h/IcpkwP+A+2QzarmYfldwspInZm42mDyzwrDTfK52
jTqCaljL1Mq+YqhGMI6K
=POFN
-----END PGP SIGNATURE-----

--nextPart3572276.ejt761LI6v--


--===============7262363109040212018==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--===============7262363109040212018==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============7262363109040212018==--

