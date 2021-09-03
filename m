From: Petr Vorel <pvorel@suse.cz>
Date: Fri,  3 Sep 2021 13:09:20 +0200
Subject: [LTP] [PATCH 1/1] tst_test.sh: Use command -v instead of type
Message-ID: <20210903110920.28178-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

to avoid checkbashisms warnings.

`type' is part of POSIX, but as part of the X/Open Systems Interfaces
option (XSI) [1]. As Stephen Kitt noted [2] quoting man checkbashisms(1):

    Note that the definition of a bashism in this context roughly
    equates to "a shell feature that is not required to be supported
    by POSIX"; this means that some issues flagged may be permitted
    under optional sections of POSIX, such as XSI or User Portability.

=> `type' is flagged because it is an optional feature.

`command -v' is POSIX (no XSI extension) [3] and we already started to
using it instead of which (e7302676f, f6cac3660).

[1] https://pubs.opengroup.org/onlinepubs/9699919799/utilities/type.html
[2] https://unix.stackexchange.com/a/667293
[3] https://pubs.opengroup.org/onlinepubs/9699919799/utilities/command.html

Cc: Stephen Kitt <steve@sk2.org>
Suggested-by: Adam Katz <khopesh@apache.org>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

this is a replacement to the original patch [4], which removed 'type'
from checkbashisms. While other issues reported by Joerg [5] are likely
checkbashisms false positives / bugs, this one is valid, thus I'd start
using command -v.

Kind regards,
Petr

[4] https://patchwork.ozlabs.org/project/ltp/patch/20210902115837.2199-1-pvorel@suse.cz/
[5] https://patchwork.ozlabs.org/comment/2745374/

 testcases/lib/tst_test.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index acf62c9ac..8f69b0551 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -30,7 +30,7 @@ _tst_do_exit()
 	TST_DO_EXIT=1
 
 	if [ -n "$TST_DO_CLEANUP" -a -n "$TST_CLEANUP" -a -z "$TST_NO_CLEANUP" ]; then
-		if type $TST_CLEANUP >/dev/null 2>/dev/null; then
+		if command -v $TST_CLEANUP >/dev/null 2>/dev/null; then
 			$TST_CLEANUP
 		else
 			tst_res TWARN "TST_CLEANUP=$TST_CLEANUP declared, but function not defined (or cmd not found)"
@@ -691,7 +691,7 @@ tst_run()
 	[ -n "$TST_NEEDS_CHECKPOINTS" ] && _tst_init_checkpoints
 
 	if [ -n "$TST_SETUP" ]; then
-		if type $TST_SETUP >/dev/null 2>/dev/null; then
+		if command -v $TST_SETUP >/dev/null 2>/dev/null; then
 			TST_DO_CLEANUP=1
 			$TST_SETUP
 		else
@@ -723,7 +723,7 @@ _tst_run_tests()
 
 	TST_DO_CLEANUP=1
 	for _tst_i in $(seq ${TST_CNT:-1}); do
-		if type ${TST_TESTFUNC}1 > /dev/null 2>&1; then
+		if command -v ${TST_TESTFUNC}1 > /dev/null 2>&1; then
 			_tst_run_test "$TST_TESTFUNC$_tst_i" $_tst_i "$_tst_data"
 		else
 			_tst_run_test "$TST_TESTFUNC" $_tst_i "$_tst_data"
-- 
2.33.0

