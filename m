From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Mon, 14 Aug 2017 19:25:37 +0800
Subject: [LTP] [PATCH v4] commands/keyctl01: Check keyctl support instead of
	kernel version
In-Reply-To: <20170804120808.GA5400@rei>
References: <20170804120808.GA5400@rei>
Message-ID: <20170814112537.17742-1-fenggw-fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
---
 testcases/commands/keyctl/keyctl01.sh | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/testcases/commands/keyctl/keyctl01.sh b/testcases/commands/keyctl/keyctl01.sh
index 76226ae..650e7f4 100644
--- a/testcases/commands/keyctl/keyctl01.sh
+++ b/testcases/commands/keyctl/keyctl01.sh
@@ -34,11 +34,38 @@ TST_NEEDS_TMPDIR=1
 TST_NEEDS_CMDS="keyctl"
 . tst_test.sh
 
+check_keyctl()
+{
+	local nosup
+	for op in $@; do
+		nosup=0
+
+		if ! keyctl 2>&1 | grep -q "keyctl $op"; then
+			nosup=1
+		fi
+
+		if [ "$op" = "request2" ]; then
+			local key=`keyctl request2 user debug:foo bar`
+			if [ $? -ne 0 ]; then
+				nosup=1
+			fi
+		fi
+
+		if [ "$op" = "unlink" ]; then
+			if ! keyctl unlink $key @s; then
+				nosup=1
+			fi
+		fi
+
+		if [ $nosup -ne 0 ]; then
+			tst_brk TCONF "keyctl operation $op not supported"
+		fi
+	done
+}
+
 setup()
 {
-	if tst_kvcmp -le 2.6.33; then
-		tst_brk TCONF "Kernel newer than 2.6.33 is needed"
-	fi
+	check_keyctl negate request2 show unlink
 
 	PATH_KEYSTAT="/proc/key-users"
 	PATH_KEYQUOTA="/proc/sys/kernel/keys/root_maxbytes"
-- 
2.9.4



