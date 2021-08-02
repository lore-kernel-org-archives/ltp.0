From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Mon,  2 Aug 2021 12:57:26 +0100
Subject: [LTP] [PATCH] setsockopt03: Add Git and CVE tags
Message-ID: <20210802115726.683-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 testcases/kernel/syscalls/setsockopt/setsockopt03.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt03.c b/testcases/kernel/syscalls/setsockopt/setsockopt03.c
index 14fdf400b..3d49628d6 100644
--- a/testcases/kernel/syscalls/setsockopt/setsockopt03.c
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt03.c
@@ -114,4 +114,8 @@ static struct tst_test test = {
 	.setup = setup,
 	.test_all = run,
 	.needs_root = 1,
+	.tags = (const struct tst_tag[]){
+		{"linux-git", "ce683e5f9d04"},
+		{"CVE", "CVE-2016-4997"},
+	}
 };
-- 
2.31.1

