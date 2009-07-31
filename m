Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <kiran@linux.vnet.ibm.com>) id 1MWrS7-0003ux-SW
	for ltp-list@lists.sourceforge.net; Fri, 31 Jul 2009 12:43:15 +0000
Received: from e3.ny.us.ibm.com ([32.97.182.143])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MWrS1-0007Oc-OP
	for ltp-list@lists.sourceforge.net; Fri, 31 Jul 2009 12:43:15 +0000
From: Kiran <kiran@linux.vnet.ibm.com>
Date: Fri, 31 Jul 2009 18:12:31 +0530
Message-Id: <1249044151.5432.73.camel@kiran-laptop>
Mime-Version: 1.0
Subject: [LTP] [PATCH 2/3] libstats: replace data->size by data->index
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

This patch replaces the occurrences of data->size by data->index+1 as
the index starts with 0 and ends at data->size-1.
data->size holds the max size of the records list in data->container_t.
data->index holds the index of the last record in the list. Since the
records list may not be completely filled, data->index + 1 gives the
total number of records currently in the list and it may not be equal to
data->size. 

Signed-off-by: Kiran Prakash <kiran@linux.vnet.ibm.com>
Acked-by: Gowrishankar <gowrishankar.m@in.ibm.com>
Acked-by: Darren Hart <dvhltc@us.ibm.com>
Acked-by: Sripathi Kodi <sripathik@in.ibm.com> 

diff -upr ltp-full-20090531_orig/testcases/realtime/lib/libstats.c ltp-full-20090531/testcases/realtime/lib/libstats.c
--- ltp-full-20090531_orig/testcases/realtime/lib/libstats.c	2009-07-22 21:12:47.000000000 +0530
+++ ltp-full-20090531/testcases/realtime/lib/libstats.c	2009-07-22 21:16:59.000000000 +0530
@@ -105,7 +105,7 @@ int stats_container_free(stats_container
 int stats_sort(stats_container_t *data, enum stats_sort_method method)
 {
 	// method not implemented, always ascending on y atm
-	qsort(data->records, data->size, sizeof(stats_record_t),
+	qsort(data->records, data->index + 1, sizeof(stats_record_t),
 	      stats_record_compare);
 	return 0;
 }
@@ -117,7 +117,7 @@ float stats_stddev(stats_container_t *da
 	long n;
 
 	sd = 0.0;
-	n = data->size;
+	n = data->index + 1;
 	sum = 0.0;
 
 	/* calculate the mean */
@@ -145,7 +145,7 @@ float stats_avg(stats_container_t *data)
 	float avg, sum;
 	long n;
 
-	n = data->size;
+	n = data->index + 1;
 	sum = 0.0;
 
 	/* calculate the mean */
@@ -163,7 +163,7 @@ long stats_min(stats_container_t *data)
 	long min;
 	long n;
 
-	n = data->size;
+	n = data->index + 1;
 
 	/* calculate the mean */
 	min = data->records[0].y;
@@ -182,7 +182,7 @@ long stats_max(stats_container_t *data)
 	long max;
 	long n;
 
-	n = data->size;
+	n = data->index + 1;
 
 	/* calculate the mean */
 	max = data->records[0].y;
@@ -223,16 +223,17 @@ int stats_quantiles_calc(stats_container
 	int index;
 
 	// check for sufficient data size of accurate calculation
-	if (data->size <= 0 || data->size < (long)exp10(quantiles->nines)) {
+	if (data->index < 0 || (data->index + 1) \
+	    < (long)exp10(quantiles->nines)) {
 		//printf("ERROR: insufficient data size for %d nines\n", data->size);
 		return -1;
 	}
 
-	size = data->size;
+	size = data->index + 1;
 	stats_sort(data, ASCENDING_ON_Y);
 
 	for (i = 2; i <= quantiles->nines; i++) {
-		index = data->size - data->size / exp10(i);
+		index = size - size / exp10(i);
 		quantiles->quantiles[i-2] = data->records[index].y;
 	}
 	return 0;
@@ -259,13 +260,13 @@ int stats_hist(stats_container_t *hist, 
 
 	ret = 0;
 
-	if (hist->size <= 0 || data->size <= 0) {
+	if (hist->size <= 0 || data->index < 0) {
 		return -1;
 	}
 
 	/* calculate the range of dataset */
 	min = max = data->records[0].y;
-	for (i = 0; i < data->size; i++) {
+	for (i = 0; i <= data->index; i++) {
 		y = data->records[i].y;
 		if (y > max) max = y;
 		if (y < min) min = y;
@@ -284,7 +285,7 @@ int stats_hist(stats_container_t *hist, 
 	}
 
 	/* fill in the counts */
-	for (i = 0; i < data->size; i++) {
+	for (i = 0; i <= data->index; i++) {
 		y = data->records[i].y;
 		b = MIN((y-min)/width, hist->size-1);
 		//printf("%d will go in bucket %d\n", y, b);
@@ -336,8 +337,8 @@ int stats_container_save(char *filename,
         return -1;
     } else {
         minx = maxx = data->records[0].x;
-        miny = maxy = data->records[0].y;
-        for (i = 0; i < data->size; i++) {
+	miny = maxy = data->records[0].y;
+	for (i = 0; i <= data->index; i++) {
             rec = &data->records[i];
             minx = MIN(minx, rec->x);
             maxx = MAX(maxx, rec->x);


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
