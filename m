From: Xie Ziyao <xieziyao@huawei.com>
Date: Wed, 24 Mar 2021 17:20:59 +0800
Subject: [LTP] [PATCH] syscalls/bind: Use safe_macros to check the return
 value of the close() & bind().
Message-ID: <20210324092059.8503-1-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

For those:
  testcases/kernel/syscalls/bind/bind03.c
  testcases/kernel/syscalls/bind/bind06.c

Signed-off-by: Xie Ziyao <xieziyao@huawei.com>
---
 testcases/kernel/syscalls/bind/bind03.c | 4 ++--
 testcases/kernel/syscalls/bind/bind06.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/bind/bind03.c b/testcases/kernel/syscalls/bind/bind03.c
index c39e8f197..ebde19591 100644
--- a/testcases/kernel/syscalls/bind/bind03.c
+++ b/testcases/kernel/syscalls/bind/bind03.c
@@ -66,8 +66,8 @@ void run(void)

 static void cleanup(void)
 {
-	close(sock1);
-	close(sock2);
+	SAFE_CLOSE(sock1);
+	SAFE_CLOSE(sock2);
 }

 static struct tst_test test = {
diff --git a/testcases/kernel/syscalls/bind/bind06.c b/testcases/kernel/syscalls/bind/bind06.c
index e971a8940..017e0fc89 100644
--- a/testcases/kernel/syscalls/bind/bind06.c
+++ b/testcases/kernel/syscalls/bind/bind06.c
@@ -60,8 +60,8 @@ static void cleanup(void)

 static void do_bind(void)
 {
-	bind(fd, (struct sockaddr *)&addr1, sizeof(addr1));
-	bind(fd, (struct sockaddr *)&addr2, sizeof(addr2));
+	SAFE_BIND(fd, (struct sockaddr *)&addr1, sizeof(addr1));
+	SAFE_BIND(fd, (struct sockaddr *)&addr2, sizeof(addr2));
 }

 static void *thread_run(void *arg)
--
2.17.1

