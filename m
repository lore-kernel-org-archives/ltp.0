From: Petr Vorel <pvorel@suse.cz>
Date: Wed,  2 May 2018 15:45:53 +0200
Subject: [LTP] [RFC PATCH 1/1] tst_test.sh: TCONF on basename error when
	setting TST_ID
Message-ID: <20180502134553.5429-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

'basename $0' fails when loaded in command line with bash (at least)
as $0 is invalid ('-bash'):

    $ unset TST_ID; export TST_NO_DEFAULT_RUN=1; . tst_test.sh
    -bash: tst_ansi_color.sh: No such file or directory
    basename: invalid option -- 'b'
    Try 'basename --help' for more information.

It's better to TCONF than be without TST_ID.

NOTE: Sourcing tst_test.sh can be needed for network scripts: users
might want to set network variables with tst_net.sh, which itself
sources tst_test.sh.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_test.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 8d49d34b6..39744d29e 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -377,7 +377,8 @@ tst_run()
 }
 
 if [ -z "$TST_ID" ]; then
-	filename=$(basename $0)
+	filename=$(basename $0) || \
+		tst_brk TBROK "Failed to set TST_ID from \$0 ('$0'), fix it with setting TST_ID before sourcing tst_test.sh"
 	TST_ID=${filename%%.*}
 fi
 export TST_ID="$TST_ID"
-- 
2.16.3

