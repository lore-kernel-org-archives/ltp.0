Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1WcWD2-0007VP-If
	for ltp-list@lists.sourceforge.net; Tue, 22 Apr 2014 08:37:44 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WcWCz-0005X4-MN
	for ltp-list@lists.sourceforge.net; Tue, 22 Apr 2014 08:37:44 +0000
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s3M8bVHd012863
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 22 Apr 2014 04:37:31 -0400
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with
	ESMTP id s3M8bUJt000843
	for <ltp-list@lists.sourceforge.net>; Tue, 22 Apr 2014 04:37:31 -0400
From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 22 Apr 2014 10:37:19 +0200
Message-Id: <fd155c8dfbfcbe2e906879f0bd5e4fbe7fb16c9b.1398155754.git.jstancek@redhat.com>
Subject: [LTP] [PATCH 1/2] readahead02: fix signed/unsigned comparison
	warnings
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

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/readahead/readahead02.c |   22 +++++++++++---------
 1 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/testcases/kernel/syscalls/readahead/readahead02.c b/testcases/kernel/syscalls/readahead/readahead02.c
index 66158f0..8940821 100644
--- a/testcases/kernel/syscalls/readahead/readahead02.c
+++ b/testcases/kernel/syscalls/readahead/readahead02.c
@@ -120,7 +120,7 @@ static void drop_caches(void)
 	}
 }
 
-static long parse_entry(const char *fname, const char *entry)
+static unsigned long parse_entry(const char *fname, const char *entry)
 {
 	FILE *f;
 	long value = -1;
@@ -140,17 +140,17 @@ static long parse_entry(const char *fname, const char *entry)
 	return value;
 }
 
-static long get_bytes_read(void)
+static unsigned long get_bytes_read(void)
 {
 	char fname[128];
-	char entry[] = "read_bytes: %ld";
+	char entry[] = "read_bytes: %lu";
 	sprintf(fname, "/proc/%u/io", getpid());
 	return parse_entry(fname, entry);
 }
 
-static long get_cached_size(void)
+static unsigned long get_cached_size(void)
 {
-	char entry[] = "Cached: %ld";
+	char entry[] = "Cached: %lu";
 	return parse_entry(meminfo_fname, entry);
 }
 
@@ -158,7 +158,7 @@ static void create_testfile(void)
 {
 	FILE *f;
 	char *tmp;
-	int i;
+	size_t i;
 
 	tst_resm(TINFO, "creating test file of size: %ld", testfile_size);
 	tmp = SAFE_MALLOC(cleanup, pagesize);
@@ -197,9 +197,11 @@ static void create_testfile(void)
  * @cached: returns cached kB from /proc/meminfo
  */
 static void read_testfile(int do_readahead, const char *fname, size_t fsize,
-			  long *read_bytes, long *usec, long *cached)
+			  unsigned long *read_bytes, long *usec,
+			  unsigned long *cached)
 {
-	int fd, i;
+	int fd;
+	size_t i;
 	long read_bytes_start;
 	unsigned char *p, tmp;
 	unsigned long time_start_usec, time_end_usec;
@@ -261,9 +263,9 @@ static void read_testfile(int do_readahead, const char *fname, size_t fsize,
 
 static void test_readahead(void)
 {
-	long read_bytes, read_bytes_ra;
+	unsigned long read_bytes, read_bytes_ra;
 	long usec, usec_ra;
-	long cached_max, cached_low, cached, cached_ra;
+	unsigned long cached_max, cached_low, cached, cached_ra;
 	char proc_io_fname[128];
 	sprintf(proc_io_fname, "/proc/%u/io", getpid());
 
-- 
1.7.1


------------------------------------------------------------------------------
Start Your Social Network Today - Download eXo Platform
Build your Enterprise Intranet with eXo Platform Software
Java Based Open Source Intranet - Social, Extensible, Cloud Ready
Get Started Now And Turn Your Intranet Into A Collaboration Platform
http://p.sf.net/sfu/ExoPlatform
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
