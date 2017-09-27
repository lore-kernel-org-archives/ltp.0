From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Wed, 27 Sep 2017 13:32:50 +0800
Subject: [LTP] [PATCH v2] commands/file: Fix for "executable" match failure
	on newer gcc
In-Reply-To: <20170926093731.GA4884@rei.lan>
References: <20170926093731.GA4884@rei.lan>
Message-ID: <20170927053250.28768-1-fenggw-fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On newer gcc, --enable-default-pie is enabled by default,
thus in.c is compiled as position independent executable,
which is described as "shared object", so add this.

Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Signed-off-by: Fei Jie <feij.fnst@cn.fujitsu.com>
Signed-off-by: Lei Shaoting <leist.fnst@cn.fujitsu.com>
---
 testcases/commands/file/file01.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/testcases/commands/file/file01.sh b/testcases/commands/file/file01.sh
index 1b253cb..ff1a795 100755
--- a/testcases/commands/file/file01.sh
+++ b/testcases/commands/file/file01.sh
@@ -88,7 +88,8 @@ do_test()
 			    "[pP]ython script text executable";;
 	 9) file_test in.m4 "M4 macro processor script, ASCII text" \
 			    "ASCII M4 macro language pre-processor text";;
-	10) file_test in "ELF .*-bit $TEST_ARCH executable, .*";;
+	10) file_test in "ELF .*-bit $TEST_ARCH executable, .*" \
+		"ELF .*-bit $TEST_ARCH shared object, .*";;
 	11) file_test in.ar "current ar archive";;
 	12) file_test in.tar "tar archive";;
 	13) file_test in.tar.gz "gzip compressed data, .*";;
-- 
2.9.5



