Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <carmelo.amoroso@st.com>) id 1RnX42-0000k6-0q
	for ltp-list@lists.sourceforge.net; Wed, 18 Jan 2012 15:04:38 +0000
Received: from eu1sys200aog104.obsmtp.com ([207.126.144.117])
	by sog-mx-2.v43.ch3.sourceforge.com with smtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1RnX3w-0005OA-A7
	for ltp-list@lists.sourceforge.net; Wed, 18 Jan 2012 15:04:37 +0000
From: Carmelo AMOROSO <carmelo.amoroso@st.com>
Date: Wed, 18 Jan 2012 16:04:18 +0100
Message-Id: <1326899058-19175-1-git-send-email-carmelo.amoroso@st.com>
Subject: [LTP] [PATCH 1/2] cacheflush: enable cacheflush syscall for other
	architectures.
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
To: ltp-list@lists.sf.net

From: Francesco Rundo <francesco.rundo@st.com>

'cacheflush' syscall is available for other architectures than mips (i.e. SH4)
as originally the testcase was assuming.
Rely upon the availability of __NR_syscall numbers from kernel headers.

Signed-off-by: Francesco Rundo <francesco.rundo@st.com>
Signed-off-by: Carmelo Amoroso <carmelo.amoroso@st.com>
---
 .../kernel/syscalls/cacheflush/cacheflush01.c      |   27 ++++++-------------
 1 files changed, 9 insertions(+), 18 deletions(-)

diff --git a/testcases/kernel/syscalls/cacheflush/cacheflush01.c b/testcases/kernel/syscalls/cacheflush/cacheflush01.c
index 50c4ade..fbd3b32 100644
--- a/testcases/kernel/syscalls/cacheflush/cacheflush01.c
+++ b/testcases/kernel/syscalls/cacheflush/cacheflush01.c
@@ -44,9 +44,16 @@
 #include <stdlib.h>
 #include <errno.h>
 
-/* cacheflush man page states that cacheflush() is only applicable to
- * MIPS architecture -- regardless, it's a good negative test.. */
+/* Harness Specific Include Files. */
+#include "test.h"
+#include "usctest.h"
+#include "linux_syscall_numbers.h"
 
+#if defined __NR_cacheflush && __NR_cacheflush > 0
+#include <asm/cachectl.h>
+#else
+/* Fake linux_syscall_numbers.h */
+#define __NR_cacheflush		0
 #ifndef   ICACHE
 #define   ICACHE   (1<<0)		/* flush instruction cache        */
 #endif
@@ -56,22 +63,6 @@
 #ifndef   BCACHE
 #define   BCACHE   (ICACHE|DCACHE)	/* flush both caches              */
 #endif
-
-/* Harness Specific Incnude Files. */
-#include "test.h"
-#include "usctest.h"
-#include "linux_syscall_numbers.h"
-
-/* cacheflush man page states that cacheflush() is only applicable to
- * MIPS architecture -- regardless, it's a good negative test.. */
-#if defined __mips__
-#include <asm/cachectl.h>
-#ifndef __NR_cacheflush
-#define __NR_cacheflush		0
-#endif
-#else
-/* Fake linux_syscall_numbers.h */
-#define __NR_cacheflush		0
 #endif
 
 /* Extern Global Variables */
-- 
1.7.4.4


------------------------------------------------------------------------------
Keep Your Developer Skills Current with LearnDevNow!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
