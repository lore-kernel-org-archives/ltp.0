From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 15 Mar 2021 15:49:09 +0100
Subject: [LTP] [COMITTED] [PATCH] mem/thp01: Add git and CVE tags
Message-ID: <20210315144909.9001-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/mem/thp/thp01.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/testcases/kernel/mem/thp/thp01.c b/testcases/kernel/mem/thp/thp01.c
index db7256050..2e75f85e3 100644
--- a/testcases/kernel/mem/thp/thp01.c
+++ b/testcases/kernel/mem/thp/thp01.c
@@ -138,4 +138,9 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = thp_test,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "a7d6e4ecdb76"},
+		{"CVE", "2011-0999"},
+		{}
+	}
 };
-- 
2.26.2

