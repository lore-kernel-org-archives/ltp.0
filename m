Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1WKQzt-0004eJ-KS
	for ltp-list@lists.sourceforge.net; Mon, 03 Mar 2014 11:25:25 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WKQzs-0000yN-Bm
	for ltp-list@lists.sourceforge.net; Mon, 03 Mar 2014 11:25:25 +0000
Message-ID: <1393845909.1984.13.camel@G08JYZSD130126>
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Mon, 03 Mar 2014 19:25:09 +0800
In-Reply-To: <1393845775.1984.10.camel@G08JYZSD130126>
References: <1392372604.2085.10.camel@G08JYZSD130126>
	<1795224124.5672526.1392809381205.JavaMail.zimbra@redhat.com>
	<1392889204.2053.7.camel@G08JYZSD130126>
	<1392889813.2053.10.camel@G08JYZSD130126>
	<1128042688.6449127.1392894329625.JavaMail.zimbra@redhat.com>
	<929738145.6498501.1392901385804.JavaMail.zimbra@redhat.com>
	<1393832848.1991.19.camel@G08JYZSD130126>
	<1393833079.1991.22.camel@G08JYZSD130126>
	<1720660524.12179720.1393837634610.JavaMail.zimbra@redhat.com>
	<1393845775.1984.10.camel@G08JYZSD130126>
Mime-Version: 1.0
Subject: [LTP] [PATCH v5 3/3] mlock/mlock02.c: add EPERM and ENOMEM errno
	tests
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Add EPERM and ENOMEM errno tests for mlock(2).

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/mlock/mlock02.c | 82 ++++++++++++++++++++++++++++++-
 1 file changed, 80 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/mlock/mlock02.c b/testcases/kernel/syscalls/mlock/mlock02.c
index 95c499d..bfed030 100644
--- a/testcases/kernel/syscalls/mlock/mlock02.c
+++ b/testcases/kernel/syscalls/mlock/mlock02.c
@@ -23,11 +23,20 @@
  *   1. mlock() fails with -1 return value and sets errno to ENOMEM,
  *      if some of the specified address range does not correspond to
  *      mapped pages in the address space of the process.
+ *   2. mlock() fails with -1 return value and sets errno to ENOMEM,
+ *      if (Linux  2.6.9  and  later)  the caller had a non-zero RLIMIT_MEMLOCK
+ *      soft resource limit, but tried to lock more memory than the limit
+ *      permitted.  This limit is not enforced if the process is privileged
+ *      (CAP_IPC_LOCK).
+ *   3. mlock() fails with -1 return value and sets errno to EPERM,
+ *      if (Linux 2.6.9 and later) the caller was not privileged (CAP_IPC_LOCK)
+ *      and its RLIMIT_MEMLOCK soft resource limit was 0.
  */
 
 #include <errno.h>
 #include <unistd.h>
 #include <sys/mman.h>
+#include <pwd.h>
 
 #include "test.h"
 #include "usctest.h"
@@ -40,14 +49,18 @@ char *TCID = "mlock02";
 static void setup(void);
 static void cleanup(void);
 static void test_enomem1(void);
+static void test_enomem2(void);
+static void test_eperm(void);
 static void mlock_verify(const void *, const size_t, const int);
 
 static size_t len;
+static struct rlimit original;
+static struct passwd *ltpuser;
 
-static void (*test_func[])(void) = { test_enomem1 };
+static void (*test_func[])(void) = { test_enomem1, test_enomem2, test_eperm };
 
 int TST_TOTAL = ARRAY_SIZE(test_func);
-static int exp_enos[] = { ENOMEM, 0 };
+static int exp_enos[] = { ENOMEM, EPERM, 0 };
 
 int main(int ac, char **av)
 {
@@ -73,11 +86,17 @@ int main(int ac, char **av)
 
 static void setup(void)
 {
+	tst_require_root(NULL);
+
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	TEST_PAUSE;
 
+	ltpuser = SAFE_GETPWNAM(cleanup, "nobody");
+
 	len = getpagesize();
+
+	SAFE_GETRLIMIT(cleanup, RLIMIT_MEMLOCK, &original);
 }
 
 static void test_enomem1(void)
@@ -111,6 +130,65 @@ static void test_enomem1(void)
 	mlock_verify(addr, len, ENOMEM);
 }
 
+static void test_enomem2(void)
+{
+	void *addr;
+	struct rlimit rl;
+
+	if ((tst_kvercmp(2, 6, 9)) < 0) {
+		tst_resm(TCONF,
+			 "ENOMEM error value test for this condition needs "
+			 "kernel 2.6.9 or higher");
+		return;
+	}
+
+	rl.rlim_max = len - 1;
+	rl.rlim_cur = len - 1;
+	SAFE_SETRLIMIT(cleanup, RLIMIT_MEMLOCK, &rl);
+
+	addr = SAFE_MMAP(cleanup, NULL, len, PROT_READ,
+			 MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
+
+	SAFE_SETEUID(cleanup, ltpuser->pw_uid);
+
+	mlock_verify(addr, len, ENOMEM);
+
+	SAFE_SETEUID(cleanup, 0);
+
+	SAFE_MUNMAP(cleanup, addr, len);
+
+	SAFE_SETRLIMIT(cleanup, RLIMIT_MEMLOCK, &original);
+}
+
+static void test_eperm(void)
+{
+	void *addr;
+	struct rlimit rl;
+
+	if ((tst_kvercmp(2, 6, 9)) < 0) {
+		tst_resm(TCONF,
+			 "EPERM error value test needs kernel 2.6.9 or higher");
+		return;
+	}
+
+	rl.rlim_max = 0;
+	rl.rlim_cur = 0;
+	SAFE_SETRLIMIT(cleanup, RLIMIT_MEMLOCK, &rl);
+
+	addr = SAFE_MMAP(cleanup, NULL, len, PROT_READ,
+			 MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
+
+	SAFE_SETEUID(cleanup, ltpuser->pw_uid);
+
+	mlock_verify(addr, len, EPERM);
+
+	SAFE_SETEUID(cleanup, 0);
+
+	SAFE_MUNMAP(cleanup, addr, len);
+
+	SAFE_SETRLIMIT(cleanup, RLIMIT_MEMLOCK, &original);
+}
+
 static void mlock_verify(const void *addr, const size_t len, const int error)
 {
 	TEST(mlock(addr, len));
-- 
1.8.4.2




------------------------------------------------------------------------------
Subversion Kills Productivity. Get off Subversion & Make the Move to Perforce.
With Perforce, you get hassle-free workflows. Merge that actually works. 
Faster operations. Version large binaries.  Built-in WAN optimization and the
freedom to use Git, Perforce or both. Make the move to Perforce.
http://pubads.g.doubleclick.net/gampad/clk?id=122218951&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
