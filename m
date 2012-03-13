Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1S7UZd-00074H-DD
	for ltp-list@lists.sourceforge.net; Tue, 13 Mar 2012 16:27:45 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1S7UZU-0002JF-TL
	for ltp-list@lists.sourceforge.net; Tue, 13 Mar 2012 16:27:45 +0000
Received: from int-mx01.intmail.prod.int.phx2.redhat.com
	(int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q2DGRVQ1008771
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 13 Mar 2012 12:27:31 -0400
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with
	ESMTP id q2DGRQOH015775
	for <ltp-list@lists.sourceforge.net>; Tue, 13 Mar 2012 12:27:27 -0400
Message-ID: <4F5F756E.4010808@redhat.com>
Date: Tue, 13 Mar 2012 17:27:26 +0100
From: Jan Stancek <jstancek@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020803080600040100000909"
Subject: [LTP] [PATCH/RFC] mtest01: add option to limit max swap usage
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
--------------020803080600040100000909
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On large machines (with dozens of gigabytes of swap)
it can take significant time until it completes,
unless you specify "-p" parameter to set percent of total
memory to use. It is difficult to find value, that would fit
all setups. If the value is low, it won't exercise
conditions when memory is low. If the value is high it turns
into stress test, which can be swapping memory for hours.

This patch adds new option '-s', which stops test if swap
usage goes beyoned <s> MBytes. By default it is 0 - no limit.

For example:
     mtest01 -p 95 -w -s 4096
will keep allocating memory until 95% of total memory is used,
or swap usage is > 4GB.

This parameter is meant to be used in sanity tests, so that
malloc is exercised in situations with high/low memory
until system resorts to swapping, but ends when swap usage
is high enough.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
  testcases/kernel/mem/mtest01/mtest01.c |   17 +++++++++++++++--
  1 files changed, 15 insertions(+), 2 deletions(-)



--------------020803080600040100000909
Content-Type: text/x-patch;
	name="0001-mtest01-add-option-to-limit-max-swap-usage.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="0001-mtest01-add-option-to-limit-max-swap-usage.patch"

diff --git a/testcases/kernel/mem/mtest01/mtest01.c b/testcases/kernel/mem/mtest01/mtest01.c
index dc960a8..54bda70 100644
--- a/testcases/kernel/mem/mtest01/mtest01.c
+++ b/testcases/kernel/mem/mtest01/mtest01.c
@@ -67,6 +67,7 @@ int main(int argc, char* argv[])
 	unsigned long long original_maxbytes, maxbytes = 0;
 	unsigned long long pre_mem = 0, post_mem = 0;
 	unsigned long long total_ram, total_free, D, C;
+	unsigned long long used_swap, swap_max = 0;
 	int chunksize = 1024*1024; /* one meg at a time by default */
 	struct sysinfo sstats;
 	int i, pid_cntr;
@@ -78,7 +79,7 @@ int main(int argc, char* argv[])
 	sigemptyset(&act.sa_mask);
 	sigaction(SIGRTMIN,  &act, 0);
 	
-	while ((c = getopt(argc, argv, "c:b:p:wvh")) != -1) {
+	while ((c = getopt(argc, argv, "c:b:p:s:wvh")) != -1) {
 		switch(c) {
 		case 'c':
 			chunksize = atoi(optarg);
@@ -105,6 +106,10 @@ int main(int argc, char* argv[])
 				    "ERROR: -p option cannot be greater than "
 				    "99");
 			break;
+		case 's':
+			swap_max = atoi(optarg);
+			swap_max = swap_max * 1024 * 1024;
+			break;
 		case 'w':
 			dowrite = 1;
 			break;
@@ -116,7 +121,8 @@ int main(int argc, char* argv[])
 			printf("usage: %s [-c <bytes>] [-b <bytes>|-p <percent>] [-v]\n", argv[0]);
 			printf("\t-c <num>\tsize of chunk in bytes to malloc on each pass\n");
 			printf("\t-b <bytes>\tmaximum number of bytes to allocate before stopping\n");
-			printf("\t-p <bytes>\tpercent of total memory used at which the program stops\n");
+			printf("\t-p <percent>\tpercent of total memory used at which the program stops\n");
+			printf("\t-s <MBytes>\tstop when used swap is higher than <s> MB, default: 0 - no limit\n");
 			printf("\t-w\t\twrite to the memory after allocating\n");
 			printf("\t-v\t\tverbose\n");
 			printf("\t-h\t\tdisplay usage\n");
@@ -262,6 +268,13 @@ int main(int argc, char* argv[])
 				sysinfo(&sstats);
 				post_mem = (unsigned long long)sstats.mem_unit * sstats.freeram;
 				post_mem = post_mem + (unsigned long long)sstats.mem_unit * sstats.freeswap;
+
+				used_swap = sstats.mem_unit * (sstats.totalswap - sstats.freeswap);
+				if (swap_max > 0 && used_swap > swap_max) {
+					tst_resm(TINFO, "Reached max swap usage: %llu Mbytes > %llu MBytes",
+							used_swap / 1024 / 1024, swap_max / 1024 / 1024);
+					break;
+				}
 			}
 		}
 		while (pid_list[i] != 0) {


--------------020803080600040100000909
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Keep Your Developer Skills Current with LearnDevNow!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-d2d
--------------020803080600040100000909
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------020803080600040100000909--

