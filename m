From: Masayoshi Mizuma <msys.mizuma@gmail.com>
Date: Wed, 15 Aug 2018 14:55:16 -0400
Subject: [LTP] [PATCH] ver_linux: use lscpu command result instead of
	/proc/cpuinfo
Message-ID: <20180815185516.32726-1-msys.mizuma@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

lscpu command shows the cpu information clearly. So let's use
the result if the command is installed to the system.

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
---
 ver_linux | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/ver_linux b/ver_linux
index dda337926..5f9260f5f 100755
--- a/ver_linux
+++ b/ver_linux
@@ -96,5 +96,10 @@ echo 'free reports:'
 free
 
 echo
-echo '/proc/cpuinfo'
-cat /proc/cpuinfo
+echo 'cpuinfo:'
+which lscpu > /dev/null 2>&1
+if [ $? -eq 0 ]; then
+	lscpu
+else
+	cat /proc/cpuinfo
+fi
-- 
2.18.0

