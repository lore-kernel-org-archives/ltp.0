From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Wed, 14 Jul 2021 08:11:55 +0100
Subject: [LTP] [PATCH v2 5/8] doc: Document TEST macro and state TST_RET/ERR
 rule LTP-002
In-Reply-To: <20210714071158.15868-1-rpalethorpe@suse.com>
References: <20210714071158.15868-1-rpalethorpe@suse.com>
Message-ID: <20210714071158.15868-6-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

There are cases where these variables can be safely used by the
library. However it is a difficult problem to identify these cases
automatically.

Identifying any library code which uses them is relatively easy. In
fact it is easier to automate it than by code review. Because it is
such a boring thing to repeatedly look for and comment on.

If a test library function needs these variables it can recreate its
own private copies.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 doc/c-test-api.txt                     | 47 ++++++++++++++++++++++++++
 doc/library-api-writing-guidelines.txt | 14 ++++++++
 2 files changed, 61 insertions(+)

diff --git a/doc/c-test-api.txt b/doc/c-test-api.txt
index 45784195b..b47728f60 100644
--- a/doc/c-test-api.txt
+++ b/doc/c-test-api.txt
@@ -767,6 +767,53 @@ LTP_ALIGN(x, a)
 
 Aligns the x to be next multiple of a. The a must be power of 2.
 
+[source,c]
+-------------------------------------------------------------------------------
+TEST(socket(AF_INET, SOCK_RAW, 1));
+if (TST_RET > -1) {
+	tst_res(TFAIL, "Created raw socket");
+	SAFE_CLOSE(TST_RET);
+} else if (TST_ERR != EPERM) {
+	tst_res(TFAIL | TTERRNO,
+		"Failed to create socket for wrong reason");
+} else {
+	tst_res(TPASS | TTERRNO, "Didn't create raw socket");
+}
+-------------------------------------------------------------------------------
+
+The +TEST+ macro sets +TST_RET+ to its argument's return value and
++TST_ERR+ to +errno+. The +TTERNO+ flag can be used to print the error
+number's symbolic value.
+
+No LTP library function or macro, except those in 'tst_test_macros.h',
+will write to these variables (rule 'LTP-002'). So their values will
+not be changed unexpectedly.
+
+[source,c]
+-------------------------------------------------------------------------------
+TST_EXP_POSITIVE(wait(&status));
+
+if (!TST_PASS)
+	return;
+-------------------------------------------------------------------------------
+
+If the return value of 'wait' is positive. This macro will print a
+pass result and set +TST_PASS+ appropriately. If the return value is
+zero or negative, then it will print fail.
+
+This and similar macros take optional variadic arguments. These begin
+with a format string and then appropriate values to be formatted.
+
+[source,c]
+-------------------------------------------------------------------------------
+TST_EXP_PASS(chown("a/file", uid, gid), "chown(%s,%d,%d)",
+	     "a/file", uid, gid);
+-------------------------------------------------------------------------------
+
+Expects +chown+ to return 0 and emits a pass or a fail. The arguments
+to +chown+ will be printed in either case. There are many similar
+macros, please see 'tst_test_macros.h'.
+
 1.13 Filesystem type detection and skiplist
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/doc/library-api-writing-guidelines.txt b/doc/library-api-writing-guidelines.txt
index a4393fc54..2819d4177 100644
--- a/doc/library-api-writing-guidelines.txt
+++ b/doc/library-api-writing-guidelines.txt
@@ -21,10 +21,24 @@ Don't forget to update docs when you change the API.
 2. C API
 --------
 
+2.1 LTP-001: Sources have tst_ prefix
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
 API source code is in headers `include/*.h`, `include/lapi/*.h` (backward
 compatibility for old kernel and libc) and C sources in `lib/*.c`. Files have
 'tst_' prefix.
 
+2.2 LTP-002: TST_RET and TST_ERR are not modified
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The test author is guaranteed that the test API will not modify these
+variables. This prevents silent errors where the return value and
+errno are overwritten before the test has chance to check them.
+
+The macros which are clearly intended to update these variables. That
+is +TEST+ and those in 'tst_test_macros.h'. Are of course allowed to
+update these variables.
+
 3. Shell API
 ------------
 
-- 
2.31.1

