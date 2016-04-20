From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 20 Apr 2016 17:23:17 +0800
Subject: [LTP] [PATCH 1/3] syscalls/signal*: Fix unused parameter compiler
	warnings
Message-ID: <1461144199-29361-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/signal/signal03.c | 2 +-
 testcases/kernel/syscalls/signal/signal04.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/signal/signal03.c b/testcases/kernel/syscalls/signal/signal03.c
index c9f8017..7975c77 100644
--- a/testcases/kernel/syscalls/signal/signal03.c
+++ b/testcases/kernel/syscalls/signal/signal03.c
@@ -148,7 +148,7 @@ int main(int ac, char **av)
 /*
  * sighandler() - the test fails if we ever get here.
  */
-void sighandler(int sig)
+void sighandler(int sig LTP_ATTRIBUTE_UNUSED)
 {
 	fail = 1;
 }
diff --git a/testcases/kernel/syscalls/signal/signal04.c b/testcases/kernel/syscalls/signal/signal04.c
index baca161..5a18fa6 100644
--- a/testcases/kernel/syscalls/signal/signal04.c
+++ b/testcases/kernel/syscalls/signal/signal04.c
@@ -158,7 +158,7 @@ int main(int ac, char **av)
 /*
  * sighandler() - handle the signals
  */
-void sighandler(int sig)
+void sighandler(int sig LTP_ATTRIBUTE_UNUSED)
 {
 }
 
-- 
1.8.3.1



