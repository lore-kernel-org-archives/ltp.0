From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Wed, 29 Jul 2020 13:25:52 +0530
Subject: [LTP] [PATCH V8 4/5] syscalls: semop: Rename semop05.c
In-Reply-To: <fab6e65d02767b60594916da89cca34221989229.1596008484.git.viresh.kumar@linaro.org>
References: <fab6e65d02767b60594916da89cca34221989229.1596008484.git.viresh.kumar@linaro.org>
Message-ID: <aecc872dc379eb572e3d5ae9b6795c639abf33f0.1596008484.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Rename it to semop03.c.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 runtest/syscalls                                             | 2 +-
 runtest/syscalls-ipc                                         | 2 +-
 testcases/kernel/syscalls/ipc/semop/.gitignore               | 2 +-
 testcases/kernel/syscalls/ipc/semop/{semop05.c => semop03.c} | 0
 4 files changed, 3 insertions(+), 3 deletions(-)
 rename testcases/kernel/syscalls/ipc/semop/{semop05.c => semop03.c} (100%)

diff --git a/runtest/syscalls b/runtest/syscalls
index 99831f6aa36e..7bbf3a76611f 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1169,7 +1169,7 @@ semget06 semget06
 
 semop01 semop01
 semop02 semop02
-semop05 semop05
+semop03 semop03
 
 send01 send01
 
diff --git a/runtest/syscalls-ipc b/runtest/syscalls-ipc
index 1a63071b22cf..690ccb214b15 100644
--- a/runtest/syscalls-ipc
+++ b/runtest/syscalls-ipc
@@ -44,7 +44,7 @@ semget06 semget06
 
 semop01 semop01
 semop02 semop02
-semop05 semop05
+semop03 semop03
 
 shmat01 shmat01
 shmat02 shmat02
diff --git a/testcases/kernel/syscalls/ipc/semop/.gitignore b/testcases/kernel/syscalls/ipc/semop/.gitignore
index 35b7af66c465..bb57f08afda8 100644
--- a/testcases/kernel/syscalls/ipc/semop/.gitignore
+++ b/testcases/kernel/syscalls/ipc/semop/.gitignore
@@ -1,3 +1,3 @@
 /semop01
 /semop02
-/semop05
+/semop03
diff --git a/testcases/kernel/syscalls/ipc/semop/semop05.c b/testcases/kernel/syscalls/ipc/semop/semop03.c
similarity index 100%
rename from testcases/kernel/syscalls/ipc/semop/semop05.c
rename to testcases/kernel/syscalls/ipc/semop/semop03.c
-- 
2.14.1

