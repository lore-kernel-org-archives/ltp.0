From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Date: Tue, 22 Jun 2021 13:14:39 +0200
Subject: [LTP] [PATCH 1/2] syscalls/msgstress03: fix fork failure on small
 memory systems
Message-ID: <20210622111440.74722-1-krzysztof.kozlowski@canonical.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Running syscalls/msgstress03 on a system with less than ~4 GB of RAM fails:

    msgstress03    1  TFAIL  :  msgstress03.c:155: 	Fork failed (may be OK if under stress)

In dmesg:

    LTP: starting msgstress03
    cgroup: fork rejected by pids controller in /user.slice/user-1000.slice/session-1.scope

The reason is cgroups pid limit set by systemd user.slice.  The limit is
set for login session, also for root user.  For example on 2 GB RAM
machine it is set as:
    /sys/fs/cgroup/pids/user.slice/user-0.slice/pids.max:5207

Read the maximum number of pids and adjust the test limit.  For 2 GB RAM
machine with systemd this will result in:

    msgstress03    0  TINFO  :  Found limit of processes 5056 (from /sys/fs/cgroup/pids/user.slice/user-1000.slice/pids.max)
    msgstress03    0  TINFO  :  Requested number of processes higher than user session limit (10000 > 4556), setting to 4556

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 include/ipcmsg.h                              |  2 +
 libs/libltpipc/libipc.c                       | 58 +++++++++++++++++++
 .../syscalls/ipc/msgstress/msgstress03.c      | 15 ++++-
 3 files changed, 74 insertions(+), 1 deletion(-)

diff --git a/include/ipcmsg.h b/include/ipcmsg.h
index d89894b726cf..b73b72d6d172 100644
--- a/include/ipcmsg.h
+++ b/include/ipcmsg.h
@@ -61,8 +61,10 @@ void rm_queue(int);
 
 key_t getipckey();
 int getuserid(char *);
+int get_session_uid(void);
 
 int get_max_msgqueues(void);
 int get_used_msgqueues(void);
+int get_pids_limit(void);
 
 #endif /* ipcmsg.h */
diff --git a/libs/libltpipc/libipc.c b/libs/libltpipc/libipc.c
index d94880f54b64..cd3480ed9f21 100644
--- a/libs/libltpipc/libipc.c
+++ b/libs/libltpipc/libipc.c
@@ -151,6 +151,31 @@ int getuserid(char *user)
 	return (ent->pw_uid);
 }
 
+/*
+ * Get the effective session UID - either one invoking current test via sudo
+ * or the real UID.
+ */
+int get_session_uid(void)
+{
+	const char *sudo_uid;
+
+	sudo_uid = getenv("SUDO_UID");
+	if (sudo_uid) {
+		int real_uid;
+
+		TEST(sscanf(sudo_uid, "%u", &real_uid));
+		if (TEST_RETURN != 1) {
+#ifdef DEBUG
+			tst_resm(TINFO, "No SUDO_UID from env");
+#endif
+		} else {
+			return real_uid;
+		}
+	}
+
+	return getuid();
+}
+
 /*
  * rm_shm() - removes a shared memory segment.
  */
@@ -218,3 +243,36 @@ int get_max_msgqueues(void)
 	fclose(f);
 	return atoi(buff);
 }
+
+/*
+ * Get the limit of processes for current session configured by systemd user.slice.
+ * This also applies to root user.
+ */
+int get_pids_limit(void)
+{
+	int real_uid, ret;
+	char path[PATH_MAX];
+	long unsigned int max_pids;
+
+	real_uid = get_session_uid();
+	if (TEST_RETURN != 1) {
+		tst_resm(TINFO, "Cannot get UID");
+		return -1;
+	}
+
+	ret = snprintf(path, sizeof(path),
+		       "/sys/fs/cgroup/pids/user.slice/user-%d.slice/pids.max",
+		       real_uid);
+	if (ret < 0 || (size_t)ret >= sizeof(path))
+		return -1;
+
+	if (access(path, R_OK) != 0) {
+		tst_resm(TINFO, "Cannot read session user limits from '%s'", path);
+		return -1;
+	}
+
+	SAFE_FILE_SCANF(cleanup, path, "%lu", &max_pids);
+	tst_resm(TINFO, "Found limit of processes %lu (from %s)", max_pids, path);
+
+	return max_pids;
+}
diff --git a/testcases/kernel/syscalls/ipc/msgstress/msgstress03.c b/testcases/kernel/syscalls/ipc/msgstress/msgstress03.c
index 294b401b1b38..9cf96db7956e 100644
--- a/testcases/kernel/syscalls/ipc/msgstress/msgstress03.c
+++ b/testcases/kernel/syscalls/ipc/msgstress/msgstress03.c
@@ -78,7 +78,7 @@ static void usage(void)
 
 int main(int argc, char **argv)
 {
-	int i, j, ok, pid;
+	int i, j, ok, pid, max_session_pids;
 	int count, status;
 	struct sigaction act;
 
@@ -109,6 +109,19 @@ int main(int argc, char **argv)
 		}
 	}
 
+	max_session_pids = get_pids_limit();
+	if (max_session_pids > 0) {
+		/* Clamp number of processes to session limit with some buffer for OS */
+		max_session_pids = (max_session_pids > 500 ? max_session_pids - 500 : 0);
+		if (nprocs >= max_session_pids) {
+			tst_resm(TINFO,
+				 "Requested number of processes higher than user session limit (%d > %d), "
+				 "setting to %d", nprocs, max_session_pids,
+				 max_session_pids);
+			nprocs = max_session_pids;
+		}
+	}
+
 	srand(getpid());
 	tid = -1;
 
-- 
2.27.0

