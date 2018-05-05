From: Yixin Zhang <yixin.zhang@intel.com>
Date: Sat,  5 May 2018 09:59:52 +0800
Subject: [LTP] [PATCH ltp] runtest/scsi_debug.part1: remove invalid line in
	scenario file
Message-ID: <20180505015952.14640-1-yixin.zhang@intel.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Yixin Zhang <yixin.zhang@intel.com>
---
 runtest/scsi_debug.part1 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/runtest/scsi_debug.part1 b/runtest/scsi_debug.part1
index 5538516a3..acc427131 100644
--- a/runtest/scsi_debug.part1
+++ b/runtest/scsi_debug.part1
@@ -1,5 +1,5 @@
 #DESCRIPTION:scsi_debug filesystem tests
-echo "----- Checking the Reiserfs -----"
+
 # Check the Reiserfs filesystem
 gf201 growfiles -W gf201 -d /test/growfiles/reiser -b -e 1 -u -i 0 -L 20 -w -C 1 -l -I r -T 10 glseek20 glseek20.2
 gf202 growfiles -W gf202 -d /test/growfiles/reiser -b -e 1 -L 10 -i 100 -I p -S 2 -u -f gf03_
-- 
2.14.1

