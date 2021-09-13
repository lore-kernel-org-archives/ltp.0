From: Bogdan Lezhepekov <bogdan.lezhepekov@suse.com>
Date: Mon, 13 Sep 2021 19:37:44 +0300
Subject: [LTP] [PATCH v1 2/3] realtime:hrtimer-prio:run_auto: jump to
 current dir
In-Reply-To: <20210913163745.28108-1-bogdan.lezhepekov@suse.com>
References: <20210913163745.28108-1-bogdan.lezhepekov@suse.com>
Message-ID: <20210913163745.28108-2-bogdan.lezhepekov@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The patch makes possible to run the test from LTP root dir.

Signed-off-by: Bogdan Lezhepekov <bogdan.lezhepekov@suse.com>
---
 testcases/realtime/func/hrtimer-prio/run_auto.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/realtime/func/hrtimer-prio/run_auto.sh b/testcases/realtime/func/hrtimer-prio/run_auto.sh
index ec3d83a85..a20dbe540 100644
--- a/testcases/realtime/func/hrtimer-prio/run_auto.sh
+++ b/testcases/realtime/func/hrtimer-prio/run_auto.sh
@@ -2,6 +2,7 @@
 
 profile=${1:-default}
 
+cd $(dirname $0) # Move to test directory
 if [ ! $SCRIPTS_DIR ]; then
         # assume we're running standalone
         export SCRIPTS_DIR=../../scripts/
-- 
2.32.0

