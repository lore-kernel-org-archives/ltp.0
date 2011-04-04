Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <aelder@sgi.com>) id 1Q6idh-0005hE-Jj
	for ltp-list@lists.sourceforge.net; Mon, 04 Apr 2011 12:12:13 +0000
Received: from relay1.sgi.com ([192.48.179.29] helo=relay.sgi.com)
	by sog-mx-2.v43.ch3.sourceforge.com with smtp (Exim 4.74)
	id 1Q6idd-0007QZ-D6
	for ltp-list@lists.sourceforge.net; Mon, 04 Apr 2011 12:12:13 +0000
Received: from cf--amer001e--3.americas.sgi.com
	(cf--amer001e--3.americas.sgi.com [137.38.100.5])
	by relay1.corp.sgi.com (Postfix) with ESMTP id 24D9F8F807A
	for <ltp-list@lists.sourceforge.net>;
	Mon,  4 Apr 2011 05:12:04 -0700 (PDT)
From: Alex Elder <aelder@sgi.com>
Date: Mon, 04 Apr 2011 07:08:42 -0500
Message-ID: <1301918922.3282.29.camel@doink>
Mime-Version: 1.0
Subject: [LTP] [PATCH 6/6] ltp: enable -Wall for doio compiles
Reply-To: aelder@sgi.com
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
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list <ltp-list@lists.sourceforge.net>

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
