From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 26 Nov 2020 22:41:16 +0100
Subject: [LTP] [PATCH v4 1/6] fanotify12: Drop incorrect hint
In-Reply-To: <20201126214121.6836-1-pvorel@suse.cz>
References: <20201126214121.6836-1-pvorel@suse.cz>
Message-ID: <20201126214121.6836-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

hint "CONFIG_FANOTIFY_ACCESS_PERMISSIONS not configured in kernel?"
is wrong here (fanotify12 does not use FAN_ACCESS_PERM).

Suggested-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v3->v4:
Removed second CONFIG_FANOTIFY_ACCESS_PERMISSIONS

 testcases/kernel/syscalls/fanotify/fanotify12.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify12.c b/testcases/kernel/syscalls/fanotify/fanotify12.c
index fcb7ec0d3..fea7cb607 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify12.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify12.c
@@ -146,10 +146,6 @@ static int setup_mark(unsigned int n)
 					"FAN_OPEN_EXEC not supported in "
 					"kernel?");
 				return -1;
-			} else if (errno == EINVAL) {
-				tst_brk(TCONF | TERRNO,
-					"CONFIG_FANOTIFY_ACCESS_PERMISSIONS "
-					"not configured in kernel?");
 			}else {
 				tst_brk(TBROK | TERRNO,
 					"fanotify_mark(%d, FAN_MARK_ADD | %s, "
@@ -173,11 +169,6 @@ static int setup_mark(unsigned int n)
 						"FAN_OPEN_EXEC not supported "
 						"in kernel?");
 					return -1;
-				} else if (errno == EINVAL) {
-					tst_brk(TCONF | TERRNO,
-						"CONFIG_FANOTIFY_ACCESS_"
-						"PERMISSIONS not configured in "
-						"kernel?");
 				} else {
 					tst_brk(TBROK | TERRNO,
 						"fanotify_mark (%d, "
-- 
2.29.2

