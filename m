From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 15 Jan 2020 14:43:12 +0100
Subject: [LTP] [PATCH v2 1/3] syscalls/capset02: Cleanup & convert to
 new library
In-Reply-To: <1578651702-19486-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <20200109124101.GE31981@rei.lan>
 <1578651702-19486-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20200115134311.GE14046@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with minor changes, thanks.

The diff is:

diff --git a/testcases/kernel/syscalls/capset/capset02.c b/testcases/kernel/syscalls/capset/capset02.c
index 15589d462..a6c4f29a0 100644
--- a/testcases/kernel/syscalls/capset/capset02.c
+++ b/testcases/kernel/syscalls/capset/capset02.c
@@ -28,10 +28,11 @@
 #define CAP1 (1 << CAP_NET_RAW | 1 << CAP_CHOWN  | 1 << CAP_SETPCAP)
 #define CAP2 (CAP1 | 1 << CAP_KILL)
 
-static int drop_flag;
 static struct __user_cap_header_struct *header;
 static struct __user_cap_data_struct *data;
 
+static void *bad_addr;
+
 static struct tcase {
        int version;
        int pid;
@@ -63,8 +64,8 @@ static void verify_capset(unsigned int n)
 
        tst_res(TINFO, "%s", tc->message);
 
-       TEST(tst_syscall(__NR_capset, tc->flag - 1 ? header : NULL,
-                               tc->flag - 2 ? data : NULL));
+       TEST(tst_syscall(__NR_capset, tc->flag - 1 ? header : bad_addr,
+                               tc->flag - 2 ? data : bad_addr));
        if (TST_RET == 0) {
                tst_res(TFAIL, "capset() succeed unexpectedly");
                return;
@@ -97,9 +98,9 @@ static void setup(void)
 
        TEST(prctl(PR_CAPBSET_DROP, CAP_KILL));
        if (TST_RET == -1)
-               tst_res(TFAIL | TTERRNO, "drop CAP_KILL failed");
-       else
-               drop_flag = 1;
+               tst_brk(TBROK | TTERRNO, "drop CAP_KILL failed");
+
+       bad_addr = tst_get_bad_addr(NULL);
 }


-- 
Cyril Hrubis
chrubis@suse.cz
