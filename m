From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Wed, 13 Sep 2017 15:48:43 +0800
Subject: [LTP] [PATCH 2/2] commands/ar01: Fix misplaced test result
	description
In-Reply-To: <20170913074843.12212-1-fenggw-fnst@cn.fujitsu.com>
References: <20170913074843.12212-1-fenggw-fnst@cn.fujitsu.com>
Message-ID: <20170913074843.12212-2-fenggw-fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Signed-off-by: Fei Jie <feij.fnst@cn.fujitsu.com>
---
 testcases/commands/ar/ar01 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/commands/ar/ar01 b/testcases/commands/ar/ar01
index 4b00711..d688f76 100644
--- a/testcases/commands/ar/ar01
+++ b/testcases/commands/ar/ar01
@@ -289,9 +289,9 @@ test14()
 	file1_mtime2=$(ar -tv lib.a | grep file1.in)
 
 	if [ "$file0_mtime1" = "$file0_mtime2" ]; then
-		tst_res TFAIL "ar updated modified file0 (-u)"
+		tst_res TFAIL "ar haven't updated modified file0 (-u)"
 	else
-		tst_res TPASS "ar haven't updated modified file0 (-u)"
+		tst_res TPASS "ar updated modified file0 (-u)"
 	fi
 
 	if [ "$file1_mtime1" = "$file1_mtime2" ]; then
-- 
1.8.3.1



