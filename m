Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <kiran@linux.vnet.ibm.com>) id 1MWrRr-000883-7G
	for ltp-list@lists.sourceforge.net; Fri, 31 Jul 2009 12:42:59 +0000
Received: from e39.co.us.ibm.com ([32.97.110.160])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MWrRl-0002zT-Ck
	for ltp-list@lists.sourceforge.net; Fri, 31 Jul 2009 12:42:59 +0000
From: Kiran <kiran@linux.vnet.ibm.com>
Date: Fri, 31 Jul 2009 18:12:28 +0530
Message-Id: <1249044148.5432.72.camel@kiran-laptop>
Mime-Version: 1.0
Subject: [LTP] [PATCH 1/3] libstats: add append API to libstats
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
To: ltp-list <ltp-list@lists.sf.net>
Cc: gowrishankar.m@in.ibm.com

This patch adds a new API stats_container_append to libstats. This
function adds a new stats_record_t to the records list in
stats_container_t. 

Signed-off-by: Kiran Prakash <kiran@linux.vnet.ibm.com>
Acked-by: Gowrishankar <gowrishankar.m@in.ibm.com>
Acked-by: Darren Hart <dvhltc@us.ibm.com>
Acked-by: Sripathi Kodi <sripathik@in.ibm.com>

diff -upr ltp-full-20090531_orig/testcases/realtime/include/libstats.h ltp-full-20090531/testcases/realtime/include/libstats.h
--- ltp-full-20090531_orig/testcases/realtime/include/libstats.h	2008-04-20 22:50:18.000000000 +0530
+++ ltp-full-20090531/testcases/realtime/include/libstats.h	2009-07-24 18:39:11.000000000 +0530
@@ -56,6 +56,7 @@ typedef struct stats_record {
 
 typedef struct stats_container {
 	long size;
+	long index;
 	stats_record_t *records;
 } stats_container_t;
 
@@ -162,4 +163,11 @@ void stats_hist_print(stats_container_t 
  */
 int stats_container_save(char *filename, char *title, char *labelx, char *labely, stats_container_t *data, char *mode);
 
+/* stats_container_append - appends stats_record_t to data
+ * data: stats_container_t structure for holding the records list, index of
+ *       min and max elements in records list and the sum
+ * rec: stats_record_t to be appended to the records list in data
+ * Returns the index of the appended record on success and -1 on error
+ */
+int stats_container_append(stats_container_t *data, stats_record_t rec);
 #endif /* LIBSTAT_H */
diff -upr ltp-full-20090531_orig/testcases/realtime/lib/libstats.c ltp-full-20090531/testcases/realtime/lib/libstats.c
--- ltp-full-20090531_orig/testcases/realtime/lib/libstats.c	2008-04-20 22:50:18.000000000 +0530
+++ ltp-full-20090531/testcases/realtime/lib/libstats.c	2009-07-25 21:10:06.000000000 +0530
@@ -31,6 +31,7 @@
  *
  * HISTORY
  *      2006-Oct-17: Initial version by Darren Hart
+ *      2009-Jul-22: Addition of stats_container_append function by Kiran Prakash
  *
  * TODO: the save routine for gnuplot plotting should be more modular...
  *
@@ -43,6 +44,7 @@
 #include <unistd.h>
 #include <math.h>
 #include <libstats.h>
+#include <librttest.h>
 
 int save_stats = 0;
 
@@ -62,12 +64,26 @@ static int stats_record_compare(const vo
 int stats_container_init(stats_container_t *data, long size)
 {
 	data->size = size;
+	data->index = -1;
 	data->records = calloc(size, sizeof(stats_record_t));
 	if (!data->records)
 		return -1;
 	return 0;
 }
 
+int stats_container_append(stats_container_t *data, stats_record_t rec)
+{
+	int myindex = ++data->index;
+	if (myindex >= data->size) {
+		debug(DBG_ERR, "Number of elements cannot be more than %d\n",
+				data->size);
+		data->index--;
+		return -1;
+	}
+	data->records[myindex] = rec;
+	return myindex;
+}
+
 int stats_container_resize(stats_container_t *data, long size)
 {
 	stats_record_t *newrecords = realloc(data->records, size*sizeof(stats_record_t));

-- 

Thanks,
Kiran


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
