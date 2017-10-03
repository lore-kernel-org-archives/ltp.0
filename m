From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue,  3 Oct 2017 16:20:00 +0200
Subject: [LTP] [COMMITTED] [PATCH 27/40] Make use of SAFE_IOCTL()
In-Reply-To: <20171003142013.25230-1-chrubis@suse.cz>
References: <20171003142013.25230-1-chrubis@suse.cz>
Message-ID: <20171003142013.25230-27-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/ioctl/ioctl02.c         | 8 ++------
 testcases/kernel/syscalls/sockioctl/sockioctl01.c | 6 ++----
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl02.c b/testcases/kernel/syscalls/ioctl/ioctl02.c
index 9201ce205..48e8eaa7f 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl02.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl02.c
@@ -370,9 +370,7 @@ static int do_parent_setup(void)
 	closed = 0;
 
 	/* flush tty queues to remove old output */
-	if (ioctl(pfd, TCFLSH, 2) < 0)
-		tst_brkm(TBROK, cleanup, "ioctl TCFLSH failed : "
-			 "errno = %d", errno);
+	SAFE_IOCTL(cleanup, pfd, TCFLSH, 2);
 	return pfd;
 }
 
@@ -438,9 +436,7 @@ static void setup(void)
 			 "setup(), errno = %d", devname, errno);
 
 	/* Save the current device information - to be restored in cleanup() */
-	if (ioctl(fd, TCGETA, &save_io) < 0)
-		tst_brkm(TBROK, cleanup, "TCGETA ioctl failed in "
-			 "do_parent_setup");
+	SAFE_IOCTL(cleanup, fd, TCGETA, &save_io);
 
 	/* Close the device */
 	SAFE_CLOSE(cleanup, fd);
diff --git a/testcases/kernel/syscalls/sockioctl/sockioctl01.c b/testcases/kernel/syscalls/sockioctl/sockioctl01.c
index 50bdc935a..ce1831cc8 100644
--- a/testcases/kernel/syscalls/sockioctl/sockioctl01.c
+++ b/testcases/kernel/syscalls/sockioctl/sockioctl01.c
@@ -40,6 +40,7 @@
 #include <net/if.h>
 
 #include "test.h"
+#include "safe_macros.h"
 
 char *TCID = "sockioctl01";
 int testno;
@@ -235,10 +236,7 @@ static void setup2(void)
 static void setup3(void)
 {
 	setup2();
-	if (ioctl(s, SIOCGIFCONF, &ifc) < 0) {
-		tst_brkm(TBROK, cleanup, "socket setup failed: %s",
-			 strerror(errno));
-	}
+	SAFE_IOCTL(cleanup, s, SIOCGIFCONF, &ifc);
 	ifr = *(struct ifreq *)ifc.ifc_buf;
 }
 
-- 
2.13.5

