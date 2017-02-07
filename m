From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue,  7 Feb 2017 13:02:33 +0100
Subject: [LTP] [COMMITTED] [PATCH] openposix: strftime_1-1: Set LC_TIME to C
Message-ID: <20170207120233.30412-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The test fails with anything else than english ISO locale so we
explicitly set LC_TIME to C before the test.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/open_posix_testsuite/conformance/interfaces/strftime/1-1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/strftime/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/strftime/1-1.c
index 25c9f62..4350edb 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/strftime/1-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/strftime/1-1.c
@@ -26,7 +26,7 @@ int main(void)
 	char text[256];
 	int result;
 
-	setlocale(LC_TIME, "");
+	setlocale(LC_TIME, "C");
 	strftime(text, sizeof(text), nl_langinfo(D_T_FMT), local_t);
 	printf("STRING IS:   %s\n\n", text);
 
-- 
2.10.2

