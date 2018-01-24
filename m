From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 24 Jan 2018 15:04:07 +0800
Subject: [LTP] [PATCH] lapi/aarch64.in: Fix incorrect syscall number for
	copy_file_range
Message-ID: <1516777447-24314-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

64-bit ARM should use the generic syscall number which is 285.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 include/lapi/syscalls/aarch64.in | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/lapi/syscalls/aarch64.in b/include/lapi/syscalls/aarch64.in
index 8b725e3..1f45839 100644
--- a/include/lapi/syscalls/aarch64.in
+++ b/include/lapi/syscalls/aarch64.in
@@ -256,4 +256,4 @@ sendmmsg 269
 kcmp 272
 getrandom 278
 memfd_create 279
-copy_file_range 391
+copy_file_range 285
-- 
1.8.3.1



