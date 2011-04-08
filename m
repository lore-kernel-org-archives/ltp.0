Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <aelder@sgi.com>) id 1Q8IOD-0003GR-AK
	for ltp-list@lists.sourceforge.net; Fri, 08 Apr 2011 20:34:45 +0000
Received: from relay2.sgi.com ([192.48.179.30] helo=relay.sgi.com)
	by sog-mx-1.v43.ch3.sourceforge.com with smtp (Exim 4.74)
	id 1Q8IOC-0005DZ-Ee
	for ltp-list@lists.sourceforge.net; Fri, 08 Apr 2011 20:34:45 +0000
From: Alex Elder <aelder@sgi.com>
Date: Fri,  8 Apr 2011 15:34:32 -0500
Message-Id: <2fb6f8d9dc82ef63e3c7cd80151cb6ea7972aae9.1302294850.git.aelder@sgi.com>
In-Reply-To: <1302294875-6898-1-git-send-email-aelder@sgi.com>
References: <1302294875-6898-1-git-send-email-aelder@sgi.com>
Subject: [LTP] [PATCH 1/4] ltp: kill remaining warnings in "lib/tlibio.c"
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
To: ltp-list@lists.sourceforge.net

There remain a few warnings when I build "lib/tlibio.c":
- _GNU_SOURCE is defined on the command line, then defined
  unconditionally in this file.  Fix by making the definition
  in the file conditional on whether it's already defined.
- The function random_bit() has a full, standard declaration in
  "include/random_range.h", so just include that file rather than
  doing an incomplete declaration in lio_random_methods().

Signed-off-by: Alex Elder <aelder@sgi.com>
---
 lib/tlibio.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/tlibio.c b/lib/tlibio.c
index 15b536b..634aca8 100644
--- a/lib/tlibio.c
+++ b/lib/tlibio.c
@@ -79,7 +79,9 @@
  */
 
 #ifdef __linux__
+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif /* !_GNU_SOURCE */
 #define _LARGEFILE64_SOURCE
 #endif
 #include "config.h"
@@ -113,6 +115,7 @@
 #include <stdlib.h> /* atoi, abs */
 
 #include "tlibio.h"		/* defines LIO* marcos */
+#include "random_range.h"
 
 #ifndef PATH_MAX
 #define PATH_MAX	MAXPATHLEN
@@ -470,7 +473,6 @@ int
 lio_random_methods(long curr_mask)
 {
     int mask=0;
-    long random_bit();
 
     /* remove random select, io type, and wait method bits from curr_mask */
     mask = curr_mask & (~(LIO_IO_TYPES | LIO_WAIT_TYPES | LIO_RANDOM));
@@ -2079,4 +2081,4 @@ char **argv;
 
     exit(exit_status);
 }
-#endif
\ No newline at end of file
+#endif
-- 
1.7.4


------------------------------------------------------------------------------
Xperia(TM) PLAY
It's a major breakthrough. An authentic gaming
smartphone on the nation's most reliable network.
And it wants your games.
http://p.sf.net/sfu/verizon-sfdev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
