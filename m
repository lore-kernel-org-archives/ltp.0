From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 9 Dec 2020 18:35:47 +0800
Subject: [LTP] [PATCH 2/2] syscalls/fsconfig02.c: Remove unneeded
 .needs_tmpdir
In-Reply-To: <20201209103547.1343502-1-yangx.jy@cn.fujitsu.com>
References: <20201209103547.1343502-1-yangx.jy@cn.fujitsu.com>
Message-ID: <20201209103547.1343502-2-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

.needs_device will enable .needs_tmpdir automatically so
remove the unneeded flag.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/fsconfig/fsconfig02.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/testcases/kernel/syscalls/fsconfig/fsconfig02.c b/testcases/kernel/syscalls/fsconfig/fsconfig02.c
index 20d77917f..9ff41a7d7 100644
--- a/testcases/kernel/syscalls/fsconfig/fsconfig02.c
+++ b/testcases/kernel/syscalls/fsconfig/fsconfig02.c
@@ -94,7 +94,6 @@ static struct tst_test test = {
 	.test = run,
 	.setup = setup,
 	.cleanup = cleanup,
-	.needs_tmpdir = 1,
 	.needs_root = 1,
 	.needs_device = 1,
 };
-- 
2.25.1



