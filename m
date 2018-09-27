From: Masayoshi Mizuma <msys.mizuma@gmail.com>
Date: Thu, 27 Sep 2018 10:08:37 -0400
Subject: [LTP] [PATCH v2] ver_linux: use lscpu command result instead of
	/proc/cpuinfo
Message-ID: <20180927140837.24642-1-msys.mizuma@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

lscpu command shows the cpu information clearly. So let's
use the result if the command is installed to the system.

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
---
 ver_linux | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/ver_linux b/ver_linux
index dda337926..320b624a1 100755
--- a/ver_linux
+++ b/ver_linux
@@ -96,5 +96,9 @@ echo 'free reports:'
 free
 
 echo
-echo '/proc/cpuinfo'
-cat /proc/cpuinfo
+echo 'cpuinfo:'
+if which lscpu > /dev/null 2>&1; then
+	lscpu
+else
+	cat /proc/cpuinfo
+fi
-- 
2.19.0

