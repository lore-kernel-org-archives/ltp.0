From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 15 Jun 2021 18:33:05 +0200
Subject: [LTP] [RFC PATCH 1/3] tst_test.sh: Add $LTPROOT/testcases/bin into
 PATH
In-Reply-To: <20210615163307.10755-1-pvorel@suse.cz>
References: <20210615163307.10755-1-pvorel@suse.cz>
Message-ID: <20210615163307.10755-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

when LTPROOT set. Also TWARN when directory does not exist.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_test.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 8b4e9cb60..970eca7d1 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -697,6 +697,10 @@ if [ -z "$LTPROOT" ]; then
 	export LTPROOT="$PWD"
 	export TST_DATAROOT="$LTPROOT/datafiles"
 else
+	if [ ! -d "$LTPROOT/testcases/bin" ]; then
+		tst_res TWARN "$LTPROOT/testcases/bin does not exist, is \$LTPROOT properly set?"
+	fi
+	export PATH="$LTPROOT/testcases/bin:$PATH"
 	export TST_DATAROOT="$LTPROOT/testcases/data/$TST_ID"
 fi
 
-- 
2.32.0

