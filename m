From: Yixin Zhang <yixin.zhang@intel.com>
Date: Mon, 12 Aug 2019 15:24:31 +0800
Subject: [LTP] [PATCH ltp] runtest/fs: remove non-acsii char from comment
Message-ID: <20190812072431.24378-1-yixin.zhang@intel.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Remove non-acsii char <C2><B4> from comment

Signed-off-by: Yixin Zhang <yixin.zhang@intel.com>
---
 runtest/fs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/runtest/fs b/runtest/fs
index ef2e848b9..07d6e2b67 100644
--- a/runtest/fs
+++ b/runtest/fs
@@ -66,7 +66,7 @@ fs_di fs_di -d $TMPDIR
 
 # Read every file in /proc. Not likely to crash, but does enough
 # to disturb the kernel. A good kernel latency killer too.
-# Was not sure why it should reside in runtest/crashme and won?t get tested ever
+# Was not sure why it should reside in runtest/crashme and won't get tested ever
 proc01 proc01 -m 128
 
 read_all_dev read_all -d /dev -p -q -r 10
-- 
2.17.1

