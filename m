Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <mats.liljegren@enea.com>) id 1WjrWs-0006kw-2T
	for ltp-list@lists.sourceforge.net; Mon, 12 May 2014 14:48:34 +0000
Received: from sestofw01.enea.se ([192.36.1.252] helo=mx-3.enea.com)
	by sog-mx-1.v43.ch3.sourceforge.com with smtp (Exim 4.76)
	id 1WjrWp-00063o-Mb
	for ltp-list@lists.sourceforge.net; Mon, 12 May 2014 14:48:34 +0000
From: Mats Liljegren <mats.liljegren@enea.com>
Date: Mon, 12 May 2014 16:48:11 +0200
Message-ID: <1399906092-28901-2-git-send-email-mats.liljegren@enea.com>
In-Reply-To: <1399906092-28901-1-git-send-email-mats.liljegren@enea.com>
References: <1399906092-28901-1-git-send-email-mats.liljegren@enea.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH 1/2] SAFE_POPEN: Added function to safe_stdio.h
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

Signed-off-by: Mats Liljegren <mats.liljegren@enea.com>
---
 include/safe_stdio.h |    5 +++++
 lib/safe_stdio.c     |   25 +++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/include/safe_stdio.h b/include/safe_stdio.h
index a4e3da0..b006567 100644
--- a/include/safe_stdio.h
+++ b/include/safe_stdio.h
@@ -36,4 +36,9 @@ int safe_asprintf(const char *file, const int lineno, void (cleanup_fn)(void),
 #define SAFE_ASPRINTF(cleanup_fn, strp, fmt, ...) \
 	safe_asprintf(__FILE__, __LINE__, cleanup_fn, strp, fmt, __VA_ARGS__)
 
+FILE *safe_popen(const char *file, const int lineno, void (cleanup_fn)(void),
+		 const char *command, const char *type);
+#define SAFE_POPEN(cleanup_fn, command, type) \
+	safe_popen(__FILE__, __LINE__, cleanup_fn, command, type)
+
 #endif /* __SAFE_STDIO_H__ */
diff --git a/lib/safe_stdio.c b/lib/safe_stdio.c
index d9a2529..b61daa5 100644
--- a/lib/safe_stdio.c
+++ b/lib/safe_stdio.c
@@ -19,6 +19,7 @@
 #define _GNU_SOURCE
 #include <stdarg.h>
 #include <stdio.h>
+#include <errno.h>
 #include "test.h"
 #include "safe_stdio.h"
 
@@ -68,3 +69,27 @@ int safe_asprintf(const char *file, const int lineno, void (cleanup_fn)(void),
 
 	return ret;
 }
+
+FILE *safe_popen(const char *file, const int lineno, void (cleanup_fn)(void),
+		 const char *command, const char *type)
+{
+	FILE *stream;
+	const int saved_errno = errno;
+
+	errno = 0;
+	stream = popen(command, type);
+
+	if (stream == NULL) {
+		if (errno != 0) {
+			tst_brkm(TBROK | TERRNO, cleanup_fn,
+				 "%s:%d: popen(%s,%s) failed",
+				 file, lineno, command, type);
+		} else {
+			tst_brkm(TBROK, cleanup_fn,
+				 "%s:%d: popen(%s,%s) failed: Out of memory",
+				 file, lineno, command, type);
+		}
+	}
+
+	errno = saved_errno;
+}
-- 
1.7.10.4


------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.
Get unparalleled scalability from the best Selenium testing platform available
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
