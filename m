Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71815C636CC
	for <ltp@archiver.kernel.org>; Wed, 15 Feb 2023 14:55:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5069D3CBF11
	for <ltp@archiver.kernel.org>; Wed, 15 Feb 2023 15:55:36 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6A8183CB4DB
 for <ltp@lists.linux.it>; Wed, 15 Feb 2023 15:54:50 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by in-2.smtp.seeweb.it (Postfix) with ESMTP id B23A9600101
 for <ltp@lists.linux.it>; Wed, 15 Feb 2023 15:54:49 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B5E5106F
 for <ltp@lists.linux.it>; Wed, 15 Feb 2023 06:55:30 -0800 (PST)
Received: from e126380.cambridge.arm.com (unknown [10.1.196.169])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 16B143F703
 for <ltp@lists.linux.it>; Wed, 15 Feb 2023 06:54:46 -0800 (PST)
From: Teo Couprie Diaz <teo.coupriediaz@arm.com>
To: ltp@lists.linux.it
Date: Wed, 15 Feb 2023 14:54:38 +0000
Message-Id: <20230215145440.78482-2-teo.coupriediaz@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230215145440.78482-1-teo.coupriediaz@arm.com>
References: <20230215145440.78482-1-teo.coupriediaz@arm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/3] lib/tst_pid: Find cgroup pid.max programmatically
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

In some distributions, the two files used in lib/tst_pid.c are not
available, but cgroups still imposes a task limit far smaller than
the kernel pid_max.
If the cgroup sysfs is mounted, we can use it to retrieve the current task
limit imposed to the process. Implement the retrieval of this limit.

This can be done by first checking /proc/self/cgroup to get the cgroup
the process is in, which will be a path under the cgroup sysfs.
To get the path to the cgroup sysfs, check /proc/self/mountinfo.
Finally, concatenate those two paths with pid.max to get the full path
to the file containing the limit.

This patch changes the way read_session_pids_limit is called, not passing
a format string to be completed anymore, but is still used the same way.
A following patch will update this function.

This fixes failures for msgstress04.

Signed-off-by: Teo Couprie Diaz <teo.coupriediaz@arm.com>
---
 lib/tst_pid.c | 53 +++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 43 insertions(+), 10 deletions(-)

diff --git a/lib/tst_pid.c b/lib/tst_pid.c
index 5595e79bd..3d0be6dcd 100644
--- a/lib/tst_pid.c
+++ b/lib/tst_pid.c
@@ -32,8 +32,6 @@
 
 #define PID_MAX_PATH "/proc/sys/kernel/pid_max"
 #define THREADS_MAX_PATH "/proc/sys/kernel/threads-max"
-#define CGROUPS_V1_SLICE_FMT "/sys/fs/cgroup/pids/user.slice/user-%d.slice/pids.max"
-#define CGROUPS_V2_SLICE_FMT "/sys/fs/cgroup/user.slice/user-%d.slice/pids.max"
 /* Leave some available processes for the OS */
 #define PIDS_RESERVE 50
 
@@ -97,18 +95,53 @@ static int read_session_pids_limit(const char *path_fmt, int uid,
 
 static int get_session_pids_limit(void (*cleanup_fn) (void))
 {
-	int max_pids, uid;
+	char path[PATH_MAX + 1];
+	char cgroup_pids[PATH_MAX + 1];
+	char catchall;
+	int uid, ret = 0;
 
 	uid = get_session_uid();
-	max_pids = read_session_pids_limit(CGROUPS_V2_SLICE_FMT, uid, cleanup_fn);
-	if (max_pids < 0)
-		max_pids = read_session_pids_limit(CGROUPS_V1_SLICE_FMT, uid,
-						   cleanup_fn);
+	/* Check for generic cgroup v1 pid.max */
+	ret = FILE_LINES_SCANF(cleanup_fn, "/proc/self/cgroup",
+						   "%*d:pids:%s\n", cgroup_pids);
+	/*
+	 * This is a bit of a hack of scanf format strings. Indeed, if all
+	 * conversion specifications have been matched the return of scanf will be
+	 * the same whether any outstanding literal characters match or not.
+	 * As we want to match the literal part, we can add a catchall after it
+	 * so that it won't be counted if the literal part doesn't match.
+	 * This makes the macro go to the next line until the catchall, thus
+	 * the literal parts, is matched.
+	 *
+	 * Assume that the root of the mount is '/'. It can be anything,
+	 * but it should be '/' on any normal system.
+	 */
+	if (!ret)
+		ret = FILE_LINES_SCANF(cleanup_fn, "/proc/self/mountinfo",
+							   "%*s %*s %*s %*s %s %*[^-] - cgroup %*s %*[rw],pid%c",
+							   path, &catchall);
+
+	if (!ret) {
+		strncat(path, cgroup_pids, PATH_MAX);
+		strncat(path, "/pids.max", PATH_MAX);
+		return read_session_pids_limit(path, uid, cleanup_fn);
+	}
 
-	if (max_pids < 0)
-		return -1;
+	/* Check for generic cgroup v2 pid.max */
+	ret = FILE_LINES_SCANF(cleanup_fn, "/proc/self/cgroup",
+						   "%*d::%s\n", cgroup_pids);
+	if (!ret)
+		ret = FILE_LINES_SCANF(cleanup_fn, "/proc/self/mountinfo",
+							   "%*s %*s %*s %*s %s %*[^-] - cgroup2 %c",
+							   path, &catchall);
+
+	if (!ret) {
+		strncat(path, cgroup_pids, PATH_MAX);
+		strncat(path, "/pids.max", PATH_MAX);
+		return read_session_pids_limit(path, uid, cleanup_fn);
+	}
 
-	return max_pids;
+	return -1;
 }
 
 int tst_get_free_pids_(void (*cleanup_fn) (void))
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
