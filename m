From: Steve Ellcey <sellcey@cavium.com>
Date: Thu,  2 Mar 2017 08:52:53 -0800
Subject: [LTP] [PATCH v2] bin/ftest02: Fix negative lseek offset expression.
Message-ID: <1488473573-23472-1-git-send-email-sellcey@caviumnetworks.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Cast the result of sizeof to (off_t) so that we have a signed value
before we negate it.  Otherwise we will get the wrong value in cases
where sizeof returns a 32 bit unsigned type and off_t is a 64 bit
signed type.  This problem shows up on x86_64 when compiling with
-mx32.

This fixes LTP issue #135.

Signed-off-by: Steve Ellcey <sellcey@caviumnetworks.com>
---
 testcases/kernel/fs/ftest/ftest02.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/fs/ftest/ftest02.c b/testcases/kernel/fs/ftest/ftest02.c
index f205961..a416a98 100644
--- a/testcases/kernel/fs/ftest/ftest02.c
+++ b/testcases/kernel/fs/ftest/ftest02.c
@@ -268,7 +268,7 @@ static void crfile(int me, int count)
 	val = write(fd, crmsg, sizeof(crmsg) - 1);
 	warn(val, "write", 0);
 
-	val = lseek(fd, -(sizeof(crmsg) - 1), 1);
+	val = lseek(fd, -((off_t) sizeof(crmsg) - 1), 1);
 	warn(val, "lseek", 0);
 
 	val = read(fd, buf, sizeof(crmsg) - 1);
-- 
2.7.4

