Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1YfS8S-0004QX-P6
	for ltp-list@lists.sourceforge.net; Tue, 07 Apr 2015 11:57:40 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YfS8R-0005MX-AB
	for ltp-list@lists.sourceforge.net; Tue, 07 Apr 2015 11:57:40 +0000
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (Postfix) with ESMTPS id AEC3F2D154E
	for <ltp-list@lists.sourceforge.net>;
	Tue,  7 Apr 2015 11:57:32 +0000 (UTC)
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with
	ESMTP id t37BvVWx021700
	for <ltp-list@lists.sourceforge.net>; Tue, 7 Apr 2015 07:57:32 -0400
From: Jan Stancek <jstancek@redhat.com>
Date: Tue,  7 Apr 2015 13:57:28 +0200
Message-Id: <fcfdc0e76da63f0dac43e44738a6d5f85e638ada.1428407537.git.jstancek@redhat.com>
Subject: [LTP] [PATCH] mtest06: pick a distant address to mmap at
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

Test expects, that either file is mmaped and read will
result in expected pattern or file is not mapped and
read will trigger SIGSEGV.

However there is also possibility that unrelated mmap,
(e.g. from pthread_exit or printf call chain) will pick the
same area between munmap/mmap calls for map_address, which
creates a race where data read from map_address are unexpected.

This patch makes a dummy mmap/munmap of large block to find
some distant location, where futher mmap calls are unlikely
to occur. Middle of this area is then used to mmap map_address.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/mem/mtest06/mmap1.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/mem/mtest06/mmap1.c b/testcases/kernel/mem/mtest06/mmap1.c
index 5f13d48..f3eae99 100644
--- a/testcases/kernel/mem/mtest06/mmap1.c
+++ b/testcases/kernel/mem/mtest06/mmap1.c
@@ -54,6 +54,7 @@
 #include <string.h>
 #include "test.h"
 
+#define DISTANT_MMAP_SIZE (64*1024*1024)
 #define OPT_MISSING(prog, opt) do { \
 	fprintf(stderr, "%s: option -%c ", prog, opt); \
         fprintf(stderr, "requires an argument\n"); \
@@ -64,6 +65,7 @@ static int verbose_print = 0;
 static char *volatile map_address;
 static jmp_buf jmpbuf;
 static volatile char read_lock = 0;
+static void *distant_area;
 
 char *TCID = "mmap1";
 int TST_TOTAL = 1;
@@ -145,9 +147,8 @@ void *map_write_unmap(void *ptr)
 			 args[0], args[1], args[2]);
 
 	for (i = 0; i < args[2]; i++) {
-
-		map_address = mmap(0, (size_t) args[1], PROT_WRITE | PROT_READ,
-				   MAP_SHARED, (int)args[0], 0);
+		map_address = mmap(distant_area, (size_t) args[1],
+			PROT_WRITE | PROT_READ, MAP_SHARED, (int)args[0], 0);
 
 		if (map_address == (void *)-1) {
 			perror("map_write_unmap(): mmap()");
@@ -337,6 +338,19 @@ int main(int argc, char **argv)
 		}
 	}
 
+	/* We don't want other mmap calls to map into same area as is
+	 * used for test (mmap_address). The test expects read to return
+	 * test pattern or read must fail with SIGSEGV. Find an area
+	 * that we can use, which is unlikely to be chosen for other
+	 * mmap calls. */
+	distant_area = mmap(0, DISTANT_MMAP_SIZE, PROT_WRITE | PROT_READ,
+		MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
+	if (distant_area == (void *)-1)
+		tst_brkm(TBROK | TERRNO, NULL, "distant_area: mmap()");
+	if (munmap(distant_area, (size_t) DISTANT_MMAP_SIZE) == -1)
+		tst_brkm(TBROK | TERRNO, NULL, "distant_area: munmap()");
+	distant_area += DISTANT_MMAP_SIZE / 2;
+
 	if (verbose_print)
 		tst_resm(TINFO, "Input parameters are: File size:  %d; "
 			 "Scheduled to run:  %lf hours; "
-- 
1.8.3.1


------------------------------------------------------------------------------
BPM Camp - Free Virtual Workshop May 6th at 10am PDT/1PM EDT
Develop your own process in accordance with the BPMN 2 standard
Learn Process modeling best practices with Bonita BPM through live exercises
http://www.bonitasoft.com/be-part-of-it/events/bpm-camp-virtual- event?utm_
source=Sourceforge_BPM_Camp_5_6_15&utm_medium=email&utm_campaign=VA_SF
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
