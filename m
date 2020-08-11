From: Martin Doucha <mdoucha@suse.cz>
Date: Tue, 11 Aug 2020 15:05:00 +0200
Subject: [LTP] [PATCH 2/4] Update tests to new taint check API
In-Reply-To: <20200811130502.12010-1-mdoucha@suse.cz>
References: <20200811130502.12010-1-mdoucha@suse.cz>
Message-ID: <20200811130502.12010-2-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

These are just trivial changes of tst_taint_init(mask) to .taint_check = mask.
I intentionally didn't remove any tst_taint_check() calls here.

 testcases/cve/cve-2017-17053.c                        | 4 +---
 testcases/kernel/pty/pty05.c                          | 4 +---
 testcases/kernel/sound/snd_seq01.c                    | 3 +--
 testcases/kernel/sound/snd_timer01.c                  | 3 +--
 testcases/kernel/syscalls/connect/connect02.c         | 4 +---
 testcases/kernel/syscalls/sendmsg/sendmsg03.c         | 3 +--
 testcases/kernel/syscalls/setsockopt/setsockopt05.c   | 7 +++----
 testcases/kernel/syscalls/setsockopt/setsockopt06.c   | 4 +---
 testcases/kernel/syscalls/timerfd/timerfd_settime02.c | 3 +--
 9 files changed, 11 insertions(+), 24 deletions(-)

diff --git a/testcases/cve/cve-2017-17053.c b/testcases/cve/cve-2017-17053.c
index 08a08211d..a4c418986 100644
--- a/testcases/cve/cve-2017-17053.c
+++ b/testcases/cve/cve-2017-17053.c
@@ -22,7 +22,6 @@
 #include <unistd.h>
 #include <stdio.h>
 
-#include "tst_taint.h"
 #include "lapi/syscalls.h"
 
 #define EXEC_USEC   5000000
@@ -85,8 +84,6 @@ static void install_sighandler(void)
 
 static void setup(void)
 {
-	tst_taint_init(TST_TAINT_W | TST_TAINT_D);
-
 	shm = SAFE_MMAP(NULL, sizeof(struct shm_data),
 			PROT_READ | PROT_WRITE,
 			MAP_SHARED | MAP_ANONYMOUS, -1, 0);
@@ -154,6 +151,7 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = run,
+	.taint_check = TST_TAINT_W | TST_TAINT_D,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "ccd5b3235180"},
 		{"CVE", "2017-17053"},
diff --git a/testcases/kernel/pty/pty05.c b/testcases/kernel/pty/pty05.c
index 6e1d7972a..afef051c8 100644
--- a/testcases/kernel/pty/pty05.c
+++ b/testcases/kernel/pty/pty05.c
@@ -22,7 +22,6 @@
 #include "lapi/tty.h"
 
 #include "tst_test.h"
-#include "tst_taint.h"
 #include "tst_fuzzy_sync.h"
 
 #define BUF_SIZE 1
@@ -33,8 +32,6 @@ static char buf[BUF_SIZE];
 
 static void setup(void)
 {
-	tst_taint_init(TST_TAINT_W | TST_TAINT_D);
-
 	fzsync_pair.exec_loops = 100000;
 	tst_fzsync_pair_init(&fzsync_pair);
 }
@@ -99,6 +96,7 @@ static struct tst_test test = {
 	.test_all = run,
 	.setup = setup,
 	.cleanup = cleanup,
+	.taint_check = TST_TAINT_W | TST_TAINT_D,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "82f2341c94d27"},
 		{"CVE", "2017-2636"},
diff --git a/testcases/kernel/sound/snd_seq01.c b/testcases/kernel/sound/snd_seq01.c
index 0c1a44f48..c56752230 100644
--- a/testcases/kernel/sound/snd_seq01.c
+++ b/testcases/kernel/sound/snd_seq01.c
@@ -22,7 +22,6 @@
 
 #include "tst_test.h"
 #include "tst_fuzzy_sync.h"
-#include "tst_taint.h"
 
 static int fd = -1;
 static int client_id;
@@ -64,7 +63,6 @@ static void setup(void)
 {
 	struct snd_seq_queue_info qconf = { .queue = 0 };
 
-	tst_taint_init(TST_TAINT_W | TST_TAINT_D);
 	errno = 0;
 	fd = open("/dev/snd/seq", O_RDWR);
 
@@ -126,6 +124,7 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.timeout = 120,
+	.taint_check = TST_TAINT_W | TST_TAINT_D,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "d15d662e89fc"},
 		{"CVE", "2018-7566"},
diff --git a/testcases/kernel/sound/snd_timer01.c b/testcases/kernel/sound/snd_timer01.c
index e339ec862..51591c18e 100644
--- a/testcases/kernel/sound/snd_timer01.c
+++ b/testcases/kernel/sound/snd_timer01.c
@@ -18,7 +18,6 @@
 
 #include "config.h"
 #include "tst_test.h"
-#include "tst_taint.h"
 #include "tst_fuzzy_sync.h"
 #include "tst_safe_macros.h"
 #include "tst_safe_pthread.h"
@@ -71,7 +70,6 @@ static void setup(void)
 		tst_brk(TCONF, "The file '/dev/snd/timer' is not exist");
 
 	tst_fzsync_pair_init(&fzsync_pair);
-	tst_taint_init(TST_TAINT_W | TST_TAINT_D);
 	snd_fd = SAFE_OPEN("/dev/snd/timer",
 			O_RDONLY|O_CREAT|O_NOCTTY|O_SYNC|O_LARGEFILE, 0);
 }
@@ -140,6 +138,7 @@ static struct tst_test test = {
 	.test_all = run,
 	.setup = setup,
 	.cleanup = cleanup,
+	.taint_check = TST_TAINT_W | TST_TAINT_D,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "d11662f4f798"},
 		{"linux-git", "ba3021b2c79b"},
diff --git a/testcases/kernel/syscalls/connect/connect02.c b/testcases/kernel/syscalls/connect/connect02.c
index cf80213d6..e20214e24 100644
--- a/testcases/kernel/syscalls/connect/connect02.c
+++ b/testcases/kernel/syscalls/connect/connect02.c
@@ -35,7 +35,6 @@
 
 #include "tst_test.h"
 #include "tst_net.h"
-#include "tst_taint.h"
 
 static int listenfd = -1, fd = -1, confd1 = -1, confd2 = -1, confd3 = -1;
 static struct sockaddr_in6 bind_addr;
@@ -46,8 +45,6 @@ static void setup(void)
 {
 	socklen_t size = sizeof(bind_addr);
 
-	tst_taint_init(TST_TAINT_W | TST_TAINT_D);
-
 	tst_init_sockaddr_inet6_bin(&bind_addr, &in6addr_any, 0);
 	tst_init_sockaddr_inet_bin(&bind_addr4, INADDR_ANY, 0);
 	memset(&reset_addr, 0, sizeof(reset_addr));
@@ -132,6 +129,7 @@ static struct tst_test test = {
 	.test_all = run,
 	.setup = setup,
 	.cleanup = cleanup,
+	.taint_check = TST_TAINT_W | TST_TAINT_D,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "9d538fa60bad"},
 		{"linux-git", "82c9ae440857"},
diff --git a/testcases/kernel/syscalls/sendmsg/sendmsg03.c b/testcases/kernel/syscalls/sendmsg/sendmsg03.c
index 7dc491f75..c7d72f686 100644
--- a/testcases/kernel/syscalls/sendmsg/sendmsg03.c
+++ b/testcases/kernel/syscalls/sendmsg/sendmsg03.c
@@ -22,7 +22,6 @@
 #include <sched.h>
 #include "tst_test.h"
 #include "tst_fuzzy_sync.h"
-#include "tst_taint.h"
 
 #define IOVEC_COUNT 4
 #define PACKET_SIZE 100
@@ -39,7 +38,6 @@ static void setup(void)
 {
 	int i;
 
-	tst_taint_init(TST_TAINT_W | TST_TAINT_D);
 	SAFE_UNSHARE(CLONE_NEWUSER);
 	SAFE_UNSHARE(CLONE_NEWNET);
 	sockfd = SAFE_SOCKET(AF_INET, SOCK_RAW, IPPROTO_ICMP);
@@ -106,6 +104,7 @@ static struct tst_test test = {
 	.test_all = run,
 	.setup = setup,
 	.cleanup = cleanup,
+	.taint_check = TST_TAINT_W | TST_TAINT_D,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "8f659a03a0ba"},
 		{"CVE", "2017-17712"},
diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt05.c b/testcases/kernel/syscalls/setsockopt/setsockopt05.c
index 6e938aa60..e78ef236e 100644
--- a/testcases/kernel/syscalls/setsockopt/setsockopt05.c
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt05.c
@@ -9,7 +9,7 @@
  * Check that UDP fragmentation offload doesn't cause memory corruption
  * if the userspace process turns off UFO in between two send() calls.
  * Kernel crash fixed in:
- * 
+ *
  *  commit 85f1bd9a7b5a79d5baa8bf44af19658f7bf77bfa
  *  Author: Willem de Bruijn <willemb@google.com>
  *  Date:   Thu Aug 10 12:29:19 2017 -0400
@@ -27,7 +27,6 @@
 
 #include "tst_test.h"
 #include "tst_net.h"
-#include "tst_taint.h"
 
 #define BUFSIZE 4000
 
@@ -40,8 +39,6 @@ static void setup(void)
 	int sock;
 	struct ifreq ifr;
 
-	tst_taint_init(TST_TAINT_W | TST_TAINT_D);
-
 	SAFE_UNSHARE(CLONE_NEWUSER);
 	SAFE_UNSHARE(CLONE_NEWNET);
 	SAFE_FILE_PRINTF("/proc/self/setgroups", "deny");
@@ -62,6 +59,7 @@ static void run(void)
 {
 	int sock, i;
 	char buf[BUFSIZE];
+
 	memset(buf, 0x42, BUFSIZE);
 
 	for (i = 0; i < 1000; i++) {
@@ -84,6 +82,7 @@ static void run(void)
 static struct tst_test test = {
 	.test_all = run,
 	.setup = setup,
+	.taint_check = TST_TAINT_W | TST_TAINT_D,
 	.needs_kconfigs = (const char *[]) {
 		"CONFIG_USER_NS=y",
 		"CONFIG_NET_NS=y",
diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt06.c b/testcases/kernel/syscalls/setsockopt/setsockopt06.c
index dfc5f70cf..33284e5a6 100644
--- a/testcases/kernel/syscalls/setsockopt/setsockopt06.c
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt06.c
@@ -24,7 +24,6 @@
 
 #include "tst_test.h"
 #include "tst_fuzzy_sync.h"
-#include "tst_taint.h"
 #include "lapi/if_packet.h"
 #include "lapi/if_ether.h"
 
@@ -36,8 +35,6 @@ static void setup(void)
 	int real_uid = getuid();
 	int real_gid = getgid();
 
-	tst_taint_init(TST_TAINT_W | TST_TAINT_D);
-
 	SAFE_UNSHARE(CLONE_NEWUSER);
 	SAFE_UNSHARE(CLONE_NEWNET);
 	SAFE_FILE_PRINTF("/proc/self/setgroups", "deny");
@@ -122,6 +119,7 @@ static struct tst_test test = {
 	.test_all = run,
 	.setup = setup,
 	.cleanup = cleanup,
+	.taint_check = TST_TAINT_W | TST_TAINT_D,
 	.needs_kconfigs = (const char *[]) {
 		"CONFIG_USER_NS=y",
 		"CONFIG_NET_NS=y",
diff --git a/testcases/kernel/syscalls/timerfd/timerfd_settime02.c b/testcases/kernel/syscalls/timerfd/timerfd_settime02.c
index c15b69dca..ab978bde5 100644
--- a/testcases/kernel/syscalls/timerfd/timerfd_settime02.c
+++ b/testcases/kernel/syscalls/timerfd/timerfd_settime02.c
@@ -18,7 +18,6 @@
 #include "tst_timer.h"
 #include "tst_safe_timerfd.h"
 #include "tst_fuzzy_sync.h"
-#include "tst_taint.h"
 
 #define TIMERFD_FLAGS "timerfd_settime(TFD_TIMER_ABSTIME | TFD_TIMER_CANCEL_ON_SET)"
 
@@ -51,7 +50,6 @@ static void setup(void)
 	tst_res(TINFO, "Testing variant: %s", tv->desc);
 	its.type = tv->type;
 
-	tst_taint_init(TST_TAINT_W | TST_TAINT_D);
 	fd = SAFE_TIMERFD_CREATE(CLOCK_REALTIME, 0);
 
 	fzsync_pair.exec_loops = 1000000;
@@ -116,6 +114,7 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.min_kver = "2.6.25",
+	.taint_check = TST_TAINT_W | TST_TAINT_D,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "1e38da300e1e"},
 		{"CVE", "2017-10661"},
-- 
2.27.0

