Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <czhang@redhat.com>) id 1ObVnP-00042D-96
	for ltp-list@lists.sourceforge.net; Wed, 21 Jul 2010 09:40:59 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25]
	helo=mx02.colomx.prod.int.phx2.redhat.com)
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1ObVnM-00061W-Qf
	for ltp-list@lists.sourceforge.net; Wed, 21 Jul 2010 09:40:59 +0000
Date: Wed, 21 Jul 2010 05:40:49 -0400 (EDT)
From: Caspar Zhang <czhang@redhat.com>
Message-ID: <925081811.719281279705249668.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
In-Reply-To: <234306554.719221279705061623.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_31336_187498280.1279705249667"
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

------=_Part_31336_187498280.1279705249667
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit


----- "Garrett Cooper" <yanegomi@gmail.com> wrote:

> ACK (and thanks for the hard work)!
> -Garrett

Hi Garrett, I tested my patch yesterday but the result
is not so good. After 1000 times running, the fix:

+		/* do a rounding */
+		real_sec = (int)(0.5 + (tv_end.tv_sec - tv_start.tv_sec + 
+				1e-9 * (tv_end.tv_nsec - tv_start.tv_nsec)));
+		if (real_sec == total_sec)

got failed for once. so I set the allowed error to 20%(see the
attached patch). Then re-ran it for over 5000 times, without
a failure.

Then the nsec part, 10% allowed error seems not enough, 
the test failed for twice among 1000 times. So I set the
range to 20%, too.

Thanks,
Caspar

-- 
Quality Assurance Associate (Kernel) in
Red Hat Inc. (Beijing R&D Branch)

TEL: +86-10-62608150
Web: http://www.redhat.com/

------=_Part_31336_187498280.1279705249667
Content-Type: text/x-patch; name=syscalls-pselect01-fix-false-alarm.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=syscalls-pselect01-fix-false-alarm.patch

Hi all,
   
   1. In my recent tests, not all desired time be equal to exact execution 
   time in sec test part, use clock_gettime to improve precision, and allow
   the error range to be 20%.

   2. gettimeofday is marked as obsolete in POSIX.1-2008 according to
   man gettimeofday, so change gettimeofday to clock_gettime in nsec test
   part. 
   
   3. 10% range in nsec test part seems not enough.I ran the test for about 
   1000 times, the nsec test part failed twice. Changed the value to 20%.
   
   Signed-off-by: Caspar Zhang <czhang@redhat.com>

diff -Naur a/testcases/kernel/syscalls/pselect/Makefile b/testcases/kernel/syscalls/pselect/Makefile
--- a/testcases/kernel/syscalls/pselect/Makefile	2010-04-01 14:23:10.000000000 +0800
+++ b/testcases/kernel/syscalls/pselect/Makefile	2010-07-20 16:59:45.983475123 +0800
@@ -21,6 +21,7 @@
 include $(top_srcdir)/include/mk/testcases.mk
 include $(abs_srcdir)/../utils/newer_64.mk
 
+LDLIBS			+= -lpthread -lrt
 %_64: CPPFLAGS += -D_FILE_OFFSET_BITS=64
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff -Naur a/testcases/kernel/syscalls/pselect/pselect01.c b/testcases/kernel/syscalls/pselect/pselect01.c
--- a/testcases/kernel/syscalls/pselect/pselect01.c	2010-04-01 14:23:10.000000000 +0800
+++ b/testcases/kernel/syscalls/pselect/pselect01.c	2010-07-20 17:00:01.498601028 +0800
@@ -61,14 +61,13 @@
 
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
+	double real_sec;
+	int total_sec;
 
 	setup();
 
@@ -103,17 +102,20 @@
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
+		real_sec = (tv_end.tv_sec - tv_start.tv_sec + 
+				1e-9 * (tv_end.tv_nsec - tv_start.tv_nsec));
+		/* allow about 20% error */
+		if (abs(real_sec - total_sec) < 0.2 * total_sec)
 			tst_resm(TPASS, "Sleep time was correct");
 		else
-			tst_resm(TFAIL, "Sleep time was incorrect:%d != %d",
-				 total_sec, (end - start));
+			tst_resm(TFAIL, "Sleep time was incorrect:%d != %lf",
+				 total_sec, real_sec);
 	}
 
 #ifdef DEBUG
@@ -129,19 +131,19 @@
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
 
-		/* allow 10% error*/
-		if (abs(real_usec - tv.tv_nsec / 1000) < 0.1 * total_nsec / 1000)
+		/* allow 20% error*/
+		if (abs(real_nsec - tv.tv_nsec) < 0.2 * total_nsec)
 			tst_resm(TPASS, "Sleep time was correct");
 		else {
 			tst_resm(TWARN,
@@ -150,8 +152,8 @@
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

------=_Part_31336_187498280.1279705249667
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
------=_Part_31336_187498280.1279705249667
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_Part_31336_187498280.1279705249667--

