From: Punit Agrawal <punit.agrawal@arm.com>
Date: Thu, 26 Oct 2017 15:14:43 +0100
Subject: [LTP] [PATCH 14/18] ioctl: fix stty usage for busybox
In-Reply-To: <20171026141447.26749-1-punit.agrawal@arm.com>
References: <20171026141447.26749-1-punit.agrawal@arm.com>
Message-ID: <20171026141447.26749-15-punit.agrawal@arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Mark Rutland <mark.rutland@arm.com>

The ioctl tests rely on stty to test if a tty is usable, and use the
long form "--file=" flag to tell stty which tty to test. Busybox doesn't
understand the long "--file=" flag, and this causes the LTP test harness
to skip tests:

> stty: invalid argument '--file=/dev/tty0'
> ioctl01_02    0  TINFO  :  Skipping ioctl01 with /dev/tty0

Luckily, both busybox stty and GNU stty understand the equivalent "-F"
flag. This patch makes LTP use this more common option.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
---
 testcases/kernel/syscalls/ioctl/test_ioctl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/ioctl/test_ioctl b/testcases/kernel/syscalls/ioctl/test_ioctl
index 1151b55eb..923275433 100755
--- a/testcases/kernel/syscalls/ioctl/test_ioctl
+++ b/testcases/kernel/syscalls/ioctl/test_ioctl
@@ -26,7 +26,7 @@ export TST_COUNT=0
 has_tty()
 {
     if command -v stty >/dev/null 2>&1; then
-        stty --file=$1 > /dev/null
+        stty -F $1 > /dev/null
         if [ $? -ne 0 ]; then
             return 0
         fi
-- 
2.14.2

