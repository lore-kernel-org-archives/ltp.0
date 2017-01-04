From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed,  4 Jan 2017 17:57:45 +0100
Subject: [LTP] [COMMITTED] [PATCH] commands/file_test.sh: Fix for SLES11
Message-ID: <1483549065-14088-1-git-send-email-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add more alternative expected outputs, fixes the test on SLES11.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/commands/file/file_test.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/testcases/commands/file/file_test.sh b/testcases/commands/file/file_test.sh
index 66d355c..ed4792a 100755
--- a/testcases/commands/file/file_test.sh
+++ b/testcases/commands/file/file_test.sh
@@ -77,12 +77,14 @@ do_test()
 	 2) file_test in.bash "Bourne-Again shell script";;
 	 3) file_test in.sh "POSIX shell script, ASCII text executable" \
 			    "POSIX shell script text executable" \
+			    "POSIX shell script text" \
 			    "Bourne shell script text executable";;
 	 4) file_test in.ksh "Korn shell script";;
 	 5) file_test in.csh "C shell script";;
 	 6) file_test in.c "ASCII C program text" "C source, ASCII text";;
 	 7) file_test in.pl "[pP]erl script, ASCII text executable" \
-			    "[pP]erl script text executable";;
+			    "[pP]erl script text executable" \
+			    "a /usr/bin/perl script text";;
 	 8) file_test in.py "[pP]ython script, ASCII text executable" \
 			    "[pP]ython script text executable";;
 	 9) file_test in.m4 "M4 macro processor script, ASCII text" \
-- 
2.7.3

