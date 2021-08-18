From: Egor Petrov <egor.petrov@oracle.com>
Date: Wed, 18 Aug 2021 14:04:40 +0300
Subject: [LTP] [PATCH] Fixed SELinux path check in tst_get_enforce()
Message-ID: <20210818110440.285-1-egor.petrov@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

tst_get_enforce() ignored the output from tst_get_selinux_dir() and
returned an empty string on systems with valid SELinux path while
expected to return path to the SELinux enforce. Fixed it.

Signed-off-by: Egor Petrov <egor.petrov@oracle.com>
---
 testcases/lib/tst_security.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/lib/tst_security.sh b/testcases/lib/tst_security.sh
index 7ae6ddb61..05640234e 100644
--- a/testcases/lib/tst_security.sh
+++ b/testcases/lib/tst_security.sh
@@ -135,7 +135,7 @@ tst_get_selinux_dir()
 tst_get_enforce()
 {
 	local dir=$(tst_get_selinux_dir)
-	[ -z "$dir" ] || return
+	[ -z "$dir" ] && return
 
 	local f="$dir/enforce"
 	[ -f "$f" ] && echo "$f"
-- 
2.32.0.windows.2

