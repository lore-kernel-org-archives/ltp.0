From: Po-Hsu Lin <po-hsu.lin@canonical.com>
Date: Thu, 19 Nov 2020 18:18:18 +0800
Subject: [LTP] [PATCH] msgrcv03: make explicit kernel config requirement
Message-ID: <20201119101818.71869-1-po-hsu.lin@canonical.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

With commit eeed458492cc ("lib/tst_kconfig: Validate variables"), the
kernel config check is now more strict.

In this msgrcv03 test, it will fail on an ARM64 system running with
Ubuntu Bionic 4.15 kernel:
  tag=msgrcv03 stime=1605780268
  cmdline=msgrcv03
  contacts=
  analysis=exit
  <<<test_output>>>
  CONFIG_CHECKPOINT_RESTORE
                           ^
  Missing value

  tst_kconfig.c:475: TBROK: Invalid kconfig variables!

While the kernel config shows:
  $ grep CONFIG_CHECKPOINT_RESTORE /boot/config-4.15.0-1087-aws
  CONFIG_CHECKPOINT_RESTORE=y

Change the kernel config requirement to CONFIG_CHECKPOINT_RESTORE=y
to solve this issue.

Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
---
 testcases/kernel/syscalls/ipc/msgrcv/msgrcv03.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv03.c b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv03.c
index b578e2810..015351a65 100644
--- a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv03.c
+++ b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv03.c
@@ -93,7 +93,7 @@ static struct tst_test test = {
 	.needs_tmpdir = 1,
 	.needs_root = 1,
 	.needs_kconfigs = (const char *[]) {
-		"CONFIG_CHECKPOINT_RESTORE",
+		"CONFIG_CHECKPOINT_RESTORE=y",
 		NULL
 	},
 	.min_kver = "3.8.0",
-- 
2.25.1

