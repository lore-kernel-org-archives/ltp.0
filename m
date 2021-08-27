From: Yang Xu <xuyang2018.jy@fujitsu.com>
Date: Fri, 27 Aug 2021 18:19:59 +0800
Subject: [LTP] [PATCH v2] testcases: Enable userns in max_user_namespaces
 file
In-Reply-To: <1628144855-5924-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1628144855-5924-1-git-send-email-xuyang2018.jy@fujitsu.com>
Message-ID: <1630059599-13947-1-git-send-email-xuyang2018.jy@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On old distros ie centos7, the default value of max_user_namespaces is set to 0.
Enable it by increasing this value.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 testcases/cve/icmp_rate_limit01.c                   | 9 +++++++++
 testcases/kernel/containers/userns/userns08.c       | 9 +++++++++
 testcases/kernel/syscalls/bind/bind06.c             | 9 +++++++++
 testcases/kernel/syscalls/sendto/sendto03.c         | 9 +++++++++
 testcases/kernel/syscalls/setsockopt/setsockopt05.c | 9 +++++++++
 testcases/kernel/syscalls/setsockopt/setsockopt06.c | 9 +++++++++
 testcases/kernel/syscalls/setsockopt/setsockopt07.c | 9 +++++++++
 testcases/kernel/syscalls/setsockopt/setsockopt08.c | 9 +++++++++
 8 files changed, 72 insertions(+)

diff --git a/testcases/cve/icmp_rate_limit01.c b/testcases/cve/icmp_rate_limit01.c
index f24ea5bf9..f5ec77d6f 100644
--- a/testcases/cve/icmp_rate_limit01.c
+++ b/testcases/cve/icmp_rate_limit01.c
@@ -58,6 +58,11 @@ static void setup(void)
 	for (i = 0; i < SRCADDR_COUNT; i++)
 		fds[i] = -1;
 
+	/* The default value of max_user_namespaces is set to 0 on some distros,
+	 * We need to change the default value to call clone().
+	 */
+	SAFE_FILE_PRINTF("/proc/sys/user/max_user_namespaces", "%d", 10);
+
 	SAFE_UNSHARE(CLONE_NEWUSER);
 	SAFE_UNSHARE(CLONE_NEWNET);
 	SAFE_FILE_PRINTF("/proc/self/setgroups", "deny");
@@ -265,6 +270,10 @@ static struct tst_test test = {
 		"CONFIG_NET_NS=y",
 		NULL
 	},
+	.save_restore = (const char * const[]) {
+		"?/proc/sys/user/max_user_namespaces",
+		NULL,
+	},
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "b38e7819cae9"},
 		{"CVE", "2020-25705"},
diff --git a/testcases/kernel/containers/userns/userns08.c b/testcases/kernel/containers/userns/userns08.c
index aedfc6c4e..429fcf235 100644
--- a/testcases/kernel/containers/userns/userns08.c
+++ b/testcases/kernel/containers/userns/userns08.c
@@ -120,6 +120,11 @@ static void setup(void)
 
 	SAFE_WRITE(fd, 1, "\n", 1);
 	SAFE_CLOSE(fd);
+
+	/* The default value of max_user_namespaces is set to 0 on some distros,
+	 * We need to change the default value to call clone().
+	 */
+	SAFE_FILE_PRINTF("/proc/sys/user/max_user_namespaces", "%d", 10);
 }
 
 static struct tst_test test = {
@@ -133,6 +138,10 @@ static struct tst_test test = {
 		"CONFIG_USER_NS",
 		NULL
 	},
+	.save_restore = (const char * const[]) {
+		"?/proc/sys/user/max_user_namespaces",
+		NULL,
+	},
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "d2f007dbe7e4"},
 		{"CVE", "CVE-2018-18955"},
diff --git a/testcases/kernel/syscalls/bind/bind06.c b/testcases/kernel/syscalls/bind/bind06.c
index 017e0fc89..390af76a1 100644
--- a/testcases/kernel/syscalls/bind/bind06.c
+++ b/testcases/kernel/syscalls/bind/bind06.c
@@ -34,6 +34,11 @@ static void setup(void)
 	int real_gid = getgid();
 	struct ifreq ifr;
 
+	/* The default value of max_user_namespaces is set to 0 on some distros,
+	 * We need to change the default value to call clone().
+	 */
+	SAFE_FILE_PRINTF("/proc/sys/user/max_user_namespaces", "%d", 10);
+
 	SAFE_UNSHARE(CLONE_NEWUSER);
 	SAFE_UNSHARE(CLONE_NEWNET);
 	SAFE_FILE_PRINTF("/proc/self/setgroups", "deny");
@@ -107,6 +112,10 @@ static struct tst_test test = {
 		"CONFIG_NET_NS=y",
 		NULL
 	},
+	.save_restore = (const char * const[]) {
+		"?/proc/sys/user/max_user_namespaces",
+		NULL,
+	},
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "15fe076edea7"},
 		{"CVE", "2018-18559"},
diff --git a/testcases/kernel/syscalls/sendto/sendto03.c b/testcases/kernel/syscalls/sendto/sendto03.c
index 3ecb574a1..700ad24ca 100644
--- a/testcases/kernel/syscalls/sendto/sendto03.c
+++ b/testcases/kernel/syscalls/sendto/sendto03.c
@@ -43,6 +43,11 @@ static void setup(void)
 	int real_gid = getgid();
 	struct ifreq ifr;
 
+	/* The default value of max_user_namespaces is set to 0 on some distros,
+	 * We need to change the default value to call clone().
+	 */
+	SAFE_FILE_PRINTF("/proc/sys/user/max_user_namespaces", "%d", 10);
+
 	SAFE_UNSHARE(CLONE_NEWUSER);
 	SAFE_UNSHARE(CLONE_NEWNET);
 	SAFE_FILE_PRINTF("/proc/self/setgroups", "deny");
@@ -215,6 +220,10 @@ static struct tst_test test = {
 		"CONFIG_NET_NS=y",
 		NULL
 	},
+	.save_restore = (const char * const[]) {
+		"?/proc/sys/user/max_user_namespaces",
+		NULL,
+	},
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "bcc5364bdcfe"},
 		{"linux-git", "acf69c946233"},
diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt05.c b/testcases/kernel/syscalls/setsockopt/setsockopt05.c
index 0b7ff39d2..9adb2f0d2 100644
--- a/testcases/kernel/syscalls/setsockopt/setsockopt05.c
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt05.c
@@ -40,6 +40,11 @@ static void setup(void)
 	struct ifreq ifr;
 	socklen_t addrlen = sizeof(addr);
 
+	/* The default value of max_user_namespaces is set to 0 on some distros,
+	 * We need to change the default value to call clone().
+	 */
+	SAFE_FILE_PRINTF("/proc/sys/user/max_user_namespaces", "%d", 10);
+
 	SAFE_UNSHARE(CLONE_NEWUSER);
 	SAFE_UNSHARE(CLONE_NEWNET);
 	SAFE_FILE_PRINTF("/proc/self/setgroups", "deny");
@@ -99,6 +104,10 @@ static struct tst_test test = {
 		"CONFIG_NET_NS=y",
 		NULL
 	},
+	.save_restore = (const char * const[]) {
+		"?/proc/sys/user/max_user_namespaces",
+		NULL,
+	},
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "85f1bd9a7b5a"},
 		{"CVE", "2017-1000112"},
diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt06.c b/testcases/kernel/syscalls/setsockopt/setsockopt06.c
index 33284e5a6..9ea5985ba 100644
--- a/testcases/kernel/syscalls/setsockopt/setsockopt06.c
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt06.c
@@ -35,6 +35,11 @@ static void setup(void)
 	int real_uid = getuid();
 	int real_gid = getgid();
 
+	/* The default value of max_user_namespaces is set to 0 on some distros,
+	 * We need to change the default value to call clone().
+	 */
+	SAFE_FILE_PRINTF("/proc/sys/user/max_user_namespaces", "%d", 10);
+
 	SAFE_UNSHARE(CLONE_NEWUSER);
 	SAFE_UNSHARE(CLONE_NEWNET);
 	SAFE_FILE_PRINTF("/proc/self/setgroups", "deny");
@@ -125,6 +130,10 @@ static struct tst_test test = {
 		"CONFIG_NET_NS=y",
 		NULL
 	},
+	.save_restore = (const char * const[]) {
+		"?/proc/sys/user/max_user_namespaces",
+		NULL,
+	},
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "84ac7260236a"},
 		{"CVE", "2016-8655"},
diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt07.c b/testcases/kernel/syscalls/setsockopt/setsockopt07.c
index b00286989..051b1bb70 100644
--- a/testcases/kernel/syscalls/setsockopt/setsockopt07.c
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt07.c
@@ -38,6 +38,11 @@ static void setup(void)
 	int real_uid = getuid();
 	int real_gid = getgid();
 
+	/* The default value of max_user_namespaces is set to 0 on some distros,
+	 * We need to change the default value to call clone().
+	 */
+	SAFE_FILE_PRINTF("/proc/sys/user/max_user_namespaces", "%d", 10);
+
 	SAFE_UNSHARE(CLONE_NEWUSER);
 	SAFE_UNSHARE(CLONE_NEWNET);
 	SAFE_FILE_PRINTF("/proc/self/setgroups", "deny");
@@ -137,6 +142,10 @@ static struct tst_test test = {
 		"CONFIG_NET_NS=y",
 		NULL
 	},
+	.save_restore = (const char * const[]) {
+		"?/proc/sys/user/max_user_namespaces",
+		NULL,
+	},
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "c27927e372f0"},
 		{"CVE", "2017-1000111"},
diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt08.c b/testcases/kernel/syscalls/setsockopt/setsockopt08.c
index a7c0ace20..aef9bdcb6 100644
--- a/testcases/kernel/syscalls/setsockopt/setsockopt08.c
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt08.c
@@ -95,6 +95,11 @@ void setup(void)
 			"The vulnerability was only present in 32-bit compat mode");
 	}
 
+	/* The default value of max_user_namespaces is set to 0 on some distros,
+	 * We need to change the default value to call clone().
+	 */
+	SAFE_FILE_PRINTF("/proc/sys/user/max_user_namespaces", "%d", 10);
+
 	SAFE_UNSHARE(CLONE_NEWUSER);
 	SAFE_UNSHARE(CLONE_NEWNET);
 }
@@ -156,6 +161,10 @@ static struct tst_test test = {
 		"CONFIG_NET_NS=y",
 		NULL
 	},
+	.save_restore = (const char * const[]) {
+		"?/proc/sys/user/max_user_namespaces",
+		NULL,
+	},
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "b29c457a6511"},
 		{"CVE", "2021-22555"},
-- 
2.23.0

