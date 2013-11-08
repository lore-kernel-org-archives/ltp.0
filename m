Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1VekzI-0001rK-56
	for ltp-list@lists.sourceforge.net; Fri, 08 Nov 2013 12:16:32 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VekzH-000295-8Q
	for ltp-list@lists.sourceforge.net; Fri, 08 Nov 2013 12:16:32 +0000
Received: from ucsinet21.oracle.com (ucsinet21.oracle.com [156.151.31.93])
	by userp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id rA8CGOX1023153
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 8 Nov 2013 12:16:25 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
	by ucsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rA8CGNUx003374
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Fri, 8 Nov 2013 12:16:24 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
	by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rA8CGNZb003360
	for <ltp-list@lists.sourceforge.net>; Fri, 8 Nov 2013 12:16:23 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Fri,  8 Nov 2013 16:16:17 +0400
Message-Id: <1383912978-15159-1-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <527B7226.5090809@oracle.com>
References: <527B7226.5090809@oracle.com>
Subject: [LTP] [PATCH V2 1/2] syscalls/ipc/Makefile.inc: changed LIB to
	LIBIPC
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
Cc: vasily.isaenko@oracle.com

Both lib.mk and testcases/kernel/syscalls/ipc/Makefile.inc set
LIB. It confuses make when both failes are included into a leaf Makefile.

Renamed LIB to LIBIPC in Makefile.inc.

The idea is by Cyril Hrubis <chrubis@suse.cz>

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 testcases/kernel/syscalls/ipc/Makefile.inc |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/ipc/Makefile.inc b/testcases/kernel/syscalls/ipc/Makefile.inc
index a468e93..c7890a9 100644
--- a/testcases/kernel/syscalls/ipc/Makefile.inc
+++ b/testcases/kernel/syscalls/ipc/Makefile.inc
@@ -25,15 +25,15 @@
 LDLIBS			+= -lipc
 LIBDIR			:= ../lib
 
-LIB			:= $(LIBDIR)/libipc.a
+LIBIPC			:= $(LIBDIR)/libipc.a
 
 $(LIBDIR):
 	mkdir -p "$@"
 
-$(LIB): $(LIBDIR)
+$(LIBIPC): $(LIBDIR)
 	$(MAKE) -C $^ -f "$(abs_srcdir)/$^/Makefile" all
 
-MAKE_DEPS		:= $(LIB)
+MAKE_DEPS		:= $(LIBIPC)
 
 CPPFLAGS		+= -I$(abs_srcdir)/$(LIBDIR)
 
-- 
1.7.1


------------------------------------------------------------------------------
November Webinars for C, C++, Fortran Developers
Accelerate application performance with scalable programming models. Explore
techniques for threading, error checking, porting, and tuning. Get the most 
from the latest Intel processors and coprocessors. See abstracts and register
http://pubads.g.doubleclick.net/gampad/clk?id=60136231&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
