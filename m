Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jpalecek@web.de>) id 1MIY8E-0005eI-Gi
	for ltp-list@lists.sourceforge.net; Mon, 22 Jun 2009 01:15:34 +0000
Received: from fmmailgate02.web.de ([217.72.192.227])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MIY8D-0002kC-24
	for ltp-list@lists.sourceforge.net; Mon, 22 Jun 2009 01:15:34 +0000
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate02.web.de (Postfix) with ESMTP id 4102E10433376
	for <ltp-list@lists.sourceforge.net>;
	Mon, 22 Jun 2009 02:42:12 +0200 (CEST)
Received: from [83.208.36.163] (helo=debian)
	by smtp08.web.de with asmtp (WEB.DE 4.110 #277) id 1MIXbv-0005SB-00
	for ltp-list@lists.sourceforge.net; Mon, 22 Jun 2009 02:42:12 +0200
Date: Wed, 17 Jun 2009 17:06:34 +0200
From: "Jiri Palecek >" <"<jirka"@suse.de>(none)
MIME-Version: 1.0
Resent-To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>
Resent-Message-ID: <op.uvwho0n7lwynca@debian>
Subject: [LTP] [PATCH] Fix some compiler warnings
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: ltp-list-bounces@lists.sourceforge.net
Errors-To: ltp-list-bounces@lists.sourceforge.net
Cc: ltp-list@lists.sourceforge.net
Message-ID: <20090617150634.t0shZEqJbePdu931If_D28GOFKOms5RzLOj-nP62NIQ@z>

Hello,

this patch fixes compiler warnings for implicit function declarations, particularly snprintf and usleep, in mq_notify and mq_timedreceive. Note that although the functions are used in common_j_c.h, the macros have to be defined in the c files that include it, before any other header

Regards
    Jiri Palecek

Signed-off-by: Jiri Palecek <jpalecek@web.de>
---
 testcases/kernel/syscalls/mq_notify/mq_notify01.c  |    1 +
 .../syscalls/mq_timedreceive/mq_timedreceive01.c   |    1 +
 testcases/kernel/syscalls/utils/common_j_h.c       |    1 -
 3 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/testcases/kernel/syscalls/mq_notify/mq_notify01.c b/testcases/kernel/syscalls/mq_notify/mq_notify01.c
index 1cc1a6c..6004373 100644
--- a/testcases/kernel/syscalls/mq_notify/mq_notify01.c
+++ b/testcases/kernel/syscalls/mq_notify/mq_notify01.c
@@ -45,6 +45,7 @@
 /* History:     Porting from Crackerjack to LTP is done by                    */
 /*              Manas Kumar Nayak maknayak@in.ibm.com>                        */
 /******************************************************************************/
+#define _XOPEN_SOURCE 500
 #include <sys/syscall.h>
 #include <sys/types.h>
 #include <sys/stat.h>
diff --git a/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c b/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c
index 43f0d8b..dadc38d 100644
--- a/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c
+++ b/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c
@@ -45,6 +45,7 @@
 /* History:     Porting from Crackerjack to LTP is done by                    */
 /*              Manas Kumar Nayak maknayak@in.ibm.com>                        */
 /******************************************************************************/
+#define _XOPEN_SOURCE 500
 #include <sys/syscall.h>
 #include <sys/types.h>
 #include <sys/stat.h>
diff --git a/testcases/kernel/syscalls/utils/common_j_h.c b/testcases/kernel/syscalls/utils/common_j_h.c
index e19d433..c56f6e2 100644
--- a/testcases/kernel/syscalls/utils/common_j_h.c
+++ b/testcases/kernel/syscalls/utils/common_j_h.c
@@ -22,7 +22,6 @@
  * $Id: common_j_h.c,v 1.2 2009/06/09 17:58:42 subrata_modak Exp $
  *
  */
-//#define _GNU_SOURCE 1
 #include <stdio.h>
 #include <sys/types.h>
 #include <sys/wait.h>
-- 
1.6.3.1




------------------------------------------------------------------------------
Are you an open source citizen? Join us for the Open Source Bridge conference!
Portland, OR, June 17-19. Two days of sessions, one day of unconference: $250.
Need another reason to go? 24-hour hacker lounge. Register today!
http://ad.doubleclick.net/clk;215844324;13503038;v?http://opensourcebridge.org
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
