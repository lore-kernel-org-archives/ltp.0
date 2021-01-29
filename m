From: Kory Maincent <kory.maincent@bootlin.com>
Date: Fri, 29 Jan 2021 18:30:37 +0100
Subject: [LTP] [PATCH v2] sctp/func_test: add check on the sctp driver
Message-ID: <20210129173037.27287-1-kory.maincent@bootlin.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add the verification on the sctp driver for all the sctp tests.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Changes in v2:
 - include the tst_kernel header

 utils/sctp/func_tests/test_1_to_1_accept_close.c       | 4 ++++
 utils/sctp/func_tests/test_1_to_1_addrs.c              | 4 ++++
 utils/sctp/func_tests/test_1_to_1_connect.c            | 4 ++++
 utils/sctp/func_tests/test_1_to_1_connectx.c           | 4 ++++
 utils/sctp/func_tests/test_1_to_1_events.c             | 4 ++++
 utils/sctp/func_tests/test_1_to_1_initmsg_connect.c    | 4 ++++
 utils/sctp/func_tests/test_1_to_1_nonblock.c           | 4 ++++
 utils/sctp/func_tests/test_1_to_1_recvfrom.c           | 4 ++++
 utils/sctp/func_tests/test_1_to_1_recvmsg.c            | 4 ++++
 utils/sctp/func_tests/test_1_to_1_rtoinfo.c            | 4 ++++
 utils/sctp/func_tests/test_1_to_1_send.c               | 4 ++++
 utils/sctp/func_tests/test_1_to_1_sendmsg.c            | 4 ++++
 utils/sctp/func_tests/test_1_to_1_sendto.c             | 4 ++++
 utils/sctp/func_tests/test_1_to_1_shutdown.c           | 4 ++++
 utils/sctp/func_tests/test_1_to_1_socket_bind_listen.c | 4 ++++
 utils/sctp/func_tests/test_1_to_1_sockopt.c            | 4 ++++
 utils/sctp/func_tests/test_1_to_1_threads.c            | 4 ++++
 utils/sctp/func_tests/test_assoc_abort.c               | 4 ++++
 utils/sctp/func_tests/test_assoc_shutdown.c            | 4 ++++
 utils/sctp/func_tests/test_autoclose.c                 | 4 ++++
 utils/sctp/func_tests/test_basic.c                     | 4 ++++
 utils/sctp/func_tests/test_connect.c                   | 4 ++++
 utils/sctp/func_tests/test_connectx.c                  | 4 ++++
 utils/sctp/func_tests/test_fragments.c                 | 4 ++++
 utils/sctp/func_tests/test_getname.c                   | 4 ++++
 utils/sctp/func_tests/test_inaddr_any.c                | 4 ++++
 utils/sctp/func_tests/test_peeloff.c                   | 4 ++++
 utils/sctp/func_tests/test_recvmsg.c                   | 4 ++++
 utils/sctp/func_tests/test_sctp_sendrecvmsg.c          | 4 ++++
 utils/sctp/func_tests/test_sockopt.c                   | 4 ++++
 utils/sctp/func_tests/test_tcp_style.c                 | 4 ++++
 utils/sctp/func_tests/test_timetolive.c                | 4 ++++
 32 files changed, 128 insertions(+)

diff --git a/utils/sctp/func_tests/test_1_to_1_accept_close.c b/utils/sctp/func_tests/test_1_to_1_accept_close.c
index b1d8a0ad9..801496246 100644
--- a/utils/sctp/func_tests/test_1_to_1_accept_close.c
+++ b/utils/sctp/func_tests/test_1_to_1_accept_close.c
@@ -63,6 +63,7 @@
 #include <netinet/sctp.h>
 #include <sys/uio.h>
 #include <sctputil.h>
+#include "tst_kernel.h"
 
 char *TCID = __FILE__;
 int TST_TOTAL = 10;
@@ -83,6 +84,9 @@ main(void)
 
         struct sockaddr_in conn_addr,lstn_addr,acpt_addr;
 
+	if (tst_check_driver("sctp"))
+		tst_brkm(TCONF, tst_exit, "sctp driver not available");
+
 	/* Rather than fflush() throughout the code, set stdout to
          * be unbuffered.
          */
diff --git a/utils/sctp/func_tests/test_1_to_1_addrs.c b/utils/sctp/func_tests/test_1_to_1_addrs.c
index 9443f69d8..4b846d86a 100644
--- a/utils/sctp/func_tests/test_1_to_1_addrs.c
+++ b/utils/sctp/func_tests/test_1_to_1_addrs.c
@@ -69,6 +69,7 @@
 #include <netinet/sctp.h>
 #include <sys/uio.h>
 #include <sctputil.h>
+#include "tst_kernel.h"
 
 char *TCID = __FILE__;
 int TST_TOTAL = 10;
@@ -98,6 +99,9 @@ main(void)
         struct sockaddr_in conn_addr,lstn_addr,acpt_addr;
 	struct sockaddr_in *addr;
 
+	if (tst_check_driver("sctp"))
+		tst_brkm(TCONF, tst_exit, "sctp driver not available");
+
 	/* Rather than fflush() throughout the code, set stdout to
          * be unbuffered.
          */
diff --git a/utils/sctp/func_tests/test_1_to_1_connect.c b/utils/sctp/func_tests/test_1_to_1_connect.c
index 885b3d23b..bec16e1dd 100644
--- a/utils/sctp/func_tests/test_1_to_1_connect.c
+++ b/utils/sctp/func_tests/test_1_to_1_connect.c
@@ -58,6 +58,7 @@
 #include <sys/uio.h>
 #include <netinet/sctp.h>
 #include "sctputil.h"
+#include "tst_kernel.h"
 
 char *TCID = __FILE__;
 int TST_TOTAL = 10;
@@ -77,6 +78,9 @@ main(void)
 
         struct sockaddr_in conn_addr,lstn_addr,acpt_addr;
 
+	if (tst_check_driver("sctp"))
+		tst_brkm(TCONF, tst_exit, "sctp driver not available");
+
 	/* Rather than fflush() throughout the code, set stdout to
          * be unbuffered.
          */
diff --git a/utils/sctp/func_tests/test_1_to_1_connectx.c b/utils/sctp/func_tests/test_1_to_1_connectx.c
index 27999bc9c..16479a818 100644
--- a/utils/sctp/func_tests/test_1_to_1_connectx.c
+++ b/utils/sctp/func_tests/test_1_to_1_connectx.c
@@ -58,6 +58,7 @@
 #include <sys/uio.h>
 #include <netinet/sctp.h>
 #include "sctputil.h"
+#include "tst_kernel.h"
 
 char *TCID = __FILE__;
 int TST_TOTAL = 10;
@@ -76,6 +77,9 @@ main(void)
 	struct sockaddr_in conn_addr,lstn_addr,acpt_addr;
 	struct sockaddr *tmp_addr;
 
+	if (tst_check_driver("sctp"))
+		tst_brkm(TCONF, tst_exit, "sctp driver not available");
+
 	/* Rather than fflush() throughout the code, set stdout to
 	 * be unbuffered.
 	 */
diff --git a/utils/sctp/func_tests/test_1_to_1_events.c b/utils/sctp/func_tests/test_1_to_1_events.c
index 57fb842e3..447845ff3 100644
--- a/utils/sctp/func_tests/test_1_to_1_events.c
+++ b/utils/sctp/func_tests/test_1_to_1_events.c
@@ -44,6 +44,7 @@
 #include <netinet/sctp.h>
 #include <sctputil.h>
 #include <string.h>
+#include "tst_kernel.h"
 
 char *TCID = __FILE__;
 int TST_TOTAL = 4;
@@ -68,6 +69,9 @@ main(void)
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
index a6229e31b..05cc0a29d 100644
--- a/utils/sctp/func_tests/test_1_to_1_nonblock.c
+++ b/utils/sctp/func_tests/test_1_to_1_nonblock.c
@@ -55,6 +55,7 @@
 #include <sys/uio.h>
 #include <linux/socket.h>
 #include <sctputil.h>
+#include "tst_kernel.h"
 
 char *TCID = __FILE__;
 int TST_TOTAL = 5;
@@ -79,6 +80,9 @@ main(void)
 	
         struct sockaddr_in conn_addr,lstn_addr,svr_addr;
 
+	if (tst_check_driver("sctp"))
+		tst_brkm(TCONF, tst_exit, "sctp driver not available");
+
 	/* Rather than fflush() throughout the code, set stdout to
          * be unbufferd
          */
diff --git a/utils/sctp/func_tests/test_1_to_1_recvfrom.c b/utils/sctp/func_tests/test_1_to_1_recvfrom.c
index f9fbd99f3..45005a55d 100644
--- a/utils/sctp/func_tests/test_1_to_1_recvfrom.c
+++ b/utils/sctp/func_tests/test_1_to_1_recvfrom.c
@@ -55,6 +55,7 @@
 #include <sys/uio.h>
 #include <linux/socket.h>
 #include <sctputil.h>
+#include "tst_kernel.h"
 
 char *TCID = __FILE__;
 int TST_TOTAL = 7;
@@ -74,6 +75,9 @@ main(void)
 
         struct sockaddr_in conn_addr,lstn_addr,svr_addr;
 
+	if (tst_check_driver("sctp"))
+		tst_brkm(TCONF, tst_exit, "sctp driver not available");
+
 	/* Rather than fflush() throughout the code, set stdout to
          * be unbuffered.
          */
diff --git a/utils/sctp/func_tests/test_1_to_1_recvmsg.c b/utils/sctp/func_tests/test_1_to_1_recvmsg.c
index dc98fb937..aa89c4fa4 100644
--- a/utils/sctp/func_tests/test_1_to_1_recvmsg.c
+++ b/utils/sctp/func_tests/test_1_to_1_recvmsg.c
@@ -56,6 +56,7 @@
 #include <sys/uio.h>
 #include <linux/socket.h>
 #include <sctputil.h>
+#include "tst_kernel.h"
 
 char *TCID = __FILE__;
 int TST_TOTAL = 8;
@@ -79,6 +80,9 @@ main(void)
 
         struct sockaddr_in conn_addr,lstn_addr,svr_addr;
 
+	if (tst_check_driver("sctp"))
+		tst_brkm(TCONF, tst_exit, "sctp driver not available");
+
 	/* Rather than fflush() throughout the code, set stdout to
          * be unbuffered.
          */
diff --git a/utils/sctp/func_tests/test_1_to_1_rtoinfo.c b/utils/sctp/func_tests/test_1_to_1_rtoinfo.c
index cb46e3920..98e4ea185 100644
--- a/utils/sctp/func_tests/test_1_to_1_rtoinfo.c
+++ b/utils/sctp/func_tests/test_1_to_1_rtoinfo.c
@@ -52,6 +52,7 @@
 #include <sys/uio.h>
 #include <netinet/sctp.h>
 #include <sctputil.h>
+#include "tst_kernel.h"
 
 char *TCID = __FILE__;
 int TST_TOTAL = 3;
@@ -66,6 +67,9 @@ main(void)
 	struct sctp_rtoinfo srtoinfo; /*setting the variables*/
 	struct sctp_rtoinfo grtoinfo; /*Getting the variables*/
 
+	if (tst_check_driver("sctp"))
+		tst_brkm(TCONF, tst_exit, "sctp driver not available");
+
 	sd = test_socket (PF_INET, SOCK_STREAM, IPPROTO_SCTP);
 
 	len = sizeof(struct sctp_rtoinfo);
diff --git a/utils/sctp/func_tests/test_1_to_1_send.c b/utils/sctp/func_tests/test_1_to_1_send.c
index 05fae4f3e..3f072da8d 100644
--- a/utils/sctp/func_tests/test_1_to_1_send.c
+++ b/utils/sctp/func_tests/test_1_to_1_send.c
@@ -56,6 +56,7 @@
 #include <sys/uio.h>
 #include <linux/socket.h>
 #include <sctputil.h>
+#include "tst_kernel.h"
 
 char *TCID = __FILE__;
 int TST_TOTAL = 8;
@@ -74,6 +75,9 @@ main(void)
 
         struct sockaddr_in conn_addr,lstn_addr,svr_addr;
 
+	if (tst_check_driver("sctp"))
+		tst_brkm(TCONF, tst_exit, "sctp driver not available");
+
 	/* Rather than fflush() throughout the code, set stdout to
          * be unbuffered.
          */
diff --git a/utils/sctp/func_tests/test_1_to_1_sendmsg.c b/utils/sctp/func_tests/test_1_to_1_sendmsg.c
index 9c88630b2..d99f1f051 100644
--- a/utils/sctp/func_tests/test_1_to_1_sendmsg.c
+++ b/utils/sctp/func_tests/test_1_to_1_sendmsg.c
@@ -63,6 +63,7 @@
 #include <sys/uio.h>
 #include <linux/socket.h>
 #include <sctputil.h>
+#include "tst_kernel.h"
 
 char *TCID = __FILE__;
 int TST_TOTAL = 14;
@@ -89,6 +90,9 @@ main(void)
 	int fd, err_no = 0;
 	char filename[21];
 
+	if (tst_check_driver("sctp"))
+		tst_brkm(TCONF, tst_exit, "sctp driver not available");
+
 	/* Rather than fflush() throughout the code, set stdout to
          * be unbuffered.
          */
diff --git a/utils/sctp/func_tests/test_1_to_1_sendto.c b/utils/sctp/func_tests/test_1_to_1_sendto.c
index 114e6c04b..0c9b45c57 100644
--- a/utils/sctp/func_tests/test_1_to_1_sendto.c
+++ b/utils/sctp/func_tests/test_1_to_1_sendto.c
@@ -52,6 +52,7 @@
 #include <sys/uio.h>
 #include <linux/socket.h>
 #include <sctputil.h>
+#include "tst_kernel.h"
 
 char *TCID = __FILE__;
 int TST_TOTAL = 4;
@@ -69,6 +70,9 @@ main(void)
 	
         struct sockaddr_in conn_addr,lstn_addr,svr_addr;
 
+	if (tst_check_driver("sctp"))
+		tst_brkm(TCONF, tst_exit, "sctp driver not available");
+
 	/* Rather than fflush() throughout the code, set stdout to
          * be unbufferd
          */
diff --git a/utils/sctp/func_tests/test_1_to_1_shutdown.c b/utils/sctp/func_tests/test_1_to_1_shutdown.c
index 228ec442f..8a6528b06 100644
--- a/utils/sctp/func_tests/test_1_to_1_shutdown.c
+++ b/utils/sctp/func_tests/test_1_to_1_shutdown.c
@@ -52,6 +52,7 @@
 #include <string.h>
 #include <stdlib.h>
 #include <sctputil.h>
+#include "tst_kernel.h"
 
 char *TCID = __FILE__;
 int TST_TOTAL = 6;
@@ -73,6 +74,9 @@ main(void)
 	int fd, err_no = 0;
 	char filename[21];
 
+	if (tst_check_driver("sctp"))
+		tst_brkm(TCONF, tst_exit, "sctp driver not available");
+
         /* Rather than fflush() throughout the code, set stdout to 
 	 * be unbuffered.  
 	 */ 
diff --git a/utils/sctp/func_tests/test_1_to_1_socket_bind_listen.c b/utils/sctp/func_tests/test_1_to_1_socket_bind_listen.c
index 09323ca9e..436a0b785 100644
--- a/utils/sctp/func_tests/test_1_to_1_socket_bind_listen.c
+++ b/utils/sctp/func_tests/test_1_to_1_socket_bind_listen.c
@@ -71,6 +71,7 @@
 #include <netinet/sctp.h>
 #include <sys/uio.h>
 #include <sctputil.h>
+#include "tst_kernel.h"
 
 #define SCTP_RESERVED_PORT 7
 #define SCTP_INV_LOOPBACK "172.31.43.112"
@@ -90,6 +91,9 @@ main(void)
 
         struct sockaddr_in bind_addr;
 
+	if (tst_check_driver("sctp"))
+		tst_brkm(TCONF, tst_exit, "sctp driver not available");
+
 	/* Rather than fflush() throughout the code, set stdout to
          * be unbuffered.
          */
diff --git a/utils/sctp/func_tests/test_1_to_1_sockopt.c b/utils/sctp/func_tests/test_1_to_1_sockopt.c
index 436b344e9..b5af66d0d 100644
--- a/utils/sctp/func_tests/test_1_to_1_sockopt.c
+++ b/utils/sctp/func_tests/test_1_to_1_sockopt.c
@@ -72,6 +72,7 @@
 #include <netinet/sctp.h>
 #include <sys/uio.h>
 #include <sctputil.h>
+#include "tst_kernel.h"
 
 char *TCID = __FILE__;
 int TST_TOTAL = 22;
@@ -101,6 +102,9 @@ main(void)
 	int fd, err_no = 0;
 	char filename[21];
 
+	if (tst_check_driver("sctp"))
+		tst_brkm(TCONF, tst_exit, "sctp driver not available");
+
 	/* Rather than fflush() throughout the code, set stdout to
          * be unbuffered.
          */
diff --git a/utils/sctp/func_tests/test_1_to_1_threads.c b/utils/sctp/func_tests/test_1_to_1_threads.c
index e2a7eeeed..2cf96b186 100644
--- a/utils/sctp/func_tests/test_1_to_1_threads.c
+++ b/utils/sctp/func_tests/test_1_to_1_threads.c
@@ -49,6 +49,7 @@
 #include <sys/uio.h>
 #include <linux/socket.h>
 #include <sctputil.h>
+#include "tst_kernel.h"
 
 #define THREADS 10    /* FIXME should be 500 instead of 10 */
 #define THREAD_SND_RCV_LOOPS 10
@@ -146,6 +147,9 @@ main(void)
 	socklen_t len = sizeof(struct sockaddr_in);
 	struct sockaddr_in svr_addr;
 
+	if (tst_check_driver("sctp"))
+		tst_brkm(TCONF, tst_exit, "sctp driver not available");
+
 	pthread_attr_init(&attr);
 	pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_JOINABLE);
 	
diff --git a/utils/sctp/func_tests/test_assoc_abort.c b/utils/sctp/func_tests/test_assoc_abort.c
index af1d997bd..02d3974cf 100644
--- a/utils/sctp/func_tests/test_assoc_abort.c
+++ b/utils/sctp/func_tests/test_assoc_abort.c
@@ -53,6 +53,7 @@
 #include <errno.h>
 #include <netinet/sctp.h>
 #include <sctputil.h>
+#include "tst_kernel.h"
 
 char *TCID = __FILE__;
 int TST_TOTAL = 1;
@@ -84,6 +85,9 @@ main(void)
 	struct sctp_status status;
 	socklen_t status_len;
 
+	if (tst_check_driver("sctp"))
+		tst_brkm(TCONF, tst_exit, "sctp driver not available");
+
         /* Rather than fflush() throughout the code, set stdout to 
 	 * be unbuffered.  
 	 */ 
diff --git a/utils/sctp/func_tests/test_assoc_shutdown.c b/utils/sctp/func_tests/test_assoc_shutdown.c
index 8287df923..1545bb1e9 100644
--- a/utils/sctp/func_tests/test_assoc_shutdown.c
+++ b/utils/sctp/func_tests/test_assoc_shutdown.c
@@ -58,6 +58,7 @@ int TST_TOTAL = 1;
 int TST_CNT = 0;
 
 #define MAX_CLIENTS 10
+#include "tst_kernel.h"
 
 int
 main(void)
@@ -83,6 +84,9 @@ main(void)
 	struct sctp_status status;
 	socklen_t status_len;
 
+	if (tst_check_driver("sctp"))
+		tst_brkm(TCONF, tst_exit, "sctp driver not available");
+
         /* Rather than fflush() throughout the code, set stdout to 
 	 * be unbuffered.  
 	 */ 
diff --git a/utils/sctp/func_tests/test_autoclose.c b/utils/sctp/func_tests/test_autoclose.c
index 484875bbc..096efdf0b 100644
--- a/utils/sctp/func_tests/test_autoclose.c
+++ b/utils/sctp/func_tests/test_autoclose.c
@@ -53,6 +53,7 @@
 #include <errno.h>
 #include <netinet/sctp.h>
 #include <sctputil.h>
+#include "tst_kernel.h"
 
 char *TCID = __FILE__;
 int TST_TOTAL = 1;
@@ -70,6 +71,9 @@ main(void)
 	char *message = "hello, world!\n";
 	uint32_t autoclose;
 
+	if (tst_check_driver("sctp"))
+		tst_brkm(TCONF, tst_exit, "sctp driver not available");
+
 	/* Rather than fflush() throughout the code, set stdout to 
 	 * be unbuffered. 
 	 */
diff --git a/utils/sctp/func_tests/test_basic.c b/utils/sctp/func_tests/test_basic.c
index b8d4eaea1..0044a25f6 100644
--- a/utils/sctp/func_tests/test_basic.c
+++ b/utils/sctp/func_tests/test_basic.c
@@ -56,6 +56,7 @@
 #include <errno.h>
 #include <netinet/sctp.h>
 #include <sctputil.h>
+#include "tst_kernel.h"
 
 char *TCID = __FILE__;
 int TST_TOTAL = 15;
@@ -92,6 +93,9 @@ int main(void)
 	struct sockaddr_in6 *in6_addr;
 	void *addr_buf;
 
+	if (tst_check_driver("sctp"))
+		tst_brkm(TCONF, tst_exit, "sctp driver not available");
+
         /* Rather than fflush() throughout the code, set stdout to 
 	 * be unbuffered. 
 	 */
diff --git a/utils/sctp/func_tests/test_connect.c b/utils/sctp/func_tests/test_connect.c
index 3642d6bd0..f8fc1c2d5 100644
--- a/utils/sctp/func_tests/test_connect.c
+++ b/utils/sctp/func_tests/test_connect.c
@@ -49,6 +49,7 @@
 #include <errno.h>
 #include <netinet/sctp.h>
 #include <sctputil.h>
+#include "tst_kernel.h"
 
 char *TCID = __FILE__;
 int TST_TOTAL = 5;
@@ -67,6 +68,9 @@ main(void)
 	char *big_buffer;
 	int flags;
 
+	if (tst_check_driver("sctp"))
+		tst_brkm(TCONF, tst_exit, "sctp driver not available");
+
         /* Rather than fflush() throughout the code, set stdout to 
 	 * be unbuffered.  
 	 */ 
diff --git a/utils/sctp/func_tests/test_connectx.c b/utils/sctp/func_tests/test_connectx.c
index 1d3e6fa0b..dba612d0e 100644
--- a/utils/sctp/func_tests/test_connectx.c
+++ b/utils/sctp/func_tests/test_connectx.c
@@ -49,6 +49,7 @@
 #include <errno.h>
 #include <netinet/sctp.h>
 #include <sctputil.h>
+#include "tst_kernel.h"
 
 char *TCID = __FILE__;
 int TST_TOTAL = 9;
@@ -81,6 +82,9 @@ main(void)
 	struct sockaddr_in clt_loop3[NUMADDR];
 	sockaddr_storage_t svr_test[NUMADDR], clt_test1[NUMADDR], clt_test2[NUMADDR];
 
+	if (tst_check_driver("sctp"))
+		tst_brkm(TCONF, tst_exit, "sctp driver not available");
+
 	/* Rather than fflush() throughout the code, set stdout to 
 	 * be unbuffered.  
 	 */ 
diff --git a/utils/sctp/func_tests/test_fragments.c b/utils/sctp/func_tests/test_fragments.c
index 5ef1da1bb..ce836bf9d 100644
--- a/utils/sctp/func_tests/test_fragments.c
+++ b/utils/sctp/func_tests/test_fragments.c
@@ -64,6 +64,7 @@
 #include <errno.h>
 #include <netinet/sctp.h>
 #include <sctputil.h>
+#include "tst_kernel.h"
 
 char *TCID = __FILE__;
 int TST_TOTAL = 4;
@@ -95,6 +96,9 @@ main(void)
 	int disable_frag;
 	socklen_t optlen;
 
+	if (tst_check_driver("sctp"))
+		tst_brkm(TCONF, tst_exit, "sctp driver not available");
+
         /* Rather than fflush() throughout the code, set stdout to 
 	 * be unbuffered. 
 	 */
diff --git a/utils/sctp/func_tests/test_getname.c b/utils/sctp/func_tests/test_getname.c
index 653bf7167..2d7916ccd 100644
--- a/utils/sctp/func_tests/test_getname.c
+++ b/utils/sctp/func_tests/test_getname.c
@@ -49,6 +49,7 @@
 #include <errno.h>
 #include <netinet/sctp.h>
 #include <sctputil.h>
+#include "tst_kernel.h"
 
 char *TCID = __FILE__;
 int TST_TOTAL = 13;
@@ -69,6 +70,9 @@ main(void)
 	int fd, err_no = 0;
 	char filename[21];
 
+	if (tst_check_driver("sctp"))
+		tst_brkm(TCONF, tst_exit, "sctp driver not available");
+
         /* Rather than fflush() throughout the code, set stdout to 
 	 * be unbuffered.  
 	 */ 
diff --git a/utils/sctp/func_tests/test_inaddr_any.c b/utils/sctp/func_tests/test_inaddr_any.c
index 722a7025f..11405e04d 100644
--- a/utils/sctp/func_tests/test_inaddr_any.c
+++ b/utils/sctp/func_tests/test_inaddr_any.c
@@ -56,6 +56,7 @@
 #include <errno.h>
 #include <netinet/sctp.h>
 #include <sctputil.h>
+#include "tst_kernel.h"
 
 char *TCID = __FILE__;
 int TST_TOTAL = 2;
@@ -84,6 +85,9 @@ main(void)
 	uint32_t stream;
 	socklen_t namelen;
 
+	if (tst_check_driver("sctp"))
+		tst_brkm(TCONF, tst_exit, "sctp driver not available");
+
         /* Rather than fflush() throughout the code, set stdout to 
 	 * be unbuffered. 
 	 */
diff --git a/utils/sctp/func_tests/test_peeloff.c b/utils/sctp/func_tests/test_peeloff.c
index 1b9e7014b..e3a7ee65f 100644
--- a/utils/sctp/func_tests/test_peeloff.c
+++ b/utils/sctp/func_tests/test_peeloff.c
@@ -51,6 +51,7 @@
 #include <errno.h>
 #include <netinet/sctp.h>
 #include <sctputil.h>
+#include "tst_kernel.h"
 
 char *TCID = __FILE__;
 int TST_TOTAL = 6;
@@ -81,6 +82,9 @@ main(void)
         char *message = "hello, world!\n";
 	int pf_class;
 
+	if (tst_check_driver("sctp"))
+		tst_brkm(TCONF, tst_exit, "sctp driver not available");
+
         /* Rather than fflush() throughout the code, set stdout to 
 	 * be unbuffered.  
 	 */ 
diff --git a/utils/sctp/func_tests/test_recvmsg.c b/utils/sctp/func_tests/test_recvmsg.c
index 0fb3012b9..4f0a91455 100644
--- a/utils/sctp/func_tests/test_recvmsg.c
+++ b/utils/sctp/func_tests/test_recvmsg.c
@@ -53,6 +53,7 @@
 #include <errno.h>
 #include <netinet/sctp.h>
 #include <sctputil.h>
+#include "tst_kernel.h"
 
 char *TCID = __FILE__;
 int TST_TOTAL = 2;
@@ -70,6 +71,9 @@ main(void)
 	char *big_buffer;
 	void *msg_buf;
 
+	if (tst_check_driver("sctp"))
+		tst_brkm(TCONF, tst_exit, "sctp driver not available");
+
         /* Rather than fflush() throughout the code, set stdout to 
 	 * be unbuffered.  
 	 */ 
diff --git a/utils/sctp/func_tests/test_sctp_sendrecvmsg.c b/utils/sctp/func_tests/test_sctp_sendrecvmsg.c
index 294784791..e9781a15d 100644
--- a/utils/sctp/func_tests/test_sctp_sendrecvmsg.c
+++ b/utils/sctp/func_tests/test_sctp_sendrecvmsg.c
@@ -54,6 +54,7 @@
 #include <errno.h>
 #include <netinet/sctp.h>
 #include <sctputil.h>
+#include "tst_kernel.h"
 
 char *TCID = __FILE__;
 int TST_TOTAL = 10;
@@ -92,6 +93,9 @@ int main(void)
 	socklen_t len, oldlen;
 	struct sctp_status gstatus;
 
+	if (tst_check_driver("sctp"))
+		tst_brkm(TCONF, tst_exit, "sctp driver not available");
+
 	/* Rather than fflush() throughout the code, set stdout to
 	 * be unbuffered.
 	 */
diff --git a/utils/sctp/func_tests/test_sockopt.c b/utils/sctp/func_tests/test_sockopt.c
index a31c5d3ab..80bd74995 100644
--- a/utils/sctp/func_tests/test_sockopt.c
+++ b/utils/sctp/func_tests/test_sockopt.c
@@ -56,6 +56,7 @@
 #include <netinet/in.h>
 #include <netinet/sctp.h>
 #include <sctputil.h>
+#include "tst_kernel.h"
 
 char *TCID = __FILE__;
 int TST_TOTAL = 29;
@@ -101,6 +102,9 @@ main(void)
 	struct sctp_status status;
 	struct sctp_assoc_value value;
 
+	if (tst_check_driver("sctp"))
+		tst_brkm(TCONF, tst_exit, "sctp driver not available");
+
         /* Rather than fflush() throughout the code, set stdout to
 	 * be unbuffered.
 	 */
diff --git a/utils/sctp/func_tests/test_tcp_style.c b/utils/sctp/func_tests/test_tcp_style.c
index 91a19c459..e993aeac5 100644
--- a/utils/sctp/func_tests/test_tcp_style.c
+++ b/utils/sctp/func_tests/test_tcp_style.c
@@ -50,6 +50,7 @@
 #include <errno.h>
 #include <netinet/sctp.h>
 #include <sctputil.h>
+#include "tst_kernel.h"
 
 char *TCID = __FILE__;
 int TST_TOTAL = 22;
@@ -81,6 +82,9 @@ main(void)
 	char *big_buffer;
 	struct iovec iov;
 
+	if (tst_check_driver("sctp"))
+		tst_brkm(TCONF, tst_exit, "sctp driver not available");
+
         /* Rather than fflush() throughout the code, set stdout to 
 	 * be unbuffered.  
 	 */ 
diff --git a/utils/sctp/func_tests/test_timetolive.c b/utils/sctp/func_tests/test_timetolive.c
index 1d6fa2b80..ff1b073fb 100644
--- a/utils/sctp/func_tests/test_timetolive.c
+++ b/utils/sctp/func_tests/test_timetolive.c
@@ -68,6 +68,7 @@
 #include <errno.h>
 #include <netinet/sctp.h>
 #include <sctputil.h>
+#include "tst_kernel.h"
 
 char *TCID = __FILE__;
 int TST_TOTAL = 6;
@@ -114,6 +115,9 @@ int main(void)
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

