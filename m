From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 22 Nov 2019 11:05:08 +0100
Subject: [LTP] [COMMITTED] [PATCH] network/sctp_big_chunk: Add linux git tag
Message-ID: <20191122100508.21265-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/network/sctp/sctp_big_chunk.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/testcases/network/sctp/sctp_big_chunk.c b/testcases/network/sctp/sctp_big_chunk.c
index 4ebdcb20f..ceb91c5b9 100644
--- a/testcases/network/sctp/sctp_big_chunk.c
+++ b/testcases/network/sctp/sctp_big_chunk.c
@@ -182,5 +182,9 @@ static struct tst_test test = {
 	.setup = setup,
 	.forks_child = 1,
 	.test_all = run,
-	.options = options
+	.options = options,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "07f2c7ab6f8d"},
+		{}
+	}
 };
-- 
2.21.0

