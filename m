Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <Valdis.Kletnieks@vt.edu>) id 1MODTZ-0004aZ-2D
	for ltp-list@lists.sourceforge.net; Tue, 07 Jul 2009 16:25:01 +0000
Received: from turing-police.cc.vt.edu ([128.173.14.107])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MODTT-0003Rv-Mv
	for ltp-list@lists.sourceforge.net; Tue, 07 Jul 2009 16:25:00 +0000
In-Reply-To: Your message of "Mon, 06 Jul 2009 16:16:11 +0200."
	<200907061616.12220.arnd@arndb.de>
From: Valdis.Kletnieks@vt.edu
References: <4A4DFB77.1080700@petalogix.com>
	<20090706121455.GA16908@linux-sh.org>
	<4A51F3F3.6040501@petalogix.com> <200907061616.12220.arnd@arndb.de>
Mime-Version: 1.0
Date: Mon, 06 Jul 2009 20:44:57 -0400
Message-ID: <105602.1246927497@turing-police.cc.vt.edu>
Subject: Re: [LTP] mmap syscall problem
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============6891913548917157468=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Arnd Bergmann <arnd@arndb.de>
Cc: LTP <ltp-list@lists.sourceforge.net>, Linux Kernel list <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Paul Mundt <lethal@linux-sh.org>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, John Williams <john.williams@petalogix.com>

--===============6891913548917157468==
Content-Type: multipart/signed; boundary="==_Exmh_1246927497_3046P";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit

--==_Exmh_1246927497_3046P
Content-Type: text/plain; charset=us-ascii

On Mon, 06 Jul 2009 16:16:11 +0200, Arnd Bergmann said:

> What happens in a simple user space program that mmaps the same
> page to two addresses? Something like
> 
> #include <sys/mman.h>
> #include <fcntl.h>
> int main(void)
> {
> 	int fd = open("existing-4k-file", O_RDWR);
> 	char *p1 = mmap(0, 4096, PROT_READ | PROT_WRITE,
> 				MAP_SHARED, fd, 0);
> 	char *p2 = mmap(p1 + 4096, 4096, PROT_READ | PROT_WRITE,
> 				MAP_SHARED | MAP_FIXED, fd, 0);
> 
> 	*p1 = 0xaa; *p2 = 0x55;
> 
> 	return *p1; /* returns 0xaa if broken, 0x55 if correct */
> }

Strictly speaking, doesn't that need a barrier of some sort between the two
assignments?  I mean, how is gcc supposed to intuit that p1 and p2 alias
each other and it needs to reload *p1 before returning that value?

(And in more complicated code, I could even see the compiler re-ordering those
two assignments, so the in-file value is different as well as the return; value)


--==_Exmh_1246927497_3046P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFKUpqJcC3lWbTT17ARAvPDAJ4g0SupREDNuIl1wjEqFIcy5X6NaQCfQr7f
0kk4F9TjsIAuVNY2rd6J1rk=
=O+9H
-----END PGP SIGNATURE-----

--==_Exmh_1246927497_3046P--


--===============6891913548917157468==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have 
the opportunity to enter the BlackBerry Developer Challenge. See full prize 
details at: http://p.sf.net/sfu/blackberry
--===============6891913548917157468==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============6891913548917157468==--

