From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Tue, 16 Feb 2021 07:47:47 +0000
Subject: [LTP] [PATCH v2 1/2] close_range01: Drop CAP_SYS_ADMIN
Message-ID: <20210216074748.6873-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
---

V2: Try Closing the path file descriptor at the end if it was opened
    to prevent hitting the FD limit with -i

 testcases/kernel/syscalls/close_range/close_range01.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/testcases/kernel/syscalls/close_range/close_range01.c b/testcases/kernel/syscalls/close_range/close_range01.c
index f4be60bb3..56def2426 100644
--- a/testcases/kernel/syscalls/close_range/close_range01.c
+++ b/testcases/kernel/syscalls/close_range/close_range01.c
@@ -197,6 +197,10 @@ static struct tst_test test = {
 	.all_filesystems = 1,
 	.needs_root = 1,
 	.test = run,
+	.caps = (struct tst_cap []) {
+		TST_CAP(TST_CAP_DROP, CAP_SYS_ADMIN),
+		{}
+	},
 	.taint_check = TST_TAINT_W | TST_TAINT_D,
 	.setup = setup,
 	.tags = (const struct tst_tag[]) {
-- 
2.30.0

