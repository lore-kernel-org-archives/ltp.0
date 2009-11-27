Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NDwKF-0007qD-5s
	for ltp-list@lists.sourceforge.net; Fri, 27 Nov 2009 08:37:11 +0000
Received: from mail-pz0-f193.google.com ([209.85.222.193])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NDwK7-00005k-Tu
	for ltp-list@lists.sourceforge.net; Fri, 27 Nov 2009 08:37:11 +0000
Received: by pzk31 with SMTP id 31so912578pzk.28
	for <ltp-list@lists.sourceforge.net>;
	Fri, 27 Nov 2009 00:36:58 -0800 (PST)
MIME-Version: 1.0
Date: Fri, 27 Nov 2009 00:36:58 -0800
Message-ID: <364299f40911270036l3307d3ffg1d453b259bbe51e8@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: [LTP] performance_counter* - make TCONF for <2.6.31
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: LTP list <ltp-list@lists.sourceforge.net>

Hi all,
    I was trying to track down when and where the performance_counter
syscalls were added to the Linux kernel, and it appears to have been
2.6.31. The current testcases run and fail on all architectures,
without returning -1 and setting errno == ENOSYS. So I'm proposing the
following change, but of course wondering whether or not it makes
sense:

1. Block off testcases for kernel versions <2.6.31.
2. Make asserts into more graceful errors.
3. Convert tst_resm + tst_exit into tst_brkm's.
4. Convert hardcoded 8's into sizeof(unsigned long long)'s, or
sizeof() for the equivalent variable under inspection.

Signed-off-by: Garrett Cooper <yanegomi@gmail.com>

Index: ./performance_counters/performance_counter01.c
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/performance_counters/performance_counter01.c,v
retrieving revision 1.5
diff -u -r1.5 performance_counter01.c
--- ./performance_counters/performance_counter01.c      27 Nov 2009
08:15:35 -0000      1.5
+++ ./performance_counters/performance_counter01.c      27 Nov 2009
08:31:33 -0000
@@ -62,32 +62,57 @@

 int
 main(void) {
+
        unsigned long long count1, count2;
        int fd1, fd2, ret;
+
+       /*
+        * Kernel performance counters weren't available until 2.6.31 --
+        * http://lwn.net/Articles/311850/
+        *
+        * The syscalls don't return -1 // errno == ENOSYS either. Weird.
+        */
+       if (tst_kvercmp(2, 6, 31) < 0) {
+               tst_brkm(TCONF, cleanup,
+                       "performance_counter support only available in "
+                       "2.6.31+");
+       }
        fd1 = syscall(__NR_perf_counter_open,
                        PERF_COUNT_INSTRUCTIONS, 0, 0, 0, -1);
        if (fd1 < 0) {
-               tst_resm(TBROK | TERRNO,
+               tst_brkm(TBROK | TERRNO, cleanup,
                        "Failed to create PERF_COUNT_INSTRUCTIONS fd");
-               tst_exit();
        }
        fd2 = syscall(__NR_perf_counter_open,
                        PERF_COUNT_CACHE_MISSES, 0, 0, 0, -1);
        if (fd2 < 0) {
-               tst_resm(TBROK | TERRNO,
+               tst_brkm(TBROK | TERRNO, cleanup,
                        "Failed to create PERF_COUNT_CACHE_MISSES fd");
-               tst_exit();
        }

-       for (;;) {
+       do {
+
                ret = read(fd1, &count1, sizeof(count1));
-               assert(ret == 8);
-               ret = read(fd2, &count2, sizeof(count2));
-               assert(ret == 8);
-               printf("counter1 value: %Ld instructions\n", count1);
-               printf("counter2 value: %Ld cachemisses\n",  count2);
-               sleep(1);
-       }
-       return 0;
+
+               if (ret == sizeof(count1)) {
+
+                       ret = read(fd2, &count2, sizeof(count2));
+
+                       if (ret == sizeof(count2)) {
+                               tst_resm(TINFO,
+                                       "counter1 value: %Ld instructions",
+                                       count1);
+                               tst_resm(TINFO,
+                                       "counter2 value: %Ld cachemisses",
+                                       count2);
+                               sleep(1);
+                       }
+
+               }
+
+       } while (ret == sizeof(unsigned long long));
+
+       tst_exit();
+
 }

Index: ./performance_counters/performance_counter02.c
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/performance_counters/performance_counter02.c,v
retrieving revision 1.4
diff -u -r1.4 performance_counter02.c
--- ./performance_counters/performance_counter02.c      27 Nov 2009
08:15:35 -0000      1.4
+++ ./performance_counters/performance_counter02.c      27 Nov 2009
08:31:33 -0000
@@ -154,6 +154,18 @@
        int verbose = 0;
        double ratio;

+       /*
+        * Kernel performance counters weren't available until 2.6.31 --
+        * http://lwn.net/Articles/311850/
+        *
+        * The syscalls don't return -1 // errno == ENOSYS either. Weird.
+        */
+       if (tst_kvercmp(2, 6, 31) < 0) {
+               tst_brkm(TCONF, cleanup,
+                       "performance_counter support only available in "
+                       "2.6.31+");
+       }
+
        nhw = 8;
        while ((i = getopt(ac, av, "c:v")) != -1) {
                switch (i) {

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
