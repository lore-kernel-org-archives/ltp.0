Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <aelder@sgi.com>) id 1Q5mPS-0002yT-7n
	for ltp-list@lists.sourceforge.net; Fri, 01 Apr 2011 22:01:38 +0000
Received: from relay1.sgi.com ([192.48.179.29] helo=relay.sgi.com)
	by sog-mx-1.v43.ch3.sourceforge.com with smtp (Exim 4.74)
	id 1Q5mPR-0007f1-NR
	for ltp-list@lists.sourceforge.net; Fri, 01 Apr 2011 22:01:38 +0000
From: Alex Elder <aelder@sgi.com>
Date: Fri,  1 Apr 2011 17:01:28 -0500
Message-Id: <f39f962d54cc562f0c03f1f86fe16d0a0fe55a55.1301695094.git.aelder@sgi.com>
In-Reply-To: <1301695288-24912-1-git-send-email-aelder@sgi.com>
References: <1301695288-24912-1-git-send-email-aelder@sgi.com>
In-Reply-To: <26c7134d7a0855a4bd8a5f73e7dfc8088115f9d2.1301695094.git.aelder@sgi.com>
References: <26c7134d7a0855a4bd8a5f73e7dfc8088115f9d2.1301695094.git.aelder@sgi.com>
Subject: [LTP] [PATCH 6/6] ltp: enable -Wall for doio compiles
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

Now that the code has been made modern and a few minor problems have
been addressed, enable the "-Wall" flag for gcc when building files
under "testcases/kernel/fs/doio/".

Signed-off-by: Alex Elder <aelder@sgi.com>
---
 testcases/kernel/fs/doio/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/testcases/kernel/fs/doio/Makefile b/testcases/kernel/fs/doio/Makefile
index 2cfc8b7..7e56089 100644
--- a/testcases/kernel/fs/doio/Makefile
+++ b/testcases/kernel/fs/doio/Makefile
@@ -24,7 +24,7 @@ top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 
-CFLAGS			+= -D_LARGEFILE64_SOURCE
+CFLAGS			+= -D_LARGEFILE64_SOURCE -Wall
 LDLIBS			+= -lrt -lpthread
 
 INSTALL_TARGETS		:= rwtest
-- 
1.7.4


------------------------------------------------------------------------------
Create and publish websites with WebMatrix
Use the most popular FREE web apps or write code yourself; 
WebMatrix provides all the features you need to develop and 
publish your website. http://p.sf.net/sfu/ms-webmatrix-sf
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
