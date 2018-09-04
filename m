From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue,  4 Sep 2018 17:59:31 +0200
Subject: [LTP] [COMMITTED] [PATCH] lapi/syscalls: Fix typo in arm.in
Message-ID: <20180904155931.7116-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This has been introduced in:

commit 0d28feaac245064cdcbd0c3602a1737751348ebe
Author: vaishnavid <vaishnavi.d@zilogic.com>
Date:   Mon Sep 3 12:16:31 2018 +0000

    syscalls: Prepare for testing statx syscall

And caught by our travis.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/lapi/syscalls/arm.in | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/lapi/syscalls/arm.in b/include/lapi/syscalls/arm.in
index 807a52af9..0a7f98ac5 100644
--- a/include/lapi/syscalls/arm.in
+++ b/include/lapi/syscalls/arm.in
@@ -343,4 +343,4 @@ memfd_create (__NR_SYSCALL_BASE+385)
 execveat (__NR_SYSCALL_BASE+387)
 mlock2 (__NR_SYSCALL_BASE+390)
 copy_file_range (__NR_SYSCALL_BASE+391)
-statx (__NR_SYSCALL+397)
+statx (__NR_SYSCALL_BASE+397)
-- 
2.16.4

