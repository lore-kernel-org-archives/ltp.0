Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F7B2C05027
	for <ltp@archiver.kernel.org>; Sun, 19 Feb 2023 08:53:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C7E4C3CBD90
	for <ltp@archiver.kernel.org>; Sun, 19 Feb 2023 09:53:07 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CD97D3CB039
 for <ltp@lists.linux.it>; Sun, 19 Feb 2023 09:52:56 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 366982000E9
 for <ltp@lists.linux.it>; Sun, 19 Feb 2023 09:52:52 +0100 (CET)
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 31J8qhZf054106;
 Sun, 19 Feb 2023 16:52:43 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from atctrx.andestech.com (10.0.15.173) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0; Sun, 19 Feb 2023
 16:52:41 +0800
From: Leo Yu-Chi Liang <ycliang@andestech.com>
To: <ltp@lists.linux.it>
Date: Sun, 19 Feb 2023 16:52:33 +0800
Message-ID: <20230219085233.645683-1-ycliang@andestech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Originating-IP: [10.0.15.173]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 31J8qhZf054106
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/1] lib/tst_pid.c: Count used pid by traversing
 /proc
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: peterlin@andestech.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Calling shell code from C programs makes things less predictable
and possibly unstable, so we modify the calculating process to
plain C code.

Suggested-by: Petr Vorel <pvorel@suse.cz>
Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Leo Yu-Chi Liang <ycliang@andestech.com>
---
 lib/tst_pid.c | 37 +++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/lib/tst_pid.c b/lib/tst_pid.c
index 5595e79bd..546526113 100644
--- a/lib/tst_pid.c
+++ b/lib/tst_pid.c
@@ -18,6 +18,7 @@
  *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
 
+#include <ctype.h>
 #include <errno.h>
 #include <fcntl.h>
 #include <limits.h>
@@ -111,23 +112,31 @@ static int get_session_pids_limit(void (*cleanup_fn) (void))
 	return max_pids;
 }
 
-int tst_get_free_pids_(void (*cleanup_fn) (void))
+static int get_used_pids(void (*cleanup_fn) (void))
 {
-	FILE *f;
-	int rc, used_pids, max_pids, max_session_pids, max_threads;
-
-	f = popen("ps -eT | wc -l", "r");
-	if (!f) {
-		tst_brkm(TBROK, cleanup_fn, "Could not run 'ps' to calculate used pids");
-		return -1;
+	DIR *dir_proc;
+	struct dirent *ent;
+	char status_path[PATH_MAX];
+	int used_thread, used_pids = 0;
+
+	dir_proc = SAFE_OPENDIR("/proc");
+
+	while ((ent = SAFE_READDIR(dir_proc))) {
+		if (isdigit(ent->d_name[0])) {
+			snprintf(status_path, sizeof(status_path), "/proc/%s/status", ent->d_name);
+			if (!FILE_LINES_SCANF(cleanup_fn, status_path, "Threads: %d", &used_threads))
+				used_pids += used_threads;
+		}
 	}
-	rc = fscanf(f, "%i", &used_pids);
-	pclose(f);
 
-	if (rc != 1 || used_pids < 0) {
-		tst_brkm(TBROK, cleanup_fn, "Could not read output of 'ps' to calculate used pids");
-		return -1;
-	}
+	SAFE_CLOSEDIR(dir_proc);
+
+	return used_pids;
+}
+
+int tst_get_free_pids_(void (*cleanup_fn) (void))
+{
+	int max_pids, max_session_pids, max_threads, used_pids = get_used_pids(cleanup_fn);
 
 	SAFE_FILE_SCANF(cleanup_fn, PID_MAX_PATH, "%d", &max_pids);
 	SAFE_FILE_SCANF(cleanup_fn, THREADS_MAX_PATH, "%d", &max_threads);
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
