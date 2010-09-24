Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jtluka@redhat.com>) id 1Oz7t3-0004nX-JO
	for ltp-list@lists.sourceforge.net; Fri, 24 Sep 2010 13:00:25 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Oz7t2-00075N-9Z
	for ltp-list@lists.sourceforge.net; Fri, 24 Sep 2010 13:00:25 +0000
Received: from int-mx08.intmail.prod.int.phx2.redhat.com
	(int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.21])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id o8OD0ICf016617
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 24 Sep 2010 09:00:18 -0400
Received: from localhost (dhcp-27-139.brq.redhat.com [10.34.27.139])
	by int-mx08.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP
	id o8OD0G9D004446
	for <ltp-list@lists.sourceforge.net>; Fri, 24 Sep 2010 09:00:17 -0400
Date: Fri, 24 Sep 2010 15:00:16 +0200
From: Jan Tluka <jtluka@redhat.com>
Message-ID: <20100924130014.GB7889@dhcp-27-139.brq.redhat.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] fix incorrect cleanup after hugeshmget05 test
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============7928271826353500415=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net


--===============7928271826353500415==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="S1BNGpv0yoYahz37"
Content-Disposition: inline


--S1BNGpv0yoYahz37
Content-Type: multipart/mixed; boundary="61jdw2sOBCFtR2d/"
Content-Disposition: inline


--61jdw2sOBCFtR2d/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I've noticed that in some cases the hugeshmget05 testcase is not
cleaning up properly after itself. It leaves hugepages reserved and=20
does not free them. This could break further test runs.=20

I think the problem is with signal handling. The testcase will do
rm_shm() only if it ends up properly. In case it's being killed by
SIGTERM signal (as seen from the testlog) the cleanup() function does
not return shared memory.

Without the patch I have to use ipcrm to remove all hugepages reserved
and not returned.

# grep -i unexpected RHEL-hugepage.run.log
hugeshmget05    1  TBROK  :  Unexpected signal 15 received.
# ipcs -m
------ Shared Memory Segments --------
key        shmid      owner      perms      bytes      nattch     status   =
  =20
0x7400ee08 3932160    root      600        4          0                    =
  =20
0x7400edde 4620289    root      600        4          0                    =
  =20
0x00000000 4980738    gdm       600        393216     2          dest      =
  =20
0x7400eddd 4587523    root      600        4          0                    =
  =20
0x78002a3b 64552964   root      600        209715200  0                    =
  =20
0x78002a38 64520197   root      600        209715200  0                    =
  =20
# ipcrm -m 64552964 -m 64520197

With the patch the test returns hugepages back to the system even if it
gets signal 15.

Checked on RHEL5.5.

Thanks, Jan

--61jdw2sOBCFtR2d/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename=ltp-test-patch-fix-incorrect-cleanup-after-hugeshmget05-test
Content-Transfer-Encoding: quoted-printable

--- ltp-full-20100831/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.=
c	2010-09-14 13:04:33.000000000 +0200
+++ ltp-full-20100831.new/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmge=
t05.c	2010-09-24 13:47:19.413177300 +0200
@@ -105,7 +105,6 @@
=20
 		do_child();
=20
-		cleanup();
=20
 		/*NOTREACHED*/
 	} else {		/* parent */
@@ -114,11 +113,10 @@
 			tst_brkm(TBROK, cleanup, "waitpid failed");
 		}
=20
-		/* if it exists, remove the shared memory resource */
-		rm_shm(shm_id_1);
-
 		/* Remove the temporary directory */
 		tst_rmdir();
+
+		cleanup();
 	}
 	return 0;
 }
@@ -209,6 +207,9 @@
 void
 cleanup(void)
 {
+	/* if it exists, remove the shared memory resource */
+	rm_shm(shm_id_1);
+
 	/*
 	 * print timing stats if that option was specified.
 	 * print errno log if that option was specified.

--61jdw2sOBCFtR2d/--

--S1BNGpv0yoYahz37
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkycoN4ACgkQLlTqDvSoCHhGlgCgiWgqTgVyytpmPsiCqObiRfGV
7+cAn2fpIxHHYNx1sP17THkReB29YA8Z
=uYJi
-----END PGP SIGNATURE-----

--S1BNGpv0yoYahz37--


--===============7928271826353500415==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Nokia and AT&T present the 2010 Calling All Innovators-North America contest
Create new apps & games for the Nokia N8 for consumers in  U.S. and Canada
$10 million total in prizes - $4M cash, 500 devices, nearly $6M in marketing
Develop with Nokia Qt SDK, Web Runtime, or Java and Publish to Ovi Store 
http://p.sf.net/sfu/nokia-dev2dev
--===============7928271826353500415==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============7928271826353500415==--

