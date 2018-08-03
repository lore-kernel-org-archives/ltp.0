From: Sandeep Patil <sspatil@google.com>
Date: Fri,  3 Aug 2018 08:20:18 -0700
Subject: [LTP] [PATCH] fs: exclude 'wakeup_count' from read_all_sys test.
Message-ID: <20180803152018.13701-1-sspatil@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

/sys/power/wakeup_count semantics state that the read() for the file
will block as long as there is a wakeup_event in progress. On most
systems, this will be non deterministic and will result in extremely
flaky test. Exclude the file from read_all_sys test for the same.

Signed-off-by: Sandeep Patil <sspatil@google.com>
---
 runtest/fs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/runtest/fs b/runtest/fs
index a66948a43..aca7e355f 100644
--- a/runtest/fs
+++ b/runtest/fs
@@ -71,7 +71,7 @@ proc01 proc01 -m 128
 
 read_all_dev read_all -d /dev -p -q -r 10
 read_all_proc read_all -d /proc -q -r 10
-read_all_sys read_all -d /sys -q -r 10
+read_all_sys read_all -d /sys -q -r 10 -e /sys/power/wakeup_count
 
 #Run the File System Race Condition Check tests as well
 fs_racer fs_racer.sh -t 5
-- 
2.18.0.597.ga71716f1ad-goog

