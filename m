From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Thu, 13 Feb 2020 18:35:21 +0800
Subject: [LTP] [PATCH v2 2/2] syscalls/kill11,
 abort01: lower MIN_RLIMIT_CORE size
In-Reply-To: <1581590121-4626-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1581590121-4626-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <1581590121-4626-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From ulimit manpage, ulimit -c options used 512-bytes-block in posix mode
and used 1024-bytes-block in common mode. Usually, this case used "ulimit
 -c 1024" to test, but it will report TCONF in posix mode under unprivileged user.
Since these two cases only check correct signal, lower this size doesn't affect
this result. This also can avoid github issue(640[1],83[2]).

[1]https://github.com/linux-test-project/ltp/issues/640
[2]https://github.com/linux-test-project/ltp/issues/83

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/abort/abort01.c | 2 +-
 testcases/kernel/syscalls/kill/kill11.c   | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/abort/abort01.c b/testcases/kernel/syscalls/abort/abort01.c
index 6fde3721c..9505a5eec 100644
--- a/testcases/kernel/syscalls/abort/abort01.c
+++ b/testcases/kernel/syscalls/abort/abort01.c
@@ -62,7 +62,7 @@ void verify_abort(void)
 		tst_res(TFAIL, "abort() raised %s", tst_strsig(sig));
 }
 
-#define MIN_RLIMIT_CORE (1024 * 1024)
+#define MIN_RLIMIT_CORE (512 * 1024)
 
 static void setup(void)
 {
diff --git a/testcases/kernel/syscalls/kill/kill11.c b/testcases/kernel/syscalls/kill/kill11.c
index 4025fcc87..9b81e0095 100644
--- a/testcases/kernel/syscalls/kill/kill11.c
+++ b/testcases/kernel/syscalls/kill/kill11.c
@@ -192,8 +192,7 @@ void do_child(void)
 	exit(1);
 }
 
-/* 1024 GNU blocks */
-#define MIN_RLIMIT_CORE (1024 * 1024)
+#define MIN_RLIMIT_CORE (512 * 1024)
 
 void setup(void)
 {
-- 
2.18.0



