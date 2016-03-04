From: Li Wang <liwang@redhat.com>
Date: Fri,  4 Mar 2016 16:24:50 +0800
Subject: [LTP] [PATCH RFC 1/9] ftrace_stress: remove the useless file
	ftrace_get_page_size.c
In-Reply-To: <1457079898-9449-1-git-send-email-liwang@redhat.com>
References: <1457079898-9449-1-git-send-email-liwang@redhat.com>
Message-ID: <1457079898-9449-2-git-send-email-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

After checking the whole test suit, I didn't find anyplace calling this
program. Also, we cloud get system page size by command 'getconf PAGESIZE'.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/tracing/ftrace_stress_test/.gitignore            | 1 -
 .../kernel/tracing/ftrace_stress_test/ftrace_get_page_size.c      | 8 --------
 2 files changed, 9 deletions(-)
 delete mode 100644 testcases/kernel/tracing/ftrace_stress_test/.gitignore
 delete mode 100644 testcases/kernel/tracing/ftrace_stress_test/ftrace_get_page_size.c

diff --git a/testcases/kernel/tracing/ftrace_stress_test/.gitignore b/testcases/kernel/tracing/ftrace_stress_test/.gitignore
deleted file mode 100644
index 099ec4e..0000000
--- a/testcases/kernel/tracing/ftrace_stress_test/.gitignore
+++ /dev/null
@@ -1 +0,0 @@
-/ftrace_get_page_size
diff --git a/testcases/kernel/tracing/ftrace_stress_test/ftrace_get_page_size.c b/testcases/kernel/tracing/ftrace_stress_test/ftrace_get_page_size.c
deleted file mode 100644
index 9f5dec7..0000000
--- a/testcases/kernel/tracing/ftrace_stress_test/ftrace_get_page_size.c
+++ /dev/null
@@ -1,8 +0,0 @@
-#include <unistd.h>
-#include <stdio.h>
-
-int main(void)
-{
-	printf("%d\n", getpagesize());
-	return 0;
-}
-- 
1.8.3.1

