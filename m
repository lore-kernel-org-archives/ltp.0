From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 13 Nov 2020 16:51:22 +0100
Subject: [LTP] [PATCH v2 4/5] fanotify: Check FAN_REPORT_{FID, NAME} support
In-Reply-To: <20201113155123.5959-1-pvorel@suse.cz>
References: <20201113155123.5959-1-pvorel@suse.cz>
Message-ID: <20201113155123.5959-5-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

in safe_fanotify_init()

Suggested-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
New in v2.

 testcases/kernel/syscalls/fanotify/fanotify.h | 21 +++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
index 8452f983a..277760c09 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify.h
+++ b/testcases/kernel/syscalls/fanotify/fanotify.h
@@ -48,11 +48,24 @@ int safe_fanotify_init(const char *file, const int lineno,
 
 	if (rval == -1) {
 		if (errno == ENOSYS) {
-			tst_brk(TCONF,
-				"fanotify is not configured in this kernel.");
+			tst_brk(TCONF, "%s:%d: fanotify is not configured in this kernel",
+				file, lineno);
 		}
-		tst_brk(TBROK | TERRNO,
-			"%s:%d: fanotify_init() failed", file, lineno);
+
+		if (errno == EINVAL) {
+			if (flags & FAN_REPORT_FID) {
+				tst_brk(TCONF, "%s:%d: FAN_REPORT_FID not supported by kernel?",
+					file, lineno);
+			}
+
+			if (flags & FAN_REPORT_NAME) {
+				tst_brk(TCONF, "%s:%d: FAN_REPORT_NAME not supported by kernel?",
+					file, lineno);
+			}
+		}
+
+		tst_brk(TBROK | TERRNO, "%s:%d: fanotify_init() failed",
+			file, lineno);
 	}
 #else
 	tst_brk(TCONF, "Header <sys/fanotify.h> is not present");
-- 
2.29.2

