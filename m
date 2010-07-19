Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <czhang@redhat.com>) id 1OalmO-0003HP-Rl
	for ltp-list@lists.sourceforge.net; Mon, 19 Jul 2010 08:32:52 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24]
	helo=mx01.colomx.prod.int.phx2.redhat.com)
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OalmN-00043R-K9
	for ltp-list@lists.sourceforge.net; Mon, 19 Jul 2010 08:32:52 +0000
Date: Mon, 19 Jul 2010 04:32:44 -0400 (EDT)
From: Caspar Zhang <czhang@redhat.com>
Message-ID: <1523981765.524681279528364312.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
In-Reply-To: <817263552.524511279528077317.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_23066_2030536042.1279528364307"
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

------=_Part_23066_2030536042.1279528364307
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


----- "Garrett Cooper" <yanegomi@gmail.com> wrote:

> On Sun, Jul 18, 2010 at 11:55 PM, Caspar Zhang <czhang@redhat.com>
> wrote:
> >
> > ----- "Garrett Cooper" <yanegomi@gmail.com> wrote:
> >
> >>
> >> =C2=A0 =C2=A0 The fact that the test is using time(3) to calculate the
> elapsed
> >> period instead of clock_gettime is dubious at best, because the
> >> precision of time is in seconds. Maybe it should be converted to
> >> clock_gettime calls for improved precision?
> >
> > Use clock_gettime instead of time(3), patch attached.
>=20
> Looks better, but being strict it's still buggy. POSIX defines struct
> timespec as:
>=20
> The <time.h> header shall declare the structure timespec, which has
> at
> least the following members:
>=20
> time_t  tv_sec    Seconds.
> long    tv_nsec   Nanoseconds.
>=20
> So you're losing precision in one case, and time_t can be variable
> (the spec for types.h is rather fluid):
>=20
> time_t and clock_t shall be integer or real-floating types.
>=20
> The (struct timeval *) casts are also unnecessary because you're
> getting the address of a struct timeval object (which is in both
> cases
> struct timeval*).
>=20
> > Another question, since POSIX.1-2008 marks gettimeofday() as
> obsolete
> > (man gettimeofday), should the usec test part be changed to
> > clock_getime as well?
>=20
> Sure, if you want.

Updated patch, FYI.

Thanks,
Caspar



Hi all,
  =20
   1. In my recent tests, not all desired time be equal to exact execution=
=20
   time in sec test part, use clock_gettime to improve precision.=20
   2. gettimeofday is marked as obsolete in POSIX.1-2008 according to
   man gettimeofday, so change gettimeofday to clock_gettime in nsec test
   part.
  =20
   Signed-off-by: Caspar Zhang <czhang@redhat.com>

diff -Naur a/testcases/kernel/syscalls/pselect/Makefile b/testcases/kernel/=
syscalls/pselect/Makefile
--- a/testcases/kernel/syscalls/pselect/Makefile        2010-04-01 14:23:10=
.000000000 +0800
+++ b/testcases/kernel/syscalls/pselect/Makefile        2010-07-19 14:54:38=
.984482305 +0800
@@ -21,6 +21,7 @@
 include $(top_srcdir)/include/mk/testcases.mk
 include $(abs_srcdir)/../utils/newer_64.mk
=20
+LDLIBS                 +=3D -lpthread -lrt
 %_64: CPPFLAGS +=3D -D_FILE_OFFSET_BITS=3D64
=20
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff -Naur a/testcases/kernel/syscalls/pselect/pselect01.c b/testcases/kern=
el/syscalls/pselect/pselect01.c
--- a/testcases/kernel/syscalls/pselect/pselect01.c     2010-04-01 14:23:10=
.000000000 +0800
+++ b/testcases/kernel/syscalls/pselect/pselect01.c     2010-07-19 16:08:32=
.402482397 +0800
@@ -61,14 +61,12 @@
=20
 int main()
 {
-       int ret_pselect, total_sec, fd, total_nsec;
+       int ret_pselect, fd;
        fd_set readfds;
-       struct timespec tv;
        int retval;
-       time_t t;
-       unsigned start, end;
-       struct timeval tv_start, tv_end;
-       int real_usec;
+       struct timespec tv, tv_start, tv_end;
+       long real_nsec, total_nsec;
+       int real_sec, total_sec;
=20
        setup();
=20
@@ -103,17 +101,20 @@
                tst_resm(TINFO,
                         "Testing basic pselect sanity,Sleeping for %jd sec=
s",
                         (intmax_t)tv.tv_sec);
-               start =3D time(&t);
+               clock_gettime(CLOCK_REALTIME, &tv_start);
                retval =3D
-                   pselect(0, &readfds, NULL, NULL, (struct timespec *)&tv=
,
+                   pselect(0, &readfds, NULL, NULL, &tv,
                            NULL);
-               end =3D time(&t);
+               clock_gettime(CLOCK_REALTIME, &tv_end);
=20
-               if (((end - start) =3D=3D total_sec) || ((end - start) =3D=
=3D total_sec + 1))
+               /* do a rounding */
+               real_sec =3D (int)(0.5 + (tv_end.tv_sec - tv_start.tv_sec +=
=20
+                               1e-9 * (tv_end.tv_nsec - tv_start.tv_nsec))=
);
+               if (real_sec =3D=3D total_sec)
                        tst_resm(TPASS, "Sleep time was correct");
                else
                        tst_resm(TFAIL, "Sleep time was incorrect:%d !=3D %=
d",
-                                total_sec, (end - start));
+                                total_sec, real_sec);
        }
=20
 #ifdef DEBUG
@@ -129,19 +130,19 @@
                tst_resm(TINFO,
                         "Testing basic pselect sanity,Sleeping for %ld nan=
o secs",
                         tv.tv_nsec);
-               gettimeofday(&tv_start, NULL);
+               clock_gettime(CLOCK_REALTIME, &tv_start);
                retval =3D
                    pselect(0, &readfds, NULL, NULL, &tv,
                            NULL);
-               gettimeofday(&tv_end, NULL);
+               clock_gettime(CLOCK_REALTIME, &tv_end);
=20
                /* Changed total_sec compare to an at least vs an exact com=
pare */
=20
-               real_usec =3D (tv_end.tv_sec - tv_start.tv_sec) * 1e6 +
-                       tv_end.tv_usec - tv_start.tv_usec;
+               real_nsec =3D (tv_end.tv_sec - tv_start.tv_sec) * 1e9 +
+                       tv_end.tv_nsec - tv_start.tv_nsec;
=20
                /* allow 10% error*/
-               if (abs(real_usec - tv.tv_nsec / 1000) < 0.1 * total_nsec /=
 1000)
+               if (abs(real_nsec - tv.tv_nsec) < 0.1 * total_nsec)
                        tst_resm(TPASS, "Sleep time was correct");
                else {
                        tst_resm(TWARN,
@@ -150,8 +151,8 @@
                                 "due to the limitation of the way it calcu=
lates the");
                        tst_resm(TWARN, "system call execution time.");
                        tst_resm(TFAIL,
-                               "Sleep time was incorrect:%d usec vs expect=
ed %d usec",
-                                real_usec, total_nsec / 1000);
+                               "Sleep time was incorrect:%ld nsec vs expec=
ted %ld nsec",
+                                real_nsec, total_nsec);
                }
        }
        cleanup();


--=20
Kernel Associate Quality Engineer
Red Hat Inc. (Beijing R&D Branch)

Red Hat China R&D Branch Unit 907, North Tower C,=20
  Raycom Infotech Park, No.2 Kexueyuan Nanlu,=20
  Haidian District, Beijing 100190

TEL: +86-10-62608150
Web: http://www.redhat.com/

------=_Part_23066_2030536042.1279528364307
Content-Type: text/x-patch; name=syscalls-pselect01-fix-false-alarm.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=syscalls-pselect01-fix-false-alarm.patch

Hi all,
   
   1. In my recent tests, not all desired time be equal to exact execution 
   time in sec test part, use clock_gettime to improve precision. 
   2. gettimeofday is marked as obsolete in POSIX.1-2008 according to
   man gettimeofday, so change gettimeofday to clock_gettime in nsec test
   part.
   
   Signed-off-by: Caspar Zhang <czhang@redhat.com>

diff -Naur a/testcases/kernel/syscalls/pselect/Makefile b/testcases/kernel/syscalls/pselect/Makefile
--- a/testcases/kernel/syscalls/pselect/Makefile	2010-04-01 14:23:10.000000000 +0800
+++ b/testcases/kernel/syscalls/pselect/Makefile	2010-07-19 14:54:38.984482305 +0800
@@ -21,6 +21,7 @@
 include $(top_srcdir)/include/mk/testcases.mk
 include $(abs_srcdir)/../utils/newer_64.mk
 
+LDLIBS			+= -lpthread -lrt
 %_64: CPPFLAGS += -D_FILE_OFFSET_BITS=64
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff -Naur a/testcases/kernel/syscalls/pselect/pselect01.c b/testcases/kernel/syscalls/pselect/pselect01.c
--- a/testcases/kernel/syscalls/pselect/pselect01.c	2010-04-01 14:23:10.000000000 +0800
+++ b/testcases/kernel/syscalls/pselect/pselect01.c	2010-07-19 16:08:32.402482397 +0800
@@ -61,14 +61,12 @@
 
 int main()
 {
-	int ret_pselect, total_sec, fd, total_nsec;
+	int ret_pselect, fd;
 	fd_set readfds;
-	struct timespec tv;
 	int retval;
-	time_t t;
-	unsigned start, end;
-	struct timeval tv_start, tv_end;
-	int real_usec;
+	struct timespec tv, tv_start, tv_end;
+	long real_nsec, total_nsec;
+	int real_sec, total_sec;
 
 	setup();
 
@@ -103,17 +101,20 @@
 		tst_resm(TINFO,
 			 "Testing basic pselect sanity,Sleeping for %jd secs",
 			 (intmax_t)tv.tv_sec);
-		start = time(&t);
+		clock_gettime(CLOCK_REALTIME, &tv_start);
 		retval =
-		    pselect(0, &readfds, NULL, NULL, (struct timespec *)&tv,
+		    pselect(0, &readfds, NULL, NULL, &tv,
 			    NULL);
-		end = time(&t);
+		clock_gettime(CLOCK_REALTIME, &tv_end);
 
-		if (((end - start) == total_sec) || ((end - start) == total_sec + 1))
+		/* do a rounding */
+		real_sec = (int)(0.5 + (tv_end.tv_sec - tv_start.tv_sec + 
+				1e-9 * (tv_end.tv_nsec - tv_start.tv_nsec)));
+		if (real_sec == total_sec)
 			tst_resm(TPASS, "Sleep time was correct");
 		else
 			tst_resm(TFAIL, "Sleep time was incorrect:%d != %d",
-				 total_sec, (end - start));
+				 total_sec, real_sec);
 	}
 
 #ifdef DEBUG
@@ -129,19 +130,19 @@
 		tst_resm(TINFO,
 			 "Testing basic pselect sanity,Sleeping for %ld nano secs",
 			 tv.tv_nsec);
-		gettimeofday(&tv_start, NULL);
+		clock_gettime(CLOCK_REALTIME, &tv_start);
 		retval =
 		    pselect(0, &readfds, NULL, NULL, &tv,
 			    NULL);
-		gettimeofday(&tv_end, NULL);
+		clock_gettime(CLOCK_REALTIME, &tv_end);
 
 		/* Changed total_sec compare to an at least vs an exact compare */
 
-		real_usec = (tv_end.tv_sec - tv_start.tv_sec) * 1e6 +
-			tv_end.tv_usec - tv_start.tv_usec;
+		real_nsec = (tv_end.tv_sec - tv_start.tv_sec) * 1e9 +
+			tv_end.tv_nsec - tv_start.tv_nsec;
 
 		/* allow 10% error*/
-		if (abs(real_usec - tv.tv_nsec / 1000) < 0.1 * total_nsec / 1000)
+		if (abs(real_nsec - tv.tv_nsec) < 0.1 * total_nsec)
 			tst_resm(TPASS, "Sleep time was correct");
 		else {
 			tst_resm(TWARN,
@@ -150,8 +151,8 @@
 				 "due to the limitation of the way it calculates the");
 			tst_resm(TWARN, "system call execution time.");
 			tst_resm(TFAIL,
-				"Sleep time was incorrect:%d usec vs expected %d usec",
-				 real_usec, total_nsec / 1000);
+				"Sleep time was incorrect:%ld nsec vs expected %ld nsec",
+				 real_nsec, total_nsec);
 		}
 	}
 	cleanup();

------=_Part_23066_2030536042.1279528364307
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
------=_Part_23066_2030536042.1279528364307
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_Part_23066_2030536042.1279528364307--

