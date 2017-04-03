From: Petr Vorel <pvorel@suse.cz>
Date: Mon,  3 Apr 2017 14:45:01 +0200
Subject: [LTP] [RFC PATCH v3 1/3] gitignore: Prefixing filenames
In-Reply-To: <20170403124503.24054-1-pvorel@suse.cz>
References: <20170403124503.24054-1-pvorel@suse.cz>
Message-ID: <20170403124503.24054-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
 testcases/lib/.gitignore | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/testcases/lib/.gitignore b/testcases/lib/.gitignore
index 920817cac..522889bed 100644
--- a/testcases/lib/.gitignore
+++ b/testcases/lib/.gitignore
@@ -1,6 +1,6 @@
-tst_sleep
-tst_random
-tst_checkpoint
-tst_rod
-tst_kvcmp
-tst_device
+/tst_sleep
+/tst_random
+/tst_checkpoint
+/tst_rod
+/tst_kvcmp
+/tst_device
-- 
2.11.0

