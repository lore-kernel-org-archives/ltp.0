Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CACADC636CC
	for <ltp@archiver.kernel.org>; Wed, 15 Feb 2023 14:55:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 728EE3CC40F
	for <ltp@archiver.kernel.org>; Wed, 15 Feb 2023 15:55:13 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2ECE93CBF0B
 for <ltp@lists.linux.it>; Wed, 15 Feb 2023 15:54:51 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by in-7.smtp.seeweb.it (Postfix) with ESMTP id CD0BD200AC8
 for <ltp@lists.linux.it>; Wed, 15 Feb 2023 15:54:49 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C12171477;
 Wed, 15 Feb 2023 06:55:30 -0800 (PST)
Received: from e126380.cambridge.arm.com (unknown [10.1.196.169])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A0B4E3F703;
 Wed, 15 Feb 2023 06:54:47 -0800 (PST)
From: Teo Couprie Diaz <teo.coupriediaz@arm.com>
To: ltp@lists.linux.it
Date: Wed, 15 Feb 2023 14:54:39 +0000
Message-Id: <20230215145440.78482-3-teo.coupriediaz@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230215145440.78482-1-teo.coupriediaz@arm.com>
References: <20230215145440.78482-1-teo.coupriediaz@arm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/3] lib/tst_pid: Go to parent cgroups for max value
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
Cc: Beata Michalska <beata.michalska@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

A cgroup resource limitation can be either a number or "max".
It means that the cgroup will not be limited _more_ than it already is.
This can mean that it will use the kernel limit for the resource, if it
exists, or the limit of a parent cgroup.

This patch reworks "read_session_pids_limit" to go up the cgroup hierarchy
if it encounters a "max" value rather than a numerical one, using the
kernel limit in the event where it doesn't find any.

Clean up uid related code as it is not used anymore.

Signed-off-by: Teo Couprie Diaz <teo.coupriediaz@arm.com>
Co-developed-by: Beata Michalska <beata.michalska@arm.com>
Signed-off-by: Beata Michalska <beata.michalska@arm.com>
---
 lib/tst_pid.c | 96 +++++++++++++++++++++++++++++----------------------
 1 file changed, 54 insertions(+), 42 deletions(-)

diff --git a/lib/tst_pid.c b/lib/tst_pid.c
index 3d0be6dcd..ad1893290 100644
--- a/lib/tst_pid.c
+++ b/lib/tst_pid.c
@@ -44,50 +44,69 @@ pid_t tst_get_unused_pid_(void (*cleanup_fn) (void))
 	return pid;
 }
 
-/*
- * Get the effective session UID - either one invoking current test via sudo
- * or the real UID.
- */
-static unsigned int get_session_uid(void)
+static int __read_pids_limit(const char *path, void (*cleanup_fn) (void))
 {
-	const char *sudo_uid;
+	char max_pids_value[100];
+	int max_pids;
 
-	sudo_uid = getenv("SUDO_UID");
-	if (sudo_uid) {
-		unsigned int real_uid;
-		int ret;
+	if (access(path, R_OK) != 0) {
+		tst_resm(TINFO, "Cannot read session user limits from '%s'", path);
+		return -1;
+	}
 
-		ret = sscanf(sudo_uid, "%u", &real_uid);
-		if (ret == 1)
-			return real_uid;
+	SAFE_FILE_SCANF(cleanup_fn, path, "%s", max_pids_value);
+	if (strcmp(max_pids_value, "max")) {
+		max_pids =  SAFE_STRTOL(max_pids_value, 0, INT_MAX);
+		tst_resm(TINFO, "Found limit of processes %d (from %s)",
+				max_pids, path);
+	} else {
+		max_pids = -1;
 	}
 
-	return getuid();
+	return max_pids;
 }
 
-static int read_session_pids_limit(const char *path_fmt, int uid,
-				   void (*cleanup_fn) (void))
+/*
+ * Take the path to the cgroup mount and to the current cgroup pid controller
+ * and try to find the PID limit imposed by cgroup.
+ * Go up the cgroup hierarchy if needed, otherwise use the kernel PID limit.
+ */
+static int read_session_pids_limit(const char *cgroup_mount,
+				   const char *cgroup_path, void (*cleanup_fn) (void))
 {
-	int max_pids, ret;
-	char max_pid_value[100];
-	char path[PATH_MAX];
-
-	ret = snprintf(path, sizeof(path), path_fmt, uid);
+	int ret, cgroup_depth = 0, max_pids = -1;
+	char path[PATH_MAX + 1], file_path[PATH_MAX + 1];
+	const char *sub_path = cgroup_path;
+
+	/* Find the number of groups we can go up. */
+	do {
+		cgroup_depth += 1;
+		sub_path++;
+		sub_path = strchr(sub_path, '/');
+	} while (sub_path);
+
+	ret = snprintf(path, sizeof(path), "%s%s", cgroup_mount, cgroup_path);
 	if (ret < 0 || (size_t)ret >= sizeof(path))
 		return -1;
 
-	if (access(path, R_OK) != 0) {
-		tst_resm(TINFO, "Cannot read session user limits from '%s'", path);
-		return -1;
+	for (int i = 0 ; i < cgroup_depth ; i++) {
+		/* Create a path to read from. */
+		ret = snprintf(file_path, sizeof(file_path), "%s/pids.max", path);
+		if (ret < 0 || (size_t)ret >= sizeof(file_path))
+			return -1;
+
+		max_pids = __read_pids_limit(file_path, cleanup_fn);
+		if (max_pids >= 0)
+			return max_pids;
+
+		strncat(path, "/..", PATH_MAX);
 	}
 
-	SAFE_FILE_SCANF(cleanup_fn, path, "%s", max_pid_value);
-	if (!strcmp(max_pid_value, "max")) {
+	if (max_pids < 0) {
+		/* Read kernel imposed limits */
 		SAFE_FILE_SCANF(cleanup_fn, PID_MAX_PATH, "%d", &max_pids);
-		tst_resm(TINFO, "Found limit of processes %d (from %s=max)", max_pids, path);
-	} else {
-		max_pids = SAFE_STRTOL(max_pid_value, 0, INT_MAX);
-		tst_resm(TINFO, "Found limit of processes %d (from %s)", max_pids, path);
+		tst_resm(TINFO, "Using kernel processes limit of %d",
+			 max_pids);
 	}
 
 	return max_pids;
@@ -98,9 +117,8 @@ static int get_session_pids_limit(void (*cleanup_fn) (void))
 	char path[PATH_MAX + 1];
 	char cgroup_pids[PATH_MAX + 1];
 	char catchall;
-	int uid, ret = 0;
+	int ret = 0;
 
-	uid = get_session_uid();
 	/* Check for generic cgroup v1 pid.max */
 	ret = FILE_LINES_SCANF(cleanup_fn, "/proc/self/cgroup",
 						   "%*d:pids:%s\n", cgroup_pids);
@@ -121,11 +139,8 @@ static int get_session_pids_limit(void (*cleanup_fn) (void))
 							   "%*s %*s %*s %*s %s %*[^-] - cgroup %*s %*[rw],pid%c",
 							   path, &catchall);
 
-	if (!ret) {
-		strncat(path, cgroup_pids, PATH_MAX);
-		strncat(path, "/pids.max", PATH_MAX);
-		return read_session_pids_limit(path, uid, cleanup_fn);
-	}
+	if (!ret)
+		return read_session_pids_limit(path, cgroup_pids, cleanup_fn);
 
 	/* Check for generic cgroup v2 pid.max */
 	ret = FILE_LINES_SCANF(cleanup_fn, "/proc/self/cgroup",
@@ -135,11 +150,8 @@ static int get_session_pids_limit(void (*cleanup_fn) (void))
 							   "%*s %*s %*s %*s %s %*[^-] - cgroup2 %c",
 							   path, &catchall);
 
-	if (!ret) {
-		strncat(path, cgroup_pids, PATH_MAX);
-		strncat(path, "/pids.max", PATH_MAX);
-		return read_session_pids_limit(path, uid, cleanup_fn);
-	}
+	if (!ret)
+		return read_session_pids_limit(path, cgroup_pids, cleanup_fn);
 
 	return -1;
 }
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
