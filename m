From: zhe.he@windriver.com <zhe.he@windriver.com>
Date: Mon, 22 Apr 2019 16:35:18 +0800
Subject: [LTP]  [PATCH v2] file01.sh: Fix in was not recognized
Message-ID: <1555922118-412699-1-git-send-email-zhe.he@windriver.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: He Zhe <zhe.he@windriver.com>

Some file has "pie" appending after LSB or MSB, which causes mismatch and the
following error.

"file01 10 TFAIL: in: was not recognized"
..."ELF 64-bit LSB pie executable"...

This patches tunes the regulation expression to include those cases.

Signed-off-by: He Zhe <zhe.he@windriver.com>
---
v1 to v2: split into two groups to just match the encountered case

 testcases/commands/file/file01.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/testcases/commands/file/file01.sh b/testcases/commands/file/file01.sh
index 0a8119e..55c0433 100755
--- a/testcases/commands/file/file01.sh
+++ b/testcases/commands/file/file01.sh
@@ -91,7 +91,9 @@ do_test()
 	 9) file_test in.m4 "M4 macro processor script, ASCII text" \
 			    "ASCII M4 macro language pre-processor text";;
 	10) file_test in "ELF .*-bit $TEST_ARCH executable, .*" \
-			 "ELF .*-bit $TEST_ARCH shared object, .*";;
+			 "ELF .*-bit $TEST_ARCH shared object, .*" \
+			 "ELF .*-bit $TEST_ARCH pie executable, .*" \
+			 "ELF .*-bit $TEST_ARCH pie shared object, .*";;
 	11) file_test in.ar "current ar archive";;
 	12) file_test in.tar "tar archive";;
 	13) file_test in.tar.gz "gzip compressed data, .*";;
-- 
2.7.4

