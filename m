From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 13 Apr 2021 19:29:16 +0200
Subject: [LTP] [PATCH 2/2] [COMMITTED] syscalls/p{read,
 write}v03: Skip test on tmpfs
In-Reply-To: <20210413172916.24434-1-chrubis@suse.cz>
References: <20210413172916.24434-1-chrubis@suse.cz>
Message-ID: <20210413172916.24434-2-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Since open with O_DIRECT returns EINVAL on tmpfs.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/preadv/preadv03.c   | 4 ++++
 testcases/kernel/syscalls/pwritev/pwritev03.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/testcases/kernel/syscalls/preadv/preadv03.c b/testcases/kernel/syscalls/preadv/preadv03.c
index c456d4105..59c3b84f7 100644
--- a/testcases/kernel/syscalls/preadv/preadv03.c
+++ b/testcases/kernel/syscalls/preadv/preadv03.c
@@ -135,4 +135,8 @@ static struct tst_test test = {
 	.mntpoint = MNTPOINT,
 	.mount_device = 1,
 	.all_filesystems = 1,
+	.skip_filesystems = (const char *[]) {
+		"tmpfs",
+		NULL
+	}
 };
diff --git a/testcases/kernel/syscalls/pwritev/pwritev03.c b/testcases/kernel/syscalls/pwritev/pwritev03.c
index f32c368c0..91a5e3c54 100644
--- a/testcases/kernel/syscalls/pwritev/pwritev03.c
+++ b/testcases/kernel/syscalls/pwritev/pwritev03.c
@@ -134,4 +134,8 @@ static struct tst_test test = {
 	.mntpoint = MNTPOINT,
 	.mount_device = 1,
 	.all_filesystems = 1,
+	.skip_filesystems = (const char *[]){
+		"tmpfs",
+		NULL
+	}
 };
-- 
2.26.3

