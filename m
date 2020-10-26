From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Mon, 26 Oct 2020 13:48:36 +0800
Subject: [LTP] [PATCH 4/4] syscalls/sync: Rename sync03.c to sync01.c
In-Reply-To: <1603691317-22811-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1603691317-22811-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <1603691317-22811-4-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 runtest/syscalls                                      | 2 +-
 testcases/kernel/syscalls/sync/.gitignore             | 2 +-
 testcases/kernel/syscalls/sync/{sync03.c => sync01.c} | 0
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename testcases/kernel/syscalls/sync/{sync03.c => sync01.c} (100%)

diff --git a/runtest/syscalls b/runtest/syscalls
index afc27c142..0dcd3d66d 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1477,7 +1477,7 @@ symlink05 symlink05
 #symlinkat test cases
 symlinkat01 symlinkat01
 
-sync03 sync03
+sync01 sync01
 
 syncfs01 syncfs01
 
diff --git a/testcases/kernel/syscalls/sync/.gitignore b/testcases/kernel/syscalls/sync/.gitignore
index 8008fa6e2..74d01da47 100644
--- a/testcases/kernel/syscalls/sync/.gitignore
+++ b/testcases/kernel/syscalls/sync/.gitignore
@@ -1 +1 @@
-/sync03
+/sync01
diff --git a/testcases/kernel/syscalls/sync/sync03.c b/testcases/kernel/syscalls/sync/sync01.c
similarity index 100%
rename from testcases/kernel/syscalls/sync/sync03.c
rename to testcases/kernel/syscalls/sync/sync01.c
-- 
2.23.0



