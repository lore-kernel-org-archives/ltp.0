Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1MbV7i-0000mb-A0
	for ltp-list@lists.sourceforge.net; Thu, 13 Aug 2009 07:53:22 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MbV7b-0000Di-U1
	for ltp-list@lists.sourceforge.net; Thu, 13 Aug 2009 07:53:22 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Thu, 13 Aug 2009 03:53:08 -0400
References: <4A76D6DD.4020401@petalogix.com>
	<20090803151449.GA29794@us.ibm.com>
In-Reply-To: <20090803151449.GA29794@us.ibm.com>
MIME-Version: 1.0
Message-Id: <200908130353.09371.vapier@gentoo.org>
Subject: Re: [LTP] clone01 -c 10 on x86
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0453235702830964147=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============0453235702830964147==
Content-Type: multipart/signed; boundary="nextPart29793542.1gU4s47hcT";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart29793542.1gU4s47hcT
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 03 August 2009 11:14:49 Serge E. Hallyn wrote:
> Quoting Michal Simek (michal.simek@petalogix.com):
> > can you please to run clone01 syscall test on any x86 machine? I am
> > getting fault there when I run it 10 times for example.
> > The same problem I have on Microblaze.
> >
> >  ./clone01  -c 10
> > clone01     1  TPASS  :  clone() returned 22738
> > clone01     1  TPASS  :  clone() returned 22740
> > clone01     1  TPASS  :  clone() returned 22742
> > clone01     1  TPASS  :  clone() returned 22748
> > clone01     1  TPASS  :  clone() returned 22750
> > clone01     1  TPASS  :  clone() returned 22752
> > clone01     1  TPASS  :  clone() returned 22754
> > clone01     1  TFAIL  :  clone() returned 134919589, errno =3D 22755
> > [monstr@monstr clone]$ clone01     1  TPASS  :  clone() returned 22744
> > clone01     1  TPASS  :  clone() returned 22746
>
> All right I don't have the patiente to wade through the parse_opts
> and usc_lib crap, but this is not a clone failure.  What appears to
> be happening is setup() at the top of clone01.c is calling
> lib/parse_opts.c:usc_global_setup_hook(), with STD_COPIES set to the
> count option you passed in.  That forks of 10 copies of the test.
> I don't know what happens with the actual loop then, but the reason
> you get the error for the last clone test is that one of those
> forked copies of clone01 (*not* one of the cloned children) exits,
> and wait() catches that one.  That is why wait() returned 22744,
> which isn't any of the cloned children.
>
> So one stupid way of fixing this without dealing with the convoluted
> setup junk would be to change the waitpid chunk of the code like so:

since there is no wait*() func that i'm aware of that says "only wait for=20
children/siblings", we need to create a dedicated process group for each te=
st. =20
do we know if any LTP test relies on process groups via the -c option ?  i=
=20
highly doubt this, so i'd propose we add a call to setpgid() in the parse_o=
pts=20
code that does the forking so that every child is in its own process group=
=20
(just like if -c isnt used at all).  then the clone01 test should magically=
=20
work without any changes as should any other test that uses wait*() funcs.
=2Dmike

--nextPart29793542.1gU4s47hcT
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iQIcBAABAgAGBQJKg8ZlAAoJEEFjO5/oN/WBrzsP/RDuOKol0IHVynbIR6XBkNBI
pH77gq0sLPzJbXA8QNE9YqkRJMBz6nOHPvzJc/lbUN0O0T1scXyrT0Iaw7e1X6ho
MYCQ1l1HwFIMYz0UpRHYnyofKdrywGuANxCubxC43SKnDshQ8Lq3y+ZmLT4dIHlC
OaO8Pq3gNZl9fewYh1VhAljAQ6oyRzweoeQPOhnmMjUtJd1yelSsEfZ5fQlKNLlk
mlXc06LIOmEJeKBjP9UK6mmo+QOJ8HUMZjCz+LaXvc2h8xV+eqiIKL0qQUdJ60Rl
x50wv7jDUZQUUQpMw+43zCaYCi4dMqcqaTss5fzM9gOIrFurxcFgNe+XCBMuhGgP
FYSd9wqGbWpj6vAFv6XcekJVhAbVZUnFcND6/RgKII2P8Iun9V3rS6hzH9lBfPLl
rOVOUxXnzpbmCTlHYPlQdJc9uhlI1WKwJ/z9uJo+KXwNvl+VVnfrIDEeT98dNfhM
YKKsFLC3UphOkKn0HiMA3BRybXY0hvk3XWAGhQvcwtghDd+lQ1PXRhx9wkvYgHPL
HI9+CKoIgNBSlQO0I3xCSiS1yDZQnJIp6VVSSoYRCdrV8A27PY03mESuEfuXvSWr
TG+V2e8UiAPKrAQwLa44ypmaek7POenzpIgNAHbn/VlNuUn+5IM2VXipiYN1S+9N
Xnvr03RZ/0ErpGzt6dmb
=XMjY
-----END PGP SIGNATURE-----

--nextPart29793542.1gU4s47hcT--


--===============0453235702830964147==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--===============0453235702830964147==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============0453235702830964147==--

