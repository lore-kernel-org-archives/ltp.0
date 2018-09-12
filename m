From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 12 Sep 2018 11:51:52 +0200
Subject: [LTP] [PATCH] [COMMITTED] syscalls/execveat03: Fix typo shell ->
	shall
Message-ID: <20180912095152.27382-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/execveat/execveat03.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/execveat/execveat03.c b/testcases/kernel/syscalls/execveat/execveat03.c
index 82ec58cd2..d2d4aaf88 100644
--- a/testcases/kernel/syscalls/execveat/execveat03.c
+++ b/testcases/kernel/syscalls/execveat/execveat03.c
@@ -30,7 +30,7 @@
  *     can't be found. The solution could use d_find_any_alias() instead of
  *     d_find_alias().
  *
- *     Starting with kernel 4.14, this case fails, execveat shell
+ *     Starting with kernel 4.14, this case fails, execveat shall
  *     returns EINVAL.
  *
  *     This has been fixed by:
-- 
2.16.4

