Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1OTKV2-0003jQ-7y
	for ltp-list@lists.sourceforge.net; Mon, 28 Jun 2010 20:00:12 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OTKV1-0003HY-8U
	for ltp-list@lists.sourceforge.net; Mon, 28 Jun 2010 20:00:12 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Mon, 28 Jun 2010 15:52:17 -0400
References: <20100628115217.23913.32352.sendpatchset@subratamodak.linux.ibm.com>
	<201006281544.13666.vapier@gentoo.org>
	<AANLkTinzjwlLcX6zJ30Fxu9UjondsMavX21qXKfov840@mail.gmail.com>
In-Reply-To: <AANLkTinzjwlLcX6zJ30Fxu9UjondsMavX21qXKfov840@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <201006281552.18057.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] Remove files which does not have a dmesg entry
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5836300660772856933=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: LTP List Members <ltp-list@lists.sf.net>

--===============5836300660772856933==
Content-Type: multipart/signed; boundary="nextPart2298121.KjHffSfGpA";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2298121.KjHffSfGpA
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Monday, June 28, 2010 15:47:27 Garrett Cooper wrote:
> On Mon, Jun 28, 2010 at 12:44 PM, Mike Frysinger <vapier@gentoo.org> wrot=
e:
> > On Monday, June 28, 2010 07:52:18 Subrata Modak wrote:
> >> +     if [ $ALT_DMESG_OUT -eq 1 ] ; then
> >> +             PWD=3D`pwd`
> >> +             cd $DMESG_DIR
> >> +             for dmesg_file in `ls`
> >> +             do
> >> +                     dmesg_file_size=3D`wc -c $dmesg_file | cut -d ' '
> >> -f1 | tr -d
> >=20
> > '\n'`
> >=20
> >> +                     if [ $dmesg_file_size -eq 0 ]; then
> >> +                             rm -rf $dmesg_file
> >> +                     fi
> >> +             done
> >> +             cd $PWD
> >> +     fi
> >=20
> > ugh.  what's wrong with simply executing:
> >        find "$DMESG_DIR" -size 0 -exec rm {} +
>=20
> Or find "$DMESG_DIR" -size 0 | xargs rm -f ?

no, because mine handles funky named files while yours does not.  both are=
=20
POSIX and handle command line length issues correctly.
=2Dmike

--nextPart2298121.KjHffSfGpA
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)

iQIcBAABAgAGBQJMKP1xAAoJEEFjO5/oN/WB/PYQAL9TbokC32vBkEAv7Uw15YFZ
AzlvUEcjV/1+l3VCGBMsQqbSFoI2QnpaCvxV5BG6uHWENQA3c/xSkYCeTP9hjn+v
xEDo7i1Eepn0PKs1S4vm8MVnvghHXyOZjpXwG6hGjjqLU1wPq+xmU6DvHIc/17JP
echQPD52lIySadrzwetVZ1tok0Y2APq5xMMh43pnPrC9HERhQA5c+3EUeOSfpBRL
43WlbNLjHFfoeDHM1paahUfXqbsl3nW4wqkxrE4JdUhACk126PM++nhpAh1wlhoG
gtLXXVud7qcR5pL9Hui7GKoFzUXTeAIhck3vcauXvkEHGW7o43IFmoTuHSFD/SZG
bwUezNcojwnePn8Y075DNLWnf/4Npofk6Izz5xtyvaNzLgBm6whuko92OoMevc0t
QLYRr5xrV+k6qkVcuH04xE/1JuHtRxhNWfvA02YLkY2sbh6+cI0qB2WvR68XKiZl
Iw2jDmirqUGLuRF1dOYW2xRz4JnZeXRlvGe0ltqE/E8heRpWAxW1U15QSQ5vrnDl
4Cc/fTeXYMt6RWYdrbfeXf4ZUfGQD46pJzk9YPmdm0C224a1XUAYCg4z7CDBKOks
CLcha+nkSlL56TGDznrG3HlcnU3KPkGYWydcZjA0Tj3tP3dGbRBpFVhRA6+BpIZP
J+J1VS9aGv4Faon01DoU
=d0Wu
-----END PGP SIGNATURE-----

--nextPart2298121.KjHffSfGpA--


--===============5836300660772856933==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
--===============5836300660772856933==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============5836300660772856933==--

