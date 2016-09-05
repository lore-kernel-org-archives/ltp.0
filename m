From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon,  5 Sep 2016 17:24:14 +0200
Subject: [LTP] [PATCH 5/6] memcg_lib.sh: Remove subdirectories in cleanup
In-Reply-To: <1473089055-17782-1-git-send-email-chrubis@suse.cz>
References: <1473089055-17782-1-git-send-email-chrubis@suse.cz>
Message-ID: <1473089055-17782-5-git-send-email-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Some tests create subdirectories in the memcg directory created for the
testcase, namely the move_charge_at_immigrate ones. Hence we need to
remove all subdirectories before we attempt to remove the test
directory. Otherwise the test will not clean up properly on TBROK.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/controllers/memcg/functional/memcg_lib.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
index 1bf0143..b785fe3 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
@@ -57,6 +57,12 @@ cleanup()
 	cd "$TMP_DIR"
 
 	if [ -n "$TEST_ID" -a -d "/dev/memcg/$TEST_ID" ]; then
+		for i in "/dev/memcg/$TEST_ID/"*; do
+			if [ -d "$i" ]; then
+				rmdir "$i"
+			fi
+		done
+
 		rmdir "/dev/memcg/$TEST_ID"
 	fi
 
-- 
2.7.3

