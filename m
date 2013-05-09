Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1UaTcb-0003Fl-Nv
	for ltp-list@lists.sourceforge.net; Thu, 09 May 2013 16:23:09 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1UaTcb-0003lt-1W
	for ltp-list@lists.sourceforge.net; Thu, 09 May 2013 16:23:09 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Thu, 9 May 2013 12:22:51 -0400
References: <518B618F.80400@cn.fujitsu.com>
In-Reply-To: <518B618F.80400@cn.fujitsu.com>
MIME-Version: 1.0
Message-Id: <201305091222.52821.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH 1/2]semctl/semctl01.c: cleanup
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============7652368171346113660=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============7652368171346113660==
Content-Type: multipart/signed; boundary="nextPart1597626.Qo76rEhSt6";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1597626.Qo76rEhSt6
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Thursday 09 May 2013 04:42:55 DAN LI wrote:
> --- a/testcases/kernel/syscalls/ipc/semctl/semctl01.c
> +++ b/testcases/kernel/syscalls/ipc/semctl/semctl01.c
>=20
>  /*
> @@ -24,32 +23,6 @@
>   * DESCRIPTION
>   *	semctl01 - test the 10 possible semctl() commands
>   *
> - * ALGORITHM
> - *	create a semaphore set with read and alter permissions
> - *	loop if that option was specified
> - *	  loop through the test cases
> - *	    do any setup required for the test case
> - *	    make the semctl() call using the TEST() macro
> - *	    check the return code
> - *	      if failure, issue a FAIL message.
> - *	    otherwise,
> - *	      if doing functionality testing
> - *		call the appropriate test function
> - *	  	if correct,
> - *			issue a PASS message
> - *		otherwise
> - *			issue a FAIL message
> - *	call cleanup

i don't see high level DESCRIPTION/ALGORITHM as "useless".  why do you ?

>   * HISTORY

on the flip side, HISTORY is pretty useless.  that's what `git log` is for.
=2Dmike

--nextPart1597626.Qo76rEhSt6
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJRi81cAAoJEEFjO5/oN/WBdvoQAJcJCwus2SS3cnlJ20z47H9C
fsP5uJTiH/y+GDmiISsxkUpTgOjXMC0Bc1eCXav8ZAVOn2R5TMrFGW/Y9OXNjsQB
PpHQpZCKRV+CnsgmkTY00j8WJ+OsaLmATetufUWrMcDc+MLWlKXf6XrA2MAxmPI2
Jx3a58mHcXNSMYXY/y5W4hTJYQ4GK+eR2lJRPf8xYcZghPSbTO4gLZWxYGH231YC
oO65U9Q0eq5ZJ8sg1bOm0ktbFzL0j+k7FrnJucP4pFSlSotsferr0OE39NJoAqWN
WYTPy2xxKF8rr/udzFxf28/U6Lt1I4IgVGynIEi9HDEq5AOvYU3YpRJh4zm82kXm
rig6SxIUXFiJNuwmGP3Ojcx6GCwKV00DNjxVDi//MPVVNbtIDaHc+n7LaIJ/ggZp
YSgxWSIun7Hkfx/VYHmJswamYZZMTa2xsMt4lNkEH9qYw5exApefPHDFPY3MjQsM
4glCWtddFiDrV2gGIQ91hNCTzB/5Ps1tHLws/kp41ss540G7/UqQ01OYb6lWTnNv
6CNJitx94qitQ/lTcZG/qCrLu5z5w/CFv3iNZd9TEkFIiIn1HkgnztK1EOhXiPmJ
5mdUeG6pCCAg99LCyRxaiRRwUXMbs6lKBAAiqG0sqzf40YsCKaGm1uRfxQ6IxV42
W0wios28Si+oc9Iq/zkG
=PQs1
-----END PGP SIGNATURE-----

--nextPart1597626.Qo76rEhSt6--


--===============7652368171346113660==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and 
their applications. This 200-page book is written by three acclaimed 
leaders in the field. The early access version is available now. 
Download your free book today! http://p.sf.net/sfu/neotech_d2d_may
--===============7652368171346113660==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============7652368171346113660==--

