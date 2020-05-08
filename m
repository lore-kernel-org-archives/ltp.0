From: Jan Stancek <jstancek@redhat.com>
Date: Fri,  8 May 2020 14:58:32 +0200
Subject: [LTP] [PATCH] nm01: fix regex matching internal symbols
Message-ID: <797dd5eeadd81fae30635dd66d0a715cc213c51e.1588942651.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Current regex matches any word character followed by space
and one of letters "abdft". So it doesn't match only symbol type,
but can match for example value and size:
  $ grep "\w [a,b,d,f,t]" nm.out
  __libc_csu_init T 10000640 b4
                   matches ^ ^

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/commands/nm/nm01.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/commands/nm/nm01.sh b/testcases/commands/nm/nm01.sh
index fd9d3d92262f..873126d20945 100755
--- a/testcases/commands/nm/nm01.sh
+++ b/testcases/commands/nm/nm01.sh
@@ -47,7 +47,7 @@ test2()
 {
 	EXPECT_PASS $NM -f posix -g $TST_DATAROOT/f1 \> nm.out
 
-	if grep -q "\w [a,b,d,f,t]" nm.out; then
+	if grep -q "^[^ ]\+ [abdft]" nm.out; then
 		tst_res TFAIL "Got internal symbols with -g"
 		cat nm.out
 	else
-- 
2.18.1

