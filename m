From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 19 Jun 2019 14:31:48 +0200
Subject: [LTP] [PATCH 2/2] syscalls/sync_file_range02: Skip test on fuse.
In-Reply-To: <20190619123148.29733-1-chrubis@suse.cz>
References: <20190619123148.29733-1-chrubis@suse.cz>
Message-ID: <20190619123148.29733-3-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The syscall is not implemented on FUSE, as a matter of fact it returns
with success but does nothing so we even cannot detect if it's
implemented or not so let's just skip it.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
CC: Amir Goldstein <amir73il@gmail.com>
CC: Sumit Garg <sumit.garg@linaro.org>
---
 testcases/kernel/syscalls/sync_file_range/sync_file_range02.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/syscalls/sync_file_range/sync_file_range02.c b/testcases/kernel/syscalls/sync_file_range/sync_file_range02.c
index d4c29f9c2..eb08143c3 100644
--- a/testcases/kernel/syscalls/sync_file_range/sync_file_range02.c
+++ b/testcases/kernel/syscalls/sync_file_range/sync_file_range02.c
@@ -121,6 +121,7 @@ static struct tst_test test = {
 	.needs_root = 1,
 	.mount_device = 1,
 	.all_filesystems = 1,
+	.dev_fs_flags = TST_FS_SKIP_FUSE,
 	.mntpoint = MNTPOINT,
 	.setup = setup,
 	.test = run,
-- 
2.19.2

