From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu,  4 Oct 2018 16:33:12 +0200
Subject: [LTP] [PATCH] [COMMITTED] syscalls/getxattr05: Exit with TCONF when
	ACL is not supported
Message-ID: <20181004143312.6684-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/getxattr/getxattr05.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/getxattr/getxattr05.c b/testcases/kernel/syscalls/getxattr/getxattr05.c
index 8656205f2..31b985ee0 100644
--- a/testcases/kernel/syscalls/getxattr/getxattr05.c
+++ b/testcases/kernel/syscalls/getxattr/getxattr05.c
@@ -134,8 +134,12 @@ static void setup(void)
 		tst_brk(TBROK | TERRNO, "acl_from_text() failed");
 
 	res = acl_set_file(TEST_FILE, ACL_TYPE_ACCESS, acl);
-	if (res == -1)
+	if (res == -1) {
+		if (errno == EOPNOTSUPP)
+			tst_brk(TCONF | TERRNO, "acl_set_file()");
+
 		tst_brk(TBROK | TERRNO, "acl_set_file(%s) failed", TEST_FILE);
+	}
 
 	/* The default value of max_user_namespaces is set to 0 on some distros,
 	 * We need to change the default value to call unshare().
-- 
2.16.4

