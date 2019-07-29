From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 29 Jul 2019 10:56:06 +0200
Subject: [LTP] [PATCH] syscalls/sendmmsg: add new test
In-Reply-To: <20190725211119.239938-1-smuckle@google.com>
References: <20190725211119.239938-1-smuckle@google.com>
Message-ID: <20190729085606.GA25517@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Steve,

> Test basic functionality of sendmmsg and recvmmsg.

> Signed-off-by: Steve Muckle <smuckle@google.com>
Acked-by: Petr Vorel <pvorel@suse.cz>

> ---

> Changes since v3:
>  - drop resending of messages on partially successful sendmmsg()
>  - drop use of pthreads, do message creation and port management in
>    setup/cleanup

The only thing left in v4 is duplicate LTP_CHECK_MMSGHDR call.
+ I'd use lapi/socket.h also in cve-2016-7117.c (as Cyril pointed out)
in this commit (this change is simple enough).

So I'd be for merging v4 with diff below.

Kind regards,
Petr

diff --git configure.ac configure.ac
index 5e4e7f1f9..f7d1afc40 100644
--- configure.ac
+++ configure.ac
@@ -255,7 +255,6 @@ LTP_CHECK_TIME
 LTP_CHECK_TIMERFD
 test "x$with_tirpc" = xyes && LTP_CHECK_TIRPC
 LTP_CHECK_TPACKET_V3
-LTP_CHECK_MMSGHDR
 LTP_CHECK_UNAME_DOMAINNAME
 LTP_CHECK_XFS_QUOTACTL
 LTP_CHECK_X_TABLES
diff --git testcases/cve/cve-2016-7117.c testcases/cve/cve-2016-7117.c
index f0f6c22f1..140839712 100644
--- testcases/cve/cve-2016-7117.c
+++ testcases/cve/cve-2016-7117.c
@@ -30,6 +30,8 @@
  * https://blog.lizzie.io/notes-about-cve-2016-7117.html
  */
 
+#include "config.h"
+
 #include <sys/wait.h>
 #include <sys/types.h>
 #include <sys/socket.h>
@@ -44,20 +46,12 @@
 
 /* The bug was present in the kernel before recvmmsg was exposed by glibc */
 #include "lapi/syscalls.h"
-
-#include "config.h"
+#include "lapi/socket.h"
 
 #define MSG "abcdefghijklmnop"
 #define RECV_TIMEOUT 1
 #define ATTEMPTS 0x1FFFFF
 
-#ifndef HAVE_STRUCT_MMSGHDR
-struct mmsghdr {
-	struct msghdr msg_hdr;
-	unsigned int msg_len;
-};
-#endif
-
 static volatile int socket_fds[2];
 static struct mmsghdr msghdrs[2] = {
 	{
