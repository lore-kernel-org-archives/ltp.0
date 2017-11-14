From: Sandeep Patil <sspatil@google.com>
Date: Mon, 13 Nov 2017 18:11:16 -0800
Subject: [LTP] [PATCH 2/4] checkpoint: add TST_CHECKPOINT_INIT() for new
	library headers
In-Reply-To: <20171114021118.103786-1-sspatil@google.com>
References: <20171114021118.103786-1-sspatil@google.com>
Message-ID: <20171114021118.103786-3-sspatil@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The macro was missing unlike the new library equivalents of old
TST_SAFE_CHECKPOINT_{WAIT/WAKE} macros. So, add it, so it can be used
immediately in mm/mallocstress test conversion to checkpoint API.

Signed-off-by: Sandeep Patil <sspatil@google.com>
---
 include/tst_checkpoint.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/tst_checkpoint.h b/include/tst_checkpoint.h
index d6f7607ab..f936c698e 100644
--- a/include/tst_checkpoint.h
+++ b/include/tst_checkpoint.h
@@ -20,6 +20,15 @@
 
 #include "tst_checkpoint_fn.h"
 
+/*
+ * Checkpoint initialization, must be done first.
+ *
+ * Note: .needs_tmpdir must be set for the tests using checkpoints
+ */
+
+#define TST_CHECKPOINT_INIT() \
+	tst_checkpoint_init(__FILE__, __LINE__, NULL)
+
 #define TST_CHECKPOINT_WAIT(id) \
         tst_safe_checkpoint_wait(__FILE__, __LINE__, NULL, id, 0);
 
-- 
2.15.0.448.gf294e3d99a-goog

