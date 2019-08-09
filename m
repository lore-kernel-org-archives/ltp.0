From: Yixin Zhang <yixin.zhang@intel.com>
Date: Fri,  9 Aug 2019 14:20:00 +0800
Subject: [LTP] [PATCH ltp 5/5] runtest/numa: rename duplicated test cases
In-Reply-To: <20190809062000.8671-1-yixin.zhang@intel.com>
References: <20190809062000.8671-1-yixin.zhang@intel.com>
Message-ID: <20190809062000.8671-5-yixin.zhang@intel.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

move_pages** is used in syscalls, rename them to move_pages**_numa here.

Signed-off-by: Yixin Zhang <yixin.zhang@intel.com>
---
 runtest/numa | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/runtest/numa b/runtest/numa
index 7885be90c..667eff773 100644
--- a/runtest/numa
+++ b/runtest/numa
@@ -1,16 +1,16 @@
 Numa-testcases numa01.sh
-move_pages01 move_pages01
-move_pages02 move_pages02
-move_pages03 move_pages03
-move_pages04 move_pages04
-move_pages05 move_pages05
-move_pages06 move_pages06
-move_pages07 move_pages07
-move_pages08 move_pages08
-move_pages09 move_pages09
-move_pages10 move_pages10
-move_pages11 move_pages11
-move_pages12 move_pages12
+move_pages01_numa move_pages01
+move_pages02_numa move_pages02
+move_pages03_numa move_pages03
+move_pages04_numa move_pages04
+move_pages05_numa move_pages05
+move_pages06_numa move_pages06
+move_pages07_numa move_pages07
+move_pages08_numa move_pages08
+move_pages09_numa move_pages09
+move_pages10_numa move_pages10
+move_pages11_numa move_pages11
+move_pages12_numa move_pages12
 
 set_mempolicy01 set_mempolicy01
 set_mempolicy02 set_mempolicy02
-- 
2.17.1

