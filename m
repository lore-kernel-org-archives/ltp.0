From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 15 Apr 2020 16:08:54 +0800
Subject: [LTP] [PATCH 2/2] syscalls/quotactl04.c: Specify inode size for
 prjquota feature
In-Reply-To: <20200415080854.65971-1-yangx.jy@cn.fujitsu.com>
References: <20200415080854.65971-1-yangx.jy@cn.fujitsu.com>
Message-ID: <20200415080854.65971-2-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Background:
1) LTP uses default 256M filesystem to run test.
2) Mke2fs sets inode size to 128 bytes for small filesystem(e.g. 256M) usually.
3) Prjquota feature requires bigger inode size which is at least 256 bytes.

new mke2fs can adjust inode size to 256M automatically by commit 66aae96 in
e2fsprogs, but old mke2fs cannot do it and reports the following error:
-----------------------------------------------------------
mke2fs 1.43.4 (31-Jan-2017)
mkfs.ext4: 128 byte inodes are too small for project quota; specify larger size
-----------------------------------------------------------

Make quotactl04 with old mke2fs works by specifying inode size to 256 bytes.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/quotactl/quotactl04.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/quotactl/quotactl04.c b/testcases/kernel/syscalls/quotactl/quotactl04.c
index b0db8fe5d..73980d7e9 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl04.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl04.c
@@ -102,7 +102,7 @@ static struct tcase {
 
 static void setup(void)
 {
-	const char *const fs_opts[] = {"-O quota,project", NULL};
+	const char *const fs_opts[] = {"-I 256", "-O quota,project", NULL};
 
 	test_id = geteuid();
 	SAFE_MKFS(tst_device->dev, tst_device->fs_type, fs_opts, NULL);
-- 
2.25.1



