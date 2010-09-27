Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jtluka@redhat.com>) id 1P0CMF-0004dZ-9T
	for ltp-list@lists.sourceforge.net; Mon, 27 Sep 2010 11:58:59 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1P0CME-00065E-47
	for ltp-list@lists.sourceforge.net; Mon, 27 Sep 2010 11:58:59 +0000
Date: Mon, 27 Sep 2010 13:58:49 +0200
From: Jan Tluka <jtluka@redhat.com>
Message-ID: <20100927115849.GA22015@dhcp-27-142.brq.redhat.com>
References: <20100924130014.GB7889@dhcp-27-139.brq.redhat.com>
	<20100924132104.GC7889@dhcp-27-139.brq.redhat.com>
	<AANLkTin2=Hcf-FLqJ=1DFmQg1x+T1o84JH-LkAWXQcRK@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <AANLkTin2=Hcf-FLqJ=1DFmQg1x+T1o84JH-LkAWXQcRK@mail.gmail.com>
Subject: Re: [LTP] [PATCH] fix incorrect cleanup after hugeshmget05 test
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2132944108626190361=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net


--===============2132944108626190361==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Sat, Sep 25, 2010 at 06:56:44AM CEST, yanegomi@gmail.com wrote:
>On Fri, Sep 24, 2010 at 6:21 AM, Jan Tluka <jtluka@redhat.com> wrote:
>> Resending ...
>>
>> I've noticed that in some cases the hugeshmget05 testcase is not
>> cleaning up properly after itself. It leaves hugepages reserved and
>> does not free them. This could break further test runs.
>>
>> I think the problem is with signal handling. The testcase will do
>> rm_shm() only if it ends up properly. In case it's being killed by
>> SIGTERM signal (as seen from the testlog) the cleanup() function does
>> not return shared memory.
>>
>> Without the patch I have to use ipcrm to remove all hugepages reserved
>> and not returned.
>>
>> # grep -i unexpected RHEL-hugepage.run.log
>> hugeshmget05 =A0 =A01 =A0TBROK =A0: =A0Unexpected signal 15 received.
>> # ipcs -m
>> ------ Shared Memory Segments --------
>> key =A0 =A0 =A0 =A0shmid =A0 =A0 =A0owner =A0 =A0 =A0perms =A0 =A0 =A0by=
tes =A0 =A0 =A0nattch =A0 =A0 status
>> 0x7400ee08 3932160 =A0 =A0root =A0 =A0 =A0600 =A0 =A0 =A0 =A04 =A0 =A0 =
=A0 =A0 =A00
>> 0x7400edde 4620289 =A0 =A0root =A0 =A0 =A0600 =A0 =A0 =A0 =A04 =A0 =A0 =
=A0 =A0 =A00
>> 0x00000000 4980738 =A0 =A0gdm =A0 =A0 =A0 600 =A0 =A0 =A0 =A0393216 =A0 =
=A0 2 =A0 =A0 =A0 =A0 =A0dest
>> 0x7400eddd 4587523 =A0 =A0root =A0 =A0 =A0600 =A0 =A0 =A0 =A04 =A0 =A0 =
=A0 =A0 =A00
>> 0x78002a3b 64552964 =A0 root =A0 =A0 =A0600 =A0 =A0 =A0 =A0209715200 =A00
>> 0x78002a38 64520197 =A0 root =A0 =A0 =A0600 =A0 =A0 =A0 =A0209715200 =A00
>> # ipcrm -m 64552964 -m 64520197
>>
>> With the patch the test returns hugepages back to the system even if it
>> gets signal 15.
>>
>> Checked on RHEL5.5.
>>
>> Thanks, Jan
>>
>>
>> The patch follows,
>>
>>
>> --- ltp-full-20100831/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget=
05.c =A0 =A02010-09-14 13:04:33.000000000 +0200
>> +++ ltp-full-20100831.new/testcases/kernel/mem/hugetlb/hugeshmget/hugesh=
mget05.c =A0 =A0 =A0 =A02010-09-24 13:47:19.413177300 +0200
>> @@ -105,7 +105,6 @@
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0do_child();
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cleanup();
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*NOTREACHED*/
>> =A0 =A0 =A0 =A0} else { =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* parent */
>> @@ -114,11 +113,10 @@
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_brkm(TBROK, cleanup, =
"waitpid failed");
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* if it exists, remove the shared memory =
resource */
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 rm_shm(shm_id_1);
>> -
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Remove the temporary directory */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_rmdir();
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cleanup();
>> =A0 =A0 =A0 =A0}
>> =A0 =A0 =A0 =A0return 0;
>> =A0}
>> @@ -209,6 +207,9 @@
>> =A0void
>> =A0cleanup(void)
>> =A0{
>> + =A0 =A0 =A0 /* if it exists, remove the shared memory resource */
>> + =A0 =A0 =A0 rm_shm(shm_id_1);
>> +
>> =A0 =A0 =A0 =A0/*
>> =A0 =A0 =A0 =A0 * print timing stats if that option was specified.
>> =A0 =A0 =A0 =A0 * print errno log if that option was specified.
>
>Hi Jan,
>    I spotted some other potential issues with the test. Please try
>this patch and let me know whether or not it works for you .
>Cheers,
>-Garrett

Hi Garrett, I ran the hugeshmget05 test with your patch applied and=20
it works fine. Did 100 loops with no issues observed.

Thanks.

>diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c b/test=
cases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c
>index bc4bd2c..3e9e26a 100644
>--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c
>+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c
>@@ -77,7 +77,8 @@ char *ltp_user =3D "nobody";
> int main(int ac, char **av)
> {
> 	char *msg;			/* message returned from parse_opts */
>-	int pid;
>+	pid_t pid;
>+	int status;
> 	void do_child(void);
>=20
> 	/* parse standard options */
>@@ -105,21 +106,22 @@ int main(int ac, char **av)
>=20
> 		do_child();
>=20
>-		cleanup();
>-
>+		tst_exit();
> 		/*NOTREACHED*/
> 	} else {		/* parent */
> 		/* wait for the child to return */
>-		if (waitpid(pid, NULL, 0) =3D=3D -1) {
>-			tst_brkm(TBROK, cleanup, "waitpid failed");
>+		if (waitpid(pid, &status, 0) =3D=3D -1) {
>+			tst_resm(TBROK, "waitpid failed");
>+		}
>+		else if (status !=3D 0) {
>+			tst_resm(TFAIL,	"child process failed to exit cleanly "
>+				"(exit status =3D %d)", status);
> 		}
>+	}
>=20
>-		/* if it exists, remove the shared memory resource */
>-		rm_shm(shm_id_1);
>+	cleanup();
>=20
>-		/* Remove the temporary directory */
>-		tst_rmdir();
>-	}
>+	/* NOTREACHED */
> 	return 0;
> }
>=20
>@@ -152,13 +154,11 @@ do_child()
>=20
> 		switch(TEST_ERRNO) {
> 		case EACCES:
>-			tst_resm(TPASS, "expected failure - errno =3D "
>-				 "%d : %s", TEST_ERRNO, strerror(TEST_ERRNO));
>+			tst_resm(TPASS|TTERRNO, "expected failure");
> 			break;
> 		default:
>-			tst_resm(TFAIL, "call failed with an "
>-				 "unexpected error - %d : %s",
>-				 TEST_ERRNO, strerror(TEST_ERRNO));
>+			tst_resm(TFAIL|TTERRNO, "call failed with an "
>+				 "unexpected error");
> 			break;
> 		}	=09
> 	}
>@@ -209,6 +209,9 @@ setup(void)
> void
> cleanup(void)
> {
>+	/* if it exists, remove the shared memory resource */
>+	rm_shm(shm_id_1);
>+
> 	/*
> 	 * print timing stats if that option was specified.
> 	 * print errno log if that option was specified.


--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkyghvkACgkQLlTqDvSoCHhlyQCfRX5T/MqObJv5pUhhqTCbXAT5
rKUAn3dodi74TiSts0yZDG0ovhGy1kDP
=4ndI
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--


--===============2132944108626190361==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Start uncovering the many advantages of virtual appliances
and start using them to simplify application deployment and
accelerate your shift to cloud computing.
http://p.sf.net/sfu/novell-sfdev2dev
--===============2132944108626190361==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============2132944108626190361==--

