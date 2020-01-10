From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Fri, 10 Jan 2020 13:18:31 +0800
Subject: [LTP] [PATCH] syscalls/capget[set]: Make use of guarded buffers
Message-ID: <1578633511-15403-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Also, using pid=0 instead of getpid() in capget02.c because
it also returns the capabilities for the calling thread.

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/capget/capget01.c | 17 +++--
 testcases/kernel/syscalls/capget/capget02.c | 79 ++++++++++-----------
 testcases/kernel/syscalls/capset/capset01.c | 24 +++++--
 3 files changed, 66 insertions(+), 54 deletions(-)

diff --git a/testcases/kernel/syscalls/capget/capget01.c b/testcases/kernel/syscalls/capget/capget01.c
index bc8bd7ce7..f3767594b 100644
--- a/testcases/kernel/syscalls/capget/capget01.c
+++ b/testcases/kernel/syscalls/capget/capget01.c
@@ -13,6 +13,8 @@
 #include <linux/capability.h>
 
 static pid_t pid;
+static struct __user_cap_header_struct *hdr;
+static struct __user_cap_data_struct *data;
 
 static struct tcase {
 	int version;
@@ -26,16 +28,12 @@ static struct tcase {
 static void verify_capget(unsigned int n)
 {
 	struct tcase *tc = &tcases[n];
-	struct __user_cap_header_struct hdr = {
-		.version = tc->version,
-		.pid = pid,
-	};
-
-	struct __user_cap_data_struct data[2];
 
 	tst_res(TINFO, "%s", tc->message);
 
-	TEST(tst_syscall(__NR_capget, &hdr, data));
+	hdr->version = tc->version;
+	hdr->pid = pid;
+	TEST(tst_syscall(__NR_capget, hdr, data));
 	if (TST_RET == 0)
 		tst_res(TPASS, "capget() returned %ld", TST_RET);
 	else
@@ -61,4 +59,9 @@ static struct tst_test test = {
 		TST_CAP(TST_CAP_DROP, CAP_NET_RAW),
 		{}
 	},
+	.bufs = (struct tst_buffers []) {
+		{&hdr, .size = sizeof(*hdr)},
+		{&data, .size = 2 * sizeof(*data)},
+		{},
+	}
 };
diff --git a/testcases/kernel/syscalls/capget/capget02.c b/testcases/kernel/syscalls/capget/capget02.c
index 42c76a011..73804e0c8 100644
--- a/testcases/kernel/syscalls/capget/capget02.c
+++ b/testcases/kernel/syscalls/capget/capget02.c
@@ -20,29 +20,44 @@
 #include "lapi/syscalls.h"
 #include <linux/capability.h>
 
-static struct __user_cap_header_struct header, bad_version_header, bad_pid_header, unused_pid_header;
-static struct __user_cap_data_struct data;
+static pid_t unused_pid;
+static struct __user_cap_header_struct *header;
+static struct __user_cap_data_struct *data, *bad_data;
 
 static struct tcase {
-	cap_user_header_t headerp;
-	cap_user_data_t datap;
+	int version;
+	int pid;
 	int exp_err;
-	int reset_flag;
+	int flag;
 	char *message;
 } tcases[] = {
-	{NULL, &data, EFAULT, 0, "Test bad address header"},
-	{&header, NULL, EFAULT, 0, "Test bad address data"},
-	{&bad_version_header, &data, EINVAL, 1, "Test bad version"},
-	{&bad_pid_header, &data, EINVAL, 0, "Test bad pid"},
-	{&unused_pid_header, &data, ESRCH, 0, "Test unused pid"},
+	{0x20080522, 0, EFAULT, 1, "Test bad address header"},
+	{0x20080522, 0, EFAULT, 2, "Test bad address data"},
+	{0, 0, EINVAL, 0, "Test bad version"},
+	{0x20080522, -1, EINVAL, 0, "Test bad pid"},
+	{0x20080522, 1, ESRCH, 0, "Test unused pid"},
 };
 
 static void verify_capget(unsigned int n)
 {
 	struct tcase *tc = &tcases[n];
 
-	tst_res(TINFO, "%s", tc->message);
-	TEST(tst_syscall(__NR_capget, tc->headerp, tc->datap));
+	header->version = tc->version;
+	if (tc->pid == 1)
+		header->pid = unused_pid;
+	else
+		header->pid = tc->pid;
+
+	tst_res(TINFO, "%s ", tc->message);
+
+	/*
+	 * header must not be NULL. data may be NULL only when the user is
+	 * trying to determine the preferred capability version format
+	 * supported by the kernel. So use tst_get_bad_addr() to get
+	 * this error.
+	 */
+	TEST(tst_syscall(__NR_capget, tc->flag - 1 ? header : NULL,
+				tc->flag - 2 ? data : bad_data));
 	if (TST_RET == 0) {
 		tst_res(TFAIL, "capget() succeed unexpectedly");
 		return;
@@ -58,43 +73,25 @@ static void verify_capget(unsigned int n)
 	 * return the kernel preferred value of _LINUX_CAPABILITY_VERSION_?.
 	 * Since linux 2.6.26, version 3 is default. We use it.
 	 */
-	if (tc->reset_flag) {
-		if (tc->headerp->version == 0x20080522)
-			tc->headerp->version = 0;
-		else
-			tst_res(TFAIL, "kernel doesn't return preferred linux"
-				" capability version when using bad version");
-	}
+	if (header->version != 0x20080522)
+		tst_res(TFAIL, "kernel doesn't return preferred linux"
+			" capability version when using bad version");
 }
 
 static void setup(void)
 {
-	unsigned int i, pid;
-
-	pid = getpid();
-
-	header.version = 0x19980330;
-	header.pid = pid;
-
-	bad_version_header.version = 0;
-	bad_version_header.pid = pid;
-
-	bad_pid_header.version = 0x19980330;
-	bad_pid_header.pid = -1;
-
-	unused_pid_header.version = 0x19980330;
-	unused_pid_header.pid = tst_get_unused_pid();
-
-	for (i = 0; i < ARRAY_SIZE(tcases); i++) {
-		if (!tcases[i].headerp)
-			tcases[i].headerp = tst_get_bad_addr(NULL);
-		if (!tcases[i].datap)
-			tcases[i].datap = tst_get_bad_addr(NULL);
-	}
+	unused_pid = tst_get_unused_pid();
+	bad_data = tst_get_bad_addr(NULL);
 }
 
 static struct tst_test test = {
 	.setup = setup,
 	.tcnt = ARRAY_SIZE(tcases),
 	.test = verify_capget,
+	.bufs = (struct tst_buffers []) {
+		{&header, .size = sizeof(*header)},
+		{&data, .size = 2 * sizeof(*data)},
+		{&bad_data, .size = 2 * sizeof(*data)},
+		{},
+	}
 };
diff --git a/testcases/kernel/syscalls/capset/capset01.c b/testcases/kernel/syscalls/capset/capset01.c
index cfbe986fa..f8540539d 100644
--- a/testcases/kernel/syscalls/capset/capset01.c
+++ b/testcases/kernel/syscalls/capset/capset01.c
@@ -13,6 +13,9 @@
 #include "lapi/syscalls.h"
 #include <linux/capability.h>
 
+static pid_t pid;
+static struct __user_cap_header_struct *header;
+static struct __user_cap_data_struct *data;
 static struct tcase {
 	int version;
 	char *message;
@@ -25,26 +28,35 @@ static struct tcase {
 static void verify_capset(unsigned int n)
 {
 	struct tcase *tc = &tcases[n];
-	struct __user_cap_header_struct header;
-	struct __user_cap_data_struct data[2];
 
 	tst_res(TINFO, "%s", tc->message);
-	header.version = tc->version;
-	header.pid = getpid();
+	header->version = tc->version;
+	header->pid = pid;
 
-	if (tst_syscall(__NR_capget, &header, data) == -1) {
+	if (tst_syscall(__NR_capget, header, data) == -1) {
 		tst_res(TFAIL | TTERRNO, "capget() failed");
 		return;
 	}
 
-	TEST(tst_syscall(__NR_capset, &header, data));
+	TEST(tst_syscall(__NR_capset, header, data));
 	if (TST_RET == 0)
 		tst_res(TPASS, "capset() returned %ld", TST_RET);
 	else
 		tst_res(TFAIL | TTERRNO, "Test Failed, capset() returned %ld", TST_RET);
 }
 
+static void setup(void)
+{
+	pid = getpid();
+}
+
 static struct tst_test test = {
+	.setup = setup,
 	.tcnt = ARRAY_SIZE(tcases),
 	.test = verify_capset,
+	.bufs = (struct tst_buffers []) {
+		{&header, .size = sizeof(*header)},
+		{&data, .size = 2 * sizeof(*data)},
+		{},
+	}
 };
-- 
2.18.0



