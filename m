From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 22 Feb 2021 17:02:42 +0100
Subject: [LTP] [PATCH 3/4] io_uring02: Add linux-stable-git tag
In-Reply-To: <20210222160243.507-1-pvorel@suse.cz>
References: <20210222160243.507-1-pvorel@suse.cz>
Message-ID: <20210222160243.507-4-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/syscalls/io_uring/io_uring02.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/testcases/kernel/syscalls/io_uring/io_uring02.c b/testcases/kernel/syscalls/io_uring/io_uring02.c
index cd90fbdc3..5127ff980 100644
--- a/testcases/kernel/syscalls/io_uring/io_uring02.c
+++ b/testcases/kernel/syscalls/io_uring/io_uring02.c
@@ -19,6 +19,12 @@
  *  Date:   Fri Feb 7 16:05:21 2020 -0700
  *
  *  io_uring: grab ->fs as part of async preparation
+ *
+ * stable 5.4 specific backport:
+ *
+ *  commit c4a23c852e80a3921f56c6fbc851a21c84a6d06b
+ *  Author: Nicolai Stange <nstange@suse.de>
+ *  Date:   Wed Jan 27 14:34:43 2021 +0100
  */
 
 #include <stdio.h>
@@ -252,6 +258,7 @@ static struct tst_test test = {
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "9392a27d88b9"},
 		{"linux-git", "ff002b30181d"},
+		{"linux-stable-git", "c4a23c852e80"},
 		{"CVE", "2020-29373"},
 		{}
 	}
-- 
2.30.1

