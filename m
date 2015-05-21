Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <weijg.fnst@cn.fujitsu.com>) id 1YvG17-000595-Uf
	for ltp-list@lists.sourceforge.net; Thu, 21 May 2015 02:15:25 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YvG16-0008HT-1i
	for ltp-list@lists.sourceforge.net; Thu, 21 May 2015 02:15:25 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t4L2DqhM004620
	for <ltp-list@lists.sourceforge.net>; Thu, 21 May 2015 10:13:53 +0800
From: "Wei,Jiangang" <weijg.fnst@cn.fujitsu.com>
Date: Thu, 21 May 2015 10:14:41 +0800
Message-ID: <1432174482-23967-1-git-send-email-weijg.fnst@cn.fujitsu.com>
In-Reply-To: <20150520133631.GA9052@rei.suse.de>
References: <20150520133631.GA9052@rei.suse.de>
MIME-Version: 1.0
Subject: [LTP] [PATCH v2 1/2] testcases/kernel/syscalls: make use of
	ARRAY_SIZE
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

Use ARRAY_SIZE or sizeof() replace sizeof(x)/sizeof(x[0])

Signed-off-by: Wei,Jiangang <weijg.fnst@cn.fujitsu.com>
---
 testcases/kernel/syscalls/setreuid/setreuid02.c | 2 +-
 testcases/kernel/syscalls/setreuid/setreuid03.c | 2 +-
 testcases/kernel/syscalls/setreuid/setreuid04.c | 3 +--
 testcases/kernel/syscalls/setreuid/setreuid05.c | 2 +-
 testcases/kernel/syscalls/sysctl/sysctl01.c     | 4 +---
 testcases/kernel/syscalls/sysctl/sysctl03.c     | 9 ++++-----
 testcases/kernel/syscalls/sysctl/sysctl04.c     | 3 +--
 testcases/kernel/syscalls/sysctl/sysctl05.c     | 4 +---
 8 files changed, 11 insertions(+), 18 deletions(-)

diff --git a/testcases/kernel/syscalls/setreuid/setreuid02.c b/testcases/kernel/syscalls/setreuid/setreuid02.c
index 9cc0333..1257046 100644
--- a/testcases/kernel/syscalls/setreuid/setreuid02.c
+++ b/testcases/kernel/syscalls/setreuid/setreuid02.c
@@ -58,7 +58,7 @@ static struct test_data_t {
 	&bin.pw_uid, &neg_one, &bin, &root, "After setreuid(bin, -1)"}, {
 &root.pw_uid, &neg_one, &root, &root, "After setreuid(-1, root)"},};
 
-int TST_TOTAL = sizeof(test_data) / sizeof(test_data[0]);
+int TST_TOTAL = ARRAY_SIZE(test_data);
 
 static void setup(void);
 static void cleanup(void);
diff --git a/testcases/kernel/syscalls/setreuid/setreuid03.c b/testcases/kernel/syscalls/setreuid/setreuid03.c
index 2533908..34fa606 100644
--- a/testcases/kernel/syscalls/setreuid/setreuid03.c
+++ b/testcases/kernel/syscalls/setreuid/setreuid03.c
@@ -83,7 +83,7 @@ static struct test_data_t {
 	&nobody.pw_uid, &bin.pw_uid, &fail, &nobody, &nobody,
 		    "After setreuid(nobody, bin),"},};
 
-int TST_TOTAL = sizeof(test_data) / sizeof(test_data[0]);
+int TST_TOTAL = ARRAY_SIZE(test_data);
 
 static void setup(void);
 static void cleanup(void);
diff --git a/testcases/kernel/syscalls/setreuid/setreuid04.c b/testcases/kernel/syscalls/setreuid/setreuid04.c
index f05f61d..2080f47 100644
--- a/testcases/kernel/syscalls/setreuid/setreuid04.c
+++ b/testcases/kernel/syscalls/setreuid/setreuid04.c
@@ -54,8 +54,7 @@ struct test_data_t {
 &nobody.pw_uid, &nobody.pw_uid, &nobody, &nobody,
 		    "After setreuid(-1, -1),"},};
 
-/*int TST_TOTAL = sizeof(test_data)/sizeof(test_data[0]);*/
-int TST_TOTAL = 2;
+int TST_TOTAL = ARRAY_SIZE(test_data);
 
 static void setup(void);
 static void cleanup(void);
diff --git a/testcases/kernel/syscalls/setreuid/setreuid05.c b/testcases/kernel/syscalls/setreuid/setreuid05.c
index d6c4c6f..98436d3 100644
--- a/testcases/kernel/syscalls/setreuid/setreuid05.c
+++ b/testcases/kernel/syscalls/setreuid/setreuid05.c
@@ -76,7 +76,7 @@ struct test_data_t {
 	&neg_one, &bin.pw_uid, &fail, &daemonpw, &daemonpw,
 		    "After setreuid(-1, bin),"},};
 
-int TST_TOTAL = sizeof(test_data) / sizeof(test_data[0]);
+int TST_TOTAL = ARRAY_SIZE(test_data);
 
 static void setup(void);
 static void cleanup(void);
diff --git a/testcases/kernel/syscalls/sysctl/sysctl01.c b/testcases/kernel/syscalls/sysctl/sysctl01.c
index fe62905..c423f47 100644
--- a/testcases/kernel/syscalls/sysctl/sysctl01.c
+++ b/testcases/kernel/syscalls/sysctl/sysctl01.c
@@ -66,8 +66,6 @@ static int sysctl(int *name, int nlen, void *oldval, size_t * oldlenp,
 	return syscall(__NR__sysctl, &args);
 }
 
-#define SIZE(x) sizeof(x)/sizeof(x[0])
-
 struct utsname buf;
 char osname[BUFSIZ];
 size_t osnamelth;
@@ -115,7 +113,7 @@ int main(int ac, char **av)
 
 		for (i = 0; i < TST_TOTAL; ++i) {
 
-			osnamelth = SIZE(osname);
+			osnamelth = sizeof(osname);
 
 			switch (i) {
 			case 0:
diff --git a/testcases/kernel/syscalls/sysctl/sysctl03.c b/testcases/kernel/syscalls/sysctl/sysctl03.c
index 88890b6..ec15d11 100644
--- a/testcases/kernel/syscalls/sysctl/sysctl03.c
+++ b/testcases/kernel/syscalls/sysctl/sysctl03.c
@@ -86,7 +86,6 @@ int sysctl(int *name, int nlen, void *oldval, size_t * oldlenp,
 	return syscall(__NR__sysctl, &args);
 }
 
-#define SIZE(x) sizeof(x)/sizeof(x[0])
 #define OSNAMESZ 100
 
 void setup(void);
@@ -123,9 +122,9 @@ int main(int ac, char **av)
 		tst_count = 0;
 
 		strcpy(osname, "Linux");
-		osnamelth = SIZE(osname);
+		osnamelth = sizeof(osname);
 
-		TEST(sysctl(name, SIZE(name), 0, 0, osname, osnamelth));
+		TEST(sysctl(name, ARRAY_SIZE(name), 0, 0, osname, osnamelth));
 
 		if (TEST_RETURN != -1) {
 			tst_resm(TFAIL, "sysctl(2) succeeded unexpectedly");
@@ -142,7 +141,7 @@ int main(int ac, char **av)
 			}
 		}
 
-		osnamelth = SIZE(osname);
+		osnamelth = sizeof(osname);
 		if ((ltpuser = getpwnam("nobody")) == NULL) {
 			tst_brkm(TBROK, cleanup, "getpwnam() failed");
 		}
@@ -158,7 +157,7 @@ int main(int ac, char **av)
 		}
 
 		if (pid == 0) {
-			TEST(sysctl(name, SIZE(name), 0, 0, osname, osnamelth));
+			TEST(sysctl(name, ARRAY_SIZE(name), 0, 0, osname, osnamelth));
 
 			if (TEST_RETURN != -1) {
 				tst_resm(TFAIL, "call succeeded unexpectedly");
diff --git a/testcases/kernel/syscalls/sysctl/sysctl04.c b/testcases/kernel/syscalls/sysctl/sysctl04.c
index ff63364..6339bf2 100644
--- a/testcases/kernel/syscalls/sysctl/sysctl04.c
+++ b/testcases/kernel/syscalls/sysctl/sysctl04.c
@@ -67,7 +67,6 @@ int sysctl(int *name, int nlen, void *oldval, size_t * oldlenp,
 	return syscall(__NR__sysctl, &args);
 }
 
-#define SIZE(x) sizeof(x)/sizeof(x[0])
 #define OSNAMESZ 100
 
 void setup(void);
@@ -98,7 +97,7 @@ int main(int ac, char **av)
 
 	setup();
 
-	osnamelth = SIZE(osname);
+	osnamelth = sizeof(osname);
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
diff --git a/testcases/kernel/syscalls/sysctl/sysctl05.c b/testcases/kernel/syscalls/sysctl/sysctl05.c
index e6f09b2..85030e7 100644
--- a/testcases/kernel/syscalls/sysctl/sysctl05.c
+++ b/testcases/kernel/syscalls/sysctl/sysctl05.c
@@ -69,8 +69,6 @@ int sysctl(int *name, int nlen, void *oldval, size_t * oldlenp,
 	return syscall(__NR__sysctl, &args);
 }
 
-#define SIZE(x) sizeof(x)/sizeof(x[0])
-
 char osname[BUFSIZ];
 size_t osnamelth;
 
@@ -117,7 +115,7 @@ int main(int ac, char **av)
 
 		for (i = 0; i < TST_TOTAL; ++i) {
 
-			osnamelth = SIZE(osname);
+			osnamelth = sizeof(osname);
 
 			TEST(sysctl(testcases[i].name, testcases[i].size,
 				    testcases[i].oldval, testcases[i].oldlen,
-- 
1.9.3


------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
