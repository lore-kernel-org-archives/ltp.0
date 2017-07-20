From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Thu, 20 Jul 2017 13:38:12 +0800
Subject: [LTP] [PATCH v3] commands/keyctl01: Check keyctl support instead of
	kernel version
In-Reply-To: <f659c98f-f3bc-72f8-0c51-14dc956beba8@cn.fujitsu.com>
References: <f659c98f-f3bc-72f8-0c51-14dc956beba8@cn.fujitsu.com>
Message-ID: <20170720053812.4394-1-fenggw-fnst@cn.fujitsu.com>
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
index 76226ae..0b8e86c 100644
--- a/testcases/commands/keyctl/keyctl01.sh
+++ b/testcases/commands/keyctl/keyctl01.sh
@@ -36,8 +36,10 @@ TST_NEEDS_CMDS="keyctl"
 
 setup()
 {
-	if tst_kvcmp -le 2.6.33; then
-		tst_brk TCONF "Kernel newer than 2.6.33 is needed"
+	keyctl 2>&1 | sort | tr '\n' ' ' | grep -P \
+		"\bnegate\b.*\brequest2\b.*\bshow\b.*\bunlink\b" >/dev/null
+	if [ $? -ne 0 ]; then
+		tst_brk TCONF "keyctl operations not supported"
 	fi
 
 	PATH_KEYSTAT="/proc/key-users"
-- 
2.9.4



