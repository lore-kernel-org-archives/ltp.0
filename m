From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Tue,  2 Mar 2021 15:25:05 +0000
Subject: [LTP] [RFC PATCH v2 2/7] API: Add macro for the container_of trick
In-Reply-To: <20210302152510.15116-1-rpalethorpe@suse.com>
References: <20210302152510.15116-1-rpalethorpe@suse.com>
Message-ID: <20210302152510.15116-3-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 include/tst_common.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/tst_common.h b/include/tst_common.h
index fd7a900d4..317925d1d 100644
--- a/include/tst_common.h
+++ b/include/tst_common.h
@@ -83,4 +83,9 @@
 #define TST_RES_SUPPORTS_TCONF_TFAIL_TINFO_TPASS_TWARN(condition) \
 	TST_BUILD_BUG_ON(condition)
 
+#define tst_container_of(ptr, type, member) ({		     \
+	const typeof( ((type *)0)->member ) *__mptr = (ptr); \
+	(type *)( (char *)__mptr - offsetof(type,member) );  \
+})
+
 #endif /* TST_COMMON_H__ */
-- 
2.30.0

