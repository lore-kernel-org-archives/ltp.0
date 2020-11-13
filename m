From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 13 Nov 2020 16:51:19 +0100
Subject: [LTP] [PATCH v2 1/5] fanotify12: Drop incorrect hint
In-Reply-To: <20201113155123.5959-1-pvorel@suse.cz>
References: <20201113155123.5959-1-pvorel@suse.cz>
Message-ID: <20201113155123.5959-2-pvorel@suse.cz>
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
New in v2.

 testcases/kernel/syscalls/fanotify/fanotify12.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify12.c b/testcases/kernel/syscalls/fanotify/fanotify12.c
index fcb7ec0d3..7f23fc9dc 100644
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
-- 
2.29.2

