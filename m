From: Xiao Yang <ice_yangxiao@163.com>
Date: Mon,  9 Dec 2019 14:35:22 +0800
Subject: [LTP] [PATCH] runtest/syscalls: Add vmsplice03 to runtest/syscalls
Message-ID: <20191209063522.12888-1-ice_yangxiao@163.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Xiao Yang <ice_yangxiao@163.com>
---
 runtest/syscalls | 1 +
 1 file changed, 1 insertion(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 15dbd9971..fa87ef63f 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1547,6 +1547,7 @@ vhangup02 vhangup02
 #vmsplice test cases
 vmsplice01 vmsplice01
 vmsplice02 vmsplice02
+vmsplice03 vmsplice03
 
 wait01 wait01
 wait02 wait02
-- 
2.21.0


