Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <czhang@redhat.com>) id 1Obr5M-0004D0-P0
	for ltp-list@lists.sourceforge.net; Thu, 22 Jul 2010 08:24:56 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24]
	helo=mx01.colomx.prod.int.phx2.redhat.com)
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Obr5L-0000Dd-RN
	for ltp-list@lists.sourceforge.net; Thu, 22 Jul 2010 08:24:56 +0000
Date: Thu, 22 Jul 2010 04:24:49 -0400 (EDT)
From: Caspar Zhang <czhang@redhat.com>
Message-ID: <1934556201.804521279787089179.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
In-Reply-To: <70998121.804501279787023401.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_34683_974513289.1279787089178"
Subject: Re: [LTP] [PATCH] fix false alarm in pselect01
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

------=_Part_34683_974513289.1279787089178
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


----- "Garrett Cooper" <yanegomi@gmail.com> wrote:

> On Wed, Jul 21, 2010 at 2:40 AM, Caspar Zhang <czhang@redhat.com>
> wrote:
> > Hi Garrett, I tested my patch yesterday but the result
> > is not so good. After 1000 times running, the fix:
> >
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* do a rounding */
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 real_sec =3D (int)(0=
.5 + (tv_end.tv_sec -
> tv_start.tv_sec +
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1e-9 * (tv_end.tv_nsec -
> tv_start.tv_nsec)));
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (real_sec =3D=3D =
total_sec)
> >
> > got failed for once. so I set the allowed error to 20%(see the
> > attached patch). Then re-ran it for over 5000 times, without
> > a failure.

Hi, seems that this changing not ACKed or committed, re-attach
the patch .

Thanks,
Caspar

> >
> > Then the nsec part, 10% allowed error seems not enough,
> > the test failed for twice among 1000 times. So I set the
> > range to 20%, too.
>=20
> Fair enough... change committed.



Hi,
        Tests can be easily failing when using real_sec =3D=3D total_sec.
        Changed to the similar way as in nsec part does, allow 20%
        error.

        Signed-off-by: Caspar Zhang <czhang@redhat.com>

--- a/testcases/kernel/syscalls/pselect/pselect01.c     2010-07-21 18:08:25=
.139600055 +0800
+++ b/testcases/kernel/syscalls/pselect/pselect01.c     2010-07-22 16:17:06=
.552474774 +0800
@@ -66,7 +66,8 @@
        int retval;
        struct timespec tv, tv_start, tv_end;
        long real_nsec, total_nsec;
-       int real_sec, total_sec;
+       double real_sec;
+       int total_sec;
=20
        setup();
=20
@@ -107,13 +108,13 @@
                            NULL);
                clock_gettime(CLOCK_REALTIME, &tv_end);
=20
-               /* do a rounding */
-               real_sec =3D (int)(0.5 + (tv_end.tv_sec - tv_start.tv_sec +=
=20
-                               1e-9 * (tv_end.tv_nsec - tv_start.tv_nsec))=
);
-               if (real_sec =3D=3D total_sec)
+               real_sec =3D (tv_end.tv_sec - tv_start.tv_sec +=20
+                               1e-9 * (tv_end.tv_nsec - tv_start.tv_nsec))=
;
+               /* allow about 20% error */
+               if (abs(real_sec - total_sec) < 0.2 * total_sec)
                        tst_resm(TPASS, "Sleep time was correct");
                else
-                       tst_resm(TFAIL, "Sleep time was incorrect:%d !=3D %=
d",
+                       tst_resm(TFAIL, "Sleep time was incorrect:%d !=3D %=
lf",
                                 total_sec, real_sec);
        }

--=20
Quality Assurance Associate (Kernel) in
Red Hat Inc. (Beijing R&D Branch)

TEL: +86-10-62608150
Web: http://www.redhat.com/

------=_Part_34683_974513289.1279787089178
Content-Type: text/x-patch; name=pselect-error-range.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=pselect-error-range.patch

Hi,
	Tests can be easily failing when using real_sec == total_sec.
	Changed to the similar way as in nsec part does, allow 20%
	error.

	Signed-off-by: Caspar Zhang <czhang@redhat.com>

--- a/testcases/kernel/syscalls/pselect/pselect01.c	2010-07-21 18:08:25.139600055 +0800
+++ b/testcases/kernel/syscalls/pselect/pselect01.c	2010-07-22 16:17:06.552474774 +0800
@@ -66,7 +66,8 @@
 	int retval;
 	struct timespec tv, tv_start, tv_end;
 	long real_nsec, total_nsec;
-	int real_sec, total_sec;
+	double real_sec;
+	int total_sec;
 
 	setup();
 
@@ -107,13 +108,13 @@
 			    NULL);
 		clock_gettime(CLOCK_REALTIME, &tv_end);
 
-		/* do a rounding */
-		real_sec = (int)(0.5 + (tv_end.tv_sec - tv_start.tv_sec + 
-				1e-9 * (tv_end.tv_nsec - tv_start.tv_nsec)));
-		if (real_sec == total_sec)
+		real_sec = (tv_end.tv_sec - tv_start.tv_sec + 
+				1e-9 * (tv_end.tv_nsec - tv_start.tv_nsec));
+		/* allow about 20% error */
+		if (abs(real_sec - total_sec) < 0.2 * total_sec)
 			tst_resm(TPASS, "Sleep time was correct");
 		else
-			tst_resm(TFAIL, "Sleep time was incorrect:%d != %d",
+			tst_resm(TFAIL, "Sleep time was incorrect:%d != %lf",
 				 total_sec, real_sec);
 	}
 

------=_Part_34683_974513289.1279787089178
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
------=_Part_34683_974513289.1279787089178
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_Part_34683_974513289.1279787089178--

