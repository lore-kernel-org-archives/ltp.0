From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 24 Sep 2020 10:17:39 +0300
Subject: [LTP] [PATCH 4/5] network/netstress: replace rand with rand_r() in
 the client thread
In-Reply-To: <20200924071740.6963-1-alexey.kodanev@oracle.com>
References: <20200924071740.6963-1-alexey.kodanev@oracle.com>
Message-ID: <20200924071740.6963-4-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Store seed per client thread in order to get reproducible results.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 configure.ac                            |  1 +
 testcases/network/netstress/netstress.c | 33 ++++++++++++++++---------
 2 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/configure.ac b/configure.ac
index 142bfe26e..03e4e09c9 100644
--- a/configure.ac
+++ b/configure.ac
@@ -108,6 +108,7 @@ AC_CHECK_FUNCS_ONCE([ \
     profil \
     pwritev \
     pwritev2 \
+    rand_r \
     readlinkat \
     recvmmsg \
     renameat \
diff --git a/testcases/network/netstress/netstress.c b/testcases/network/netstress/netstress.c
index c5da4d464..e79e64220 100644
--- a/testcases/network/netstress/netstress.c
+++ b/testcases/network/netstress/netstress.c
@@ -31,6 +31,13 @@
 #include "tst_test.h"
 #include "tst_safe_net.h"
 
+#if !defined(HAVE_RAND_R)
+static int rand_r(LTP_ATTRIBUTE_UNUSED unsigned int *seed)
+{
+    return rand();
+}
+#endif
+
 static const int max_msg_len = (1 << 16) - 1;
 static const int min_msg_len = 5;
 
@@ -62,6 +69,7 @@ static const int end_byte	= 0x0a;
 static int init_cln_msg_len	= 32;
 static int init_srv_msg_len	= 128;
 static int max_rand_msg_len;
+static int init_seed;
 
 /*
  * The number of requests from client after
@@ -344,10 +352,11 @@ union net_size_field {
 	uint16_t value;
 };
 
-static void make_client_request(char client_msg[], int *cln_len, int *srv_len)
+static void make_client_request(char client_msg[], int *cln_len, int *srv_len,
+				unsigned int *seed)
 {
 	if (max_rand_msg_len)
-		*cln_len = *srv_len = min_msg_len + rand() % max_rand_msg_len;
+		*cln_len = *srv_len = min_msg_len + rand_r(seed) % max_rand_msg_len;
 
 	memset(client_msg, client_byte, *cln_len);
 	client_msg[0] = start_byte;
@@ -362,7 +371,7 @@ static void make_client_request(char client_msg[], int *cln_len, int *srv_len)
 	client_msg[*cln_len - 1] = end_byte;
 }
 
-void *client_fn(LTP_ATTRIBUTE_UNUSED void *arg)
+void *client_fn(void *id)
 {
 	int cln_len = init_cln_msg_len,
 	    srv_len = init_srv_msg_len;
@@ -371,13 +380,14 @@ void *client_fn(LTP_ATTRIBUTE_UNUSED void *arg)
 	char client_msg[max_msg_len];
 	int i = 0;
 	intptr_t err = 0;
+	unsigned int seed = init_seed ^ (intptr_t)id;
 
 	inf.raddr_len = sizeof(inf.raddr);
 	inf.etime_cnt = 0;
 	inf.timeout = wait_timeout;
 	inf.pmtu_err_cnt = 0;
 
-	make_client_request(client_msg, &cln_len, &srv_len);
+	make_client_request(client_msg, &cln_len, &srv_len, &seed);
 
 	/* connect & send requests */
 	inf.fd = client_connect_send(client_msg, cln_len);
@@ -407,7 +417,7 @@ void *client_fn(LTP_ATTRIBUTE_UNUSED void *arg)
 		}
 
 		if (max_rand_msg_len)
-			make_client_request(client_msg, &cln_len, &srv_len);
+			make_client_request(client_msg, &cln_len, &srv_len, &seed);
 
 		SAFE_SEND(1, inf.fd, client_msg, cln_len, send_flags);
 
@@ -468,9 +478,9 @@ static void client_init(void)
 	family = remote_addrinfo->ai_family;
 
 	clock_gettime(CLOCK_MONOTONIC_RAW, &tv_client_start);
-	int i;
+	intptr_t i;
 	for (i = 0; i < clients_num; ++i)
-		SAFE_PTHREAD_CREATE(&thread_ids[i], 0, client_fn, NULL);
+		SAFE_PTHREAD_CREATE(&thread_ids[i], 0, client_fn, (void *)i);
 }
 
 static void client_run(void)
@@ -496,7 +506,7 @@ static void client_run(void)
 	int msg_len = min_msg_len;
 
 	max_rand_msg_len = 0;
-	make_client_request(client_msg, &msg_len, &msg_len);
+	make_client_request(client_msg, &msg_len, &msg_len, NULL);
 	/* ask server to terminate */
 	client_msg[0] = start_fin_byte;
 	int cfd = client_connect_send(client_msg, msg_len);
@@ -861,10 +871,9 @@ static void setup(void)
 
 	if (max_rand_msg_len) {
 		max_rand_msg_len -= min_msg_len;
-		unsigned int seed = max_rand_msg_len ^ client_max_requests;
-
-		srand(seed);
-		tst_res(TINFO, "srand() seed 0x%x", seed);
+		init_seed = max_rand_msg_len ^ client_max_requests;
+		srand(init_seed); /* in case rand_r() is missing */
+		tst_res(TINFO, "rand start seed 0x%x", init_seed);
 	}
 
 	/* if client_num is not set, use num of processors */
-- 
2.20.1

