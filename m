From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Mon, 20 Aug 2018 08:42:54 +0200
Subject: [LTP] [PATCH 2/5] lib: Add LTP_ATTRIBUTE_FALLTHROUGH for case
	statements
In-Reply-To: <20180820064257.17974-1-rpalethorpe@suse.com>
References: <20180820064257.17974-1-rpalethorpe@suse.com>
Message-ID: <20180820064257.17974-3-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Can be used in place of break if you deliberately want to fallthrough to the
next case statement.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 include/tst_common.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/tst_common.h b/include/tst_common.h
index 27924766e..05e381edf 100644
--- a/include/tst_common.h
+++ b/include/tst_common.h
@@ -24,6 +24,7 @@
 #define LTP_ATTRIBUTE_NORETURN		__attribute__((noreturn))
 #define LTP_ATTRIBUTE_UNUSED		__attribute__((unused))
 #define LTP_ATTRIBUTE_UNUSED_RESULT	__attribute__((warn_unused_result))
+#define LTP_ATTRIBUTE_FALLTHROUGH	__attribute__((fallthrough))
 
 #ifndef ARRAY_SIZE
 # define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
-- 
2.18.0

