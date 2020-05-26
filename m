From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Tue, 26 May 2020 14:38:47 +0300
Subject: [LTP] [PATCH] acct02: fix the ac_version check on big endian
 platforms
Message-ID: <20200526113847.6837-1-stanislav.kholmanskikh@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

If we are on a big endian platform where char is signed,
the following compilation error is emitted:

acct02.c: In function ?verify_acct?:
acct02.c:38:37: warning: comparison is always true due to limited range of data type [-Wtype-limits]
 #define ACCT_MEMBER_V3(x) (((struct acct_v3 *)acc)->x)
                                     ^
acct02.c:144:6: note: in expansion of macro ?ACCT_MEMBER_V3?
  if (ACCT_MEMBER_V3(ac_version) != (3 | ACCT_BYTEORDER)) {

and the test case fails, because it cannot 'decrypt' the ac_version
from the file:

acct02.c:238: INFO: Verifying using 'struct acct_v3'
acct02.c:191: INFO: == entry 1 ==
acct02.c:146: INFO: ac_version != 3 (-125)

One way to address that is to explicitly cast the expression
we compare to (which is int) to the type of ac_version (which is char).

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 testcases/kernel/syscalls/acct/acct02.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/acct/acct02.c b/testcases/kernel/syscalls/acct/acct02.c
index d6b16b8..8ee1bfc 100644
--- a/testcases/kernel/syscalls/acct/acct02.c
+++ b/testcases/kernel/syscalls/acct/acct02.c
@@ -141,7 +141,7 @@ static int verify_acct(void *acc, int elap_time)
 		ret = 1;
 	}
 
-	if (ACCT_MEMBER_V3(ac_version) != (3 | ACCT_BYTEORDER)) {
+	if (ACCT_MEMBER_V3(ac_version) != (char)(3 | ACCT_BYTEORDER)) {
 		tst_res(TINFO, "ac_version != 3 (%d)",
 			ACCT_MEMBER_V3(ac_version));
 		ret = 1;
-- 
1.8.3.1

