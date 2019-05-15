From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 15 May 2019 11:52:30 +0200
Subject: [LTP] [PATCH] syscalls/ioctl_ns: Fix failures on -m32
Message-ID: <20190515095230.12585-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

These are not apparently implemented in the 32bit compat layer so the
test were failing with ENOTTY there.

Reported-by: Richard Palethorpe <rpalethorpe@suse.de>
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/ioctl/ioctl_ns01.c |  3 +++
 testcases/kernel/syscalls/ioctl/ioctl_ns02.c |  3 +++
 testcases/kernel/syscalls/ioctl/ioctl_ns03.c |  5 +++++
 testcases/kernel/syscalls/ioctl/ioctl_ns04.c |  3 +++
 testcases/kernel/syscalls/ioctl/ioctl_ns05.c | 13 ++++++++++++-
 testcases/kernel/syscalls/ioctl/ioctl_ns06.c | 11 ++++++++++-
 6 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ns01.c b/testcases/kernel/syscalls/ioctl/ioctl_ns01.c
index f2c77a01a..dfde4da6c 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_ns01.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ns01.c
@@ -40,6 +40,9 @@ static void test_ns_get_parent(void)
 	fd = SAFE_OPEN("/proc/self/ns/pid", O_RDONLY);
 	parent_fd = ioctl(fd, NS_GET_PARENT);
 	if (parent_fd == -1) {
+		if (errno == ENOTTY)
+			tst_brk(TCONF, "ioctl(NS_GET_PARENT) not implemented");
+
 		if (errno == EPERM)
 			tst_res(TPASS, "NS_GET_PARENT fails with EPERM");
 		else
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ns02.c b/testcases/kernel/syscalls/ioctl/ioctl_ns02.c
index 4f5cb1427..33ef757a8 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_ns02.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ns02.c
@@ -32,6 +32,9 @@ static void run(void)
 	fd = SAFE_OPEN("/proc/self/ns/uts", O_RDONLY);
 	parent_fd = ioctl(fd, NS_GET_PARENT);
 	if (parent_fd == -1) {
+		if (errno == ENOTTY)
+			tst_brk(TCONF, "ioctl(NS_GET_PARENT) not implemented");
+
 		if (errno == EINVAL)
 			tst_res(TPASS, "NS_GET_PARENT fails with EINVAL");
 		else
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ns03.c b/testcases/kernel/syscalls/ioctl/ioctl_ns03.c
index 2e19cff3a..279032d20 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_ns03.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ns03.c
@@ -33,6 +33,11 @@ static void run(void)
 
 	owner_fd = ioctl(fd, NS_GET_OWNER_UID, &uid);
 	if (owner_fd == -1) {
+		if (errno == ENOTTY) {
+			tst_brk(TCONF,
+			        "ioctl(NS_GET_OWNER_UID) not implemented");
+		}
+
 		if (errno == EINVAL)
 			tst_res(TPASS, "NS_GET_OWNER_UID fails, UTS namespace");
 		else
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ns04.c b/testcases/kernel/syscalls/ioctl/ioctl_ns04.c
index b9181cb3d..90035cbeb 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_ns04.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ns04.c
@@ -31,6 +31,9 @@ static void run(void)
 	fd = SAFE_OPEN("/proc/self/ns/user", O_RDONLY);
 	parent_fd = ioctl(fd, NS_GET_USERNS);
 	if (parent_fd == -1) {
+		if (errno == ENOTTY)
+			tst_brk(TCONF, "ioctl(NS_GET_USERNS) not implemented");
+
 		if (errno == EPERM)
 			tst_res(TPASS, "NS_GET_USERNS fails with EPERM");
 		else
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ns05.c b/testcases/kernel/syscalls/ioctl/ioctl_ns05.c
index bdef4d6e9..a8dee07a1 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_ns05.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ns05.c
@@ -53,7 +53,18 @@ static void run(void)
 	sprintf(child_namespace, "/proc/%i/ns/pid", pid);
 	my_fd = SAFE_OPEN("/proc/self/ns/pid", O_RDONLY);
 	child_fd = SAFE_OPEN(child_namespace, O_RDONLY);
-	parent_fd = SAFE_IOCTL(child_fd, NS_GET_PARENT);
+	parent_fd = ioctl(child_fd, NS_GET_PARENT);
+
+	if (parent_fd == -1) {
+		TST_CHECKPOINT_WAKE(0);
+
+		if (errno == ENOTTY) {
+			tst_res(TCONF, "ioctl(NS_GET_PARENT) not implemented");
+			return;
+		}
+
+		tst_brk(TBROK | TERRNO, "ioctl(NS_GET_PARENT) failed");
+	}
 
 	struct stat my_stat, child_stat, parent_stat;
 
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ns06.c b/testcases/kernel/syscalls/ioctl/ioctl_ns06.c
index eabb7e49c..805a0a072 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_ns06.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ns06.c
@@ -50,7 +50,16 @@ static void run(void)
 
 	my_fd = SAFE_OPEN("/proc/self/ns/user", O_RDONLY);
 	child_fd = SAFE_OPEN(child_namespace, O_RDONLY);
-	parent_fd = SAFE_IOCTL(child_fd, NS_GET_USERNS);
+	parent_fd = ioctl(child_fd, NS_GET_USERNS);
+
+	if (parent_fd == -1) {
+		TST_CHECKPOINT_WAKE(0);
+
+		if (errno == ENOTTY)
+			tst_brk(TCONF, "ioctl(NS_GET_USERNS) not implemented");
+
+		tst_brk(TBROK | TERRNO, "ioctl(NS_GET_USERNS) failed");
+	}
 
 	struct stat my_stat, child_stat, parent_stat;
 
-- 
2.19.2

