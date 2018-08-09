From: Jan Stancek <jstancek@redhat.com>
Date: Thu,  9 Aug 2018 10:35:44 +0200
Subject: [LTP] [PATCH COMMITTED] settimeofday01: make sure tv_usec <
	USEC_PER_SEC
Message-ID: <1bba98c12e5c2b87082310a1afc0fc6d74a08ef2.1533803589.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Kernel checks for this and reports EINVAL, which causes
test to rarely fail:
    if (!timeval_valid(&user_tv))
        return -EINVAL;

Fixes: 9ba1051fbe29 ("settimeofday01: fix for linux kernel >= 4.2")
Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/settimeofday/settimeofday01.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/testcases/kernel/syscalls/settimeofday/settimeofday01.c b/testcases/kernel/syscalls/settimeofday/settimeofday01.c
index c68fb37eb0f7..7388c3231aaa 100644
--- a/testcases/kernel/syscalls/settimeofday/settimeofday01.c
+++ b/testcases/kernel/syscalls/settimeofday/settimeofday01.c
@@ -64,6 +64,7 @@
 #define	VAL_SEC		100
 #define	VAL_MSEC	100
 #define ACCEPTABLE_DELTA	500	/* in milli-seconds */
+#define USEC_PER_SEC    1000000L
 
 char *TCID = "settimeofday01";
 int TST_TOTAL = 1;
@@ -92,6 +93,8 @@ int main(int argc, char **argv)
 		gettimeofday(&tp, NULL);
 		tp.tv_sec += VAL_SEC;
 		tp.tv_usec += VAL_MSEC;
+		if (tp.tv_usec >= USEC_PER_SEC)
+			tp.tv_usec = VAL_MSEC;
 
 		TEST(settimeofday(&tp, NULL));
 		if (TEST_RETURN == -1) {
-- 
1.8.3.1

