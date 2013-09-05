Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1VHU0P-00082x-Ap
	for ltp-list@lists.sourceforge.net; Thu, 05 Sep 2013 07:29:29 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VHU0O-0002f1-8q
	for ltp-list@lists.sourceforge.net; Thu, 05 Sep 2013 07:29:29 +0000
Received: from int-mx02.intmail.prod.int.phx2.redhat.com
	(int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r857TMne018750
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 5 Sep 2013 03:29:22 -0400
From: Jan Stancek <jstancek@redhat.com>
Date: Thu,  5 Sep 2013 09:29:13 +0200
Message-Id: <9e5ca46eba40644a4d51bb60f9a81d2b99cc814c.1378366073.git.jstancek@redhat.com>
Subject: [LTP] [PATCH] proc01: add nfsd/pool_stats to list of known issues
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

This file is available if /proc/fs/nfsd filesystem is mounted,
but it can be opened only when nfs server is running.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/fs/proc/proc01.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/testcases/kernel/fs/proc/proc01.c b/testcases/kernel/fs/proc/proc01.c
index 2771cd4..73a55c8 100644
--- a/testcases/kernel/fs/proc/proc01.c
+++ b/testcases/kernel/fs/proc/proc01.c
@@ -85,6 +85,7 @@ static const struct mapping known_issues[] = {
 	{"open", "/proc/sal/cmc/data", EBUSY},
 	{"open", "/proc/sal/init/data", EBUSY},
 	{"open", "/proc/sal/mca/data", EBUSY},
+	{"open", "/proc/fs/nfsd/pool_stats", ENODEV},
 	{"read", "/proc/acpi/event", EAGAIN},
 	{"read", "/proc/kmsg", EAGAIN},
 	{"read", "/proc/sal/cpe/event", EAGAIN},
-- 
1.7.1


------------------------------------------------------------------------------
Learn the latest--Visual Studio 2012, SharePoint 2013, SQL 2012, more!
Discover the easy way to master current and previous Microsoft technologies
and advance your career. Get an incredible 1,500+ hours of step-by-step
tutorial videos with LearnDevNow. Subscribe today and save!
http://pubads.g.doubleclick.net/gampad/clk?id=58041391&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
