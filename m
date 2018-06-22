From: Alistair Strachan <astrachan@google.com>
Date: Fri, 22 Jun 2018 14:57:10 -0700
Subject: [LTP] [PATCH] abs01: Switch from <values.h> to <limits.h>
In-Reply-To: <20180622215710.126661-1-astrachan@google.com>
References: <20180622215710.126661-1-astrachan@google.com>
Message-ID: <20180622215710.126661-4-astrachan@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The <values.h> is an obsolete glibc interface that wraps <limits.h> and
<float.h>. The abs01 test only uses it for MININT, which can be
switched over to <limits.h> and INT_MIN, for increased portability.

Signed-off-by: Alistair Strachan <astrachan@google.com>
---
 testcases/misc/math/abs/abs01.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/misc/math/abs/abs01.c b/testcases/misc/math/abs/abs01.c
index c0659fa6d..c62bf0303 100644
--- a/testcases/misc/math/abs/abs01.c
+++ b/testcases/misc/math/abs/abs01.c
@@ -42,7 +42,7 @@
 #include <ctype.h>
 #include <math.h>
 #include <errno.h>
-#include <values.h>
+#include <limits.h>
 
 /*****	LTP Port	*****/
 
@@ -72,7 +72,7 @@ int main(int argc, char *argv[])
 /*--------------------------------------------------------------*/
 	blenter();
 
-	i = llabs(MININT) + (long long)MININT;
+	i = llabs(INT_MIN) + (long long)INT_MIN;
 
 	if (i != 0) {
 		fprintf(temp, "abs of minimum integer failed.");
