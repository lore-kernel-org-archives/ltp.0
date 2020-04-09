From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Thu,  9 Apr 2020 08:07:44 +0200
Subject: [LTP] [PATCH v2 1/2] pty04: Use guarded buffers for transmission
Message-ID: <20200409060745.9619-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---

V2: Simply resend of patch-set with this commit included

 testcases/kernel/pty/pty04.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/pty/pty04.c b/testcases/kernel/pty/pty04.c
index 0273bf902..d730d6834 100644
--- a/testcases/kernel/pty/pty04.c
+++ b/testcases/kernel/pty/pty04.c
@@ -27,6 +27,7 @@
 
 #define _GNU_SOURCE
 #include "tst_test.h"
+#include "tst_buffers.h"
 #include "config.h"
 
 #if defined(HAVE_LINUX_IF_PACKET_H) && defined(HAVE_LINUX_IF_ETHER_H)
@@ -110,7 +111,7 @@ static ssize_t try_write(int fd, char *data, ssize_t size, ssize_t *written)
 
 static void write_pty(void)
 {
-	char *data = SAFE_MALLOC(mtu);
+	char *data = tst_alloc(mtu);
 	ssize_t written, ret;
 
 	memset(data, '_', mtu - 1);
@@ -137,7 +138,7 @@ static void write_pty(void)
 
 	tst_res(TPASS, "Writing to PTY interrupted by hangup");
 
-	free(data);
+	tst_free_all();
 }
 
 static void open_netdev(struct ldisc_info *ldisc)
@@ -203,7 +204,7 @@ static void check_data(const char *data, ssize_t len)
 static void read_netdev(void)
 {
 	int rlen, plen = mtu - 1;
-	char *data = SAFE_MALLOC(plen);
+	char *data = tst_alloc(plen);
 
 	tst_res(TINFO, "Reading from socket %d", sk);
 
@@ -222,7 +223,7 @@ static void read_netdev(void)
 
 	tst_res(TPASS, "Reading data from netdev interrupted by hangup");
 
-	free(data);
+	tst_free_all();
 }
 
 static void do_test(unsigned int n)
-- 
2.24.0

