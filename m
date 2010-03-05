Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1Nne9H-0001gv-PO
	for ltp-list@lists.sourceforge.net; Fri, 05 Mar 2010 20:29:27 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Nne9G-0001h1-S6
	for ltp-list@lists.sourceforge.net; Fri, 05 Mar 2010 20:29:27 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Fri, 5 Mar 2010 15:29:19 -0500
References: <000301cabb68$7fb08c30$7f11a490$@co.jp>
In-Reply-To: <000301cabb68$7fb08c30$7f11a490$@co.jp>
MIME-Version: 1.0
Message-Id: <201003051529.20596.vapier@gentoo.org>
Subject: Re: [LTP] Is there another method to download?
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============8682521891215920639=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: Mitani <mitani@ryobi.co.jp>

--===============8682521891215920639==
Content-Type: multipart/signed; boundary="nextPart1724440.Ebe15ToyVn";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1724440.Ebe15ToyVn
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Thursday 04 March 2010 02:01:22 Mitani wrote:
> I tried to get source by using GIT.
> But It failed with following message:
>=20
> ------------
> # git clone git://ltp.git.sourceforge.net/gitroot/ltp/ltp-dev.git ltp-dev
> Initialized empty Git repository in /home/mitani/wk/ltp-dev/.git/
> fatal: Unable to look up ltp.git.sourceforge.net (port 9418) (Temporary
> failure in name resolution)
> #
> ------------
>=20
> It seems to be caused by the fact that port 9418 does not open.
> This is a problem by me.
> But I think that there are some companies which don't open a port 9418
> due to the security. I think that it becomes the problem in those
> companies that GIT cannot be used.
>=20
> I'm saved very much if there is the method to download via HTTP.

we have no control over this.  talk to sf.net about the issue.

in the meantime, use the gitweb interface to download snapshots.
=2Dmike

--nextPart1724440.Ebe15ToyVn
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iQIcBAABAgAGBQJLkWmgAAoJEEFjO5/oN/WBwmoP/27XIwkpCpoiEwlBJmDGzUv5
W4fMDfB3e/NEX1mxt5auAzO562LxVMdzC5aDzGprbcnACBje7/bnxYkne2aVx394
bFkXxzxwzkgcfMNIyfUjVkP4EjZBG888zU6/oxSXwQDxbuR94ooimSL+7/X33vtw
tM0oRM9mJ8VNGDwPNFvZaAn4eU+TY5gV3r+9l4t25AVwOSuxCcCPBAsGneukUvzK
yXMEL/dkjxqSMhKafqzg+MGvy1glOnDnXDr5b5DwphFyRf6dye+MamyRymnB0g1P
UoeXpOcgNSj82IzwpaaUo6soeuGLpVQiVoykhJrdCyg/3W/oiHRIzahu7PjJhenL
5gDnkaXizoTvXoMFPE2jfyURVWUZaZGpBw4U5fnKFtirPxnahPvAvy+thIlcarNq
8joviN9wpm5RBetn+ykqlhmZ3h8V4HKUiXR4ZDRUlhww5wf3Xe4SrMy7F+/uFRS3
5r8ZFF+aEMz0zI2tPg+GCh2TBZWmd6GGwBwrNFw2ZJQrnqCwFkM0PfbBG1Rj/OMA
AkMDtj1BkvyXoCpqzFCqZpP30rpt/gkGnYTPrNRW0QsGRXMCtyWPNlm1GnEOS2SA
o0C0d8J81P25SuFG8cZTQRE4MgHmDMm9IqkEhVB0pTGF/Hvqa1SHCjGZNPedyEf/
OAsf9ZfVmXBoCmXm9jLD
=zhMw
-----END PGP SIGNATURE-----

--nextPart1724440.Ebe15ToyVn--


--===============8682521891215920639==
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
--===============8682521891215920639==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============8682521891215920639==--

