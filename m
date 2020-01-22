From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Wed, 22 Jan 2020 13:26:36 +0800
Subject: [LTP] [PATCH v2] syscalls/add_key01: test the length of payload
In-Reply-To: <20200121151342.GD6337@rei>
References: <20200121151342.GD6337@rei>
Message-ID: <1579670796-21233-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Seeing add_key manpages, the length of payload for "user"/"logon"
is 32767, this value is up tp 1M for "big_key". For "keyring" type
, this value is zero.

---------
v1->v2:
1. use different buffers for different length
2. split pass and fail message, make code less confusing
---------

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/add_key/add_key01.c | 110 ++++++++++++++++--
 1 file changed, 102 insertions(+), 8 deletions(-)

diff --git a/testcases/kernel/syscalls/add_key/add_key01.c b/testcases/kernel/syscalls/add_key/add_key01.c
index 4fe97dac6..9830d48dc 100644
--- a/testcases/kernel/syscalls/add_key/add_key01.c
+++ b/testcases/kernel/syscalls/add_key/add_key01.c
@@ -4,23 +4,117 @@
  * Porting from Crackerjack to LTP is done by
  * Manas Kumar Nayak maknayak@in.ibm.com>
  *
- * Basic test for the add_key() syscall.
+ * This case test various key type can support how many long
+ * bytes payload.
+ * keyring: 0 bytes
+ * user/logon: 32767 bytes
+ * big_key: 1M -1byte
  */
 
 #include <errno.h>
-
 #include "tst_test.h"
 #include "lapi/keyctl.h"
 
-static void verify_add_key(void)
+static char *keyring_buf, *keyring_buf1;
+static char *user_buf, *user_buf1;
+static char *logon_buf, *logon_buf1;
+static char *big_key_buf, *big_key_buf1;
+static unsigned int logon_nsup, big_key_nsup;
+
+struct tcase {
+	const char *type;
+	const char *desc;
+	char **buf;
+	size_t plen;
+	int pass_flag;
+	char *message;
+} tcases[] = {
+	{"keyring", "abc", &keyring_buf, 0, 1,
+	"The key type is keyrings and plen is 0"},
+
+	{"keyring", "bcd", &keyring_buf, 1, 0,
+	"the key type is keyrings and plen is 1"},
+
+	{"user", "cde", &user_buf, 32767, 1,
+	"The key type is user and plen is 32767"},
+
+	{"user", "def", &user_buf1, 32768, 0,
+	"The key type is user and plen is 32768"},
+
+	{"logon", "ef:g", &logon_buf, 32767, 1,
+	"The key type is logon and plen is 32767"},
+
+	{"logon", "fg:h", &logon_buf1, 32768, 0,
+	"The key type is logon and plen is 32768"},
+
+	{"big_key", "ghi", &big_key_buf, (1 << 20) - 1, 1,
+	"The key type is big_key and plen is 1048575"},
+
+	{"big_key", "hij", &big_key_buf1, 1 << 20, 0,
+	"The key type is big_key and plen is 1048576"},
+};
+
+static void verify_add_key(unsigned int n)
 {
-	TEST(add_key("keyring", "wjkey", NULL, 0, KEY_SPEC_THREAD_KEYRING));
+	struct tcase *tc = &tcases[n];
+
+	tst_res(TINFO, "%s", tc->message);
+
+	if (!strcmp(tc->type, "logon") && logon_nsup) {
+		tst_res(TCONF, "skipping unsupported logon key");
+		return;
+	}
+	if (!strcmp(tc->type, "big_key") && big_key_nsup) {
+		tst_res(TCONF, "skipping unsupported big_key key");
+		return;
+	}
+
+	TEST(add_key(tc->type, tc->desc, *tc->buf, tc->plen, KEY_SPEC_THREAD_KEYRING));
+	if (tc->pass_flag) {
+		if (TST_RET == -1)
+			tst_res(TFAIL | TTERRNO, "add_key call failed unexpectedly");
+		else
+			tst_res(TPASS, "add_key call succeeded as expected");
+	} else {
+		if (TST_RET == -1) {
+			if (TST_ERR == EINVAL)
+				tst_res(TPASS | TTERRNO, "add_key call failed as expected");
+			else
+				tst_res(TFAIL | TTERRNO, "add_key call failed expected EINVAL but got");
+		} else
+			tst_res(TFAIL, "add_key call succeeded unexpectedly");
+	}
+}
+
+static void setup(void)
+{
+	char *logon_sup_buf, *big_key_sup_buf;
+
+	logon_sup_buf = tst_alloc(64);
+	big_key_sup_buf = tst_alloc(64);
+
+	TEST(add_key("logon", "test:sup_logon", logon_sup_buf, 64, KEY_SPEC_THREAD_KEYRING));
+	if (TST_RET == -1)
+		logon_nsup = 1;
+
+	TEST(add_key("big_key", "sup_big_key", big_key_sup_buf, 64, KEY_SPEC_THREAD_KEYRING));
 	if (TST_RET == -1)
-		tst_res(TFAIL | TTERRNO, "add_key call failed");
-	else
-		tst_res(TPASS, "add_key call succeeded");
+		big_key_nsup = 1;
 }
 
 static struct tst_test test = {
-	.test_all = verify_add_key,
+	.setup = setup,
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = verify_add_key,
+	.bufs = (struct tst_buffers []) {
+		{&keyring_buf, .size = 1},
+		{&keyring_buf1, .size = 1},
+		{&user_buf, .size = 32767},
+		{&user_buf1, .size = 32768},
+		{&logon_buf, .size = 32767},
+		{&logon_buf1, .size = 32768},
+		{&big_key_buf, .size = (1 << 20) - 1},
+		{&big_key_buf1, .size = 1 << 20},
+		{}
+	}
 };
-- 
2.18.0



