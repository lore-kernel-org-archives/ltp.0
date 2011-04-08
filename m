Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <aelder@sgi.com>) id 1Q8IOE-0008DA-0z
	for ltp-list@lists.sourceforge.net; Fri, 08 Apr 2011 20:34:46 +0000
Received: from relay2.sgi.com ([192.48.179.30] helo=relay.sgi.com)
	by sog-mx-2.v43.ch3.sourceforge.com with smtp (Exim 4.74)
	id 1Q8IOD-0004cI-6Z
	for ltp-list@lists.sourceforge.net; Fri, 08 Apr 2011 20:34:45 +0000
From: Alex Elder <aelder@sgi.com>
Date: Fri,  8 Apr 2011 15:34:34 -0500
Message-Id: <57c873600371b0d63d046e940cea750c2e70618a.1302294850.git.aelder@sgi.com>
In-Reply-To: <1302294875-6898-1-git-send-email-aelder@sgi.com>
References: <1302294875-6898-1-git-send-email-aelder@sgi.com>
In-Reply-To: <2fb6f8d9dc82ef63e3c7cd80151cb6ea7972aae9.1302294850.git.aelder@sgi.com>
References: <2fb6f8d9dc82ef63e3c7cd80151cb6ea7972aae9.1302294850.git.aelder@sgi.com>
Subject: [LTP] [PATCH 3/4] ltp: kill warnings related to formatting off_t in
	"aio-stress.c"
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

In "testcases/kernel/io/ltp-aiodio/aio-stress.c" there are a number
of warnings that show up due to mismatches between fprintf()
conversion specifications and the variables being formatted.

Fix most of these by casting the variables to the right type; in one
case a "%td" is used to signify a ptrdiff_t variable.

Signed-off-by: Alex Elder <aelder@sgi.com>
---
 testcases/kernel/io/ltp-aiodio/aio-stress.c |   18 +++++++++++-------
 1 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/io/ltp-aiodio/aio-stress.c b/testcases/kernel/io/ltp-aiodio/aio-stress.c
index e77f5be..cd0b211 100644
--- a/testcases/kernel/io/ltp-aiodio/aio-stress.c
+++ b/testcases/kernel/io/ltp-aiodio/aio-stress.c
@@ -1165,7 +1165,7 @@ restart:
 
     if (t->stage_mb_trans && t->num_files > 0) {
         double seconds = time_since_now(&stage_time);
-	fprintf(stderr, "thread %d %s totals (%.2f MB/s) %.2f MB in %.2fs\n",
+	fprintf(stderr, "thread %td %s totals (%.2f MB/s) %.2f MB in %.2fs\n",
 	        t - global_thread_info, this_stage, t->stage_mb_trans/seconds,
 		t->stage_mb_trans, seconds);
     }
@@ -1447,16 +1447,20 @@ int main(int ac, char **av)
 
     if (file_size < num_contexts * context_offset) {
         fprintf(stderr, "file size %Lu too small for %d contexts\n",
-	        file_size, num_contexts);
+	        (unsigned long long) file_size, num_contexts);
 	exit(1);
     }
 
-    fprintf(stderr, "file size %LuMB, record size %luKB, depth %d, ios per iteration %d\n", file_size / (1024 * 1024), rec_len / 1024, depth, io_iter);
+    fprintf(stderr, "file size %LuMB, record size %luKB, depth %d, "
+	    "ios per iteration %d\n",
+	    (unsigned long long) (file_size / (1024 * 1024)),
+	    rec_len / 1024, depth, io_iter);
     fprintf(stderr, "max io_submit %d, buffer alignment set to %luKB\n",
             max_io_submit, (page_size_mask + 1)/1024);
-    fprintf(stderr, "threads %d files %d contexts %d context offset %LuMB verification %s\n",
-            num_threads, num_files, num_contexts,
-	    context_offset / (1024 * 1024), verify ? "on" : "off");
+    fprintf(stderr, "threads %d files %d contexts %d context offset %LuMB "
+	    "verification %s\n", num_threads, num_files, num_contexts,
+	    (unsigned long long) context_offset / (1024 * 1024),
+	    verify ? "on" : "off");
     /* open all the files and do any required setup for them */
     for (i = optind ; i < ac ; i++) {
 	int thread_index;
@@ -1508,4 +1512,4 @@ int main(int ac, char **av)
 	exit(1);
     }
     return status;
-}
\ No newline at end of file
+}
-- 
1.7.4


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
