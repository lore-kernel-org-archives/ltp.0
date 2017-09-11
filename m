From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Mon, 11 Sep 2017 13:50:53 +0200
Subject: [LTP] [PATCH v5 2/3] CVE-2012-0957: Use SAFE_PERSONALITY
In-Reply-To: <20170911115054.19982-1-rpalethorpe@suse.com>
References: <20170911115054.19982-1-rpalethorpe@suse.com>
Message-ID: <20170911115054.19982-2-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 testcases/cve/cve-2012-0957.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/testcases/cve/cve-2012-0957.c b/testcases/cve/cve-2012-0957.c
index f065735a1..096f49f69 100644
--- a/testcases/cve/cve-2012-0957.c
+++ b/testcases/cve/cve-2012-0957.c
@@ -26,10 +26,8 @@
 
 #include <string.h>
 #include <sys/utsname.h>
-#include <sys/personality.h>
 #include "tst_test.h"
-
-#define UNAME26 0x0020000
+#include "lapi/personality.h"
 
 static int check_field(char *bytes, size_t length, char *field)
 {
@@ -75,9 +73,7 @@ static void run(unsigned int test_nr)
 		tst_res(TINFO, "Calling uname with default personality");
 		try_leak_bytes();
 	} else {
-		if (personality(PER_LINUX | UNAME26) < 0)
-			tst_brk(TCONF | TERRNO,
-				"Could not change personality to UNAME26");
+		SAFE_PERSONALITY(PER_LINUX | UNAME26);
 		tst_res(TINFO, "Calling uname with UNAME26 personality");
 		try_leak_bytes();
 	}
-- 
2.14.1

