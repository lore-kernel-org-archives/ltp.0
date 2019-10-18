From: Clemens Famulla-Conrad <cfamullaconrad@suse.de>
Date: Fri, 18 Oct 2019 14:45:02 +0200
Subject: [LTP] [PATCH v4 5/5] Adopt doc for TST_RETRY_FUNC for
 LTP_TIMEOUT_MUL
In-Reply-To: <20191018124502.25599-1-cfamullaconrad@suse.de>
References: <20191018124502.25599-1-cfamullaconrad@suse.de>
Message-ID: <20191018124502.25599-6-cfamullaconrad@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Mention that time limit is mulitplied with LTP_TIMEOUT_MUL.
---
 doc/test-writing-guidelines.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index efff4d40c..905a4baa5 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -2313,7 +2313,8 @@ Retry a function in limited time
 Sometimes LTP test needs retrying a function for many times to get success.
 This achievement makes that possible via keeping it retrying if the return
 value of the function is NOT as we expected. After exceeding a limited time,
-test will break from the retries immediately.
+test will break from the retries immediately. The time limit is multiplied
+with LTP_TIMEOUT_MUL.
 
 [source,c]
 -------------------------------------------------------------------------------
-- 
2.16.4

