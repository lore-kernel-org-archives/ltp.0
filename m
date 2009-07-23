Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1MTmBD-0007c7-DZ
	for ltp-list@lists.sourceforge.net; Thu, 23 Jul 2009 00:29:03 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MTmB9-0001Tx-CL
	for ltp-list@lists.sourceforge.net; Thu, 23 Jul 2009 00:29:03 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Wed, 22 Jul 2009 20:28:53 -0400
References: <1247741996.3886.5.camel@dyn9002018117.watson.ibm.com>
	<364299f40907182215q56ff7c3au5971afb877d4aa15@mail.gmail.com>
	<1248297619.3714.10.camel@dyn9002018117.watson.ibm.com>
In-Reply-To: <1248297619.3714.10.camel@dyn9002018117.watson.ibm.com>
MIME-Version: 1.0
Message-Id: <200907222028.55612.vapier@gentoo.org>
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
Content-Type: multipart/mixed; boundary="===============3669260782053298539=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: ltp-list <ltp-list@lists.sf.net>, Shaz <shazalive@gmail.com>, waqar afridi <afridi.waqar@gmail.com>

--===============3669260782053298539==
Content-Type: multipart/signed; boundary="nextPart3341116.pZG4hqOCOo";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart3341116.pZG4hqOCOo
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 22 July 2009 17:20:19 Mimi Zohar wrote:
> testcases/kernel/security/integrity/ima/tests/ima_policy.sh
>
> -		if [ "${line:0:1}" !=3D "#" ] ; then
> +		firstch=3D`expr substr "${line}" 1 1`
> +		if [ "${firstch}" !=3D "#" ] ; then

the `expr` util, while pretty flexible, tends to not get used.  so it'll=20
probably be easier for people to grok:
	if [ "${line#\#}" =3D "${line}" ] ; then

> -	RC=3D$((`expr $RC1 + $RC2`))
> -	if [ $RC -eq 1 ]; then
> +	if [ $RC1 -eq 0 ] && [ $RC2 -eq 0 ]; then

i dont see what was wrong with the original here, but if you really want to=
=20
rewrite this, then just change the one line to:
	RC=3D$((RC1 + RC2))

> testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
>
> +	zero=3D"0000000000000000000000000000000000000000"
>
> +	ima_aggr=3D`expr substr "${line}" 49 40`
>
> -		[ "${line:49:40}" -eq 0 ] || RC=3D$?
> +		[ "${ima_aggr}" =3D "${zero}" ] || RC=3D$?

these changes arent exactly equivalent.  if the subst of line only returned=
=20
say 5 zeros, then your check wouldnt work.  do you even need this ?  simply=
=20
changing the line to ima_aggr via substr looks good enough to me.  this sho=
uld=20
work fine in POSIX shells:
	[ "00000" -eq 0 ]

> testcases/kernel/security/integrity/ima/tests/ima_violations.sh
>
> +			tst_res TINFO $LTPTMP/imalog.$$\
> +			 "$TCID: (message ratelimiting?)"

this shows up a few times in the patch ... if you're going to line wrap=20
things, there needs to be a space before the continuation marker for style.
=2Dmike

--nextPart3341116.pZG4hqOCOo
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iQIcBAABAgAGBQJKZ67HAAoJEEFjO5/oN/WBzPEQALmuO1NsxBY+n73F3Pw5efKF
pKFdhsavTbbC0vMqoZAtal1Y/cOWonGdkuG8eSsYZOgCxCy6PanNfuZO+KJBXIY6
Y7MkcoJ9cSQkcwNI9JMlfo2TRlAnlAg/IbCcCR/890DS/pzx0ejy5L7TMASGodJ6
O50dTFwUdNo2Qd2qbV0qePUtD3Z6XZQZZxmeRSJXa8qTLAvin4CkfHESOvl3cWXh
+0smljvxUKCCjZBbN6is3l/Ip+w02JZWRNp8yyed4ZP74GdUGsauV6TGc2WK1kZ2
G23heu7A5FUjIqFwR133C/MNff8spaUeBl/00PyxyeEa0mwshB/+JPav36zqg7cz
NHZtZ6/otJiRZDZO5oHFClEIxUeEvFNLIi8Wc6RpGVPL1IhsiZQCbhAUzzRitr6r
pDCeAHcpwx/KGftrdD0tKaVNROJSQNV0njCetuMH9Gm6OY9Ee6M8zAF1Y9HDefPa
tKE/1+oGDHMdr3caOgXWSY61Tb7PSt83ZQ0YJ/zVftgKKBUb8wvXA9zOnD3bHzDQ
xkUkTzGxobF+RHwIGaTSz94p79N1B24dz0u83/76H/sIR+O8lK0dfKCSN9HlpWiu
YCZfvRib15aQUE18QAwvKIYJtZmXSJeDKt/q00ZoCEgjuluyC2qfS9ytviQGrE3Y
tehz9H1VsO6Qp3PlKRK4
=KW/W
-----END PGP SIGNATURE-----

--nextPart3341116.pZG4hqOCOo--


--===============3669260782053298539==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--===============3669260782053298539==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============3669260782053298539==--

