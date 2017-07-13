From: Dan Rue <dan.rue@linaro.org>
Date: Thu, 13 Jul 2017 12:16:10 -0500
Subject: [LTP] [PATCH] su: Remove 'catch close'
Message-ID: <20170713171610.32370-1-dan.rue@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Introduced in d97c827e3e, the exit codes captured by 'set codes [wait]' are
getting lost due to the 'catch close' call, causing tests 2, 4, 6, and 7 to
fail.

Signed-off-by: Dan Rue <dan.rue@linaro.org>
---
 testcases/commands/su/su01_s1 | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/testcases/commands/su/su01_s1 b/testcases/commands/su/su01_s1
index fd2e485da..313207b64 100755
--- a/testcases/commands/su/su01_s1
+++ b/testcases/commands/su/su01_s1
@@ -135,7 +135,6 @@ expect {
   }
 }
 
-catch close
 # capture result code
 set codes [wait]
 set pid [lindex $codes 0]
@@ -152,7 +151,6 @@ if { $i_am_root==1 } {
 		}
 	}
 	expect eof
-	catch close
 	wait
 
 	set test_env_var [exec cat $TEST_ENV_FILE]
@@ -198,7 +196,6 @@ expect {
   }
 }
 
-catch close
 # capture result code
 set codes [wait]
 set pid [lindex $codes 0]
@@ -237,7 +234,6 @@ expect {
   }
 }
 
-catch close
 # capture result code
 set codes [wait]
 set pid [lindex $codes 0]
@@ -292,7 +288,6 @@ expect {
   }
 }
 
-catch close
 # capture result code
 set codes [wait]
 set pid [lindex $codes 0]
@@ -325,7 +320,6 @@ expect {
   }
 }
 
-catch close
 # capture result code
 set codes [wait]
 set pid [lindex $codes 0]
@@ -384,7 +378,6 @@ expect {
   }
 }
 
-catch close
 # capture result code
 set codes [wait]
 set pid [lindex $codes 0]
@@ -447,7 +440,6 @@ expect {
   }
 }
 
-catch close
 # capture result code
 set codes [wait]
 set pid [lindex $codes 0]
@@ -481,7 +473,6 @@ expect {
   }
 }
 
-catch close
 } else {
 
 	send_user "TEST:  su to user1 with the user1 password expired. (FAILED),see more next line.\n"
-- 
2.11.0

