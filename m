Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1MSPGD-0002cB-9T
	for ltp-list@lists.sourceforge.net; Sun, 19 Jul 2009 05:48:33 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MSPG6-0005uL-HG
	for ltp-list@lists.sourceforge.net; Sun, 19 Jul 2009 05:48:33 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Sun, 19 Jul 2009 01:48:22 -0400
References: <1247741996.3886.5.camel@dyn9002018117.watson.ibm.com>
	<200907190126.47767.vapier@gentoo.org>
	<364299f40907182235m7bbcc16bka760ffc2d0ae3384@mail.gmail.com>
In-Reply-To: <364299f40907182235m7bbcc16bka760ffc2d0ae3384@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <200907190148.24664.vapier@gentoo.org>
Subject: Re: [LTP] ltp: IMA cross platform fixes
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0492844894460914523=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: waqar afridi <afridi.waqar@gmail.com>, ltp-list@lists.sourceforge.net, Shaz <shazalive@gmail.com>, Mimi Zohar <zohar@linux.vnet.ibm.com>, ltp-list <ltp-list@lists.sf.net>

--===============0492844894460914523==
Content-Type: multipart/signed; boundary="nextPart1418685.mnSmanPvR8";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1418685.mnSmanPvR8
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sunday 19 July 2009 01:35:22 Garrett Cooper wrote:
> On Sat, Jul 18, 2009 at 10:26 PM, Mike Frysinger<vapier@gentoo.org> wrote:
> > On Sunday 19 July 2009 01:15:04 Garrett Cooper wrote:
> >>     /bin/sh should remain the standard, but a number of changes need
> >> to happen to the .sh scripts to make them POSIX compatible, e.g.
> >> backticks execution should become $(), etc. Let's not make things
> >> bash-only...
> >
> > umm, `cmd` is in POSIX
>
>     Not anymore; a fellow bourne shell-ist at work noted that it
> wasn't POSIX compliant anymore, after consulting the POSIX 2001
> reference:
>
> http://publib.boulder.ibm.com/infocenter/systems/index.jsp?topic=3D/com.i=
bm.a
>ix.baseadmn/doc/baseadmndita/korn_shell_comm_sub.htm

what ibm has to say on the topic is irrelevant, as does *ksh* documentation=
,=20
as does outdated POSIX specs (2001 here).  what is relevant is POSIX itself:
http://www.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag=
_18_06_03

$(...) is preferred style wise due to nesting capabilities, but that doesnt=
=20
mean it isnt in the standard.  i still prefer `...` in make scripts because=
 it=20
avoids having to do $$(...) to escape it for make.
=2Dmike

--nextPart1418685.mnSmanPvR8
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iQIcBAABAgAGBQJKYrOoAAoJEEFjO5/oN/WBehgP/2/JACKbw96wkCsfyMKbSZ5Y
OQYpiSb8zy1Ldww/73OXlWkVF1KRNNlmp5KlgfBmjbYNJATgBhHfs1dOit2Q7yke
G08mLgd6x+sT70jFeAjRhxh7g7SvXnhLeNCZHvGs8B0y3BJGK7WIYlgJovz9p4uf
nxdExXtR7sDz/iBRwUpxepjDaY3hwKX9at4UkbprZFjJVmmhozmFbKjdeH9x0lP/
7HvCozG4UU6ErqOpjSZfBtVguX0Fb1yPHpnG+SE6HO9LO/ahTCXaN7q3Zyp/lJd6
sVANt+6OSwT0BpjmP7dWFJUX2cd1caksUYiBc9GDcd0vy8yICmwLkcpLnZwiNRwL
Tuw48KmfXjWq8SEZogA7NcrjmRIvRK4pcGdRywOJrvBp4bsurn2Fdiemr5rQL4tb
D5fxRHGpGaZcDxt3kVKpr/ZGvzKFs1uZ+/4ON7konHNrxif5JJgvOLYA5MaMcGSY
mOuSDTYEf4vCzbK21+e1CX7IP0cgS/CU3diPxUdAEVVjin57RNOto2fK6ss/T5c4
JuFI6+jW37C2Hd4YyvmqEOkpmDMdfUe2/sPDIz503vKdj2VMQkCCpiEVMmG5LeYu
MF9J0Je2xS9YQdcFLB54BRQKkpdf5yjknDT0acCD4Zlz2lP3hFjwBKz96rLHvN/m
1+ibZojHHANjyqvPzfcc
=6pgD
-----END PGP SIGNATURE-----

--nextPart1418685.mnSmanPvR8--


--===============0492844894460914523==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have
the opportunity to enter the BlackBerry Developer Challenge. See full prize  
details at: http://p.sf.net/sfu/Challenge
--===============0492844894460914523==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============0492844894460914523==--

