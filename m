From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Tue, 18 Jul 2017 14:31:44 +0800
Subject: [LTP] [PATCH v2 3/3] commands/keyctl01: Check keyctl support
	instead of kernel version
In-Reply-To: <20170718063144.18856-1-fenggw-fnst@cn.fujitsu.com>
References: <20170717114235.GB11059@rei.lan>
 <20170718063144.18856-1-fenggw-fnst@cn.fujitsu.com>
Message-ID: <20170718063144.18856-3-fenggw-fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
---
 testcases/commands/keyctl/keyctl01.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/testcases/commands/keyctl/keyctl01.sh b/testcases/commands/keyctl/keyctl01.sh
index 76226ae..8e96622 100644
--- a/testcases/commands/keyctl/keyctl01.sh
+++ b/testcases/commands/keyctl/keyctl01.sh
@@ -36,8 +36,10 @@ TST_NEEDS_CMDS="keyctl"
 
 setup()
 {
-	if tst_kvcmp -le 2.6.33; then
-		tst_brk TCONF "Kernel newer than 2.6.33 is needed"
+	keyctl 2>&1 | tr '\n' ' ' | grep "request2" | grep "negate" | \
+		grep "show" | grep "unlink" >/dev/null
+	if [ $? -ne 0 ]; then
+		tst_brk TCONF "keyctl operations not supported"
 	fi
 
 	PATH_KEYSTAT="/proc/key-users"
-- 
2.9.4



