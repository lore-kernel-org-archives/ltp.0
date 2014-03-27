Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1WT4jF-0000u7-2A
	for ltp-list@lists.sourceforge.net; Thu, 27 Mar 2014 07:27:57 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WT4jE-0000QD-6J
	for ltp-list@lists.sourceforge.net; Thu, 27 Mar 2014 07:27:57 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Thu, 27 Mar 2014 03:27:49 -0400
Message-ID: <1726286.IeLLt5ULzV@vapier>
In-Reply-To: <533396DD.4090703@oracle.com>
References: <533396DD.4090703@oracle.com>
MIME-Version: 1.0
Subject: Re: [LTP] hardcoded network interface name
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5999229921941968942=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net


--===============5999229921941968942==
Content-Type: multipart/signed; boundary="nextPart1676282.2l1Zpalmgj";
	micalg="pgp-sha1"; protocol="application/pgp-signature"


--nextPart1676282.2l1Zpalmgj
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

On Thu 27 Mar 2014 11:11:25 Simon Xu wrote:
> ip_tests.sh has hardcoded 'eth0', which doesn't work with biosdevname=

> such as 'em', 'enp' etc.  Do we have a  canonical way to fix this kin=
d
> of issue in LTP?

rename your device ;)

i wonder if that script needs an external device ... a glance says no. =
 so=20
it'd probably be saner to:
=09- use lo instead of eth0
=09- change the 10.x addresses to 127.x
=2Dmike
--nextPart1676282.2l1Zpalmgj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAABAgAGBQJTM9L1AAoJEEFjO5/oN/WBNbwP/2Bz9V3Y4Ux+XHX4r6N3At63
WwTqXirXYKZsetPKRn0t/owftz7AKueOWpmRWxsqB5ubH5Pvvmtg7SWxo+Hw+zdX
L80tshUZNTrDBzuwduR68U4EHRWomHrJKGKJiZj49oADplq0L43IGzAM9JMHduko
sMSE3Rit7HvTkQEJJI2pkeqDDQWpdd5dMczccoOFLoukGzCdeJiDbwCixCpczc2B
pMqDWLhOOrSgMIoI1GdMIy9aCLii10m2gO0SGopW3EcQcplH+qgUPAm57zZFd7kv
8Npv3sGkShg6kb0YH96zj0Omrl9JrnYIpJa0QWsEoF/5x/KovlAF15g4o9CsNYUb
Fal3aFYQv5g+1IclMo8+cQ6cjv4An4ku4jTXR2Y+3CdBaFwmvmC5rbCw4FoMh7yV
a3XhXkvOPNzhviM0cWu9O5c+VikipH1kk9X4Rry+6SAaieRPHKYsWrk+RNTpwzoH
hei2df7Cep9Zw5OMFK8LG/bmKR2m8H9C8CVoSTOo63E+VOJ/Y+5jmA2+SUlcSWdl
66IDFfg3Y7QLLPfy/KWP6OLDR+fwUdSSSdcmW+i1rBISq9oUqR7EkrfBaicOQAM1
gAT9m+ow/cljrcCBGRMjp7d4bosEgU8avqy6T1FjfNeYtc8z5wLwMhlZXriRb1WI
eQuBvNGgmMhfA/ZwnBRh
=RiiA
-----END PGP SIGNATURE-----

--nextPart1676282.2l1Zpalmgj--



--===============5999229921941968942==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--===============5999229921941968942==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============5999229921941968942==--


