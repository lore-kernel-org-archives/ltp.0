From: Eryu Guan <eguan@redhat.com>
Date: Thu,  5 Nov 2015 22:35:00 +0800
Subject: [LTP] [PATCH 2/3] lib/test.sh: special case jfs in tst_mkfs
In-Reply-To: <1446734101-6175-1-git-send-email-eguan@redhat.com>
References: <1446734101-6175-1-git-send-email-eguan@redhat.com>
Message-ID: <1446734101-6175-2-git-send-email-eguan@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

jfs needs "-f" option too.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 testcases/lib/test.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/lib/test.sh b/testcases/lib/test.sh
index 6de39b9..31c99ee 100644
--- a/testcases/lib/test.sh
+++ b/testcases/lib/test.sh
@@ -271,7 +271,7 @@ tst_mkfs()
 	local device=$2
 	local fs_opts=""
 
-	if [ $fs_type = "xfs" ]; then
+	if [ $fs_type = "xfs" -o $fs_type = "jfs" ]; then
 		tst_resm TINFO "Appending '-f' flag to mkfs.$fs_type"
 		fs_opts="-f"
 	fi
-- 
2.5.0

