From: Eryu Guan <eguan@redhat.com>
Date: Wed, 24 May 2017 21:23:48 +0800
Subject: [LTP] [PATCH] syscalls/lseek11: take EOPNOTSUPP as not supported too
Message-ID: <20170524132348.8564-1-eguan@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Filesystems could set errno to EOPNOTSUPP to indicate SEEK_DATA/HOLE
operations are not supported by this fs, e.g. NFSv4.0/v4.1, so exit
test with TCONF when EOPNOTSUPP is returned.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 testcases/kernel/syscalls/lseek/lseek11.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/lseek/lseek11.c b/testcases/kernel/syscalls/lseek/lseek11.c
index 47987c1..54d5da6 100644
--- a/testcases/kernel/syscalls/lseek/lseek11.c
+++ b/testcases/kernel/syscalls/lseek/lseek11.c
@@ -119,7 +119,7 @@ static void get_blocksize(void)
 		SAFE_FSYNC(fd);
 		pos = lseek(fd, 0, SEEK_DATA);
 		if (pos == -1) {
-			if (errno == EINVAL) {
+			if (errno == EINVAL || errno == EOPNOTSUPP) {
 				tst_brk(TCONF | TERRNO, "SEEK_DATA "
 					"and SEEK_HOLE not implemented");
 			}
-- 
2.9.4

