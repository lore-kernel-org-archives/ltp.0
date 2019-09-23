From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 23 Sep 2019 11:52:03 +0200
Subject: [LTP] [COMMITTED] [PATCH] syscalls/getxattr01: Fix rare failures
Message-ID: <20190923095203.30362-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The test was observed to fail on s390x, the cause is obviously that we
use strcmp() for something that is not guaranteed to be null terminated.
That is because we store the string without the terminating null into
the extended attribute and the allocated buffer we read the attribute to
is not initialized either.

Fix the test by checking the returned size first then using memcmp()
instead of strcmp(). This change is just pre-release band-aid with
minimal changes, I've opened issue #583 so that we don't forget to
rewrite the test later on.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/getxattr/getxattr01.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/getxattr/getxattr01.c b/testcases/kernel/syscalls/getxattr/getxattr01.c
index be410a536..54ca65390 100644
--- a/testcases/kernel/syscalls/getxattr/getxattr01.c
+++ b/testcases/kernel/syscalls/getxattr/getxattr01.c
@@ -121,7 +121,14 @@ int main(int argc, char *argv[])
 			}
 		}
 
-		if (strcmp(tc[i - 1].value, XATTR_TEST_VALUE))
+		if (TEST_RETURN != XATTR_TEST_VALUE_SIZE) {
+			tst_resm(TFAIL,
+				 "getxattr() returned wrong size %ld expected %d",
+				 TEST_RETURN, XATTR_TEST_VALUE_SIZE);
+			continue;
+		}
+
+		if (memcmp(tc[i - 1].value, XATTR_TEST_VALUE, XATTR_TEST_VALUE_SIZE))
 			tst_resm(TFAIL, "Wrong value, expect \"%s\" got \"%s\"",
 				 XATTR_TEST_VALUE, tc[i - 1].value);
 		else
-- 
2.21.0

