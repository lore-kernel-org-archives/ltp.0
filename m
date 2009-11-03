Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1N5Qll-0000yY-6e
	for ltp-list@lists.sourceforge.net; Tue, 03 Nov 2009 21:18:25 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N5Qld-0008D2-ES
	for ltp-list@lists.sourceforge.net; Tue, 03 Nov 2009 21:18:25 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Tue, 3 Nov 2009 17:19:17 -0400
References: <b9d696240911031223h6734d911s57830e7d859813f9@mail.gmail.com>
	<200911031533.53910.vapier@gentoo.org>
	<b9d696240911031302v7ac8fb27jdf53c159c2ac95f9@mail.gmail.com>
In-Reply-To: <b9d696240911031302v7ac8fb27jdf53c159c2ac95f9@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <200911031619.18266.vapier@gentoo.org>
Subject: Re: [LTP] 20091031 won't run
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============6558599148400526516=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: "K.D. Lucas" <kdlucas@gmail.com>
Cc: ltp-list@lists.sourceforge.net

--===============6558599148400526516==
Content-Type: multipart/signed; boundary="nextPart1331609.ubUgGQSpDW";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1331609.ubUgGQSpDW
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tuesday 03 November 2009 16:02:14 K.D. Lucas wrote:
> I tried to execute runltp as root.
> So in the past I've always extracted and built it in
> /var/tmp/<username>/ltp-full-<version>/
> and I don't think it ever tried to write to /opt/ltp. So this seems like a
> change in behavior.

you said you did `make install`.  it needs to install somewhere and /opt/lt=
p=20
is that somewhere.  maybe this behavior has changed, maybe it hasnt.  all t=
hat=20
really matters is that ltp now behaves like a standard configure && make=20
package.  if you dont like the default of /opt/ltp, then it's up to you to=
=20
select a place you do like.
=2Dmike

--nextPart1331609.ubUgGQSpDW
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.13 (GNU/Linux)

iQIcBAABAgAGBQJK8J5WAAoJEEFjO5/oN/WBbsUQAOK0lZBrnzaDsAjEZNf0yPiX
EbOdSzxBKMp7kdH684QvcCBU/W28+4Q2oDUuPQ1tMo0LMtXs1S/1YM2OvqKLmEf4
dlnvz8yO4BndsEJh25xnF8qU23C7KJEyYenecpp/0MofXpOc1ALM0xmeS6Ti14Xr
zSquD7IRlKw4myga2FXcdDE+9ePQMmPNnMVhPZOK/xtBg/K9PSTG8tKyGKPa3KQm
MHXgUq9nP7m6s1YdR52lyXGfIAoqkwFrvj6cHK9yO8Y8eEiAjo3/epy1hgCn2RKz
jL4kuI9SOajuuz4CtkxD///WglYZiyoI2Bmhn7FAMVlVA3H4cpS0nArEKca1IK3B
0RxrSSlXVU7HxIHh7z9i9NiqsXphimjiBZnS3SF1944PJ1wi9yKRDo/cPXwETONK
JXVj2bhNMiyDIOtX/otu3wHgicUtv0E0mWXYQ91K8f6Xvj+UNNmQhvB/01pIRMB7
J7y2QiMzKMHmkYTawPKiHQYqKEi1n2IXi7rCK72E9pluGB4pruPy6lBX4nBEvc3Y
C1IOa5wgIqQuuNJdImwXYNIKm9Od7kxw5ox47YTqqc78QJL0W6qkBFIot2DhIToM
xq0R+jXh2WVVcZzN7pNTHf7YSnwvccQX4jJOwFk0ePtrUm9Ir0YfRzspKkY+0Xl4
whoOI+8mYDkFlfBNECYl
=bPjp
-----END PGP SIGNATURE-----

--nextPart1331609.ubUgGQSpDW--


--===============6558599148400526516==
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
--===============6558599148400526516==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============6558599148400526516==--

