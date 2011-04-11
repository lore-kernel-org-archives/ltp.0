Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <aelder@sgi.com>) id 1Q9LuA-00012e-GO
	for ltp-list@lists.sourceforge.net; Mon, 11 Apr 2011 18:32:06 +0000
Received: from relay1.sgi.com ([192.48.179.29] helo=relay.sgi.com)
	by sog-mx-1.v43.ch3.sourceforge.com with smtp (Exim 4.74)
	id 1Q9Lu9-0006t3-ID
	for ltp-list@lists.sourceforge.net; Mon, 11 Apr 2011 18:32:06 +0000
Received: from cf--amer001e--3.americas.sgi.com
	(cf--amer001e--3.americas.sgi.com [137.38.100.5])
	by relay1.corp.sgi.com (Postfix) with ESMTP id 1BAA18F8050
	for <ltp-list@lists.sourceforge.net>;
	Mon, 11 Apr 2011 11:32:00 -0700 (PDT)
From: Alex Elder <aelder@sgi.com>
Date: Mon, 11 Apr 2011 13:31:50 -0500
Message-ID: <1302546710.2580.27.camel@doink>
Mime-Version: 1.0
Subject: [LTP] [PATCH 2/3, v2] ltp: fix warnings in "aio-stress.c"
Reply-To: aelder@sgi.com
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
To: ltp-list@lists.sourceforge.net

In "testcases/kernel/io/ltp-aiodio/aio-stress.c" there are a
number of warnings that show up due to mismatches between
fprintf() conversion specifications and the variables being
formatted.

Fix most of these by casting the variables to the right type;
in one case a "%td" is used to signify a ptrdiff_t variable.

Updated to address comments made by Garrett Cooper in review.
However, both "file_size" and "context_offset" variables represent
file offsets, and therefore should remain type off_t (rather than
size_t, which was recommended).  Some printf() formats were
adjusted to use %ld/(long) for printing off_t values.

Signed-off-by: Alex Elder <aelder@sgi.com>

---
 ltp/aio-stress.c |   39 ++++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

Index: b/ltp/aio-stress.c
===================================================================
--- a/ltp/aio-stress.c
+++ b/ltp/aio-stress.c
@@ -161,16 +161,16 @@ struct io_oper {
     /* read,write, random, etc */
     int rw;
 
-    /* number of ios that will get sent to aio */
+    /* number of I/O's that will get sent to aio */
     int total_ios;
 
-    /* number of ios we've already sent */
+    /* number of I/O's we've already sent */
     int started_ios;
 
     /* last offset used in an io operation */
     off_t last_offset;
 
-    /* stonewalled = 1 when we got cut off before submitting all our
ios */
+    /* stonewalled = 1 when we got cut off before submitting all our
I/O's */
     int stonewalled;
 
     /* list management */
@@ -217,7 +217,7 @@ struct thread_info {
     /* list of io units available for io */
     struct io_unit *free_ious;
 
-    /* number of io units in the ios array */
+    /* number of io units in the I/O array */
     int num_global_ios;
 
     /* number of io units in flight */
@@ -745,7 +745,7 @@ resubmit:
     calc_latency(&start_time, &stop_time, &t->io_submit_latency);
 
     if (ret != num_ios) {
-       /* some ios got through */
+       /* some I/O's got through */
        if (ret > 0) {
            update_iou_counters(my_iocbs, ret, &stop_time);
            my_iocbs += ret;
@@ -1165,7 +1165,7 @@ restart:
 
     if (t->stage_mb_trans && t->num_files > 0) {
         double seconds = time_since_now(&stage_time);
-       fprintf(stderr, "thread %d %s totals (%.2f MB/s) %.2f MB in
%.2fs\n",
+       fprintf(stderr, "thread %td %s totals (%.2f MB/s) %.2f MB in
%.2fs\n",
                t - global_thread_info, this_stage,
t->stage_mb_trans/seconds,
                t->stage_mb_trans, seconds);
     }
@@ -1270,8 +1270,10 @@ void print_usage(void) {
     printf("\t-s size in MB of the test file(s), default 1024MB\n");
     printf("\t-r record size in KB used for each io, default 64KB\n");
     printf("\t-d number of pending aio requests for each file, default
64\n");
-    printf("\t-i number of ios per file sent before switching\n\t   to
the next file, default 8\n");
-    printf("\t-I total number of ayncs IOs the program will run,
default is run until Cntl-C\n");
+    printf("\t-i number of I/O's per file sent before switching\n"
+           "\t   to the next file, default 8\n");
+    printf("\t-I total number of ayncs I/Os the program will run, "
+           "default is run until Cntl-C\n");
     printf("\t-O Use O_DIRECT (not available in 2.4 kernels),\n");
     printf("\t-S Use O_SYNC for writes\n");
     printf("\t-o add an operation to the list: write=0, read=1,\n");
@@ -1391,7 +1393,7 @@ int main(int ac, char **av)
     }
 
     /*
-     * make sure we don't try to submit more ios than we have allocated
+     * make sure we don't try to submit more I/O's than we have
allocated
      * memory for
      */
     if (depth < io_iter) {
@@ -1426,7 +1428,7 @@ int main(int ac, char **av)
         max_io_submit = num_files * io_iter * num_contexts;
 
     /*
-     * make sure we don't try to submit more ios than max_io_submit
allows
+     * make sure we don't try to submit more I/O's than max_io_submit
allows
      */
     if (max_io_submit < io_iter) {
         io_iter = max_io_submit;
@@ -1446,17 +1448,21 @@ int main(int ac, char **av)
     }
 
     if (file_size < num_contexts * context_offset) {
-        fprintf(stderr, "file size %Lu too small for %d contexts\n",
-               file_size, num_contexts);
+        fprintf(stderr, "file size %ld too small for %d contexts\n",
+               (long) file_size, num_contexts);
        exit(1);
     }
 
-    fprintf(stderr, "file size %LuMB, record size %luKB, depth %d, ios
per iteration %d\n", file_size / (1024 * 1024), rec_len / 1024, depth,
io_iter);
+    fprintf(stderr, "file size %ldMB, record size %ldKB, depth %d, "
+           "I/O's per iteration %d\n",
+           (long) (file_size / (1024 * 1024)),
+           rec_len / 1024, depth, io_iter);
     fprintf(stderr, "max io_submit %d, buffer alignment set to %luKB
\n",
             max_io_submit, (page_size_mask + 1)/1024);
-    fprintf(stderr, "threads %d files %d contexts %d context offset %
LuMB verification %s\n",
-            num_threads, num_files, num_contexts,
-           context_offset / (1024 * 1024), verify ? "on" : "off");
+    fprintf(stderr, "threads %d files %d contexts %d context offset %
ldMB "
+           "verification %s\n", num_threads, num_files, num_contexts,
+           (long) (context_offset / (1024 * 1024)),
+           verify ? "on" : "off");
     /* open all the files and do any required setup for them */
     for (i = optind ; i < ac ; i++) {
        int thread_index;
@@ -1508,4 +1514,4 @@ int main(int ac, char **av)
        exit(1);
     }
     return status;
-}
\ No newline at end of file
+}


------------------------------------------------------------------------------
Xperia(TM) PLAY
It's a major breakthrough. An authentic gaming
smartphone on the nation's most reliable network.
And it wants your games.
http://p.sf.net/sfu/verizon-sfdev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
