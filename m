From: Sandeep Patil <sspatil@google.com>
Date: Mon, 28 Aug 2017 17:11:26 -0700
Subject: [LTP] [RFC][PATCH 2/2] access04: use the new tmpfs mount for EROFS
	testing
In-Reply-To: <20170829001126.142076-1-sspatil@google.com>
References: <20170829001126.142076-1-sspatil@google.com>
Message-ID: <20170829001126.142076-3-sspatil@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Use the 'tmpfs' read-only mount to test for EROFS return from
system call instead of finding a loop device and create, format,
mount a file system

Signed-off-by: Sandeep Patil <sspatil@google.com>
---
 testcases/kernel/syscalls/access/access04.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/access/access04.c b/testcases/kernel/syscalls/access/access04.c
index dbb6d271a..b369a952f 100644
--- a/testcases/kernel/syscalls/access/access04.c
+++ b/testcases/kernel/syscalls/access/access04.c
@@ -125,9 +125,9 @@ static struct tst_test test = {
 	.needs_tmpdir = 1,
 	.needs_root = 1,
 	.forks_child = 1,
-	.mount_device = 1,
-	.mntpoint = MNT_POINT,
-	.mnt_flags = MS_RDONLY,
+	.mount_tmpfs = 1,
+	.tmpfs_mntpoint = MNT_POINT,
+	.tmpfs_flags = MS_RDONLY,
 	.setup = setup,
 	.test = verify_access,
 };
-- 
2.14.1.342.g6490525c54-goog

