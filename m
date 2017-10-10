From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 10 Oct 2017 14:31:57 +0200
Subject: [LTP] [PATCH v2 07/15] syscalls/msync04: Run test for all
	filesystems
In-Reply-To: <20171010123205.20147-1-chrubis@suse.cz>
References: <20171010123205.20147-1-chrubis@suse.cz>
Message-ID: <20171010123205.20147-7-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/msync/msync04.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/syscalls/msync/msync04.c b/testcases/kernel/syscalls/msync/msync04.c
index 4f70ca1ef..9dec3c1d9 100644
--- a/testcases/kernel/syscalls/msync/msync04.c
+++ b/testcases/kernel/syscalls/msync/msync04.c
@@ -109,5 +109,6 @@ static struct tst_test test = {
 	.needs_root = 1,
 	.mntpoint = "msync04",
 	.mount_device = 1,
+	.all_filesystems = 1,
 	.min_kver = "2.6.25",
 };
-- 
2.13.5

