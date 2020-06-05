From: Jan Stancek <jstancek@redhat.com>
Date: Fri,  5 Jun 2020 11:02:21 +0200
Subject: [LTP] [PATCH 3/3] syscalls/setns01: accept also EBADF for regular fd
In-Reply-To: <9b9e3d35b4fddb668b02595e418a997332f98491.1591347655.git.jstancek@redhat.com>
References: <9b9e3d35b4fddb668b02595e418a997332f98491.1591347655.git.jstancek@redhat.com>
Message-ID: <5632b2169cfe32807e8380be50ced5e5d6ff93cb.1591347655.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

commit 303cc571d107 ("nsproxy: attach to namespaces via pidfds")
changed errno that is returned for regular file from EINVAL to EBADF.

Accept any of the two as expect errno code.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/setns/setns01.c | 51 ++++++++++++++++-------
 1 file changed, 36 insertions(+), 15 deletions(-)

diff --git a/testcases/kernel/syscalls/setns/setns01.c b/testcases/kernel/syscalls/setns/setns01.c
index 0cf2684ba6ef..2115b81e647f 100644
--- a/testcases/kernel/syscalls/setns/setns01.c
+++ b/testcases/kernel/syscalls/setns/setns01.c
@@ -41,7 +41,7 @@ struct testcase_t {
 	int fd;
 	int ns_type;
 	int exp_ret;
-	int exp_errno;
+	int exp_errno[2];
 	int skip;
 	void (*setup) (struct testcase_t *, int i);
 	void (*cleanup) (struct testcase_t *);
@@ -60,13 +60,13 @@ struct testcase_t tcases[] = {
 		.msg = "invalid fd",
 		.fd = -1,
 		.exp_ret = -1,
-		.exp_errno = EBADF,
+		.exp_errno = { EBADF },
 		.setup = setup0,
 	},
 	{
 		.msg = "regular file fd",
 		.exp_ret = -1,
-		.exp_errno = EINVAL,
+		.exp_errno = { EINVAL, EBADF },
 		.setup = setup1,
 		.cleanup = cleanup1
 	},
@@ -74,19 +74,19 @@ struct testcase_t tcases[] = {
 		.msg = "invalid ns_type",
 		.ns_type = -1,
 		.exp_ret = -1,
-		.exp_errno = EINVAL,
+		.exp_errno = { EINVAL },
 		.setup = setup2,
 	},
 	{
 		.msg = "mismatch ns_type/fd",
 		.exp_ret = -1,
-		.exp_errno = EINVAL,
+		.exp_errno = { EINVAL },
 		.setup = setup3,
 	},
 	{
 		.msg = "without CAP_SYS_ADMIN",
 		.exp_ret = -1,
-		.exp_errno = EPERM,
+		.exp_errno = { EPERM },
 		.setup = setup4,
 		.cleanup = cleanup4,
 	}
@@ -145,7 +145,9 @@ static void cleanup4(LTP_ATTRIBUTE_UNUSED struct testcase_t *t)
 
 static void test_setns(unsigned int testno)
 {
-	int ret, i;
+	int ret, i, tres, saved_errno;
+	unsigned int j;
+	char errnos_str[256], *errnos_pos;
 	struct testcase_t *t = &tcases[testno];
 
 	for (i = 0; i < ns_total; i++) {
@@ -159,18 +161,37 @@ static void test_setns(unsigned int testno)
 
 		tst_res(TINFO, "setns(%d, 0x%x)", t->fd, t->ns_type);
 		ret = tst_syscall(__NR_setns, t->fd, t->ns_type);
-		if (ret == t->exp_ret) {
-			if (ret == -1 && errno == t->exp_errno)
-				tst_res(TPASS, "%s exp_errno=%d", t->msg,
-						t->exp_errno);
-			else
-				tst_res(TFAIL|TERRNO, "%s exp_errno=%d",
-					t->msg, t->exp_errno);
-		} else {
+		saved_errno = errno;
+
+		if (ret != t->exp_ret) {
 			tst_res(TFAIL, "%s ret=%d expected=%d", t->msg,
 					ret, t->exp_ret);
+			goto done;
 		}
 
+		/* Consider PASS if any errno matches */
+		tres = TFAIL;
+		memset(errnos_str, 0, sizeof(errnos_str));
+		errnos_pos = errnos_str;
+		for (j = 0; j < ARRAY_SIZE(t->exp_errno); j++) {
+			if (!t->exp_errno[j])
+				break;
+
+			ret = sprintf(errnos_pos, "%s%s",
+				(j == 0) ? "" : ",",
+				tst_strerrno(t->exp_errno[j]));
+
+			if (ret >= 0)
+				errnos_pos += ret;
+
+			if (saved_errno == t->exp_errno[j])
+				tres = TPASS;
+		}
+
+		tst_res(tres, "%s exp_errno(%s), got(%s)", t->msg,
+			errnos_str, tst_strerrno(saved_errno));
+
+done:
 		if (t->cleanup)
 			t->cleanup(t);
 	}
-- 
2.18.1

