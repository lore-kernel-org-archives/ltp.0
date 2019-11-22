From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 22 Nov 2019 10:56:58 +0100
Subject: [LTP] [COMMITTED] [PATCH] network/fanout01: Add CVE and git tags
Message-ID: <20191122095658.20836-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/network/packet/fanout01.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/testcases/network/packet/fanout01.c b/testcases/network/packet/fanout01.c
index f5ce19a12..5067d83a8 100644
--- a/testcases/network/packet/fanout01.c
+++ b/testcases/network/packet/fanout01.c
@@ -106,4 +106,10 @@ static struct tst_test test = {
 	.test_all = run,
 	.cleanup = cleanup,
 	.needs_root = 1,
+	.tags = (const struct tst_tag[]) {
+		{"CVE", "2017-15649"},
+		{"linux-git", "4971613c1639"},
+		{"linux-git", "008ba2a13f2d"},
+		{}
+	}
 };
-- 
2.21.0

