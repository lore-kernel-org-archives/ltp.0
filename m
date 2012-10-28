Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <tdmackey@twitter.com>) id 1TSOlp-00021H-IH
	for ltp-list@lists.sourceforge.net; Sun, 28 Oct 2012 09:03:01 +0000
Received: from mail-pa0-f47.google.com ([209.85.220.47])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1TSOlo-0007z7-Qf
	for ltp-list@lists.sourceforge.net; Sun, 28 Oct 2012 09:03:01 +0000
Received: by mail-pa0-f47.google.com with SMTP id fa11so2645650pad.34
	for <ltp-list@lists.sourceforge.net>;
	Sun, 28 Oct 2012 02:02:54 -0700 (PDT)
From: David Mackey <tdmackey@twitter.com>
Date: Sun, 28 Oct 2012 01:38:11 -0700
Message-Id: <1351413491-18760-1-git-send-email-tdmackey@twitter.com>
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

Calling open on /proc/acpi/event with O_NONBLOCK will return EAGAIN if
the acpi bus event list is empty and no process is listening for events.
This is a common errno if acpid is not running.

- Add EAGAIN to known issues list for /proc/acpi/event.

Signed-off-by: David Mackey <tdmackey@twitter.com>
---
 testcases/kernel/fs/proc/proc01.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/fs/proc/proc01.c b/testcases/kernel/fs/proc/proc01.c
index a6fb3d9..1c2b392 100644
--- a/testcases/kernel/fs/proc/proc01.c
+++ b/testcases/kernel/fs/proc/proc01.c
@@ -82,6 +82,7 @@ typedef struct mapping Mapping;
    like if SELinux is disabled, the test may still fail on some other
    entries. */
 const Mapping known_issues[] = {
+    {"open", "/proc/acpi/event", EAGAIN},
     {"open", "/proc/acpi/event", EBUSY},
     {"open", "/proc/sal/cpe/data", EBUSY},
     {"open", "/proc/sal/cmc/data", EBUSY},
-- 
1.7.11.7


------------------------------------------------------------------------------
WINDOWS 8 is here. 
Millions of people.  Your app in 30 days.
Visit The Windows 8 Center at Sourceforge for all your go to resources.
http://windows8center.sourceforge.net/
join-generation-app-and-make-money-coding-fast/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
