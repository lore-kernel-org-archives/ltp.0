From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Tue, 13 Mar 2018 16:24:47 +0100
Subject: [LTP] [PATCH v2 1/2] lib: Add TRERRNO to tst_res and remove sign
	when present
In-Reply-To: <20180313105541.GB14611@rei>
References: <20180313105541.GB14611@rei>
Message-ID: <20180313152448.7480-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Some system calls and libraries pass the error code back to the user in the
return value. Sometimes it is inverted, sometimes not. This allows TRERRNO to
be passed to tst_res which then causes it to print the error code in
TEST_RETURN.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---

I think we have to branch on TEST_RETURN < 0 because of two's complement
integer representation, but I could be missing a trick here.

 lib/tst_res.c  | 4 ++--
 lib/tst_test.c | 5 +++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/lib/tst_res.c b/lib/tst_res.c
index b56f37db0..b4bc09179 100644
--- a/lib/tst_res.c
+++ b/lib/tst_res.c
@@ -346,10 +346,10 @@ static void tst_print(const char *tcid, int tnum, int ttype, const char *tmesg)
 	}
 
 	if (ttype & TRERRNO) {
+		err = TEST_RETURN < 0 ? -(int)TEST_RETURN : (int)TEST_RETURN;
 		size += snprintf(message + size, sizeof(message) - size,
 				 ": TEST_RETURN=%s(%i): %s",
-				 tst_strerrno(TEST_RETURN), (int)TEST_RETURN,
-				 strerror(TEST_RETURN));
+				 tst_strerrno(err), err, strerror(err));
 	}
 
 	if (size + 1 >= sizeof(message)) {
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 2cf35ed66..00b8ccb69 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -215,6 +215,11 @@ static void print_result(const char *file, const int lineno, int ttype,
 	if (ttype & TTERRNO)
 		str_errno = tst_strerrno(TEST_ERRNO);
 
+	if (ttype & TRERRNO) {
+		ret = TEST_RETURN < 0 ? -(int)TEST_RETURN : (int)TEST_RETURN;
+		str_errno = tst_strerrno(ret);
+	}
+
 	ret = snprintf(str, size, "%s:%i: ", file, lineno);
 	str += ret;
 	size -= ret;
-- 
2.16.2

