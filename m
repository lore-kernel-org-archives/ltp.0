From: zhe.he@windriver.com <zhe.he@windriver.com>
Date: Mon, 22 Apr 2019 09:29:26 +0800
Subject: [LTP]  [PATCH] file01.sh: Fix in was not recognized
Message-ID: <1555896566-317528-1-git-send-email-zhe.he@windriver.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: He Zhe <zhe.he@windriver.com>

Some file may have "pie" and possible other things appending after LSB or MSB,
which causes mismatch and the following error.

"file01 10 TFAIL: in: was not recognized"
..."ELF 64-bit LSB pie executable"...

This patches tunes the regulation expression to match those cases.

Signed-off-by: He Zhe <zhe.he@windriver.com>
---
 testcases/commands/file/file01.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/commands/file/file01.sh b/testcases/commands/file/file01.sh
index 0a8119e..34274c3 100755
--- a/testcases/commands/file/file01.sh
+++ b/testcases/commands/file/file01.sh
@@ -90,8 +90,8 @@ do_test()
 			    "[pP]ython3\{0,1\} script text executable";;
 	 9) file_test in.m4 "M4 macro processor script, ASCII text" \
 			    "ASCII M4 macro language pre-processor text";;
-	10) file_test in "ELF .*-bit $TEST_ARCH executable, .*" \
-			 "ELF .*-bit $TEST_ARCH shared object, .*";;
+	10) file_test in "ELF .*-bit $TEST_ARCH .* executable, .*" \
+			 "ELF .*-bit $TEST_ARCH .* shared object, .*";;
 	11) file_test in.ar "current ar archive";;
 	12) file_test in.tar "tar archive";;
 	13) file_test in.tar.gz "gzip compressed data, .*";;
-- 
2.7.4

