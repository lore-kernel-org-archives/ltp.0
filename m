From: Yixin Zhang <yixin.zhang@intel.com>
Date: Fri,  9 Aug 2019 14:19:59 +0800
Subject: [LTP] [PATCH ltp 4/5] runtest/crashme: rename mem01 to avoid
 duplication
In-Reply-To: <20190809062000.8671-1-yixin.zhang@intel.com>
References: <20190809062000.8671-1-yixin.zhang@intel.com>
Message-ID: <20190809062000.8671-4-yixin.zhang@intel.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

mem01 is already in runtest file mm. Rename the test to mem01_crashme
here.

Signed-off-by: Yixin Zhang <yixin.zhang@intel.com>
---
 runtest/crashme | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/runtest/crashme b/runtest/crashme
index a4c5b41cc..e853663e6 100644
--- a/runtest/crashme
+++ b/runtest/crashme
@@ -10,7 +10,7 @@ crash01 crash01
 crash02 crash02
 # Generate random syscalls and execute them, less probability
 # to hose your system, but still.
-mem01 mem01 -r
+mem01_crashme mem01 -r
 # Memory eater. Loves to be run in parallel with other programs.
 # May panic on buggy systems if the OOM killer was not fast enough :-)
 fork12 fork12
-- 
2.17.1

