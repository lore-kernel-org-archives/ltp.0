Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1VFCOG-0008OY-9d
	for ltp-list@lists.sourceforge.net; Fri, 30 Aug 2013 00:16:40 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VFCOE-00028V-Rm
	for ltp-list@lists.sourceforge.net; Fri, 30 Aug 2013 00:16:39 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Thu, 29 Aug 2013 20:16:27 -0400
References: <1377761241-17744-1-git-send-email-anders.roxell@linaro.org>
	<1377761241-17744-3-git-send-email-anders.roxell@linaro.org>
	<CA+icZUWpYYd__ZKdX6SBbbpN9tJHGnywVhrawHo_UJ3ub=3cOA@mail.gmail.com>
In-Reply-To: <CA+icZUWpYYd__ZKdX6SBbbpN9tJHGnywVhrawHo_UJ3ub=3cOA@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <201308292016.29360.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH 2/2] runltp: remove bashisms
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============6052505527603926456=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net, sedat.dilek@gmail.com
Cc: patches@linaro.org

--===============6052505527603926456==
Content-Type: multipart/signed; boundary="nextPart1509137.WzhvWhBYbE";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1509137.WzhvWhBYbE
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Thursday 29 August 2013 04:41:33 Sedat Dilek wrote:
> On Thu, Aug 29, 2013 at 9:27 AM, Anders Roxell wrote:
> > -    echo -e "LOG File: \c"
> > +    echo -n "LOG File: "
>=20
> Yesterday, I looked through diverse GIT repos where I saw a commit
> saying that "echo" (dunno if it was "-e" or "-n") is not
> POSIX-compliant and "printf" should be used.
> I am no POSIX guy, but maybe someone can confirm this?

use `printf` please for both -e and -n issues
=2Dmike

--nextPart1509137.WzhvWhBYbE
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJSH+RdAAoJEEFjO5/oN/WBvwkQAM6zmBnyaouIQADYzVQjJXAc
x6QxetCsiHa4hXuvjR6/2zQpS7Bvpjrr+d592tKnK60Iy0a8+hB8DvYVk+aQnraQ
YRGBgpi5/JQ2x/Vsf4USJdUUU1DhqXnDMv0rTpas9wCxV17j6x0UYGX0hAbX0gqj
pZ+JXm5wVRMjuBgqDtyRUo2/ha5HZl7Ha0+XLB4YmyFrKP0oQ3mlykfH+Iizbmpx
8ZDWySV3nfCfxAhdV6NKMtegxNgWZQgUYYF639jR2PYE/AzUgr9cHLDwJM6hTdKG
JgvT/OnEIqSvalZXj0vcytJ5jrlsIV8AMbZruQq1Fn/e6Ga0o7QRkuap3/mUPZME
KYG/ZVagtt6J0JTxeTDb+NMz8OKuET5qBqUSGQxvUWFNIeyPburwUhCV8rMNeqo/
ZhzgayLIUFHQO8w/UYCZ8UAiWcckR1YNlkGSope1uGj2NAGmUzwJjALEBrA2j3sG
NxGEQSmmlAYmmYil1kWUQA/d+Wjlt3rLh7LQgxDbXwIdgkjFJmaANwpHmC5GM5Ek
RW0KaJO4Ue0No6jYGVdTOj/MH8IBxEc/BNXtoGF9VSd/m1wNiOLmuFSiHGsiD84Q
NB3eBU6xy+ldwxOs4kAREaORM9LLf6BfCHPoRPXmX2gqfDha1+Z7AlmG7nA//sN4
UnEuk9r1ZtXt5u8spekN
=nhtm
-----END PGP SIGNATURE-----

--nextPart1509137.WzhvWhBYbE--


--===============6052505527603926456==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Learn the latest--Visual Studio 2012, SharePoint 2013, SQL 2012, more!
Discover the easy way to master current and previous Microsoft technologies
and advance your career. Get an incredible 1,500+ hours of step-by-step
tutorial videos with LearnDevNow. Subscribe today and save!
http://pubads.g.doubleclick.net/gampad/clk?id=58040911&iu=/4140/ostg.clktrk
--===============6052505527603926456==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============6052505527603926456==--

