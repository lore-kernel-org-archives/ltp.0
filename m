From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed,  4 Oct 2017 15:24:54 +0200
Subject: [LTP] [COMMITTED] [PATCH] syscalls/dup203: Fix make use of
	SAFE_CLOSE()
Message-ID: <20171004132454.23921-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The patch:

commit df007542635aed8686b5ebc111b0807a67349b41
Author: Cyril Hrubis <chrubis@suse.cz>
Date:   Tue Oct 3 13:29:15 2017 +0200

    Make use of SAFE_CLOSE()

Broke the test since it opens and closes a fd in order to get free file
descriptor to pass to dup2() as newfd. The problem here is that
SAFE_CLOSE() sets the file descriptor to -1, which is usually good
thing.

This patch fixes the problem by using temporary variable to store the fd
to pass it to SAFE_CLOSE().

Fixes #219

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/dup2/dup203.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/dup2/dup203.c b/testcases/kernel/syscalls/dup2/dup203.c
index d3c228362..e6f281adf 100644
--- a/testcases/kernel/syscalls/dup2/dup203.c
+++ b/testcases/kernel/syscalls/dup2/dup203.c
@@ -144,7 +144,9 @@ int main(int ac, char **av)
 			tst_brkm(TBROK, cleanup, "Cannot create second file");
 		}
 
-		SAFE_CLOSE(cleanup, fd2);
+		/* SAFE_CLOSE() sets the fd to -1 avoid it here */
+		rval = fd2;
+		SAFE_CLOSE(cleanup, rval);
 
 		TEST(dup2(fd0, fd2));
 
-- 
2.13.5

