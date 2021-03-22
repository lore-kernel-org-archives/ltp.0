From: Xie Ziyao <xieziyao@huawei.com>
Date: Mon, 22 Mar 2021 17:15:12 +0800
Subject: [LTP] [PATCH] syscalls/chdir: bugfix for syscalls/chdir/chdir01.c
Message-ID: <20210322091512.103266-1-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add umask(0) before SAFE_MKDIR(DIR_NAME, 0755) to prevent the unexpected case failure when the system umask is set to some values, such as 0077.

Signed-off-by: Xie Ziyao <xieziyao@huawei.com>
---
 testcases/kernel/syscalls/chdir/chdir01.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/testcases/kernel/syscalls/chdir/chdir01.c b/testcases/kernel/syscalls/chdir/chdir01.c
index 60165a6cb..23cd455d6 100644
--- a/testcases/kernel/syscalls/chdir/chdir01.c
+++ b/testcases/kernel/syscalls/chdir/chdir01.c
@@ -55,8 +55,11 @@ static void setup(void)
 	sprintf(workdir, "%s/%s", cwd, MNTPOINT);
 	free(cwd);
 	SAFE_CHDIR(workdir);
+
+	mode_t sys_umask = umask(0);
 	SAFE_MKDIR(DIR_NAME, 0755);
 	SAFE_MKDIR(BLOCKED_NAME, 0644);
+	umask(sys_umask);

 	/* FAT and NTFS override file and directory permissions */
 	SAFE_STAT(BLOCKED_NAME, &statbuf);
--
2.17.1

