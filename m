Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <mad_soft@inbox.ru>) id 1R9cGy-0005gF-UB
	for ltp-list@lists.sourceforge.net; Fri, 30 Sep 2011 12:33:01 +0000
Received: from smtp2.mail.ru ([94.100.176.130])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1R9cGx-0002Nh-Ae
	for ltp-list@lists.sourceforge.net; Fri, 30 Sep 2011 12:33:00 +0000
Received: from [95.73.125.199] (port=11597 helo=macmini.mad.is-a-geek.org)
	by smtp2.mail.ru with asmtp id 1R9cGq-0001uH-00
	for ltp-list@lists.sourceforge.net; Fri, 30 Sep 2011 16:32:52 +0400
From: Dmitry Artamonow <mad_soft@inbox.ru>
Date: Fri, 30 Sep 2011 16:32:50 +0400
Message-Id: <1317385970-4899-1-git-send-email-mad_soft@inbox.ru>
Subject: [LTP] [PATCH] fs/proc01: namespaces fix for kernel >= 3.0
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

Add exclusion for /proc/self/.../ns/{net,uts,ipc} files introduced
in kernel 3.0. These files aren't meant to be read and merely
used for getting filedescriptor as a handle to corresponding namespace.
Any file operation on them including read() returns -EINVAL.

Signed-off-by: Dmitry Artamonow <mad_soft@inbox.ru>
---
 testcases/kernel/fs/proc/proc01.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

Resending. Previous mail got stuck in moderation queue (2 days already),
as I wasn't subscribed when sending (seems that kernel hacking spoiled me,
I forgot that not open mailing lists also exist).
Sorry, if you'll get it twice in the end.

diff --git a/testcases/kernel/fs/proc/proc01.c b/testcases/kernel/fs/proc/proc01.c
index ef40a78..0a7695a 100644
--- a/testcases/kernel/fs/proc/proc01.c
+++ b/testcases/kernel/fs/proc/proc01.c
@@ -94,6 +94,8 @@ const Mapping known_issues[] = {
     {"read", "/proc/self/task/[0-9]*/mem", EIO},
     {"read", "/proc/self/attr/*", EINVAL},
     {"read", "/proc/self/task/[0-9]*/attr/*", EINVAL},
+    {"read", "/proc/self/ns/*", EINVAL},
+    {"read", "/proc/self/task/[0-9]*/ns/*", EINVAL},
     {"read", "/proc/ppc64/rtas/error_log", EINVAL},
     {"read", "/proc/powerpc/rtas/error_log", EINVAL},
     {"read", "/proc/fs/nfsd/unlock_filesystem", EINVAL},
-- 
1.7.5.1.300.gc565c


------------------------------------------------------------------------------
All of the data generated in your IT infrastructure is seriously valuable.
Why? It contains a definitive record of application performance, security
threats, fraudulent activity, and more. Splunk takes this data and makes
sense of it. IT sense. And common sense.
http://p.sf.net/sfu/splunk-d2dcopy2
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
