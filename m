From: Khem Raj <raj.khem@gmail.com>
Date: Fri,  8 Jan 2016 08:11:50 +0000
Subject: [LTP] [PATCH 30/31] lib: Use PTHREAD_MUTEX_RECURSIVE in place of
	PTHREAD_RECURSIVE_MUTEX_INITIALIZER_NP for non-glibc
In-Reply-To: <1452240711-51180-1-git-send-email-raj.khem@gmail.com>
References: <1452240711-51180-1-git-send-email-raj.khem@gmail.com>
Message-ID: <1452240711-51180-30-git-send-email-raj.khem@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

e.g. musl does not implement the _NP mutex types

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 lib/tst_res.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/tst_res.c b/lib/tst_res.c
index 5c1c58c..3244b5e 100644
--- a/lib/tst_res.c
+++ b/lib/tst_res.c
@@ -104,8 +104,11 @@ int TEST_ERRNO;
 	assert(strlen(buf) > 0);		\
 } while (0)
 
+#ifdef __GLIBC__
 static pthread_mutex_t tmutex = PTHREAD_RECURSIVE_MUTEX_INITIALIZER_NP;
-
+#else
+static pthread_mutex_t tmutex = {  PTHREAD_MUTEX_RECURSIVE };
+#endif
 /*
  * Define local function prototypes.
  */
-- 
2.7.0

