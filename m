Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <czhang@redhat.com>) id 1Oakdy-0008RV-Tt
	for ltp-list@lists.sourceforge.net; Mon, 19 Jul 2010 07:20:06 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25]
	helo=mx02.colomx.prod.int.phx2.redhat.com)
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Oakdx-00068F-Py
	for ltp-list@lists.sourceforge.net; Mon, 19 Jul 2010 07:20:06 +0000
Date: Mon, 19 Jul 2010 03:19:56 -0400 (EDT)
From: Caspar Zhang <czhang@redhat.com>
Message-ID: <605927762.522681279523996466.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
In-Reply-To: <1727427203.522661279523956538.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_22981_1267545886.1279523996465"
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

------=_Part_22981_1267545886.1279523996465
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit


----- "Caspar Zhang" <czhang@redhat.com> wrote:

> ----- "Garrett Cooper" <yanegomi@gmail.com> wrote:
> 
> >
> >     The fact that the test is using time(3) to calculate the elapsed
> > period instead of clock_gettime is dubious at best, because the
> > precision of time is in seconds. Maybe it should be converted to
> > clock_gettime calls for improved precision?

s/1e-6/1e-9 in the patch, my typo :-|

Thanks,
Caspar

> 
> Use clock_gettime instead of time(3), patch attached.
> 
> Another question, since POSIX.1-2008 marks gettimeofday() as obsolete
> (man gettimeofday), should the usec test part be changed to
> clock_getime as well?
> 


-- 
Kernel Associate Quality Engineer
Red Hat Inc. (Beijing R&D Branch)

Red Hat China R&D Branch Unit 907, North Tower C, 
  Raycom Infotech Park, No.2 Kexueyuan Nanlu, 
  Haidian District, Beijing 100190

TEL: +86-10-62608150
Web: http://www.redhat.com/

------=_Part_22981_1267545886.1279523996465
Content-Type: text/x-patch; name=syscalls-pselect01-fix-false-alarm.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=syscalls-pselect01-fix-false-alarm.patch

Hi all,
   
   In my recent tests, not all desired time be equal to exact execution time, 
   use clock_gettime to improve precision. 
   
   Signed-off-by: Caspar Zhang <czhang@redhat.com>

--- a/testcases/kernel/syscalls/pselect/Makefile	2010-04-01 14:23:10.000000000 +0800
+++ b/testcases/kernel/syscalls/pselect/Makefile	2010-07-19 14:54:38.984482305 +0800
@@ -21,6 +21,7 @@
 include $(top_srcdir)/include/mk/testcases.mk
 include $(abs_srcdir)/../utils/newer_64.mk
 
+LDLIBS			+= -lpthread -lrt
 %_64: CPPFLAGS += -D_FILE_OFFSET_BITS=64
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
--- a/testcases/kernel/syscalls/pselect/pselect01.c	2010-04-01 14:23:10.000000000 +0800
+++ b/testcases/kernel/syscalls/pselect/pselect01.c	2010-07-19 15:04:24.175607371 +0800
@@ -65,10 +65,9 @@
 	fd_set readfds;
 	struct timespec tv;
 	int retval;
-	time_t t;
-	unsigned start, end;
+	struct timespec tp_start, tp_end;
 	struct timeval tv_start, tv_end;
-	int real_usec;
+	int real_usec, real_sec;
 
 	setup();
 
@@ -103,17 +102,20 @@
 		tst_resm(TINFO,
 			 "Testing basic pselect sanity,Sleeping for %jd secs",
 			 (intmax_t)tv.tv_sec);
-		start = time(&t);
+		clock_gettime(CLOCK_REALTIME, &tp_start);
 		retval =
 		    pselect(0, &readfds, NULL, NULL, (struct timespec *)&tv,
 			    NULL);
-		end = time(&t);
+		clock_gettime(CLOCK_REALTIME, &tp_end);
 
-		if (((end - start) == total_sec) || ((end - start) == total_sec + 1))
+		/* do a rounding */
+		real_sec = (int)(0.5 + (tp_end.tv_sec - tp_start.tv_sec + 
+				1e-9 * (tp_end.tv_nsec - tp_start.tv_nsec)));
+		if (real_sec == total_sec)
 			tst_resm(TPASS, "Sleep time was correct");
 		else
 			tst_resm(TFAIL, "Sleep time was incorrect:%d != %d",
-				 total_sec, (end - start));
+				 total_sec, real_sec);
 	}
 
 #ifdef DEBUG

------=_Part_22981_1267545886.1279523996465
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
------=_Part_22981_1267545886.1279523996465
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_Part_22981_1267545886.1279523996465--

