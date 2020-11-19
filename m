From: Po-Hsu Lin <po-hsu.lin@canonical.com>
Date: Thu, 19 Nov 2020 18:06:17 +0800
Subject: [LTP] [PATCH] acct02: make explicit kernel config requirement
Message-ID: <20201119100617.70968-1-po-hsu.lin@canonical.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

With commit eeed458492cc ("lib/tst_kconfig: Validate variables"), the
kernel config check is now more strict.

In this acct02 test, it will fail on an ARM64 system running with
Ubuntu Bionic 4.15 kernel:
  tag=acct02 stime=1605709219 dur=0 exit=exited stat=2 core=no cu=0 cs=0
  startup='Wed Nov 18 14:20:19 2020'
  CONFIG_BSD_PROCESS_ACCT
  ^
  Missing value

  tst_kconfig.c:475: TBROK: Invalid kconfig variables!

While the kernel config shows:
  $ grep CONFIG_BSD_PROCESS_ACCT /boot/config-4.15.0-1087-aws
  CONFIG_BSD_PROCESS_ACCT=y
  CONFIG_BSD_PROCESS_ACCT_V3=y

Change the kernel config requirement to CONFIG_BSD_PROCESS_ACCT=y
to solve this issue.

Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
---
 testcases/kernel/syscalls/acct/acct02.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/acct/acct02.c b/testcases/kernel/syscalls/acct/acct02.c
index fbcde0bcb..bd0427848 100644
--- a/testcases/kernel/syscalls/acct/acct02.c
+++ b/testcases/kernel/syscalls/acct/acct02.c
@@ -255,7 +255,7 @@ static void cleanup(void)
 }
 
 static const char *kconfigs[] = {
-	"CONFIG_BSD_PROCESS_ACCT",
+	"CONFIG_BSD_PROCESS_ACCT=y",
 	NULL
 };
 
-- 
2.25.1

