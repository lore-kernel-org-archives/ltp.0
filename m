Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B48FAC636D4
	for <ltp@archiver.kernel.org>; Mon, 13 Feb 2023 13:41:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 82B5B3CBF7E
	for <ltp@archiver.kernel.org>; Mon, 13 Feb 2023 14:41:32 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D4DF73CB0FA
 for <ltp@lists.linux.it>; Mon, 13 Feb 2023 14:41:20 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6D344140098D
 for <ltp@lists.linux.it>; Mon, 13 Feb 2023 14:41:17 +0100 (CET)
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 31DDfAu2009697;
 Mon, 13 Feb 2023 21:41:10 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from atctrx.andestech.com (10.0.15.173) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0; Mon, 13 Feb 2023
 21:41:09 +0800
From: Leo Yu-Chi Liang <ycliang@andestech.com>
To: <ltp@lists.linux.it>
Date: Mon, 13 Feb 2023 21:41:04 +0800
Message-ID: <20230213134104.229241-1-ycliang@andestech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Originating-IP: [10.0.15.173]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 31DDfAu2009697
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] lib/tst_pid.c: Count used pid by traversing /proc
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Use "ps -eT | wc -l" to calculate the number of used pid
could have an incorrectly larger result because "ps -eT"
may list the same pid multiple times (with different SPID).

Instead, we could count used pid by traversing /proc
directory and count the subdirectories that have name
composed of digits.

Increase PIDS_RESERVED to avoid fork failure.

Signed-off-by: Leo Yu-Chi Liang <ycliang@andestech.com>
---
 lib/tst_pid.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/lib/tst_pid.c b/lib/tst_pid.c
index 5595e79bd..7582e4828 100644
--- a/lib/tst_pid.c
+++ b/lib/tst_pid.c
@@ -18,6 +18,7 @@
  *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
 
+#include <ctype.h>
 #include <errno.h>
 #include <fcntl.h>
 #include <limits.h>
@@ -35,7 +36,7 @@
 #define CGROUPS_V1_SLICE_FMT "/sys/fs/cgroup/pids/user.slice/user-%d.slice/pids.max"
 #define CGROUPS_V2_SLICE_FMT "/sys/fs/cgroup/user.slice/user-%d.slice/pids.max"
 /* Leave some available processes for the OS */
-#define PIDS_RESERVE 50
+#define PIDS_RESERVE 200
 
 pid_t tst_get_unused_pid_(void (*cleanup_fn) (void))
 {
@@ -113,21 +114,16 @@ static int get_session_pids_limit(void (*cleanup_fn) (void))
 
 int tst_get_free_pids_(void (*cleanup_fn) (void))
 {
-	FILE *f;
-	int rc, used_pids, max_pids, max_session_pids, max_threads;
-
-	f = popen("ps -eT | wc -l", "r");
-	if (!f) {
-		tst_brkm(TBROK, cleanup_fn, "Could not run 'ps' to calculate used pids");
-		return -1;
-	}
-	rc = fscanf(f, "%i", &used_pids);
-	pclose(f);
-
-	if (rc != 1 || used_pids < 0) {
-		tst_brkm(TBROK, cleanup_fn, "Could not read output of 'ps' to calculate used pids");
-		return -1;
+	DIR *f;
+	struct dirent *ent;
+	int max_pids, max_session_pids, max_threads, used_pids = 0;
+
+	f = SAFE_OPENDIR("/proc");
+	while ((ent = SAFE_READDIR(f))) {
+		if (isdigit(ent->d_name[0]))
+			++used_pids;
 	}
+	SAFE_CLOSEDIR(f);
 
 	SAFE_FILE_SCANF(cleanup_fn, PID_MAX_PATH, "%d", &max_pids);
 	SAFE_FILE_SCANF(cleanup_fn, THREADS_MAX_PATH, "%d", &max_threads);
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
