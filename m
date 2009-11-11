Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1N84sH-0000Ax-3y
	for ltp-list@lists.sourceforge.net; Wed, 11 Nov 2009 04:32:05 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N84s9-0005Se-As
	for ltp-list@lists.sourceforge.net; Wed, 11 Nov 2009 04:32:05 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Tue, 10 Nov 2009 23:33:54 -0500
References: <4AF93496.3030408@cn.fujitsu.com>
In-Reply-To: <4AF93496.3030408@cn.fujitsu.com>
MIME-Version: 1.0
Message-Id: <200911102333.55526.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] syscalls: fix some failure on arch X86_64
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============3314034010403265224=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============3314034010403265224==
Content-Type: multipart/signed; boundary="nextPart1645673.hmXd1rqyiB";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1645673.hmXd1rqyiB
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Tuesday 10 November 2009 04:38:30 liubo wrote:
> 1) rt_sigaction
>     "sigaction" has the structure:
>=20
>  struct sigaction {
>          __sighandler_t sa_handler;
>          unsigned long sa_flags;
>   #ifdef SA_RESTORER
>           __sigrestore_t sa_restorer;
>   #endif
>           sigset_t sa_mask;               /* mask last for extensibility =
*/
>  };
>=20
>     However, on arch x86_64, if we directly get to call rt_sigaction,
> the argument "sa_restorer" will not be fulfilled, and this will lead
>  to segment fault.
>     on arch x86_64, if sa_restorer is not set, kernel will lead to segment
>  fault. In other arch, if sa_restorer is not set, kernel can do the corre=
ct
>  work. To avoid this segment fault, we use glibc function
> "int sigaction(...);" instead, which can fulfill the argument
>  "sa_restorer".

which defeats the purpose of the test.  there is no guarantee that the C=20
library sigaction function is implemented via the __NR_rt_sigaction syscall.

> 2) rt_sigprocmask
>     This failure contains two aspects,
> the first is the segment fault as described in 1),
> the second is that testcase uses a unknown signal 33 for test,
> and this will lead sigaction cannot bind signal 33 to the action.
>=20
>     So, we attempt to use a known signal instead, such as 34.

which is just as bogus and unportable.  if the test needs a real time signa=
l,=20
it should leverage the sigrtmin...sigrtmax defines.
=2Dmike

--nextPart1645673.hmXd1rqyiB
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.13 (GNU/Linux)

iQIcBAABAgAGBQJK+j6zAAoJEEFjO5/oN/WBSEcQAMw80bxEdPWfzSmGZXaNh1fN
AKMjLW18d/lJSyU/Loq2DIZb8ejLOMaqeF09pKmWnV5MQu7cMQoLvNvBpY3W4aV9
sWKOX6H/6vwv9MLMX92c1+3215DsWIzsoxb0UCG08/WEVK3M5xkAkIpITQ5xk65q
UbN3Q+l24rHItUr3RmnLqkk+6GelarHLbpfHVILRu7L2iG1wpHUzhsb2m9QlJvmV
9Gf9vjsF9Xthrm0QqdiYbelgJDL3sciKzv+H/x7v1VdY8PlRuVyifT6qvX7DbKUm
zLUjq6vKD9PoCKguBHyzDJEa608ggkminxTuFa7NdcuVMkv1F3wvL7fGWpxn0nHw
YHqoq9yOw5zrlLueXnag9ATM/EKzAVbz+U7ZFRBjojszwJFwWPD7Tf8fGVQ7LonA
rchfvTaN3s1IdizSRj6t/VcHE3HuSCYsvW3cmaQbTiy7132vAItsLG9c4MBag5qs
AAv3doe5v2cxELow4T34GfFz9SqOAkp3+Y6PZaPYKoZf8FA0Jg1yn6EO7NO57gP5
4oiynIDialMAY9KVxAPsUpY29MUFrPL5XKfdZ8uobCTi93mB5IG6YBvGDKubzdoM
FObn4YqiUZq+jGIfu9YtgMibZUvJ2VU4aqVtje3OaLGTXLoTglyy7o47NB8BfDrz
wnNLorrTj95peLTbkCCU
=BAbC
-----END PGP SIGNATURE-----

--nextPart1645673.hmXd1rqyiB--


--===============3314034010403265224==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--===============3314034010403265224==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============3314034010403265224==--

