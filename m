From: Petr Vorel <pvorel@suse.cz>
Date: Sat,  3 Jun 2017 14:00:12 +0200
Subject: [LTP] [RFC PATCH v6 01/11] gitignore: Prefixing filenames
In-Reply-To: <20170603120022.13415-1-pvorel@suse.cz>
References: <20170603120022.13415-1-pvorel@suse.cz>
Message-ID: <20170603120022.13415-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
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
2.12.2

