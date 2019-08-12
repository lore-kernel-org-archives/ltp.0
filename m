From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 12 Aug 2019 16:39:37 +0200
Subject: [LTP] [PATCH v2 07/11] syscalls/add_key04: Make use of guarded
 buffers.
In-Reply-To: <20190812143941.8119-1-chrubis@suse.cz>
References: <20190812143941.8119-1-chrubis@suse.cz>
Message-ID: <20190812143941.8119-8-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/add_key/add_key04.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/add_key/add_key04.c b/testcases/kernel/syscalls/add_key/add_key04.c
index 28cc91f72..12a169eda 100644
--- a/testcases/kernel/syscalls/add_key/add_key04.c
+++ b/testcases/kernel/syscalls/add_key/add_key04.c
@@ -32,6 +32,10 @@
 
 #define ASSOC_ARRAY_FAN_OUT 16
 
+#define PAYLOAD "payload"
+
+static char *payload;
+
 static void do_test(void)
 {
 	int status;
@@ -42,7 +46,6 @@ static void do_test(void)
 
 	if (SAFE_FORK() == 0) {
 		char description[32];
-		const char payload[] = "payload";
 		int i;
 
 		for (i = 0; i < ASSOC_ARRAY_FAN_OUT; i++) {
@@ -55,7 +58,7 @@ static void do_test(void)
 			}
 		}
 
-		TEST(add_key("user", "userkey", payload, sizeof(payload),
+		TEST(add_key("user", "userkey", payload, sizeof(PAYLOAD),
 			     KEY_SPEC_SESSION_KEYRING));
 		if (TST_RET < 0)
 			tst_brk(TBROK | TTERRNO, "unable to create user key");
@@ -72,7 +75,13 @@ static void do_test(void)
 		tst_brk(TBROK, "Child %s", tst_strstatus(status));
 }
 
+static void setup(void)
+{
+	payload = tst_strdup(PAYLOAD);
+}
+
 static struct tst_test test = {
+	.setup = setup,
 	.test_all = do_test,
 	.forks_child = 1,
 };
-- 
2.21.0

