Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1VEFDf-0003Xt-T7
	for ltp-list@lists.sourceforge.net; Tue, 27 Aug 2013 09:05:47 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VEFDa-00020H-U2
	for ltp-list@lists.sourceforge.net; Tue, 27 Aug 2013 09:05:47 +0000
Received: from int-mx12.intmail.prod.int.phx2.redhat.com
	(int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r7R95a4s023844
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 27 Aug 2013 05:05:36 -0400
From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 27 Aug 2013 11:05:32 +0200
Message-Id: <2060663a46bc8d66f90a9686c7fe4a83d21e40a4.1377594171.git.jstancek@redhat.com>
Subject: [LTP] [PATCH] proc01: add use-gss-proxy to known_issues list
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

Following commit implemented non-blocking read for use-gss-proxy:
  commit b161c144404c18f6a9e20e46b63828ae3c2eb093
  Author: J. Bruce Fields <bfields@redhat.com>
    Date:   Fri May 24 09:47:49 2013 -0400
        svcrpc: implement O_NONBLOCK behavior for use-gss-proxy

Prior to this commit non-block read hanged, but it happened
only in -rc kernels, which we can ignore.

Note, that this proc entry is available only when you load module
auth_rpcgss.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/fs/proc/proc01.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/testcases/kernel/fs/proc/proc01.c b/testcases/kernel/fs/proc/proc01.c
index f2aa483..2771cd4 100644
--- a/testcases/kernel/fs/proc/proc01.c
+++ b/testcases/kernel/fs/proc/proc01.c
@@ -106,6 +106,7 @@ static const struct mapping known_issues[] = {
 	{"read", "/proc/fs/nfsd/filehandle", EINVAL},
 	{"read", "/proc/fs/nfsd/.getfs", EINVAL},
 	{"read", "/proc/fs/nfsd/.getfd", EINVAL},
+	{"read", "/proc/self/net/rpc/use-gss-proxy", EAGAIN},
 	{"", "", 0}
 };
 
-- 
1.7.1


------------------------------------------------------------------------------
Introducing Performance Central, a new site from SourceForge and 
AppDynamics. Performance Central is your source for news, insights, 
analysis and resources for efficient Application Performance Management. 
Visit us today!
http://pubads.g.doubleclick.net/gampad/clk?id=48897511&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
