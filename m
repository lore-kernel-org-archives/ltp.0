From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 5 Sep 2018 10:48:25 +0800
Subject: [LTP] [PATCH] lapi/powerpc64.in: Fix wrong syscall number for statx
Message-ID: <1536115705-2024-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 include/lapi/syscalls/powerpc64.in | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/lapi/syscalls/powerpc64.in b/include/lapi/syscalls/powerpc64.in
index 80fa91882..c0b4226eb 100644
--- a/include/lapi/syscalls/powerpc64.in
+++ b/include/lapi/syscalls/powerpc64.in
@@ -349,4 +349,4 @@ getrandom 359
 memfd_create 360
 mlock2 378
 copy_file_range 379
-statx 360
+statx 383
-- 
2.17.0



