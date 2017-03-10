From: Li Wang <liwang@redhat.com>
Date: Fri, 10 Mar 2017 14:59:15 +0800
Subject: [LTP] [PATCH] ioctl06: fix a typo in runtest/syscalls
Message-ID: <20170310065915.4422-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Li Wang <liwang@redhat.com>
---
 runtest/syscalls | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/runtest/syscalls b/runtest/syscalls
index 931a354..89abac5 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -455,7 +455,7 @@ ioctl01_02   test_ioctl
 ioctl03      ioctl03
 ioctl04      ioctl04
 ioctl05      ioctl05
-ioctl05      ioctl06
+ioctl06      ioctl06
 
 inotify_init1_01 inotify_init1_01
 inotify_init1_02 inotify_init1_02
-- 
2.9.3

