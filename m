Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <aelder@sgi.com>) id 1Q9eEY-0006Yx-Fd
	for ltp-list@lists.sourceforge.net; Tue, 12 Apr 2011 14:06:22 +0000
Received: from relay2.sgi.com ([192.48.179.30] helo=relay.sgi.com)
	by sog-mx-4.v43.ch3.sourceforge.com with smtp (Exim 4.74)
	id 1Q9eEX-0001T2-Hx
	for ltp-list@lists.sourceforge.net; Tue, 12 Apr 2011 14:06:22 +0000
From: Alex Elder <aelder@sgi.com>
Date: Tue, 12 Apr 2011 09:06:05 -0500
Message-Id: <82d126fd4b5d31d98a4756c15b686c9e5576b0e5.1302617105.git.aelder@sgi.com>
In-Reply-To: <1302617166-10309-1-git-send-email-aelder@sgi.com>
References: <1302617166-10309-1-git-send-email-aelder@sgi.com>
In-Reply-To: <cb4b455094351bcefd98c7095f3639dd14498bca.1302617105.git.aelder@sgi.com>
References: <cb4b455094351bcefd98c7095f3639dd14498bca.1302617105.git.aelder@sgi.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------true"
Subject: [LTP] [PATCH 2/3] ltp: fix warnings in "aio-stress.c"
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
To: ltp-list@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------true
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: quoted-printable


In "testcases/kernel/io/ltp-aiodio/aio-stress.c" there are a number
of warnings that show up due to mismatches between fprintf()
conversion specifications and the variables being formatted.

Fix most of these by casting the variables to the right type; in one
case a "%td" is used to signify a ptrdiff_t variable.

Updated to address comments made by Garrett Cooper in review.
However, both "file_size" and "context_offset" variables represent
file offsets, and therefore should remain type off_t (rather than
size_t, which was recommended).  Some printf() formats were adjusted
to use %ld/(long) for printing off_t values.  Also updated some
whitespace, and now use "I/O" consistently, as requested.

Signed-off-by: Alex Elder <aelder@sgi.com>
---
 testcases/kernel/io/ltp-aiodio/aio-stress.c |   40 +++++++++++++++------=
-----
 1 files changed, 23 insertions(+), 17 deletions(-)


--------------true
Content-Type: text/x-patch; name="0002-ltp-fix-warnings-in-aio-stress.c.patch"
Content-Disposition: attachment;
	filename="0002-ltp-fix-warnings-in-aio-stress.c.patch"
Content-Transfer-Encoding: quoted-printable

diff --git a/testcases/kernel/io/ltp-aiodio/aio-stress.c b/testcases/kern=
el/io/ltp-aiodio/aio-stress.c
index e77f5be..c660cfe 100644
--- a/testcases/kernel/io/ltp-aiodio/aio-stress.c
+++ b/testcases/kernel/io/ltp-aiodio/aio-stress.c
@@ -161,16 +161,16 @@ struct io_oper {
     /* read,write, random, etc */
     int rw;
=20
-    /* number of ios that will get sent to aio */
+    /* number of I/O that will get sent to aio */
     int total_ios;
=20
-    /* number of ios we've already sent */
+    /* number of I/O we've already sent */
     int started_ios;
=20
     /* last offset used in an io operation */
     off_t last_offset;
=20
-    /* stonewalled =3D 1 when we got cut off before submitting all our i=
os */
+    /* stonewalled =3D 1 when we got cut off before submitting all our I=
/O */
     int stonewalled;
=20
     /* list management */
@@ -217,7 +217,7 @@ struct thread_info {
     /* list of io units available for io */
     struct io_unit *free_ious;
=20
-    /* number of io units in the ios array */
+    /* number of io units in the I/O array */
     int num_global_ios;
=20
     /* number of io units in flight */
@@ -745,7 +745,7 @@ resubmit:
     calc_latency(&start_time, &stop_time, &t->io_submit_latency);
=20
     if (ret !=3D num_ios) {
-	/* some ios got through */
+	/* some I/O got through */
 	if (ret > 0) {
 	    update_iou_counters(my_iocbs, ret, &stop_time);
 	    my_iocbs +=3D ret;
@@ -1165,7 +1165,7 @@ restart:
=20
     if (t->stage_mb_trans && t->num_files > 0) {
         double seconds =3D time_since_now(&stage_time);
-	fprintf(stderr, "thread %d %s totals (%.2f MB/s) %.2f MB in %.2fs\n",
+	fprintf(stderr, "thread %td %s totals (%.2f MB/s) %.2f MB in %.2fs\n",
 	        t - global_thread_info, this_stage, t->stage_mb_trans/seconds,
 		t->stage_mb_trans, seconds);
     }
@@ -1270,8 +1270,10 @@ void print_usage(void) {
     printf("\t-s size in MB of the test file(s), default 1024MB\n");
     printf("\t-r record size in KB used for each io, default 64KB\n");
     printf("\t-d number of pending aio requests for each file, default 6=
4\n");
-    printf("\t-i number of ios per file sent before switching\n\t   to t=
he next file, default 8\n");
-    printf("\t-I total number of ayncs IOs the program will run, default=
 is run until Cntl-C\n");
+    printf("\t-i number of I/O per file sent before switching\n"
+	    "\t   to the next file, default 8\n");
+    printf("\t-I total number of ayncs I/O the program will run, "
+	    "default is run until Cntl-C\n");
     printf("\t-O Use O_DIRECT (not available in 2.4 kernels),\n");
     printf("\t-S Use O_SYNC for writes\n");
     printf("\t-o add an operation to the list: write=3D0, read=3D1,\n");
@@ -1391,7 +1393,7 @@ int main(int ac, char **av)
     }
=20
     /*
-     * make sure we don't try to submit more ios than we have allocated
+     * make sure we don't try to submit more I/O than we have allocated
      * memory for
      */
     if (depth < io_iter) {
@@ -1426,7 +1428,7 @@ int main(int ac, char **av)
         max_io_submit =3D num_files * io_iter * num_contexts;
=20
     /*
-     * make sure we don't try to submit more ios than max_io_submit allo=
ws
+     * make sure we don't try to submit more I/O than max_io_submit allo=
ws
      */
     if (max_io_submit < io_iter) {
         io_iter =3D max_io_submit;
@@ -1446,17 +1448,21 @@ int main(int ac, char **av)
     }
=20
     if (file_size < num_contexts * context_offset) {
-        fprintf(stderr, "file size %Lu too small for %d contexts\n",
-	        file_size, num_contexts);
+        fprintf(stderr, "file size %ld too small for %d contexts\n",
+	        (long)file_size, num_contexts);
 	exit(1);
     }
=20
-    fprintf(stderr, "file size %LuMB, record size %luKB, depth %d, ios p=
er iteration %d\n", file_size / (1024 * 1024), rec_len / 1024, depth, io_=
iter);
+    fprintf(stderr, "file size %ldMB, record size %ldKB, depth %d, "
+	    "I/O per iteration %d\n",
+	    (long)(file_size / (1024 * 1024)),
+	    rec_len / 1024, depth, io_iter);
     fprintf(stderr, "max io_submit %d, buffer alignment set to %luKB\n",
             max_io_submit, (page_size_mask + 1)/1024);
-    fprintf(stderr, "threads %d files %d contexts %d context offset %LuM=
B verification %s\n",
-            num_threads, num_files, num_contexts,
-	    context_offset / (1024 * 1024), verify ? "on" : "off");
+    fprintf(stderr, "threads %d files %d contexts %d context offset %ldM=
B "
+	    "verification %s\n", num_threads, num_files, num_contexts,
+	    (long)(context_offset / (1024 * 1024)),
+	    verify ? "on" : "off");
     /* open all the files and do any required setup for them */
     for (i =3D optind ; i < ac ; i++) {
 	int thread_index;
@@ -1508,4 +1514,4 @@ int main(int ac, char **av)
 	exit(1);
     }
     return status;
-}
\ No newline at end of file
+}

--------------true
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Forrester Wave Report - Recovery time is now measured in hours and minutes
not days. Key insights are discussed in the 2010 Forrester Wave Report as
part of an in-depth evaluation of disaster recovery service providers.
Forrester found the best-in-class provider in terms of services and vision.
Read this report now!  http://p.sf.net/sfu/ibm-webcastpromo
--------------true
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------true--



