From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 11 Oct 2019 11:54:37 +0200
Subject: [LTP] [PATCH v5 0/5] shell: Introduce TST_TIMEOUT variable
Message-ID: <20191011095442.10541-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

hopefully the latest version.

Changes v4->v5:
* remove float related code (left from v3)
* remove "tst_test_cmds cut" check from tst_test.sh (there is check for
cut and other later => it should be probably removed as well, but as a
separate patch) (Cyril)
* remove unneeded IFS from test (Cyril)
* mention ceiling LTP_TIMEOUT_MUL in doc/user-guide.txt

Here is the diff:
diff --git doc/user-guide.txt doc/user-guide.txt
index 8913c3221..7f6334ec2 100644
--- doc/user-guide.txt
+++ doc/user-guide.txt
@@ -15,7 +15,7 @@ For running LTP network tests see `testcases/network/README.md`.
                           'n' or '0': never colorize.
 | 'LTP_TIMEOUT_MUL'     | Multiply timeout, must be number >= 1 (> 1 is useful for
                           slow machines to avoid unexpected timeout).
-                          Variable is also used in shell tests.
+                          Variable is also used in shell tests, but here ceiled to int.
 | 'PATH'                | It's required to addjust path:
                           `PATH="$PATH:$LTPROOT/testcases/bin"`
 | 'TMPDIR'              | Base directory for template directory, which is required by C tests
diff --git lib/newlib_tests/shell/test_timeout.sh lib/newlib_tests/shell/test_timeout.sh
index 7e296f9e9..2cbc66412 100755
--- lib/newlib_tests/shell/test_timeout.sh
+++ lib/newlib_tests/shell/test_timeout.sh
@@ -15,8 +15,6 @@ echo "Testing timeout in shell API"
 echo
 
 failed=0
-IFS="
-"
 for i in $DATA; do
 	file=$(echo $i | cut -d'|' -f1)
 	timeout=$(echo $i | cut -d'|' -f2)
diff --git testcases/lib/tst_test.sh testcases/lib/tst_test.sh
index 977ffd97e..8713c1cdd 100644
--- testcases/lib/tst_test.sh
+++ testcases/lib/tst_test.sh
@@ -392,7 +392,6 @@ _tst_setup_timer()
 	tst_is_num "$LTP_TIMEOUT_MUL" || tst_brk TCONF "$err ($LTP_TIMEOUT_MUL)"
 
 	if ! tst_is_int "$LTP_TIMEOUT_MUL"; then
-		tst_test_cmds cut
 		LTP_TIMEOUT_MUL=$(echo "$LTP_TIMEOUT_MUL" | cut -d. -f1)
 		LTP_TIMEOUT_MUL=$((LTP_TIMEOUT_MUL+1))
 		tst_res TINFO "ceiling LTP_TIMEOUT_MUL to $LTP_TIMEOUT_MUL"
@@ -403,13 +402,7 @@ _tst_setup_timer()
 		tst_brk TBROK "TST_TIMEOUT must be int >= 1! ($TST_TIMEOUT)"
 	fi
 
-	local sec
-	if [ "$is_float" ]; then
-		sec=`echo | awk '{printf("%d\n", '$TST_TIMEOUT' * '$LTP_TIMEOUT_MUL'+ 0.5)}'`
-	else
-		sec=$((TST_TIMEOUT * LTP_TIMEOUT_MUL))
-	fi
-
+	local sec=$((TST_TIMEOUT * LTP_TIMEOUT_MUL))
 	local h=$((sec / 3600))
 	local m=$((sec / 60 % 60))
 	local s=$((sec % 60))


Petr Vorel (5):
  shell: Add tst_is_num()
  shell: Introduce TST_TIMEOUT variable, add checks
  shell: Add timeout shell API tests
  memcg_stress_test.sh: use TST_TIMEOUT (replace LTP_TIMEOUT_MUL)
  net/if-mtu-change.sh: set TST_TIMEOUT

 doc/test-writing-guidelines.txt               | 14 ++++++--
 doc/user-guide.txt                            |  2 +-
 lib/newlib_tests/shell/test_timeout.sh        | 36 +++++++++++++++++++
 lib/newlib_tests/shell/timeout01.sh           | 13 +++++++
 lib/newlib_tests/shell/timeout02.sh           | 13 +++++++
 .../memcg/stress/memcg_stress_test.sh         |  2 +-
 testcases/lib/tst_test.sh                     | 32 +++++++++++++++--
 .../network/stress/interface/if-mtu-change.sh |  4 ++-
 8 files changed, 108 insertions(+), 8 deletions(-)
 create mode 100755 lib/newlib_tests/shell/test_timeout.sh
 create mode 100755 lib/newlib_tests/shell/timeout01.sh
 create mode 100755 lib/newlib_tests/shell/timeout02.sh

-- 
2.23.0

