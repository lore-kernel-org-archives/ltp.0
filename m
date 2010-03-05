Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1NnfBd-0004KU-Ey
	for ltp-list@lists.sourceforge.net; Fri, 05 Mar 2010 21:35:57 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NnfBc-0000B7-Fz
	for ltp-list@lists.sourceforge.net; Fri, 05 Mar 2010 21:35:57 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Fri, 5 Mar 2010 16:35:45 -0500
References: <20100227075348.GA3077@linux.vnet.ibm.com>
In-Reply-To: <20100227075348.GA3077@linux.vnet.ibm.com>
MIME-Version: 1.0
Message-Id: <201003051635.50233.vapier@gentoo.org>
Subject: Re: [LTP] A note from Maintainer
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5148011969274016073=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Cc: sachinp@linux.vnet.ibm.com, ltp-list@lists.sourceforge.net, doug.chapman@hp.com, ambar.seksena@calsoftinc.com, kamaleshb@in.ibm.com, risrajak@in.ibm.com, Cai Qian <qcai@redhat.com>, Khem Raj <kraj@mvista.com>, aneesh.kumar@linux.vnet.ibm.com, carmelo.amoroso@st.com, jburke@redhat.com, Nadia Derbey <Nadia.Derbey@bull.net>, Balbir Singh <balbir@linux.vnet.ibm.com>

--===============5148011969274016073==
Content-Type: multipart/signed; boundary="nextPart1840967.zLJK2zJu6I";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1840967.zLJK2zJu6I
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Saturday 27 February 2010 02:53:48 Rishikesh K Rajak wrote:
> We are in process of changing our sf.net host repository to
> GIT from CVS.[ Any input/discussion on this is highly appreciable ].

the authorship info really should be fixed before anything is finalized.  a=
nd=20
a git hook added to reject people pushing patches that lack proper=20
author/committer fields.  these commits by "root" are a good example of thi=
ngs=20
that should not be happening.
=2Dmike

--nextPart1840967.zLJK2zJu6I
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iQIcBAABAgAGBQJLkXk2AAoJEEFjO5/oN/WBO7QP/jdu8k+nfe+eQbtCSdeGpxp+
VC6WWsrUU7wPEnJdc7EqHwO3mIIWcsOI20QZlk1rB+ViBVmQEO+9zb8N9yweC6d2
Rk36N6qk+VWmi7pShkhDCTC4x6jmQRGmxU80ZuF4/qMBrvZxWkHFIeEgXJw7EYdP
1UpEOXEEQx/vOYih/7JI8IygKfBiSXBdSslLyxIi/fVX8+mi32x2+5BwK6PBChC+
0+rYwtITCI0Abvc+EM5q7VehKIPIInOiJsfSPyATerA8Xpen+UD5V2kdBnWDqdsm
Bi+dBzSfUpwBr2lMydurDEysSvW9PwYzaLvAWtfReBybJCm+ARq/zS2oxHFYmWFF
60PEsZZ06VOrjSmFbvxD8vTyXQUZOrucyPmSZcRiOGbhkcNH+ZtxMweVONAHpTyC
J7/vTFeAxQ6lCoCjiVcMKvU3SVYBcxu0d25dwUMRHaxGmjadj38p7ZRSQE4JwOvz
dREEkg+02PSLwpdqmLqTNTagMsO14gVf7ID0C7r2zKfThrNiysy7SkMDCInN4f3I
NF7XpQb9Okbz1LM7X9qMeGGqtASZvZYvHss9WpWVvdY6Nr/Ky8NSNFJSzexK5gT5
qxoMIZbBT2ApbQNrL/aiKy22DsrpV+Yz0FfINnaRd5hBdWSeNmElbrbuDRQNa6ZM
bP1GnqdJztccYrJVD0kh
=SOLS
-----END PGP SIGNATURE-----

--nextPart1840967.zLJK2zJu6I--


--===============5148011969274016073==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
--===============5148011969274016073==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============5148011969274016073==--

