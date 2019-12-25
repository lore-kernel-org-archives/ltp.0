From: zhe.he@windriver.com <zhe.he@windriver.com>
Date: Wed, 25 Dec 2019 14:57:43 +0800
Subject: [LTP] [PATCH] nm01: Remove prefix zeros of the addresses output by
 nm before comparing
Message-ID: <1577257063-246792-1-git-send-email-zhe.he@windriver.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: He Zhe <zhe.he@windriver.com>

The latest nm v2.33.1.20191208 outputs symbols addresses without prefix zeros
for "nm -f posix", which causes the following error.
nm01 5 TFAIL: Got wrong format with -f bsd

Let's remove the prefix zeros before comparing.

Signed-off-by: He Zhe <zhe.he@windriver.com>
---
 testcases/commands/nm/nm01.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/testcases/commands/nm/nm01.sh b/testcases/commands/nm/nm01.sh
index 30c41bd..29b6bd7 100755
--- a/testcases/commands/nm/nm01.sh
+++ b/testcases/commands/nm/nm01.sh
@@ -84,6 +84,9 @@ test5()
 	EXPECT_PASS $NM -f bsd $TST_DATAROOT/f1 \> nm_bsd.out
 	EXPECT_PASS $NM -f posix $TST_DATAROOT/f1 \> nm_posix.out
 
+	ROD awk '{print gensub(/(0+)([0-9a-fA-F]+)/, "\\2", "g")}' nm_bsd.out \> nm_bsd.out
+	ROD awk '{print gensub(/(0+)([0-9a-fA-F]+)/, "\\2", "g")}' nm_posix.out \> nm_posix.out
+
 	ROD awk '{print $3 $2 $1}' nm_bsd.out \> nm1.out
 	ROD awk '{print $1 $2 $3}' nm_posix.out \> nm2.out
 
-- 
2.7.4

