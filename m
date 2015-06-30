Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <liuhangbin@gmail.com>) id 1Z9otL-0002f0-Nq
	for ltp-list@lists.sourceforge.net; Tue, 30 Jun 2015 06:19:35 +0000
Received: from mail-pd0-f177.google.com ([209.85.192.177])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Z9otL-0006yr-1m
	for ltp-list@lists.sourceforge.net; Tue, 30 Jun 2015 06:19:35 +0000
Received: by pdbci14 with SMTP id ci14so187460pdb.2
	for <ltp-list@lists.sourceforge.net>;
	Mon, 29 Jun 2015 23:19:29 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
Date: Tue, 30 Jun 2015 14:19:15 +0800
Message-Id: <1435645155-5486-1-git-send-email-liuhangbin@gmail.com>
Subject: [LTP] [PATCH] containers: remote duplicated header file
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: LTP List <ltp-list@lists.sourceforge.net>

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 testcases/kernel/containers/libclone/libclone.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/testcases/kernel/containers/libclone/libclone.h b/testcases/kernel/containers/libclone/libclone.h
index 6a2d66d..3a38bc9 100644
--- a/testcases/kernel/containers/libclone/libclone.h
+++ b/testcases/kernel/containers/libclone/libclone.h
@@ -24,9 +24,7 @@
 #include <string.h>
 #include <errno.h>
 #include <libgen.h>
-#include <sched.h>
 #include <sys/syscall.h>
-#include <unistd.h>
 #include <signal.h>
 #include "linux_syscall_numbers.h"
 #include "test.h"
-- 
1.9.3


------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
