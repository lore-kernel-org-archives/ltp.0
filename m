From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu,  5 Mar 2020 14:37:49 +0100
Subject: [LTP] [COMMITTED] [PATCH] timerfd/timerfd_settime02: Add a
 .gitignore entry
Message-ID: <20200305133749.15167-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/timerfd/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/syscalls/timerfd/.gitignore b/testcases/kernel/syscalls/timerfd/.gitignore
index e5c819ced..1c5329966 100644
--- a/testcases/kernel/syscalls/timerfd/.gitignore
+++ b/testcases/kernel/syscalls/timerfd/.gitignore
@@ -4,3 +4,4 @@
 /timerfd_create01
 /timerfd_gettime01
 /timerfd_settime01
+/timerfd_settime02
-- 
2.23.0

