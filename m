Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A68AAC433EF
	for <ltp@archiver.kernel.org>; Mon, 22 Nov 2021 07:26:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B1F0E3C8C7F
	for <ltp@archiver.kernel.org>; Mon, 22 Nov 2021 08:26:56 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3CDC63C8C5C
 for <ltp@lists.linux.it>; Mon, 22 Nov 2021 08:26:17 +0100 (CET)
Received: from mail.jv-coder.de (mail.jv-coder.de [5.9.79.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 853231A010EA
 for <ltp@lists.linux.it>; Mon, 22 Nov 2021 08:26:16 +0100 (CET)
Received: from ubuntu.localdomain (unknown [188.195.115.12])
 by mail.jv-coder.de (Postfix) with ESMTPSA id 792869FD36;
 Mon, 22 Nov 2021 07:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jv-coder.de; s=dkim;
 t=1637565975; bh=5knM9pwRm77r/wKxoamqGDYBx/eAShhVa7WOj0F9Xeo=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=DbZPN4kt+DKn5BoMuUwjXIbk54SOSYBKGadxYWvD1AUnkw2gU8vse5WqbF4TlLvzS
 Gxx17KD50c2qjRrjeOYLi8eJGqswAPumY6u86IuTs5CWo+LCS93W3H9exmBcKeve0Q
 ZAubf5nP3ceYnlyi1njvL5Toc24saLFKMCInw2+s=
From: Joerg Vehlow <lkml@jv-coder.de>
To: ltp@lists.linux.it,
	chrubis@suse.cz
Date: Mon, 22 Nov 2021 08:26:01 +0100
Message-Id: <20211122072601.4096577-4-lkml@jv-coder.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211122072601.4096577-1-lkml@jv-coder.de>
References: <20211122072601.4096577-1-lkml@jv-coder.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 4/4] posix/interface/conformance: Fix all
 unused-result warnings
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
Cc: Joerg Vehlow <joerg.vehlow@aox-tech.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Joerg Vehlow <joerg.vehlow@aox-tech.de>

On error the failed function is printed and PTS_UNRESOLVED returned.

Signed-off-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
---
 .../conformance/interfaces/clock_getcpuclockid/5-1.c   | 10 ++++++++--
 .../conformance/interfaces/kill/2-2.c                  |  5 ++++-
 .../conformance/interfaces/kill/3-1.c                  |  5 ++++-
 .../conformance/interfaces/mmap/18-1.c                 |  8 ++++++--
 .../conformance/interfaces/mq_open/16-1.c              |  8 ++++++--
 .../conformance/interfaces/sched_setparam/2-1.c        |  5 ++++-
 .../conformance/interfaces/sched_setparam/2-2.c        |  5 ++++-
 .../conformance/interfaces/sched_yield/1-1.c           |  9 ++++++---
 .../conformance/interfaces/shm_open/26-2.c             |  9 ++++++---
 .../conformance/interfaces/shm_unlink/8-1.c            |  3 ++-
 .../conformance/interfaces/shm_unlink/9-1.c            |  6 ++++--
 .../conformance/interfaces/sigaltstack/9-1.c           |  5 ++++-
 testcases/open_posix_testsuite/include/affinity.h      |  3 ++-
 13 files changed, 60 insertions(+), 21 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/clock_getcpuclockid/5-1.c b/testcases/open_posix_testsuite/conformance/interfaces/clock_getcpuclockid/5-1.c
index 0046d5066..2e9961a19 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/clock_getcpuclockid/5-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/clock_getcpuclockid/5-1.c
@@ -35,8 +35,14 @@ int main(void)
 
 		pwd = getpwnam("nobody");
 		if (pwd != NULL) {
-			setgid(pwd->pw_gid);
-			setuid(pwd->pw_uid);
+			if (setgid(pwd->pw_gid)) {
+				perror("setgid");
+				return PTS_UNRESOLVED;
+			}
+			if (setuid(pwd->pw_uid)) {
+				perror("setuid");
+				return PTS_UNRESOLVED;
+			}
 		}
 	}
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/kill/2-2.c b/testcases/open_posix_testsuite/conformance/interfaces/kill/2-2.c
index dd566831c..1cd3b2fdc 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/kill/2-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/kill/2-2.c
@@ -55,7 +55,10 @@ int main(void)
 	 */
 	/* this is added incase user is root. If user is normal user, then it
 	 * has no effect on the tests */
-	setuid(1);
+	if (setuid(1)) {
+		perror("setuid");
+		return PTS_UNRESOLVED;
+	}
 
 	if (-1 == kill(1, 0)) {
 		if (EPERM == errno) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/kill/3-1.c b/testcases/open_posix_testsuite/conformance/interfaces/kill/3-1.c
index a5999332b..70a8c590c 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/kill/3-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/kill/3-1.c
@@ -23,7 +23,10 @@ int main(void)
 {
 	/* this is added incase user is root. If user is normal user, then it
 	 * has no effect on the tests */
-	setuid(1);
+	if (setuid(1)) {
+		perror("setuid");
+		return PTS_UNRESOLVED;
+	}
 
 	if (kill(1, 0) != -1) {
 		printf
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mmap/18-1.c b/testcases/open_posix_testsuite/conformance/interfaces/mmap/18-1.c
index 113d01b8c..9d02a074d 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mmap/18-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mmap/18-1.c
@@ -124,14 +124,18 @@ int main(void)
 	 * EAGAIN:
 	 * Lock all the memory by mlockall().
 	 * Set resource limit setrlimit()
-	 * Change the user to non-root then only setrmilit is applicable.
+	 * Change the user to non-root then only setrlimit is applicable.
 	 */
 	pa = mmap(NULL, len, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
 	if (pa == MAP_FAILED && errno == EAGAIN) {
 		printf("Got EAGAIN: %s\n", strerror(errno));
 		printf("Test PASSED\n");
 		/* Change user to root */
-		seteuid(0);
+		if (seteuid(0)) {
+			close(fd);
+			perror("seteuid");
+			return PTS_UNRESOLVED;
+		}
 		close(fd);
 		munmap(pa, len);
 		return PTS_PASS;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mq_open/16-1.c b/testcases/open_posix_testsuite/conformance/interfaces/mq_open/16-1.c
index eee55a748..ecbfb0f79 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mq_open/16-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mq_open/16-1.c
@@ -61,10 +61,14 @@ int main(void)
 		printf(TNAME " Error at open(): %s\n", strerror(errno));
 		return PTS_UNRESOLVED;
 	}
-	/* file is empty now, will cause "Bus error" */
-	write(fd, fname, sizeof(int));
 	unlink(fname);
 
+	if (ftruncate(fd, sizeof(int))) {
+		perror("ftruncate");
+		close(fd);
+		return PTS_UNRESOLVED;
+	}
+
 	pa = mmap(NULL, sizeof(int), PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
 	if (pa == MAP_FAILED) {
 		printf(TNAME " Error at mmap: %s\n", strerror(errno));
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/2-1.c
index da56343d0..fb19ff6a4 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/2-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/2-1.c
@@ -125,7 +125,10 @@ int main(void)
 		return PTS_UNRESOLVED;
 	}
 
-	pipe(the_pipe);
+	if (pipe(the_pipe)) {
+		perror("pipe");
+		return PTS_UNRESOLVED;
+	}
 
 	for (i = 0; i < nb_child; i++) {
 		child_pid[i] = fork();
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/2-2.c b/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/2-2.c
index 6f10618b6..6c68120c3 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/2-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/2-2.c
@@ -129,7 +129,10 @@ int main(void)
 		return PTS_UNRESOLVED;
 	}
 
-	pipe(the_pipe);
+	if (pipe(the_pipe)) {
+		perror("pipe");
+		return PTS_UNRESOLVED;
+	}
 
 	for (i = 0; i < nb_child; i++) {
 		child_pid[i] = fork();
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sched_yield/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sched_yield/1-1.c
index 602733e60..2e1e3197a 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sched_yield/1-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sched_yield/1-1.c
@@ -45,18 +45,21 @@ static int child_busy(int fd)
 	alarm(4);
 
 	/* Tell the parent we're ready */
-	write(fd, "go", 2);
+	if (write(fd, "go", 2) == -1) {
+		perror("write");
+		exit(PTS_UNRESOLVED);
+	}
 
 	for (;;) {
 		rc = sched_yield();
 		if (rc) {
 			ERR_LOG("child: sched_yield", rc);
-			exit(1);
+			exit(PTS_FAIL);
 		}
 	}
 
 	/* should not get here */
-	exit(2);
+	exit(PTS_UNRESOLVED);
 }
 
 int main(void)
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/shm_open/26-2.c b/testcases/open_posix_testsuite/conformance/interfaces/shm_open/26-2.c
index 215d3e1af..69edeae85 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/shm_open/26-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/shm_open/26-2.c
@@ -95,19 +95,22 @@ int main(void)
 	fd = shm_open(SHM_NAME, O_RDWR | O_TRUNC, 0);
 	if (fd == -1) {
 		perror("An error occurs when calling shm_open()");
-		seteuid(getuid());
+		if (seteuid(getuid()))
+			perror("seteuid");
 		shm_unlink(SHM_NAME);
 		return PTS_UNRESOLVED;
 	}
 
 	if (fstat(fd, &stat_buf) != 0) {
 		perror("An error occurs when calling fstat()");
-		seteuid(getuid());
+		if (seteuid(getuid()))
+			perror("seteuid");
 		shm_unlink(SHM_NAME);
 		return PTS_UNRESOLVED;
 	}
 
-	seteuid(getuid());
+	if (seteuid(getuid()))
+		perror("seteuid");
 	shm_unlink(SHM_NAME);
 
 	if (stat_buf.st_uid == old_uid && stat_buf.st_gid == old_gid) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/shm_unlink/8-1.c b/testcases/open_posix_testsuite/conformance/interfaces/shm_unlink/8-1.c
index ed18cf213..d67d2fbe2 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/shm_unlink/8-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/shm_unlink/8-1.c
@@ -86,7 +86,8 @@ int main(void)
 		return PTS_UNRESOLVED;
 	}
 
-	seteuid(getuid());
+	if (seteuid(getuid()))
+		perror("seteuid");
 
 	if (fstat(fd, &stat_after) != 0) {
 		perror("An error occurs when calling fstat()");
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/shm_unlink/9-1.c b/testcases/open_posix_testsuite/conformance/interfaces/shm_unlink/9-1.c
index 5c52465c8..9ef4b0c65 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/shm_unlink/9-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/shm_unlink/9-1.c
@@ -69,12 +69,14 @@ int main(void)
 	result = shm_unlink(SHM_NAME);
 	if (result == -1 && errno == EACCES) {
 		printf("Test PASSED\n");
-		seteuid(getuid());
+		if (seteuid(getuid()))
+			perror("seteuid");
 		shm_unlink(SHM_NAME);
 		return PTS_PASS;
 	} else if (result == -1) {
 		perror("Unexpected error");
-		seteuid(getuid());
+		if (seteuid(getuid()))
+			perror("seteuid");
 		shm_unlink(SHM_NAME);
 		return PTS_FAIL;
 	}
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaltstack/9-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaltstack/9-1.c
index 0236a752e..e9f9a8f71 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaltstack/9-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaltstack/9-1.c
@@ -59,7 +59,10 @@ int main(int argc, char *argv[])
 
 		/* Get abs path if needed and exec ourself */
 		if (*argv[0] != '/') {
-			getcwd(path, PATH_MAX);
+			if (getcwd(path, PATH_MAX) == NULL) {
+				perror("getcwd");
+				exit(PTS_UNRESOLVED);
+			}
 			strcat(path, "/");
 			strcat(path, argv[0]);
 		} else {
diff --git a/testcases/open_posix_testsuite/include/affinity.h b/testcases/open_posix_testsuite/include/affinity.h
index 86fb4f4c6..da7e6837e 100644
--- a/testcases/open_posix_testsuite/include/affinity.h
+++ b/testcases/open_posix_testsuite/include/affinity.h
@@ -46,7 +46,8 @@ static int get_online_cpu_from_sysfs(void)
 	f = fopen("/sys/devices/system/cpu/online", "r");
 	if (!f)
 		return -1;
-	fscanf(f, "%d", &cpu);
+	if (!fscanf(f, "%d", &cpu))
+		cpu = -1;
 	fclose(f);
 
 	return cpu;
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
