From: Yixin Zhang <yixin.zhang@intel.com>
Date: Tue,  9 Jul 2019 10:15:45 +0800
Subject: [LTP] [PATCH ltp] syscalls/stat: add stat02{,_64} into .gitignore
Message-ID: <20190709021545.23772-1-yixin.zhang@intel.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Yixin Zhang <yixin.zhang@intel.com>
---
 testcases/kernel/syscalls/stat/.gitignore | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/testcases/kernel/syscalls/stat/.gitignore b/testcases/kernel/syscalls/stat/.gitignore
index 4a8f61858..fa0a4ce9f 100644
--- a/testcases/kernel/syscalls/stat/.gitignore
+++ b/testcases/kernel/syscalls/stat/.gitignore
@@ -1,4 +1,6 @@
 /stat01
 /stat01_64
+/stat02
+/stat02_64
 /stat03
 /stat03_64
-- 
2.17.1

