Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <cristian@regolo.cc>) id 1PvDjX-0005WO-Hq
	for ltp-list@lists.sourceforge.net; Thu, 03 Mar 2011 18:58:43 +0000
Received: from aiolia.regolo.cc ([178.79.135.37])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1PvDjW-0006Ir-Dl
	for ltp-list@lists.sourceforge.net; Thu, 03 Mar 2011 18:58:43 +0000
Received: from regolo (93-46-12-129.ip105.fastwebnet.it [93.46.12.129])
	by aiolia.regolo.cc (Postfix) with ESMTPSA id 391BF64
	for <ltp-list@lists.sourceforge.net>;
	Thu,  3 Mar 2011 19:58:36 +0100 (CET)
Date: Thu, 3 Mar 2011 18:42:23 +0100
From: Cristian Greco <cristian@regolo.cc>(by way of Cristian Greco
	<cristian@regolo.cc>)
Message-ID: <20110303184223.23ac427e@regolo>
In-Reply-To: <4D6FCCF7.2010101@redhat.com>
References: <20110120143028.4df7ab81@regolo>
	<AANLkTikt-TBmgTSqcRT4OY21udzxpuq-s0yGqirMrWFr@mail.gmail.com>
	<4D6FCCF7.2010101@redhat.com>
Mime-Version: 1.0
Resent-Message-ID: <20110303195833.28a233b5@regolo>
Resent-To: LTP - Linux Test Project <ltp-list@lists.sourceforge.net>
Subject: Re: [LTP] [PATCH] syscalls: acct01: fix testcases [was: Re: [PATCH]
 Add tst_require_root to acct01 testcase.]
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============7475981150136298055=="
Sender: ltp-list-bounces@lists.sourceforge.net
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Caspar Zhang <czhang@redhat.com>

--===============7475981150136298055==
Content-Type: multipart/signed; micalg=PGP-SHA256;
	boundary="Sig_/.PMsjAI94TA_G8auhm+M2xn";
	protocol="application/pgp-signature"

--Sig_/.PMsjAI94TA_G8auhm+M2xn
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 04 Mar 2011 01:16:39 +0800
Caspar Zhang <czhang@redhat.com> wrote:

> On 01/21/2011 04:28 PM, Garrett Cooper wrote:
> > On Thu, Jan 20, 2011 at 5:30 AM, Cristian Greco <cristian@regolo.cc> wr=
ote:
> >> > Hi,
> >> >
> >> > [ please keep CC as I'm not currently subscribed to the list ]
> >> >
> >> > please find attached a small fix to check for root privileges in
> >> > acct(2) testcase (syscalls/acct/acct01.c).
> >     Thanks for spotting the issue. I've fixed it, added a few more
> > testcases, and discovered what appears to be a kernel bug on 2.6.34
> > (acct("/tmp/does/not/exist") should fail with =3D=3D -1 and errno =3D=3D
> > ENOTDIR) :)...
> > Cheers,
> > -Garrett
>=20
> a follow-up fix for http://article.gmane.org/gmane.linux.ltp/13576 .
> In fact, it's not a kernel bug of ENOTDIR's failure. ENOTDIR means that
> you setup a string as directory in argument, but it is actually a file.
> The patch fixes this failure. The result of given path
> /tmp/does/not/exist should be expected as ENOENT.
>=20
> And also, there is a mistake in EPERM case, to restore the permissions,
> SAFE_SETUID should be used instead of SAFE_SETGID, else it will never
> recover the permissions.

Hi Caspar,

I noticed the error today but did not have time to work on it.

Thanks for your work!
--
Cristian Greco
GPG key ID: 0xCF4D32E4

--Sig_/.PMsjAI94TA_G8auhm+M2xn
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCAAGBQJNb9L/AAoJEID329zPTTLkVd4P/144ju+5fdfZXCyJ09tnzIVj
sXDmJJB4eQREyO8Fw1KGP+w2v2YZ9eV45iXgIshlajBLsGp2ZlHEnwYuEQtLWfsW
b0fOg0f1gN4AFPiODz/jPkC55Ylk45SU3yJoHyKISJnWfPGkox1WAv4YBDTNM4c6
4pdaXIzg2iyFGAIy08RNkuka+N79Kuec9vCnLNUVKUDyxGDhaOiWNvo4Xcltz7No
Efp5ZfxuN6szmiCk7/Z51hkcUCo/UAX89yllX2xFVta0N3TATMjpkJVOcunvdLEg
USIUQmL5qTgnUDEiDfb95Xk02Xqo8LCjR0spz3jLsampZQg2dclvKyyTBSUxqr7y
n12DXinXF8erZxdaWXVhB6Kt2hkn2W1vV5KoCUEUt6YtfHabKCIl7733rvF5i+pp
hAGlf11JbPp4vV6j0HGf8VH1e/geMtZ7rnmZiZDL4uPqhLpNSo+dcdnHRkhD3Pyr
AJK9fxajb0sIeNbqTJEelUhpQ845TuckVptQ66sBfnroo1FzTBEgA6QXZlxpMd9m
bmu1pbDZmiCbA42AFptcsQRfuDIDoJq05EAK5h1ZkroVLpph+OZisTkXIfVR4cRo
IIxjNkuzVZu+dGyouoUxTIf9tUcK5iufQ7E206219IqBjmBc4gCcGb5h82gNwywF
26eTFTLIxwukf3S3yFgq
=VXt5
-----END PGP SIGNATURE-----

--Sig_/.PMsjAI94TA_G8auhm+M2xn--


--===============7475981150136298055==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Free Software Download: Index, Search & Analyze Logs and other IT data in 
Real-Time with Splunk. Collect, index and harness all the fast moving IT data 
generated by your applications, servers and devices whether physical, virtual
or in the cloud. Deliver compliance at lower cost and gain new business 
insights. http://p.sf.net/sfu/splunk-dev2dev 
--===============7475981150136298055==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============7475981150136298055==--

