From: Sandeep Patil <sspatil@google.com>
Date: Mon,  5 Nov 2018 15:50:17 -0800
Subject: [LTP] [PATCH 3/5] syscalls/fchmod02: fall back to use "daemon"
	group if "users" is absent.
In-Reply-To: <20181105235019.254846-1-sspatil@google.com>
References: <20181105235019.254846-1-sspatil@google.com>
Message-ID: <20181105235019.254846-4-sspatil@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This makes the test work successfully on Android systems where
"users" group doesn't exist.

Signed-off-by: Sandeep Patil <sspatil@google.com>
---
 testcases/kernel/syscalls/fchmod/fchmod02.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/syscalls/fchmod/fchmod02.c b/testcases/kernel/syscalls/fchmod/fchmod02.c
index d0b35db12..e60cb33a6 100644
--- a/testcases/kernel/syscalls/fchmod/fchmod02.c
+++ b/testcases/kernel/syscalls/fchmod/fchmod02.c
@@ -22,9 +22,6 @@
 #include "tst_test.h"
 #include "fchmod.h"
 
-#define LTPUSER		"nobody"
-#define LTPGRP		"users"
-
 static int fd;
 
 static void verify_fchmod(void)
@@ -53,8 +50,8 @@ static void setup(void)
 	struct passwd *ltpuser;
 	struct group *ltpgroup;
 
-	ltpuser = SAFE_GETPWNAM(LTPUSER);
-	ltpgroup = SAFE_GETGRNAM(LTPGRP);
+	ltpuser = SAFE_GETPWNAM("nobody");
+	ltpgroup = SAFE_GETGRNAM_FALLBACK("users", "daemon");
 
 	fd = SAFE_OPEN(TESTFILE, O_RDWR | O_CREAT, FILE_MODE);
 	SAFE_CHOWN(TESTFILE, ltpuser->pw_uid, ltpgroup->gr_gid);
-- 
2.19.1.930.g4563a0d9d0-goog

