From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Thu,  9 Apr 2020 13:26:45 +0200
Subject: [LTP] [PATCH v2] add_key05: Avoid race with key garbage collection
Message-ID: <20200409112645.643-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The key subsystem independently tracks user info against UID. If a user is
deleted and the UID reused for a new user then the key subsystem will mistake
the new user for the old one.

The keys/keyrings may not be accessible to the new user, but if they are not
yet garbage collected (which happens asynchronously) then the new user may be
exceeding its quota limits.

This results in a race condition where this test can fail because the old
thread keyring is taking up the full quota. We can avoid this by creating
multiple users in parallel.

This means when -i is used many users will be created. The number of new users
is limited to 10 and after the first 10 we begin reusing them. It seems best
to avoid creating a very large number of users as this may stress the system
in ways that doesn't make sense for this test. There is a one second delay
after every 10 iterations to give the system time to free keys. This won't be
enough on some systems, but I doubt running this test with -i and expecting a
consistent result is sane.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---

V2:
* Use up to 10 users and then recycle them.
* Set gc_delay to 1

 testcases/kernel/syscalls/add_key/add_key05.c | 97 ++++++++++++-------
 1 file changed, 62 insertions(+), 35 deletions(-)

diff --git a/testcases/kernel/syscalls/add_key/add_key05.c b/testcases/kernel/syscalls/add_key/add_key05.c
index f64c359bb..7f96043fa 100644
--- a/testcases/kernel/syscalls/add_key/add_key05.c
+++ b/testcases/kernel/syscalls/add_key/add_key05.c
@@ -10,6 +10,10 @@
  * This is also a regression test for
  * commit a08bf91ce28e ("KEYS: allow reaching the keys quotas exactly")
  * commit 2e356101e72a ("KEYS: reaching the keys quotas correctly")
+ *
+ * If you run this test with -i > 10 then expect to see some sporadic failures
+ * where add_key fails with EDQUOT. Keys are freed asynchronously and we only
+ * create up to 10 users to avoid race conditions.
  */
 
 #include <stdio.h>
@@ -18,47 +22,53 @@
 #include "tst_test.h"
 #include "lapi/keyctl.h"
 
+#define MAX_USERS 10
+
 static char *user_buf;
-static const char *username = "ltp_add_key05";
-static int user_added;
-struct passwd *ltpuser;
-static char fmt[1024];
+static uid_t ltpuser[MAX_USERS];
+
+static unsigned int usern;
+static volatile unsigned int useri;
 
 static const char *const save_restore[] = {
+	"?/proc/sys/kernel/keys/gc_delay",
 	"?/proc/sys/kernel/keys/maxkeys",
 	"?/proc/sys/kernel/keys/maxbytes",
 	NULL,
 };
 
-static void add_user(void)
+static void add_user(char n)
 {
-	if (user_added)
-		return;
-
+	char username[] = "ltp_add_key05_n";
 	const char *const cmd_useradd[] = {"useradd", username, NULL};
+	struct passwd *pw;
+
+	username[sizeof(username) - 2] = '0' + n;
 
 	SAFE_CMD(cmd_useradd, NULL, NULL);
-	user_added = 1;
-	ltpuser = SAFE_GETPWNAM(username);
-	sprintf(fmt, "%5u: %%*5d %%*d/%%*d %%d/%%d %%d/%%d", ltpuser->pw_uid);
+	pw = SAFE_GETPWNAM(username);
+	ltpuser[(unsigned int)n] = pw->pw_uid;
+
+	tst_res(TINFO, "Created user %s", pw->pw_name);
 }
 
-static void clean_user(void)
+static void clean_user(char n)
 {
-	if (!user_added)
-		return;
-
+	char username[] = "ltp_add_key05_n";
 	const char *const cmd_userdel[] = {"userdel", "-r", username, NULL};
 
+	username[sizeof(username) - 2] = '0' + n;
+
 	if (tst_cmd(cmd_userdel, NULL, NULL, TST_CMD_PASS_RETVAL))
 		tst_res(TWARN | TERRNO, "'userdel -r %s' failed", username);
-	else
-		user_added = 0;
 }
 
 static inline void parse_proc_key_users(int *used_key, int *max_key, int *used_bytes, int *max_bytes)
 {
 	unsigned int val[4];
+	char fmt[1024];
+
+	sprintf(fmt, "%5u: %%*5d %%*d/%%*d %%d/%%d %%d/%%d", ltpuser[useri]);
 	SAFE_FILE_LINES_SCANF("/proc/key-users", fmt, &val[0], &val[1], &val[2], &val[3]);
 
 	if (used_key)
@@ -121,8 +131,8 @@ static void verify_max_btyes(void)
 	plen = max_bytes - used_bytes - delta - strlen("test_xxx") - 1;
 	TEST(add_key("user", "test_max", buf, plen, KEY_SPEC_THREAD_KEYRING));
 	if (TST_RET == -1) {
-		 tst_res(TFAIL | TTERRNO, "add_key(test_max) failed unexpectedly");
-		 return;
+		tst_res(TFAIL | TTERRNO, "add_key(test_max) failed unexpectedly");
+		return;
 	}
 
 	tst_res(TPASS, "add_key(test_max) succeeded as expected");
@@ -170,37 +180,54 @@ count:
 
 static void do_test(unsigned int n)
 {
-	add_user();
-	if (!SAFE_FORK()) {
-		SAFE_SETUID(ltpuser->pw_uid);
-		TEST(add_key("user", "test1", user_buf, 64, KEY_SPEC_THREAD_KEYRING));
-		if (TST_RET == -1) {
-			tst_res(TFAIL | TTERRNO, "add key test1 failed");
-			return;
-		}
-		if (n)
-			verify_max_keys();
-		else
-			verify_max_btyes();
-		exit(0);
+	if (usern < MAX_USERS)
+		add_user(usern++);
+
+	if (useri >= MAX_USERS) {
+		sleep(1);
+		useri = 0;
+	}
+
+	if (SAFE_FORK()) {
+		tst_reap_children();
+		useri++;
+		return;
+	}
+
+	SAFE_SETUID(ltpuser[useri]);
+	tst_res(TINFO, "User: %d, UID: %d", useri, ltpuser[useri]);
+	TEST(add_key("user", "test1", user_buf, 64, KEY_SPEC_THREAD_KEYRING));
+	if (TST_RET == -1) {
+		tst_res(TFAIL | TTERRNO, "add key test1 failed");
+		return;
 	}
-	tst_reap_children();
-	clean_user();
+
+	if (n)
+		verify_max_keys();
+	else
+		verify_max_btyes();
 }
 
 static void setup(void)
 {
+	SAFE_FILE_PRINTF("/proc/sys/kernel/keys/gc_delay", "1");
 	SAFE_FILE_PRINTF("/proc/sys/kernel/keys/maxkeys", "200");
 	SAFE_FILE_PRINTF("/proc/sys/kernel/keys/maxbytes", "20000");
 }
 
+static void cleanup(void)
+{
+	while (usern--)
+		clean_user(usern);
+}
+
 static struct tst_test test = {
 	.test = do_test,
 	.tcnt = 2,
 	.needs_root = 1,
 	.forks_child = 1,
 	.setup = setup,
-	.cleanup = clean_user,
+	.cleanup = cleanup,
 	.save_restore = save_restore,
 	.bufs = (struct tst_buffers []) {
 		{&user_buf, .size = 64},
-- 
2.24.0

