From: Kory Maincent <kory.maincent@bootlin.com>
Date: Fri, 29 Jan 2021 10:07:59 +0100
Subject: [LTP] [PATCH] sctp/func_test: add check on the sctp driver
Message-ID: <20210129090759.16534-1-kory.maincent@bootlin.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add the verification on the sctp driver for all the sctp tests.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 utils/sctp/func_tests/test_1_to_1_accept_close.c       | 3 +++
 utils/sctp/func_tests/test_1_to_1_addrs.c              | 3 +++
 utils/sctp/func_tests/test_1_to_1_connect.c            | 3 +++
 utils/sctp/func_tests/test_1_to_1_connectx.c           | 3 +++
 utils/sctp/func_tests/test_1_to_1_events.c             | 3 +++
 utils/sctp/func_tests/test_1_to_1_initmsg_connect.c    | 4 ++++
 utils/sctp/func_tests/test_1_to_1_nonblock.c           | 3 +++
 utils/sctp/func_tests/test_1_to_1_recvfrom.c           | 3 +++
 utils/sctp/func_tests/test_1_to_1_recvmsg.c            | 3 +++
 utils/sctp/func_tests/test_1_to_1_rtoinfo.c            | 3 +++
 utils/sctp/func_tests/test_1_to_1_send.c               | 3 +++
 utils/sctp/func_tests/test_1_to_1_sendmsg.c            | 3 +++
 utils/sctp/func_tests/test_1_to_1_sendto.c             | 3 +++
 utils/sctp/func_tests/test_1_to_1_shutdown.c           | 3 +++
 utils/sctp/func_tests/test_1_to_1_socket_bind_listen.c | 3 +++
 utils/sctp/func_tests/test_1_to_1_sockopt.c            | 3 +++
 utils/sctp/func_tests/test_1_to_1_threads.c            | 3 +++
 utils/sctp/func_tests/test_assoc_abort.c               | 3 +++
 utils/sctp/func_tests/test_assoc_shutdown.c            | 3 +++
 utils/sctp/func_tests/test_autoclose.c                 | 3 +++
 utils/sctp/func_tests/test_basic.c                     | 3 +++
 utils/sctp/func_tests/test_connect.c                   | 3 +++
 utils/sctp/func_tests/test_connectx.c                  | 3 +++
 utils/sctp/func_tests/test_fragments.c                 | 3 +++
 utils/sctp/func_tests/test_getname.c                   | 3 +++
 utils/sctp/func_tests/test_inaddr_any.c                | 3 +++
 utils/sctp/func_tests/test_peeloff.c                   | 3 +++
 utils/sctp/func_tests/test_recvmsg.c                   | 3 +++
 utils/sctp/func_tests/test_sctp_sendrecvmsg.c          | 3 +++
 utils/sctp/func_tests/test_sockopt.c                   | 3 +++
 utils/sctp/func_tests/test_tcp_style.c                 | 3 +++
 utils/sctp/func_tests/test_timetolive.c                | 3 +++
 32 files changed, 97 insertions(+)

diff --git a/utils/sctp/func_tests/test_1_to_1_accept_close.c b/utils/sctp/func_tests/test_1_to_1_accept_close.c
index b1d8a0ad9..43de196e8 100644
--- a/utils/sctp/func_tests/test_1_to_1_accept_close.c
+++ b/utils/sctp/func_tests/test_1_to_1_accept_close.c
@@ -83,6 +83,9 @@ main(void)
 
         struct sockaddr_in conn_addr,lstn_addr,acpt_addr;
 
+	if (tst_check_driver("sctp"))
+		tst_brkm(TCONF, tst_exit, "sctp driver not available");
+
 	/* Rather than fflush() throughout the code, set stdout to
          * be unbuffered.
          */
diff --git a/utils/sctp/func_tests/test_1_to_1_addrs.c b/utils/sctp/func_tests/test_1_to_1_addrs.c
index 9443f69d8..c8117d99c 100644
--- a/utils/sctp/func_tests/test_1_to_1_addrs.c
+++ b/utils/sctp/func_tests/test_1_to_1_addrs.c
@@ -98,6 +98,9 @@ main(void)
         struct sockaddr_in conn_addr,lstn_addr,acpt_addr;
 	struct sockaddr_in *addr;
 
+	if (tst_check_driver("sctp"))
+		tst_brkm(TCONF, tst_exit, "sctp driver not available");
+
 	/* Rather than fflush() throughout the code, set stdout to
          * be unbuffered.
          */
diff --git a/utils/sctp/func_tests/test_1_to_1_connect.c b/utils/sctp/func_tests/test_1_to_1_connect.c
index 885b3d23b..edaa73d3d 100644
--- a/utils/sctp/func_tests/test_1_to_1_connect.c
+++ b/utils/sctp/func_tests/test_1_to_1_connect.c
@@ -77,6 +77,9 @@ main(void)
 
         struct sockaddr_in conn_addr,lstn_addr,acpt_addr;
 
+	if (tst_check_driver("sctp"))
+		tst_brkm(TCONF, tst_exit, "sctp driver not available");
+
 	/* Rather than fflush() throughout the code, set stdout to
          * be unbuffered.
          */
diff --git a/utils/sctp/func_tests/test_1_to_1_connectx.c b/utils/sctp/func_tests/test_1_to_1_connectx.c
index 27999bc9c..7e3a1a7a6 100644
--- a/utils/sctp/func_tests/test_1_to_1_connectx.c
+++ b/utils/sctp/func_tests/test_1_to_1_connectx.c
@@ -76,6 +76,9 @@ main(void)
 	struct sockaddr_in conn_addr,lstn_addr,acpt_addr;
 	struct sockaddr *tmp_addr;
 
+	if (tst_check_driver("sctp"))
+		tst_brkm(TCONF, tst_exit, "sctp driver not available");
+
 	/* Rather than fflush() throughout the code, set stdout to
 	 * be unbuffered.
 	 */
diff --git a/utils/sctp/func_tests/test_1_to_1_events.c b/utils/sctp/func_tests/test_1_to_1_events.c
index 57fb842e3..192b6ef5b 100644
--- a/utils/sctp/func_tests/test_1_to_1_events.c
+++ b/utils/sctp/func_tests/test_1_to_1_events.c
@@ -68,6 +68,9 @@ main(void)
 	uint32_t ppid;
 	uint32_t stream;
 
+	if (tst_check_driver("sctp"))
+		tst_brkm(TCONF, tst_exit, "sctp driver not available");
+
         /* Rather than fflush() throughout the code, set stdout to 
 	 * be unbuffered.  
 	 */ 
diff --git a/utils/sctp/func_tests/test_1_to_1_initmsg_connect.c b/utils/sctp/func_tests/test_1_to_1_initmsg_connect.c
index 3743679fe..98013cd30 100644
--- a/utils/sctp/func_tests/test_1_to_1_initmsg_connect.c
+++ b/utils/sctp/func_tests/test_1_to_1_initmsg_connect.c
@@ -110,4 +110,8 @@ static void test_sctp(unsigned int n)
 static struct tst_test test = {
 	.test = test_sctp,
 	.tcnt = ARRAY_SIZE(testcase_list),
+	.needs_drivers = (const char *[]) {
+		"sctp",
+		NULL
+	},
 };
diff --git a/utils/sctp/func_tests/test_1_to_1_nonblock.c b/utils/sctp/func_tests/test_1_to_1_nonblock.c
index a6229e31b..d914c11b7 100644
--- a/utils/sctp/func_tests/test_1_to_1_nonblock.c
+++ b/utils/sctp/func_tests/test_1_to_1_nonblock.c
@@ -79,6 +79,9 @@ main(void)
 	
         struct sockaddr_in conn_addr,lstn_addr,svr_addr;
 
+	if (tst_check_driver("sctp"))
+		tst_brkm(TCONF, tst_exit, "sctp driver not available");
+
 	/* Rather than fflush() throughout the code, set stdout to
          * be unbufferd
          */
diff --git a/utils/sctp/func_tests/test_1_to_1_recvfrom.c b/utils/sctp/func_tests/test_1_to_1_recvfrom.c
index f9fbd99f3..d539492f3 100644
--- a/utils/sctp/func_tests/test_1_to_1_recvfrom.c
+++ b/utils/sctp/func_tests/test_1_to_1_recvfrom.c
@@ -74,6 +74,9 @@ main(void)
 
         struct sockaddr_in conn_addr,lstn_addr,svr_addr;
 
+	if (tst_check_driver("sctp"))
+		tst_brkm(TCONF, tst_exit, "sctp driver not available");
+
 	/* Rather than fflush() throughout the code, set stdout to
          * be unbuffered.
          */
diff --git a/utils/sctp/func_tests/test_1_to_1_recvmsg.c b/utils/sctp/func_tests/test_1_to_1_recvmsg.c
index dc98fb937..8373ba782 100644
--- a/utils/sctp/func_tests/test_1_to_1_recvmsg.c
+++ b/utils/sctp/func_tests/test_1_to_1_recvmsg.c
@@ -79,6 +79,9 @@ main(void)
 
         struct sockaddr_in conn_addr,lstn_addr,svr_addr;
 
+	if (tst_check_driver("sctp"))
+		tst_brkm(TCONF, tst_exit, "sctp driver not available");
+
 	/* Rather than fflush() throughout the code, set stdout to
          * be unbuffered.
          */
diff --git a/utils/sctp/func_tests/test_1_to_1_rtoinfo.c b/utils/sctp/func_tests/test_1_to_1_rtoinfo.c
index cb46e3920..ce81d2afd 100644
--- a/utils/sctp/func_tests/test_1_to_1_rtoinfo.c
+++ b/utils/sctp/func_tests/test_1_to_1_rtoinfo.c
@@ -66,6 +66,9 @@ main(void)
 	struct sctp_rtoinfo srtoinfo; /*setting the variables*/
 	struct sctp_rtoinfo grtoinfo; /*Getting the variables*/
 
+	if (tst_check_driver("sctp"))
+		tst_brkm(TCONF, tst_exit, "sctp driver not available");
+
 	sd = test_socket (PF_INET, SOCK_STREAM, IPPROTO_SCTP);
 
 	len = sizeof(struct sctp_rtoinfo);
diff --git a/utils/sctp/func_tests/test_1_to_1_send.c b/utils/sctp/func_tests/test_1_to_1_send.c
index 05fae4f3e..29a909fff 100644
--- a/utils/sctp/func_tests/test_1_to_1_send.c
+++ b/utils/sctp/func_tests/test_1_to_1_send.c
@@ -74,6 +74,9 @@ main(void)
 
         struct sockaddr_in conn_addr,lstn_addr,svr_addr;
 
+	if (tst_check_driver("sctp"))
+		tst_brkm(TCONF, tst_exit, "sctp driver not available");
+
 	/* Rather than fflush() throughout the code, set stdout to
          * be unbuffered.
          */
diff --git a/utils/sctp/func_tests/test_1_to_1_sendmsg.c b/utils/sctp/func_tests/test_1_to_1_sendmsg.c
index 9c88630b2..a52975d49 100644
--- a/utils/sctp/func_tests/test_1_to_1_sendmsg.c
+++ b/utils/sctp/func_tests/test_1_to_1_sendmsg.c
@@ -89,6 +89,9 @@ main(void)
 	int fd, err_no = 0;
 	char filename[21];
 
+	if (tst_check_driver("sctp"))
+		tst_brkm(TCONF, tst_exit, "sctp driver not available");
+
 	/* Rather than fflush() throughout the code, set stdout to
          * be unbuffered.
          */
diff --git a/utils/sctp/func_tests/test_1_to_1_sendto.c b/utils/sctp/func_tests/test_1_to_1_sendto.c
index 114e6c04b..08b81dee7 100644
--- a/utils/sctp/func_tests/test_1_to_1_sendto.c
+++ b/utils/sctp/func_tests/test_1_to_1_sendto.c
@@ -69,6 +69,9 @@ main(void)
 	
         struct sockaddr_in conn_addr,lstn_addr,svr_addr;
 
+	if (tst_check_driver("sctp"))
+		tst_brkm(TCONF, tst_exit, "sctp driver not available");
+
 	/* Rather than fflush() throughout the code, set stdout to
          * be unbufferd
          */
diff --git a/utils/sctp/func_tests/test_1_to_1_shutdown.c b/utils/sctp/func_tests/test_1_to_1_shutdown.c
index 228ec442f..9f006c861 100644
--- a/utils/sctp/func_tests/test_1_to_1_shutdown.c
+++ b/utils/sctp/func_tests/test_1_to_1_shutdown.c
@@ -73,6 +73,9 @@ main(void)
 	int fd, err_no = 0;
 	char filename[21];
 
+	if (tst_check_driver("sctp"))
+		tst_brkm(TCONF, tst_exit, "sctp driver not available");
+
         /* Rather than fflush() throughout the code, set stdout to 
 	 * be unbuffered.  
 	 */ 
diff --git a/utils/sctp/func_tests/test_1_to_1_socket_bind_listen.c b/utils/sctp/func_tests/test_1_to_1_socket_bind_listen.c
index 09323ca9e..caf1d760d 100644
--- a/utils/sctp/func_tests/test_1_to_1_socket_bind_listen.c
+++ b/utils/sctp/func_tests/test_1_to_1_socket_bind_listen.c
@@ -90,6 +90,9 @@ main(void)
 
         struct sockaddr_in bind_addr;
 
+	if (tst_check_driver("sctp"))
+		tst_brkm(TCONF, tst_exit, "sctp driver not available");
+
 	/* Rather than fflush() throughout the code, set stdout to
          * be unbuffered.
          */
diff --git a/utils/sctp/func_tests/test_1_to_1_sockopt.c b/utils/sctp/func_tests/test_1_to_1_sockopt.c
index 436b344e9..bccfede7d 100644
--- a/utils/sctp/func_tests/test_1_to_1_sockopt.c
+++ b/utils/sctp/func_tests/test_1_to_1_sockopt.c
@@ -101,6 +101,9 @@ main(void)
 	int fd, err_no = 0;
 	char filename[21];
 
+	if (tst_check_driver("sctp"))
+		tst_brkm(TCONF, tst_exit, "sctp driver not available");
+
 	/* Rather than fflush() throughout the code, set stdout to
          * be unbuffered.
          */
diff --git a/utils/sctp/func_tests/test_1_to_1_threads.c b/utils/sctp/func_tests/test_1_to_1_threads.c
index e2a7eeeed..0e6fbce18 100644
--- a/utils/sctp/func_tests/test_1_to_1_threads.c
+++ b/utils/sctp/func_tests/test_1_to_1_threads.c
@@ -146,6 +146,9 @@ main(void)
 	socklen_t len = sizeof(struct sockaddr_in);
 	struct sockaddr_in svr_addr;
 
+	if (tst_check_driver("sctp"))
+		tst_brkm(TCONF, tst_exit, "sctp driver not available");
+
 	pthread_attr_init(&attr);
 	pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_JOINABLE);
 	
diff --git a/utils/sctp/func_tests/test_assoc_abort.c b/utils/sctp/func_tests/test_assoc_abort.c
index af1d997bd..4e3ce5f80 100644
--- a/utils/sctp/func_tests/test_assoc_abort.c
+++ b/utils/sctp/func_tests/test_assoc_abort.c
@@ -84,6 +84,9 @@ main(void)
 	struct sctp_status status;
 	socklen_t status_len;
 
+	if (tst_check_driver("sctp"))
+		tst_brkm(TCONF, tst_exit, "sctp driver not available");
+
         /* Rather than fflush() throughout the code, set stdout to 
 	 * be unbuffered.  
 	 */ 
diff --git a/utils/sctp/func_tests/test_assoc_shutdown.c b/utils/sctp/func_tests/test_assoc_shutdown.c
index 8287df923..9134d66ab 100644
--- a/utils/sctp/func_tests/test_assoc_shutdown.c
+++ b/utils/sctp/func_tests/test_assoc_shutdown.c
@@ -83,6 +83,9 @@ main(void)
 	struct sctp_status status;
 	socklen_t status_len;
 
+	if (tst_check_driver("sctp"))
+		tst_brkm(TCONF, tst_exit, "sctp driver not available");
+
         /* Rather than fflush() throughout the code, set stdout to 
 	 * be unbuffered.  
 	 */ 
diff --git a/utils/sctp/func_tests/test_autoclose.c b/utils/sctp/func_tests/test_autoclose.c
index 484875bbc..97287e905 100644
--- a/utils/sctp/func_tests/test_autoclose.c
+++ b/utils/sctp/func_tests/test_autoclose.c
@@ -70,6 +70,9 @@ main(void)
 	char *message = "hello, world!\n";
 	uint32_t autoclose;
 
+	if (tst_check_driver("sctp"))
+		tst_brkm(TCONF, tst_exit, "sctp driver not available");
+
 	/* Rather than fflush() throughout the code, set stdout to 
 	 * be unbuffered. 
 	 */
diff --git a/utils/sctp/func_tests/test_basic.c b/utils/sctp/func_tests/test_basic.c
index b8d4eaea1..07ed81036 100644
--- a/utils/sctp/func_tests/test_basic.c
+++ b/utils/sctp/func_tests/test_basic.c
@@ -92,6 +92,9 @@ int main(void)
 	struct sockaddr_in6 *in6_addr;
 	void *addr_buf;
 
+	if (tst_check_driver("sctp"))
+		tst_brkm(TCONF, tst_exit, "sctp driver not available");
+
         /* Rather than fflush() throughout the code, set stdout to 
 	 * be unbuffered. 
 	 */
diff --git a/utils/sctp/func_tests/test_connect.c b/utils/sctp/func_tests/test_connect.c
index 3642d6bd0..874301682 100644
--- a/utils/sctp/func_tests/test_connect.c
+++ b/utils/sctp/func_tests/test_connect.c
@@ -67,6 +67,9 @@ main(void)
 	char *big_buffer;
 	int flags;
 
+	if (tst_check_driver("sctp"))
+		tst_brkm(TCONF, tst_exit, "sctp driver not available");
+
         /* Rather than fflush() throughout the code, set stdout to 
 	 * be unbuffered.  
 	 */ 
diff --git a/utils/sctp/func_tests/test_connectx.c b/utils/sctp/func_tests/test_connectx.c
index 1d3e6fa0b..e66126c7b 100644
--- a/utils/sctp/func_tests/test_connectx.c
+++ b/utils/sctp/func_tests/test_connectx.c
@@ -81,6 +81,9 @@ main(void)
 	struct sockaddr_in clt_loop3[NUMADDR];
 	sockaddr_storage_t svr_test[NUMADDR], clt_test1[NUMADDR], clt_test2[NUMADDR];
 
+	if (tst_check_driver("sctp"))
+		tst_brkm(TCONF, tst_exit, "sctp driver not available");
+
 	/* Rather than fflush() throughout the code, set stdout to 
 	 * be unbuffered.  
 	 */ 
diff --git a/utils/sctp/func_tests/test_fragments.c b/utils/sctp/func_tests/test_fragments.c
index 5ef1da1bb..f1e9ec978 100644
--- a/utils/sctp/func_tests/test_fragments.c
+++ b/utils/sctp/func_tests/test_fragments.c
@@ -95,6 +95,9 @@ main(void)
 	int disable_frag;
 	socklen_t optlen;
 
+	if (tst_check_driver("sctp"))
+		tst_brkm(TCONF, tst_exit, "sctp driver not available");
+
         /* Rather than fflush() throughout the code, set stdout to 
 	 * be unbuffered. 
 	 */
diff --git a/utils/sctp/func_tests/test_getname.c b/utils/sctp/func_tests/test_getname.c
index 653bf7167..a4caf58d4 100644
--- a/utils/sctp/func_tests/test_getname.c
+++ b/utils/sctp/func_tests/test_getname.c
@@ -69,6 +69,9 @@ main(void)
 	int fd, err_no = 0;
 	char filename[21];
 
+	if (tst_check_driver("sctp"))
+		tst_brkm(TCONF, tst_exit, "sctp driver not available");
+
         /* Rather than fflush() throughout the code, set stdout to 
 	 * be unbuffered.  
 	 */ 
diff --git a/utils/sctp/func_tests/test_inaddr_any.c b/utils/sctp/func_tests/test_inaddr_any.c
index 722a7025f..c06dec7b6 100644
--- a/utils/sctp/func_tests/test_inaddr_any.c
+++ b/utils/sctp/func_tests/test_inaddr_any.c
@@ -84,6 +84,9 @@ main(void)
 	uint32_t stream;
 	socklen_t namelen;
 
+	if (tst_check_driver("sctp"))
+		tst_brkm(TCONF, tst_exit, "sctp driver not available");
+
         /* Rather than fflush() throughout the code, set stdout to 
 	 * be unbuffered. 
 	 */
diff --git a/utils/sctp/func_tests/test_peeloff.c b/utils/sctp/func_tests/test_peeloff.c
index 1b9e7014b..cd4ba4935 100644
--- a/utils/sctp/func_tests/test_peeloff.c
+++ b/utils/sctp/func_tests/test_peeloff.c
@@ -81,6 +81,9 @@ main(void)
         char *message = "hello, world!\n";
 	int pf_class;
 
+	if (tst_check_driver("sctp"))
+		tst_brkm(TCONF, tst_exit, "sctp driver not available");
+
         /* Rather than fflush() throughout the code, set stdout to 
 	 * be unbuffered.  
 	 */ 
diff --git a/utils/sctp/func_tests/test_recvmsg.c b/utils/sctp/func_tests/test_recvmsg.c
index 0fb3012b9..62b326458 100644
--- a/utils/sctp/func_tests/test_recvmsg.c
+++ b/utils/sctp/func_tests/test_recvmsg.c
@@ -70,6 +70,9 @@ main(void)
 	char *big_buffer;
 	void *msg_buf;
 
+	if (tst_check_driver("sctp"))
+		tst_brkm(TCONF, tst_exit, "sctp driver not available");
+
         /* Rather than fflush() throughout the code, set stdout to 
 	 * be unbuffered.  
 	 */ 
diff --git a/utils/sctp/func_tests/test_sctp_sendrecvmsg.c b/utils/sctp/func_tests/test_sctp_sendrecvmsg.c
index 294784791..b49dcb527 100644
--- a/utils/sctp/func_tests/test_sctp_sendrecvmsg.c
+++ b/utils/sctp/func_tests/test_sctp_sendrecvmsg.c
@@ -92,6 +92,9 @@ int main(void)
 	socklen_t len, oldlen;
 	struct sctp_status gstatus;
 
+	if (tst_check_driver("sctp"))
+		tst_brkm(TCONF, tst_exit, "sctp driver not available");
+
 	/* Rather than fflush() throughout the code, set stdout to
 	 * be unbuffered.
 	 */
diff --git a/utils/sctp/func_tests/test_sockopt.c b/utils/sctp/func_tests/test_sockopt.c
index a31c5d3ab..c8acf1239 100644
--- a/utils/sctp/func_tests/test_sockopt.c
+++ b/utils/sctp/func_tests/test_sockopt.c
@@ -101,6 +101,9 @@ main(void)
 	struct sctp_status status;
 	struct sctp_assoc_value value;
 
+	if (tst_check_driver("sctp"))
+		tst_brkm(TCONF, tst_exit, "sctp driver not available");
+
         /* Rather than fflush() throughout the code, set stdout to
 	 * be unbuffered.
 	 */
diff --git a/utils/sctp/func_tests/test_tcp_style.c b/utils/sctp/func_tests/test_tcp_style.c
index 91a19c459..6bd20b6d8 100644
--- a/utils/sctp/func_tests/test_tcp_style.c
+++ b/utils/sctp/func_tests/test_tcp_style.c
@@ -81,6 +81,9 @@ main(void)
 	char *big_buffer;
 	struct iovec iov;
 
+	if (tst_check_driver("sctp"))
+		tst_brkm(TCONF, tst_exit, "sctp driver not available");
+
         /* Rather than fflush() throughout the code, set stdout to 
 	 * be unbuffered.  
 	 */ 
diff --git a/utils/sctp/func_tests/test_timetolive.c b/utils/sctp/func_tests/test_timetolive.c
index 1d6fa2b80..6cc302f3a 100644
--- a/utils/sctp/func_tests/test_timetolive.c
+++ b/utils/sctp/func_tests/test_timetolive.c
@@ -114,6 +114,9 @@ int main(void)
 	int orig_len; 
 	struct sctp_status gstatus;
 
+	if (tst_check_driver("sctp"))
+		tst_brkm(TCONF, tst_exit, "sctp driver not available");
+
         /* Rather than fflush() throughout the code, set stdout to
 	 * be unbuffered.
 	 */
-- 
2.17.1

