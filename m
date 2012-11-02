Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <tdmackey@twitter.com>) id 1TUPcv-0002qD-Ty
	for ltp-list@lists.sourceforge.net; Fri, 02 Nov 2012 22:22:09 +0000
Received: from mail-pa0-f47.google.com ([209.85.220.47])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1TUPcu-0006Qp-Go
	for ltp-list@lists.sourceforge.net; Fri, 02 Nov 2012 22:22:09 +0000
Received: by mail-pa0-f47.google.com with SMTP id fa11so2665754pad.34
	for <ltp-list@lists.sourceforge.net>;
	Fri, 02 Nov 2012 15:22:02 -0700 (PDT)
From: David Mackey <tdmackey@twitter.com>
Date: Fri,  2 Nov 2012 15:21:38 -0700
Message-Id: <1351894898-14489-1-git-send-email-tdmackey@twitter.com>
Subject: [LTP] [PATCH] proc01: Add EAGAIN to known issues for acpi/event
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

Calling read on /proc/acpi/event with O_NONBLOCK will return EAGAIN if
the acpi bus event list is empty and no process is listening for events.
This is a common return code if acpid is not running.

- Add EAGAIN to known issues list for /proc/acpi/event.

Signed-off-by: David Mackey <tdmackey@twitter.com>
---
 testcases/kernel/fs/proc/proc01.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/fs/proc/proc01.c b/testcases/kernel/fs/proc/proc01.c
index a6fb3d9..f7444a6 100644
--- a/testcases/kernel/fs/proc/proc01.c
+++ b/testcases/kernel/fs/proc/proc01.c
@@ -87,6 +87,7 @@ const Mapping known_issues[] = {
     {"open", "/proc/sal/cmc/data", EBUSY},
     {"open", "/proc/sal/init/data", EBUSY},
     {"open", "/proc/sal/mca/data", EBUSY},
+    {"read", "/proc/acpi/event", EAGAIN},
     {"read", "/proc/kmsg", EAGAIN},
     {"read", "/proc/sal/cpe/event", EAGAIN},
     {"read", "/proc/sal/cmc/event", EAGAIN},
-- 
1.7.11.7


------------------------------------------------------------------------------
LogMeIn Central: Instant, anywhere, Remote PC access and management.
Stay in control, update software, and manage PCs from one command center
Diagnose problems and improve visibility into emerging IT issues
Automate, monitor and manage. Do more in less time with Central
http://p.sf.net/sfu/logmein12331_d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
