From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Fri, 29 Sep 2017 12:23:15 +0200
Subject: [LTP] [PATCH v5 7/7] Convert cve-2017-2671 to use long running
	threads
In-Reply-To: <20170929102315.32691-1-rpalethorpe@suse.com>
References: <20170929102315.32691-1-rpalethorpe@suse.com>
Message-ID: <20170929102315.32691-7-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 testcases/cve/cve-2017-2671.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/testcases/cve/cve-2017-2671.c b/testcases/cve/cve-2017-2671.c
index 77744db42..b0471bfff 100644
--- a/testcases/cve/cve-2017-2671.c
+++ b/testcases/cve/cve-2017-2671.c
@@ -49,13 +49,15 @@
 
 #include "tst_fuzzy_sync.h"
 
-#define ATTEMPTS 0xFFFF
+#define ATTEMPTS 0x80000
 #define PING_SYSCTL_PATH "/proc/sys/net/ipv4/ping_group_range"
 
 static int sockfd;
 static unsigned int ping_min_grp, ping_max_grp;
 static struct tst_fzsync_pair fzsync_pair = TST_FZSYNC_PAIR_INIT;
 static struct sockaddr_in iaddr, uaddr;
+static pthread_t thrd;
+static void *connect_b(void *);
 
 static void setup(void)
 {
@@ -73,13 +75,20 @@ static void setup(void)
 	SAFE_FILE_PRINTF(PING_SYSCTL_PATH, "0 0");
 
 	sockfd = SAFE_SOCKET(AF_INET, SOCK_DGRAM, IPPROTO_ICMP);
+	SAFE_PTHREAD_CREATE(&thrd, 0, connect_b, 0);
 	tst_res(TINFO, "Created ping socket, attempting to race...");
 }
 
 static void cleanup(void)
 {
+	if (thrd) {
+		tst_fzsync_pair_exit(&fzsync_pair);
+		SAFE_PTHREAD_JOIN(thrd, NULL);
+	}
+
 	if (sockfd > 0)
 		SAFE_CLOSE(sockfd);
+
 	if (ping_min_grp | ping_max_grp)
 		SAFE_FILE_PRINTF(PING_SYSCTL_PATH, "%u %u",
 				 ping_min_grp, ping_max_grp);
@@ -87,32 +96,31 @@ static void cleanup(void)
 
 static void *connect_b(void * param LTP_ATTRIBUTE_UNUSED)
 {
-	tst_fzsync_delay_b(&fzsync_pair);
-	connect(sockfd, (struct sockaddr *)&uaddr, sizeof(uaddr));
-	tst_fzsync_time_b(&fzsync_pair);
+	while(tst_fzsync_wait_update_b(&fzsync_pair)) {
+		tst_fzsync_delay_b(&fzsync_pair);
+		connect(sockfd, (struct sockaddr *)&uaddr, sizeof(uaddr));
+		tst_fzsync_time_b(&fzsync_pair);
+		if (!tst_fzsync_wait_b(&fzsync_pair))
+			break;
+	}
 
 	return 0;
 }
 
 static void run(void)
 {
-	pthread_t thrd;
 	int i;
 
 	for (i = 0; i < ATTEMPTS; i++) {
 		SAFE_CONNECT(sockfd,
 			     (struct sockaddr *)&iaddr, sizeof(iaddr));
-		SAFE_PTHREAD_CREATE(&thrd, 0, connect_b, 0);
 
+		tst_fzsync_wait_update_a(&fzsync_pair);
 		tst_fzsync_delay_a(&fzsync_pair);
 		connect(sockfd, (struct sockaddr *)&uaddr, sizeof(uaddr));
 		tst_fzsync_time_a(&fzsync_pair);
 
-		SAFE_PTHREAD_JOIN(thrd, 0);
-		tst_fzsync_pair_update(i, &fzsync_pair);
-
-		if (!(i & 0x7FFF))
-			tst_fzsync_pair_info(&fzsync_pair);
+		tst_fzsync_wait_a(&fzsync_pair);
 	}
 
 	tst_res(TPASS, "We didn't crash");
-- 
2.14.1

