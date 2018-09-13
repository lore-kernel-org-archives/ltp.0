From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 13 Sep 2018 10:30:48 +0200
Subject: [LTP] [PATCH] syscalls/mmap15: relax condition a bit
Message-ID: <1fbbf1d06b0e08fc2b078c0ad24f2dd2111348c3.1536827409.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

High address is arch specific, and it also occasionally changes
as can be seen in history of this test.

Relax the condition and accept both ENOMEM and EINVAL
as expected outcome.

Fixes: #390

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/mmap/mmap15.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/mmap/mmap15.c b/testcases/kernel/syscalls/mmap/mmap15.c
index eff27d6585e0..c8a77873a254 100644
--- a/testcases/kernel/syscalls/mmap/mmap15.c
+++ b/testcases/kernel/syscalls/mmap/mmap15.c
@@ -80,10 +80,9 @@ int main(int ac, char **av)
 			continue;
 		}
 
-		if (errno != ENOMEM) {
+		if (errno != ENOMEM && errno != EINVAL) {
 			tst_resm(TFAIL | TERRNO, "mmap into high region "
-				 "failed unexpectedly - expect "
-				 "errno=ENOMEM, got");
+				 "failed unexpectedly");
 		} else {
 			tst_resm(TPASS | TERRNO, "mmap into high region "
 				 "failed as expected");
-- 
1.8.3.1

