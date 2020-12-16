From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 16 Dec 2020 11:10:11 +0100
Subject: [LTP] [PATCH 4/5] syscalls/abort: Remove second space before
 description text
In-Reply-To: <20201216101012.14644-1-chrubis@suse.cz>
References: <20201216101012.14644-1-chrubis@suse.cz>
Message-ID: <20201216101012.14644-5-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This seems to be the only case where the change to remove only first
whitespace cause the test description to produce literal block
unexpectedly.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/abort/abort01.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/abort/abort01.c b/testcases/kernel/syscalls/abort/abort01.c
index b93324b34..ba89cc524 100644
--- a/testcases/kernel/syscalls/abort/abort01.c
+++ b/testcases/kernel/syscalls/abort/abort01.c
@@ -9,7 +9,8 @@
 
 /*\
  * [DESCRIPTION]
- *  Checks that process which called abort() gets killed by SIGIOT and dumps core.
+ *
+ * Checks that process which called abort() gets killed by SIGIOT and dumps core.
  *
  * [ALGORITHM]
  *  - Fork child.
-- 
2.26.2

