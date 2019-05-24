From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 24 May 2019 11:03:24 +0200
Subject: [LTP] [PATCH] [COMMITTED] syscalls/fcntl2*: Fix typo overlapfs ->
	overlayfs
Message-ID: <20190524090324.15975-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This is followup on:

commit 4eec12f480af98d5f1b56f8e163f2fef5b9938c3
Author: Cyril Hrubis <chrubis@suse.cz>
Date:   Thu May 23 15:42:35 2019 +0200

    syscalls/fcntl33: Fix typo overlapfs -> overlayfs

I should have done git grep before commiting the first one.

Reported-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/fcntl/fcntl24.c | 2 +-
 testcases/kernel/syscalls/fcntl/fcntl25.c | 2 +-
 testcases/kernel/syscalls/fcntl/fcntl26.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/fcntl/fcntl24.c b/testcases/kernel/syscalls/fcntl/fcntl24.c
index dff4009cf..63c716ff6 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl24.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl24.c
@@ -145,7 +145,7 @@ int main(int ac, char **av)
 		if (TEST_RETURN == -1) {
 			if (type == TST_OVERLAYFS_MAGIC && TEST_ERRNO == EAGAIN) {
 				tst_resm(TINFO | TTERRNO,
-					 "fcntl(F_SETLEASE, F_WRLCK) failed on overlapfs as expected");
+					 "fcntl(F_SETLEASE, F_WRLCK) failed on overlayfs as expected");
 			} else {
 				tst_resm(TFAIL,
 					"fcntl(%s, F_SETLEASE, F_WRLCK) Failed, errno=%d : %s",
diff --git a/testcases/kernel/syscalls/fcntl/fcntl25.c b/testcases/kernel/syscalls/fcntl/fcntl25.c
index 1592ed3d5..4917584c9 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl25.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl25.c
@@ -146,7 +146,7 @@ int main(int ac, char **av)
 		if (TEST_RETURN == -1) {
 			if (type == TST_OVERLAYFS_MAGIC && TEST_ERRNO == EAGAIN) {
 				tst_resm(TINFO | TTERRNO,
-					 "fcntl(F_SETLEASE, F_WRLCK) failed on overlapfs as expected");
+					 "fcntl(F_SETLEASE, F_WRLCK) failed on overlayfs as expected");
 			} else {
 				tst_resm(TFAIL,
 					 "fcntl(%s, F_SETLEASE, F_WRLCK) Failed, errno=%d : %s",
diff --git a/testcases/kernel/syscalls/fcntl/fcntl26.c b/testcases/kernel/syscalls/fcntl/fcntl26.c
index 28be4c362..ac74b5571 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl26.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl26.c
@@ -146,7 +146,7 @@ int main(int ac, char **av)
 		if (TEST_RETURN == -1) {
 			if (type == TST_OVERLAYFS_MAGIC && TEST_ERRNO == EAGAIN) {
 				tst_resm(TINFO | TTERRNO,
-					 "fcntl(F_SETLEASE, F_WRLCK) failed on overlapfs as expected");
+					 "fcntl(F_SETLEASE, F_WRLCK) failed on overlayfs as expected");
 			} else {
 				tst_resm(TFAIL,
 					"fcntl(%s, F_SETLEASE, F_WRLCK) Failed, errno=%d : %s",
-- 
2.19.2

