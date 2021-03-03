From: Martin Loviska <mloviska@suse.de>
Date: Wed,  3 Mar 2021 14:24:03 +0100
Subject: [LTP] [PATCH] Wait for complete input provided by `seq`
Message-ID: <20210303132403.6427-1-mloviska@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: mloviska <mloviska@suse.com>

`splice02` may exit before `seq` therefore broken pipe occurs.

Found with SLES JeOS (https://progress.opensuse.org/issues/77260).

Suggested-by: Fabian Vogt <fvogt@suse.de>
Tested-by: Petr Vorel <pvorel@suse.cz>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Martin Loviska <mloviska@suse.com>
---
 runtest/smoketest | 2 +-
 runtest/syscalls  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/runtest/smoketest b/runtest/smoketest
index 0c24fc1fa..e6800d283 100644
--- a/runtest/smoketest
+++ b/runtest/smoketest
@@ -11,5 +11,5 @@ symlink01 symlink01
 stat04 symlink01 -T stat04
 utime01A symlink01 -T utime01
 rename01A symlink01 -T rename01
-splice02 seq 1 20 | splice02
+splice02 (seq 1 20 || :) | splice02
 route4-change-dst route-change-dst.sh
diff --git a/runtest/syscalls b/runtest/syscalls
index fe22ae5b6..13b87e6bc 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1446,7 +1446,7 @@ socketpair02 socketpair02
 sockioctl01 sockioctl01
 
 splice01 splice01
-splice02 seq 1 20000 | splice02
+splice02 (seq 1 20000 || :) | splice02
 splice03 splice03
 splice04 splice04
 splice05 splice05
-- 
2.30.1

