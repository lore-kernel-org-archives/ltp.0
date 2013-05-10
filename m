Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1UapEk-0000Kn-Hi
	for ltp-list@lists.sourceforge.net; Fri, 10 May 2013 15:27:58 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1UapEj-0005lt-GV
	for ltp-list@lists.sourceforge.net; Fri, 10 May 2013 15:27:58 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Fri, 10 May 2013 11:27:48 -0400
References: <518B618F.80400@cn.fujitsu.com>
	<201305091222.52821.vapier@gentoo.org>
	<518C5CE3.9070702@cn.fujitsu.com>
In-Reply-To: <518C5CE3.9070702@cn.fujitsu.com>
MIME-Version: 1.0
Message-Id: <201305101127.49679.vapier@gentoo.org>
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
Content-Type: multipart/mixed; boundary="===============8968758539409202527=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: DAN LI <li.dan@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

--===============8968758539409202527==
Content-Type: multipart/signed; boundary="nextPart2370095.0C1fli2Vo6";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2370095.0C1fli2Vo6
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Thursday 09 May 2013 22:35:15 DAN LI wrote:
> On 05/10/2013 12:22 AM, Mike Frysinger wrote:
> > On Thursday 09 May 2013 04:42:55 DAN LI wrote:
> >> --- a/testcases/kernel/syscalls/ipc/semctl/semctl01.c
> >> +++ b/testcases/kernel/syscalls/ipc/semctl/semctl01.c
> >>=20
> >>  /*
> >>=20
> >> @@ -24,32 +23,6 @@
> >>=20
> >>   * DESCRIPTION
> >>   *	semctl01 - test the 10 possible semctl() commands
> >>   *
> >>=20
> >> - * ALGORITHM
> >> - *	create a semaphore set with read and alter permissions
> >> - *	loop if that option was specified
> >> - *	  loop through the test cases
> >> - *	    do any setup required for the test case
> >> - *	    make the semctl() call using the TEST() macro
> >> - *	    check the return code
> >> - *	      if failure, issue a FAIL message.
> >> - *	    otherwise,
> >> - *	      if doing functionality testing
> >> - *		call the appropriate test function
> >> - *	  	if correct,
> >> - *			issue a PASS message
> >> - *		otherwise
> >> - *			issue a FAIL message
> >> - *	call cleanup
> >=20
> > i don't see high level DESCRIPTION/ALGORITHM as "useless".  why do you ?
>=20
> In my opinion, "ALGORITHM" section of many ltp testcases follows one
> format: ------------------------------------------------
> setup()
> loop test frame
> 	loop all test cases
> 		TEST(call)
> 		if call failed
> 			log the errno
> 		else
> 			if functionality is ok
> 				case PASS
> 			else
> 				case FAIL
> cleanup()
> ------------------------------------------------
>=20
> So, i think this section is redundant and useless once someone has
> learned the test frame.

and if you delete all the sections, then what are people going to refer to ?
=2Dmike

--nextPart2370095.0C1fli2Vo6
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJRjRH1AAoJEEFjO5/oN/WBSOQP/1eHTdBEgnX0M71pRjyASp7l
0WYxee3mYxmDal89rQp0t8sETec3EWb+U403y/Pm6N6kJy8W/h9lE/mYLCalVQH3
L4NeGS+NKL47BydHAFAasn5641CRE8RrcGPa9SV7fMtNHHNlbXtBsfkBNcvm0AWB
pIs2AtZw+w7P7dTiNeYKuH0EeSthIK7BpcFHGokCAOMbMRZwjAZutiSQSiGq2FHz
REXsGW+WI1XAesapNXNJH6jmC1z+BZ3um8ltwe63H/pm8oArDhJGGXiVpI2q+NIR
V4qunYc7XJog1EJ7fqGT/0U0/aFsfWYgr6C63yQor34W2GrgMUQL7EMAjqCyi8H/
q6e0CZ6Spo/BV755Ow2kbdmlpmmHDXUceh6z9/hC9f4+KEFLBdflqlRFQ04Ehvgl
+HMQ5lftd8Axg8gGGoG3p0VLn4OFAMOUq7aew532LVXi7KU4uIbnCR+WXc1xE1lE
xVK2PhJQqEVw94jJL3Ss9puKVFGFuKUSZSEcd9U5ly/mua6SiMPiw/Jr9apPDxcs
pUAlAOsR4/CkcTN6Milp0f0+i1l79CZoGzEXPxeVcMgz3zDCdjmNE6HlFFgw5JZe
VFxwiqLxi9gg1rZAUUTNnc0dXwU+Hw17n9EE1Bjk/GqQ2jZ41Q36zJmW6Zs3kmZw
+9Qvuy3giNOsf4S1MH3o
=re4j
-----END PGP SIGNATURE-----

--nextPart2370095.0C1fli2Vo6--


--===============8968758539409202527==
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
--===============8968758539409202527==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============8968758539409202527==--

