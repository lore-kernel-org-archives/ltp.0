From: Murphy Zhou <jencce.kernel@gmail.com>
Date: Wed,  5 Jun 2019 12:42:15 +0800
Subject: [LTP] [PATCH v2] syscalls/preadv2/preadv203: set mount_device flag
In-Reply-To: <20190604082331.uunxtzshdgcnv4xg@XZHOUW.usersys.redhat.com>
References: <20190604082331.uunxtzshdgcnv4xg@XZHOUW.usersys.redhat.com>
Message-ID: <20190605044215.19448-1-jencce.kernel@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Now the tests are running in MOUNTPOINT without it mounted.
Fails on ext2:
    preadv203.c does not set mount_device, which makes BROK:
      preadv203.c:122: BROK: preadv2() failed: EOPNOTSUPP

Signed-off-by: Murphy Zhou <jencce.kernel@gmail.com>
---
 testcases/kernel/syscalls/preadv2/preadv203.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/syscalls/preadv2/preadv203.c b/testcases/kernel/syscalls/preadv2/preadv203.c
index 810d1e8db..e4f68a51b 100644
--- a/testcases/kernel/syscalls/preadv2/preadv203.c
+++ b/testcases/kernel/syscalls/preadv2/preadv203.c
@@ -261,6 +261,7 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.test_all = verify_preadv2,
 	.mntpoint = MNTPOINT,
+	.mount_device = 1,
 	.all_filesystems = 1,
 	.needs_tmpdir = 1,
 	.needs_root = 1,
-- 
2.21.0

