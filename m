From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Date: Tue, 29 Jun 2021 14:10:44 +0200
Subject: [LTP] [PATCH v4 1/4] include/tst_pid.h: fix language typo
 (subtraction)
In-Reply-To: <20210629121047.100391-1-krzysztof.kozlowski@canonical.com>
References: <20210629121047.100391-1-krzysztof.kozlowski@canonical.com>
Message-ID: <20210629121047.100391-2-krzysztof.kozlowski@canonical.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 include/tst_pid.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/tst_pid.h b/include/tst_pid.h
index 9ba1abb27b7c..6c42f73a57e7 100644
--- a/include/tst_pid.h
+++ b/include/tst_pid.h
@@ -13,7 +13,7 @@
 pid_t tst_get_unused_pid_(void (*cleanup_fn)(void));
 
 /*
- * Returns number of free pids by substarction of the number of pids
+ * Returns number of free pids by subtraction of the number of pids
  * currently used ('ps -eT') from max_pids
  */
 int tst_get_free_pids_(void (*cleanup_fn)(void));
-- 
2.27.0

