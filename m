From: Wang Long <w@laoqinren.net>
Date: Thu, 28 Sep 2017 20:12:14 +0800
Subject: [LTP] [PATCH] Fix small issue on ftrace_regression01.sh testcase
Message-ID: <1506600734-14077-1-git-send-email-w@laoqinren.net>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

add the forgotten `$`.

Signed-off-by: Wang Long <w@laoqinren.net>
---
 testcases/kernel/tracing/ftrace_test/ftrace_regression01.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_regression01.sh b/testcases/kernel/tracing/ftrace_test/ftrace_regression01.sh
index f90e83a..d6969cf 100755
--- a/testcases/kernel/tracing/ftrace_test/ftrace_regression01.sh
+++ b/testcases/kernel/tracing/ftrace_test/ftrace_regression01.sh
@@ -64,7 +64,7 @@ ftrace_userstacktrace_test()
 			exc_page_fault_enable=`cat $EXC_PAGE_FAULT_ENABLE`
 			echo 1 > $EXC_PAGE_FAULT_ENABLE
 		else
-			mm_page_fault_enable=`cat MM_PAGE_FAULT_ENABLE`
+			mm_page_fault_enable=`cat $MM_PAGE_FAULT_ENABLE`
 			echo 1 > $MM_PAGE_FAULT_ENABLE
 		fi
 	done
-- 
1.8.3.1




