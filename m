From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Thu,  3 Sep 2020 12:10:12 +0530
Subject: [LTP] [PATCH 2/3] syscalls: select: Rename select04.c to select02.c
In-Reply-To: <728ce5d6b7e0f3eba8015c078bfc23ec144ce1c2.1599115178.git.viresh.kumar@linaro.org>
References: <728ce5d6b7e0f3eba8015c078bfc23ec144ce1c2.1599115178.git.viresh.kumar@linaro.org>
Message-ID: <f7855857470b26fdbebcfe4adf1cd4779852f7ff.1599115178.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Do the rename.

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
index 105ca29dd29b..0c6bf0e4d0a7 100644
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

