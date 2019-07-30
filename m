From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 30 Jul 2019 20:03:15 +0200
Subject: [LTP] [COMMITTED] [PATCH 2/2] syscalls/accept02: Remove .needs_root
In-Reply-To: <20190730180315.6958-1-chrubis@suse.cz>
References: <20190730180315.6958-1-chrubis@suse.cz>
Message-ID: <20190730180315.6958-2-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This was a workaround for bug fixed in:

commit af4e42cf022b4f3d016892ed8257e0ec205ec2f0 (HEAD -> master)
Author: Cyril Hrubis <chrubis@suse.cz>
Date:   Tue Jul 30 17:31:33 2019 +0200

    syscalls/accept02: Fix TST_GET_UNUSED_PORT() usage

The test was failing randomly with EACCESS when the wrongly converted
port number was < 1024.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/accept/accept02.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/testcases/kernel/syscalls/accept/accept02.c b/testcases/kernel/syscalls/accept/accept02.c
index 3db0f33bc..df048ede4 100644
--- a/testcases/kernel/syscalls/accept/accept02.c
+++ b/testcases/kernel/syscalls/accept/accept02.c
@@ -139,5 +139,4 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.needs_checkpoints = 1,
-	.needs_root = 1,
 };
-- 
2.21.0

