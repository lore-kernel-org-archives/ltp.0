From: Petr Vorel <pvorel@suse.cz>
Date: Wed,  3 May 2017 18:07:49 +0200
Subject: [LTP] [RFC PATCH v5 1/3] gitignore: Prefixing filenames
In-Reply-To: <20170503160751.1634-1-pvorel@suse.cz>
References: <20170503160751.1634-1-pvorel@suse.cz>
Message-ID: <20170503160751.1634-2-pvorel@suse.cz>
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

