From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Tue, 12 Jan 2021 10:02:27 +0800
Subject: [LTP] [PATCH v3 3/3] syscalls: Take use of TST_EXP_PASS_SILENT
In-Reply-To: <20210112020227.11775-1-yangx.jy@cn.fujitsu.com>
References: <20210112020227.11775-1-yangx.jy@cn.fujitsu.com>
Message-ID: <20210112020227.11775-3-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Current TST_EXP_PASS macro reports the double passed for
one subtest, for example:
--------------------------------------------
tst_test.c:1261: TINFO: Timeout per run is 0h 05m 00s
access02.c:62: TPASS: access(file_f, F_OK) as root passed
access02.c:141: TPASS: access(file_f, F_OK) as root behaviour is correct.
access02.c:62: TPASS: access(file_f, F_OK) as nobody passed
access02.c:141: TPASS: access(file_f, F_OK) as nobody behaviour is correct.
access02.c:62: TPASS: access(file_r, R_OK) as root passed
...

Summary:
passed   32
failed   0
broken   0
skipped  0
warnings 0
--------------------------------------------

It is just a minor cleanup rather than a fix.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/access/access02.c | 2 +-
 testcases/kernel/syscalls/bind/bind04.c     | 2 +-
 testcases/kernel/syscalls/bind/bind05.c     | 2 +-
 testcases/kernel/syscalls/brk/brk01.c       | 6 +++++-
 testcases/kernel/syscalls/capget/capget01.c | 4 +++-
 5 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/syscalls/access/access02.c b/testcases/kernel/syscalls/access/access02.c
index ff3e7b6f4..bf636f9f4 100644
--- a/testcases/kernel/syscalls/access/access02.c
+++ b/testcases/kernel/syscalls/access/access02.c
@@ -59,7 +59,7 @@ static void access_test(struct tcase *tc, const char *user)
 	struct stat stat_buf;
 	char command[64];
 
-	TST_EXP_PASS(access(tc->pathname, tc->mode),
+	TST_EXP_PASS_SILENT(access(tc->pathname, tc->mode),
 	             "access(%s, %s) as %s", tc->pathname, tc->name, user);
 
 	if (!TST_PASS)
diff --git a/testcases/kernel/syscalls/bind/bind04.c b/testcases/kernel/syscalls/bind/bind04.c
index 49e784ccd..de43b6c13 100644
--- a/testcases/kernel/syscalls/bind/bind04.c
+++ b/testcases/kernel/syscalls/bind/bind04.c
@@ -118,7 +118,7 @@ static void test_bind(unsigned int n)
 	listen_sock = SAFE_SOCKET(tc->address->sa_family, tc->type,
 		tc->protocol);
 
-	TST_EXP_PASS(bind(listen_sock, tc->address, tc->addrlen), "bind()");
+	TST_EXP_PASS_SILENT(bind(listen_sock, tc->address, tc->addrlen), "bind()");
 
 	if (!TST_PASS) {
 		SAFE_CLOSE(listen_sock);
diff --git a/testcases/kernel/syscalls/bind/bind05.c b/testcases/kernel/syscalls/bind/bind05.c
index 3b384cf1b..c43593fe1 100644
--- a/testcases/kernel/syscalls/bind/bind05.c
+++ b/testcases/kernel/syscalls/bind/bind05.c
@@ -131,7 +131,7 @@ static void test_bind(unsigned int n)
 	tst_res(TINFO, "Testing %s", tc->description);
 	sock = SAFE_SOCKET(tc->address->sa_family, tc->type, tc->protocol);
 
-	TST_EXP_PASS(bind(sock, tc->address, tc->addrlen), "bind()");
+	TST_EXP_PASS_SILENT(bind(sock, tc->address, tc->addrlen), "bind()");
 
 	if (!TST_PASS) {
 		SAFE_CLOSE(sock);
diff --git a/testcases/kernel/syscalls/brk/brk01.c b/testcases/kernel/syscalls/brk/brk01.c
index 3f8606375..a9b89bce5 100644
--- a/testcases/kernel/syscalls/brk/brk01.c
+++ b/testcases/kernel/syscalls/brk/brk01.c
@@ -31,7 +31,9 @@ void verify_brk(void)
 		break;
 		}
 
-		TST_EXP_PASS(brk((void *)new_brk), "brk()");
+		TST_EXP_PASS_SILENT(brk((void *)new_brk), "brk()");
+		if (!TST_PASS)
+			return;
 
 		cur_brk = (uintptr_t)sbrk(0);
 
@@ -46,6 +48,8 @@ void verify_brk(void)
 		if (i % 3 == 0)
 			*((char *)cur_brk) = 0;
 	}
+
+	tst_res(TPASS, "brk() works fine");
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/syscalls/capget/capget01.c b/testcases/kernel/syscalls/capget/capget01.c
index 6c17a7c7c..af088e2fc 100644
--- a/testcases/kernel/syscalls/capget/capget01.c
+++ b/testcases/kernel/syscalls/capget/capget01.c
@@ -32,8 +32,10 @@ static void verify_capget(unsigned int n)
 	hdr->version = tc->version;
 	hdr->pid = pid;
 
-	TST_EXP_PASS(tst_syscall(__NR_capget, hdr, data),
+	TST_EXP_PASS_SILENT(tst_syscall(__NR_capget, hdr, data),
 	             "capget() with %s", tc->message);
+	if (!TST_PASS)
+		return;
 
 	if (data[0].effective & 1 << CAP_NET_RAW)
 		tst_res(TFAIL, "capget() gets CAP_NET_RAW unexpectedly in pE");
-- 
2.21.0



