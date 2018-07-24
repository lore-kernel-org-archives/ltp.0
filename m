From: Michael Moese <mmoese@suse.de>
Date: Tue, 24 Jul 2018 10:25:30 +0200
Subject: [LTP] [PATCH] add testcases/lib/tst_supported_fs to .gititnore
Message-ID: <20180724082530.18646-1-mmoese@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The binary tst_supported_fs was missing in the .gitinore file
in testcases/lib, so it should be added.

Signed-off-by: Michael Moese <mmoese@suse.de>
---
 testcases/lib/.gitignore | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/testcases/lib/.gitignore b/testcases/lib/.gitignore
index 997940006..a9034e401 100644
--- a/testcases/lib/.gitignore
+++ b/testcases/lib/.gitignore
@@ -7,4 +7,5 @@
 /tst_net_iface_prefix
 /tst_net_ip_prefix
 /tst_net_vars
-/tst_getconf
\ No newline at end of file
+/tst_getconf
+/tst_supported_fs
-- 
2.18.0

