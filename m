Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1SCAnK-0003kw-3D
	for ltp-list@lists.sourceforge.net; Mon, 26 Mar 2012 14:21:14 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SCAnJ-0007Ya-Ai
	for ltp-list@lists.sourceforge.net; Mon, 26 Mar 2012 14:21:14 +0000
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q2QEL7Ga028374
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 26 Mar 2012 10:21:07 -0400
Message-ID: <4F707B51.4090306@redhat.com>
Date: Mon, 26 Mar 2012 16:21:05 +0200
From: Jan Stancek <jstancek@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000809090700070707060502"
Subject: [LTP] [PATCH] mremap: fix dependency on ipc subdir
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: Jeffrey Burke <jburke@redhat.com>

This is a multi-part message in MIME format.
--------------000809090700070707060502
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


We need to use MAKE_DEPS to declare the ipc subdir depend otherwise
attempting to do `make mremap01` without building in the ipc subdir
will fail, and we can hit race conditions in the overall `make`.

This is same change as in commit:
commit 7103d3e8e0f9dc1804ba06ee66ee02753e8ce50e
Author: Mike Frysinger <vapier@gentoo.org>
Date:   Fri Mar 23 12:27:13 2012 -0400
     kill: fix dependency on ipc subdir

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
  testcases/kernel/syscalls/mremap/Makefile |    2 +-
  1 files changed, 1 insertions(+), 1 deletions(-)



--------------000809090700070707060502
Content-Type: text/x-patch;
	name="0001-mremap-fix-dependency-on-ipc-subdir.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="0001-mremap-fix-dependency-on-ipc-subdir.patch"

diff --git a/testcases/kernel/syscalls/mremap/Makefile b/testcases/kernel/syscalls/mremap/Makefile
index 63e7485..102e473 100644
--- a/testcases/kernel/syscalls/mremap/Makefile
+++ b/testcases/kernel/syscalls/mremap/Makefile
@@ -32,7 +32,7 @@ $(LIBDIR):
 $(LIB): $(LIBDIR)
 	$(MAKE) -C $^ -f "$(abs_srcdir)/$^/Makefile" all
 
-all: | $(LIB)
+MAKE_DEPS		:= $(LIB)
 
 CPPFLAGS                += -I$(abs_srcdir)/$(LIBDIR)
 


--------------000809090700070707060502
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF email is sponsosred by:
Try Windows Azure free for 90 days Click Here 
http://p.sf.net/sfu/sfd2d-msazure
--------------000809090700070707060502
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------000809090700070707060502--

