Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1VVasS-0008F0-3m
	for ltp-list@lists.sourceforge.net; Mon, 14 Oct 2013 05:39:36 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VVasQ-00041c-Rn
	for ltp-list@lists.sourceforge.net; Mon, 14 Oct 2013 05:39:36 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Mon, 14 Oct 2013 01:39:33 -0400
References: <1381327865-9089-1-git-send-email-maxim.uvarov@linaro.com>
In-Reply-To: <1381327865-9089-1-git-send-email-maxim.uvarov@linaro.com>
MIME-Version: 1.0
Message-Id: <201310140139.35346.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH]  syslog-lib.sh bash posix compliance
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2987040437903866413=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: linaro-networking@linaro.org, Maxim Uvarov <maxim.uvarov@linaro.com>

--===============2987040437903866413==
Content-Type: multipart/signed; boundary="nextPart3746997.Mlnlbf7Wml";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart3746997.Mlnlbf7Wml
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Wednesday 09 October 2013 10:11:05 Maxim Uvarov wrote:
> /opt/ltp/testcases/bin/syslog02: 69: [: syslog-ng: unexpected operator
> + [ syslog-ng =3D=3D syslog-ng ]
> Accoding to:
> http://tldp.org/LDP/Bash-Beginners-Guide/html/sect_07_01.html
> [ STRING1 =3D=3D STRING2 ]  True if the strings are equal. "=3D" may be
> used instead of "=3D=3D" for strict POSIX compliance.
>=20
> Because of busybox and other bash like shells look for posix syntax
> make it so.

pushed, thanks !
=2Dmike

--nextPart3746997.Mlnlbf7Wml
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJSW4OXAAoJEEFjO5/oN/WBOcQP/i7L0/d6sFfkzsz5SdUXKIKH
RLC5nFRDL2IXy8ICr1MhrvHcNPQsWYsWSYHQmGPj1eKgtK9TUclQdZup3oJIv6g0
Vn/p0VW/fB+VUp0shPADo9VJvcXbvECKKnFOPXvog1XsGg5MxkhYbzKUu8YhWXqt
J36ZCB6B/APwKIDfjMVSKRBfLPzPjd50ea4kMLkH7l8Txqd3z4di6IUGGuozBeTO
Go2x+hSQGWw9SkgPupvKxzeiG+Jwoi+Fuxn0BLJfSxeBvJHT0fK6rfYppJpJgcqi
tRbnJVB2cZDkbrvnCML72/TcSyeC7IOx5ZY4yOzGdGIdq7HMBDe5uFiVE73qjEDy
6qEm3suT6Ii5iCAjbOwzCktCVwN8N4nYSK6mQCUnOmwEmjxieKEr7NgS1k6u2rvU
Zo5niXCDrW8AqpBuYEfoaaU7OmlhPt0Urjwi3XRbOHV8pX4Y2SOjTxFR6kEOfufP
KXmqwMw29UbzBCP4I7ilYAt2tNZcgbnc3saB/q4ibFxqWe2OQg38hNOUIZpAcTMU
2p/LV8sX6m4YFjdbgCCFUkWGSrKGm97iYKQXsS4SSlix8kiIFq3WOR6qyRvkD9pD
DvRJtcyw0YtPAPYdVviiP27Kk6KbruPJ2h3d7No2ZDjPAcJrspTX3nkmSQVR4uc8
qtctwA4mLMVO36ZRub/2
=yHIY
-----END PGP SIGNATURE-----

--nextPart3746997.Mlnlbf7Wml--


--===============2987040437903866413==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60134071&iu=/4140/ostg.clktrk
--===============2987040437903866413==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============2987040437903866413==--

