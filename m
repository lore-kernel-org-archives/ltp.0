From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon,  2 Jan 2017 16:41:02 +0100
Subject: [LTP] [COMMITTED] [PATCH 3/3] waitid02: define _XOPEN_SOURCE 500
In-Reply-To: <1483371662-30039-1-git-send-email-chrubis@suse.cz>
References: <1483371662-30039-1-git-send-email-chrubis@suse.cz>
Message-ID: <1483371662-30039-2-git-send-email-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

In order to get the getpgid() function declaration exposed on slightly
older distributions.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/waitid/waitid02.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/syscalls/waitid/waitid02.c b/testcases/kernel/syscalls/waitid/waitid02.c
index b72e25e..db7e883 100644
--- a/testcases/kernel/syscalls/waitid/waitid02.c
+++ b/testcases/kernel/syscalls/waitid/waitid02.c
@@ -38,6 +38,7 @@
 /*              Manas Kumar Nayak maknayak@in.ibm.com>                        */
 /******************************************************************************/
 
+#define _XOPEN_SOURCE 500
 #include <stdio.h>
 #include <errno.h>
 #include <stdlib.h>
-- 
2.7.3

