From: Sandeep Patil <sspatil@google.com>
Date: Mon, 18 Sep 2017 09:56:30 -0700
Subject: [LTP] [RESEND][PATCH v3 2/2] syscalls/access04: use .needs_rofs
	flag for EROFS testing
In-Reply-To: <20170918165630.134076-1-sspatil@google.com>
References: <20170918165630.134076-1-sspatil@google.com>
Message-ID: <20170918165630.134076-3-sspatil@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Prefer to use the read-only bind mount of '/' over create,
format and mount a filesystem image for testing 'EROFS' return
value from access()

Signed-off-by: Sandeep Patil <sspatil@google.com>
---
 testcases/kernel/syscalls/access/access04.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/access/access04.c b/testcases/kernel/syscalls/access/access04.c
index dbb6d271a..626e6df2c 100644
--- a/testcases/kernel/syscalls/access/access04.c
+++ b/testcases/kernel/syscalls/access/access04.c
@@ -125,9 +125,8 @@ static struct tst_test test = {
 	.needs_tmpdir = 1,
 	.needs_root = 1,
 	.forks_child = 1,
-	.mount_device = 1,
+	.needs_rofs = 1,
 	.mntpoint = MNT_POINT,
-	.mnt_flags = MS_RDONLY,
 	.setup = setup,
 	.test = verify_access,
 };
-- 
2.14.1.690.gbb1197296e-goog

