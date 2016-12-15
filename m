From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Thu, 15 Dec 2016 18:49:56 +0800
Subject: [LTP] [PATCH v2 3/4] SAFE_MACROS: Add SAFE_PRCTL()
In-Reply-To: <1481798997-2320-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
References: <20161215104356.GB29787@rei.suse.cz>
 <1481798997-2320-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
Message-ID: <1481798997-2320-3-git-send-email-fenggw-fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
---
 include/tst_safe_macros.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index 59973b6..1044a34 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -278,6 +278,13 @@ static inline ssize_t safe_pwrite(const char *file, const int lineno,
 	            "fcntl(%i,%s,...) failed", fd, #cmd), 0 \
 	 : ret;})
 
+#define SAFE_PRCTL(opt, ...)                                \
+	({int ret = prctl(opt, ##__VA_ARGS__);              \
+	  ret < 0 ?                                         \
+	   tst_brk(TBROK | TERRNO,                          \
+	            "prctl(%s,...) failed", #opt), 0        \
+	 : ret;})
+
 /*
  * following functions are inline because the behaviour may depend on
  * -D_FILE_OFFSET_BITS=64 -DOFF_T=off64_t compile flags
-- 
1.8.4.2



