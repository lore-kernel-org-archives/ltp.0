From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Tue,  8 Sep 2020 15:14:27 +0530
Subject: [LTP] [PATCH V3 3/3] syscalls: select: Rename select04.c to
 select02.c
In-Reply-To: <6fbfc6919c0000e7a7745afbc3c94baab02603fa.1599558175.git.viresh.kumar@linaro.org>
References: <6fbfc6919c0000e7a7745afbc3c94baab02603fa.1599558175.git.viresh.kumar@linaro.org>
Message-ID: <e9bcd007772ffadd6326dca29532bb4d3f8e7f0a.1599558175.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Do the rename.

Acked-by: Li Wang <liwang@redhat.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 runtest/quickhit                                            | 2 +-
 runtest/syscalls                                            | 2 +-
 testcases/kernel/syscalls/select/.gitignore                 | 2 +-
 testcases/kernel/syscalls/select/{select04.c => select02.c} | 0
 4 files changed, 3 insertions(+), 3 deletions(-)
 rename testcases/kernel/syscalls/select/{select04.c => select02.c} (100%)

diff --git a/runtest/quickhit b/runtest/quickhit
index c01dc4f30b9f..9ada4c4c47c2 100644
--- a/runtest/quickhit
+++ b/runtest/quickhit
@@ -180,7 +180,7 @@ sbrk01 sbrk01
 # Basic test for sbrk(2)
 select01 select01
 # Basic select tests
-select04 select04
+select02 select02
 setgid01 setgid01
 # Basic test for setgid(2)
 setpgid01 setpgid01
diff --git a/runtest/syscalls b/runtest/syscalls
index cf8e989969e5..f299c030ecaa 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1150,7 +1150,7 @@ sched_getattr01 sched_getattr01
 sched_getattr02 sched_getattr02
 
 select01 select01
-select04 select04
+select02 select02
 
 semctl01 semctl01
 semctl02 semctl02
diff --git a/testcases/kernel/syscalls/select/.gitignore b/testcases/kernel/syscalls/select/.gitignore
index 243a092ac6ca..f5a43c23326a 100644
--- a/testcases/kernel/syscalls/select/.gitignore
+++ b/testcases/kernel/syscalls/select/.gitignore
@@ -1,2 +1,2 @@
 /select01
-/select04
+/select02
diff --git a/testcases/kernel/syscalls/select/select04.c b/testcases/kernel/syscalls/select/select02.c
similarity index 100%
rename from testcases/kernel/syscalls/select/select04.c
rename to testcases/kernel/syscalls/select/select02.c
-- 
2.25.0.rc1.19.g042ed3e048af

