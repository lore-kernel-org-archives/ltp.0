From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 27 Mar 2019 16:52:52 +0100
Subject: [LTP] [PATCH 1/1] shell: Fix handling default parameters in
	tst_mkfs()
Message-ID: <20190327155252.761-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

fixes regression when testing df01.sh

Dash does not like shifting more than possible:
/opt/ltp/testcases/bin/df01.sh: 291: shift: can't shift that many

Fixes: 465faf47f ("shell: Use $TST_FS_TYPE and $TST_DEVICE in tst_mkfs()")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

don't like checking $# twice, but don't see right now way to do it
simpler.

Sorry for introducing regression.

Kind regards,
Petr
---
 testcases/lib/tst_test.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index af16ce1cf..d3905d378 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -288,7 +288,8 @@ tst_mkfs()
 {
 	local fs_type=${1:-$TST_FS_TYPE}
 	local device=${2:-$TST_DEVICE}
-	shift 2
+	[ $# -eq 1 ] && shift 1
+	[ $# -ge 2 ] && shift 2
 	local fs_opts="$@"
 
 	if [ -z "$fs_type" ]; then
-- 
2.21.0

