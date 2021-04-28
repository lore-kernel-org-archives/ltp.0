From: Jinhui Huang <huangjh.jy@cn.fujitsu.com>
Date: Wed, 28 Apr 2021 13:56:51 +0800
Subject: [LTP] [PATCH] runtest/mm: Remove mem03 from runtest/mm
Message-ID: <1619589411-3349-1-git-send-email-huangjh.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Jinhui Huang <huangjh.jy@cn.fujitsu.com>
---
 runtest/mm | 1 -
 1 file changed, 1 deletion(-)

diff --git a/runtest/mm b/runtest/mm
index eeebd87..6537666 100644
--- a/runtest/mm
+++ b/runtest/mm
@@ -21,7 +21,6 @@ mtest06_3 mmap3 -x 0.002 -p
 #mtest-6_4 shmat1 -x 0.00005
 
 mem02 mem02
-mem03 mem03
 
 page01 page01
 page02 page02
-- 
1.8.3.1

