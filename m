From: Yixin Zhang <yixin.zhang@intel.com>
Date: Tue, 27 Mar 2018 21:22:24 +0800
Subject: [LTP] [PATCH ltp] tools/apicmds/.gitignore: add tst_flush
Message-ID: <20180327132224.15897-1-yixin.zhang@intel.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Yixin Zhang <yixin.zhang@intel.com>
---
 tools/apicmds/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/apicmds/.gitignore b/tools/apicmds/.gitignore
index a9ca9ec6d..e57a38ccd 100644
--- a/tools/apicmds/.gitignore
+++ b/tools/apicmds/.gitignore
@@ -1,6 +1,7 @@
 tst_brk
 tst_brkm
 tst_exit
+tst_flush
 tst_get_unused_port
 tst_ncpus
 tst_ncpus_conf
-- 
2.14.1

