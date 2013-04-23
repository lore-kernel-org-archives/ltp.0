Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1UUfqf-00026C-W7
	for ltp-list@lists.sourceforge.net; Tue, 23 Apr 2013 16:13:42 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1UUfqe-0001j4-Se
	for ltp-list@lists.sourceforge.net; Tue, 23 Apr 2013 16:13:41 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Tue, 23 Apr 2013 12:13:31 -0400
References: <8a4fb5929c599b2dec955086713069c20f95c466.1366704928.git.jstancek@redhat.com>
In-Reply-To: <8a4fb5929c599b2dec955086713069c20f95c466.1366704928.git.jstancek@redhat.com>
MIME-Version: 1.0
Message-Id: <201304231213.33013.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] syscalls/cma: add runtime check to setup()
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2175703007824262596=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============2175703007824262596==
Content-Type: multipart/signed; boundary="nextPart1518673.6dP3JKfrVq";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1518673.6dP3JKfrVq
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

On Tuesday 23 April 2013 04:17:15 Jan Stancek wrote:
> __NR_process_vm_readv / __NR_process_vm_writev defined doesn't
> guarantee, that kernel supports these syscalls. Add check to setup(),
> which uses ltp_syscall(). If syscall isn't supported it will
> end the testcase with TCONF.

delete all the "#else" branches since you're now using linux_syscall_numbers.h
-mike

--nextPart1518673.6dP3JKfrVq
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJRdrMsAAoJEEFjO5/oN/WBI7EP/ix3V2iWMbf5BK9xkmQSrqKX
lLFMwJRDjvTQUz1eOdwZFZPqUMN4uMYY2ADXE4p3OBrmAH4/voYA+dEK5LV349tR
u516V701yqenHKwdcsZNbTaNBvBOQvmxyrFytldec10bPrawmFGfcPrH8anmrNhs
D7W5rMfK0Oq3F6aHoQQJmiLyWbomiOGtJI4BRSuQoouXhp51ZsvrR+pN1snG298L
Ui4KG8SCzrnHvTxB2xQS7kiq0hp/amFd97qWkf6qobchIrjhM6k24CD3p0BnmrAK
SCJFZE4aY1HjTYnI1MyfxThC99X3j0dxltlpSpVa8XDK6Dv8JIiXKgF0s21DrD/L
IQ5T57VuC0/w2VJPyUir5RM+WtYylMLpNgEGhL5+KwScyEfzBBzF251u0bdR2mBo
aKUB9ltZMFy6QAWegWyjI0oaeACWtVvffnd7M1AovOacsxjEdM5ge1Z2L5ruwiZd
0zjGX86RapyhmC2+dAh104jlsbg8kBDowyobL7FVgi3Kh2Wf8n35WcJY+SjeCBHp
nAEqXDFKGnrKkR86JALSg0TOfgRGabfgvJL9yK9K0EDIrSJzWIj97JxiwPg47MPJ
OgkpSGdEe7V20DHjTK3cB/lq+NQyZNLywr2ggiapkro1qXJtH7Hy8iAo/L0Tq3xc
doqMqxw5d18Gu+VK43zK
=tI92
-----END PGP SIGNATURE-----

--nextPart1518673.6dP3JKfrVq--


--===============2175703007824262596==
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
--===============2175703007824262596==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============2175703007824262596==--

