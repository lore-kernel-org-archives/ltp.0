From: kai.kang@windriver.com <kai.kang@windriver.com>
Date: Mon, 12 Nov 2018 15:56:00 +0800
Subject: [LTP] [PATCH v2] msgstress04: correct the logic to use all values
	in keyarray
Message-ID: <20181112075600.1155-1-kai.kang@windriver.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Kai Kang <kai.kang@windriver.com>

There are some problems of the logic to use all values in keyarray. It
fails to run:

$ ./msgstress04 -n 1 -c 1 -l 1

Only the first MSGMNI members of keyarray are initialized. But it will
use the member whose index exceeds MSGMNI in keyarray.

Correct the logic to make sure to use the initialized members of
keyarray.

Signed-off-by: Kai Kang <kai.kang@windriver.com>
---
 testcases/kernel/syscalls/ipc/msgstress/msgstress04.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/ipc/msgstress/msgstress04.c b/testcases/kernel/syscalls/ipc/msgstress/msgstress04.c
index 18fad4fbd..81383d6c8 100644
--- a/testcases/kernel/syscalls/ipc/msgstress/msgstress04.c
+++ b/testcases/kernel/syscalls/ipc/msgstress/msgstress04.c
@@ -176,11 +176,11 @@ int main(int argc, char **argv)
 	} else {
 		for (i = 0; i < (MSGMNI / maxnprocs); i++) {
 			nprocs = maxnprocs;
-			dotest_iteration(i*(MSGMNI / maxnprocs));
+			dotest_iteration(i * maxnprocs);
 		}
 
 		nprocs = MSGMNI % maxnprocs;
-		dotest_iteration(i*(MSGMNI / maxnprocs));
+		dotest_iteration(i * maxnprocs);
 	}
 
 	tst_resm(TPASS, "Test ran successfully!");
-- 
2.17.0

