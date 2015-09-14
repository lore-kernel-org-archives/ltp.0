From: kai.kang@windriver.com <kai.kang@windriver.com>
Date: Mon, 14 Sep 2015 18:11:01 +0800
Subject: [LTP] [PATCH] replace inline with static inline for gcc 5.x
Message-ID: <1442225461-14559-1-git-send-email-kai.kang@windriver.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Kai Kang <kai.kang@windriver.com>

gcc 5.x defaults to -std=gnu11 instead of -std=gnu89 which causes
semantics for inline functions changes.

GNU89 inline: Same as C99 extern inline.

So the standalone 'inline' causes error such as:

git/testcases/kernel/syscalls/kill/kill10.c:355: undefined reference to `k_sigaction'

Replace inline with static inline to fix this issue.

Ref:
https://gcc.gnu.org/gcc-5/porting_to.html

Signed-off-by: Kai Kang <kai.kang@windriver.com>
---
 testcases/kernel/controllers/libcontrollers/libcontrollers.c | 2 +-
 testcases/kernel/syscalls/kill/kill10.c                      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/controllers/libcontrollers/libcontrollers.c b/testcases/kernel/controllers/libcontrollers/libcontrollers.c
index 844c5bc..75766fc 100644
--- a/testcases/kernel/controllers/libcontrollers/libcontrollers.c
+++ b/testcases/kernel/controllers/libcontrollers/libcontrollers.c
@@ -158,7 +158,7 @@ int read_file(char *filepath, int action, unsigned int *value)
  * Prints error message and returns -1
  */
 
-inline void error_function(char *msg1, char *msg2)
+static inline void error_function(char *msg1, char *msg2)
 {
 	fprintf(stdout, "ERROR: %s ", msg1);
 	fprintf(stdout, "%s\n", msg2);
diff --git a/testcases/kernel/syscalls/kill/kill10.c b/testcases/kernel/syscalls/kill/kill10.c
index 982d9da..0c51a91 100644
--- a/testcases/kernel/syscalls/kill/kill10.c
+++ b/testcases/kernel/syscalls/kill/kill10.c
@@ -185,7 +185,7 @@ int child_checklist_total = 0;
 int checklist_cmp(const void *a, const void *b);
 void checklist_reset(int bit);
 
-inline int k_sigaction(int sig, struct sigaction *sa, struct sigaction *osa);
+static inline int k_sigaction(int sig, struct sigaction *sa, struct sigaction *osa);
 
 char *TCID = "kill10";
 int TST_TOTAL = 1;
-- 
2.4.1

