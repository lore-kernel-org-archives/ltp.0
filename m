Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1MxZyH-0001oZ-Km
	for ltp-list@lists.sourceforge.net; Tue, 13 Oct 2009 05:30:53 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MxZy0-0002Ac-Vm
	for ltp-list@lists.sourceforge.net; Tue, 13 Oct 2009 05:30:43 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Tue, 13 Oct 2009 01:30:29 -0400
References: <364299f40910122222q5117ecf0i854db292154132c7@mail.gmail.com>
In-Reply-To: <364299f40910122222q5117ecf0i854db292154132c7@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <200910130130.30228.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] convert linktest.pl to linktest.sh
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0961402196207287586=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============0961402196207287586==
Content-Type: multipart/signed; boundary="nextPart2032270.72lktx05yd";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2032270.72lktx05yd
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit

On Tuesday 13 October 2009 01:22:02 Garrett Cooper wrote:
> +do_link() {
> +       pfix=$1; shift
> +       ln_opts=$1; shift
> +       limit=$1; shift

any point in shifting ?  be simpler to just use $1 $2 $3

> +       cd ${pfix}link; \
> +       while [ $i -lt $limit ]; do \

why the line continuation ?

> +                       (( lerrors++ ))
> +               (( i++ ))
> +       (( TST_COUNT++ ))

i think you want:
	: $(( TST_COUNT += 1 ))
-mike

--nextPart2032270.72lktx05yd
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iQIcBAABAgAGBQJK1BB2AAoJEEFjO5/oN/WBBZwP/3TEphALjOxwCLkbEp4XlrN6
Fl/bhS0/45tMIFrVwTa8Xfw+r+uMxrrNuUzhd9OSuoHOl0jgf+PT9Uwg/PiT72Ay
uqD0HFwaOMpgPbeQCzeb2185afL+sXfWOJNX99L4k9+1Ag6RvYyTU3nNOoEb99y7
hR1LfLsuSDbfm8VFLCJRlbFYPIm3z1UjDSGpy0Nz6Sd7CYSSCqKwaDUngjDiv37h
TlB012IVw/ARZijSV9Dq7utu75G1Iy80sz6LOWoF/WiYgxzVEtZ7jzNal7m5rIKu
3mJL0o5tQdPOY9F21sDyg38s7xBwdnbfj2ffceXnKdnm27BHH2x+JOAgLREJ8/is
CFCqSUEmT5yS9asdU/b9WWnzNStA7XoiqS+d9wowujELPojQav4yXi2HvhXXeCf5
I3A9yDOF3PZz01g/T364qRWA25HqfTh9SHBp+C0LVUPUTa2IR+BtKFINZTjmWq4k
nkUaPyLOkKmkKugI35aoXRTd3nvvRdQk0H3oxEZ3qy83rk/gIJlELScNIZl+mnhQ
1e34HagRIBjrdaDILFtkQV8IG4kYUz3sHUJEM+M43SDzZbBLweXbjXIbeSP24h5M
/HBwauwdPn4wFK/CtvLY6C7FKi9quClU6sof71Mw92aon+10/ccoyTKZCDuoCjYl
TPZwEZ7Ay0KzTyK/AdHR
=dBA9
-----END PGP SIGNATURE-----

--nextPart2032270.72lktx05yd--


--===============0961402196207287586==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
--===============0961402196207287586==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============0961402196207287586==--

