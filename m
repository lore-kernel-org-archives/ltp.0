Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@users.sourceforge.net>) id 1NpDZM-0008AF-F1
	for ltp-list@lists.sourceforge.net; Wed, 10 Mar 2010 04:30:52 +0000
Received: from sfp-scmshell-2.v30.ch3.sourceforge.com ([172.29.30.124])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NpDZM-0006nM-Cd
	for ltp-list@lists.sourceforge.net; Wed, 10 Mar 2010 04:30:52 +0000
Received: from localhost ([127.0.0.1]
	helo=sfp-scmshell-2.v30.ch3.sourceforge.com)
	by sfp-scmshell-2.v30.ch3.sourceforge.com with smtp (Exim 4.69)
	(envelope-from <risrajak@users.sourceforge.net>) id 1NpDZI-0002Ux-VZ
	for ltp-list@lists.sourceforge.net; Wed, 10 Mar 2010 04:30:51 +0000
From: "Rishi kesh K Rajak" <risrajak@linux.vnet.ibm.com>
Date: Wed, 10 Mar 2010 04:30:47 +0000
Message-Id: <E1NpDZI-0002Ux-VZ@sfp-scmshell-2.v30.ch3.sourceforge.com>
Subject: [LTP] [Git] ltp updated.
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

The branch, master, has been updated
       via  48c52fcd4e7668bc36bbe080f53462d410712b69 (commit)
      from  c962f51674b971496e14ac4be0cc75da98b75fca (commit)


- Log -----------------------------------------------------------------
commit 48c52fcd4e7668bc36bbe080f53462d410712b69
Author: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Date:   Wed Mar 10 10:00:22 2010 +0530

    Instead of LIBS, it should be LDLIBS in container/Makefile
    
    Signed-off-by: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>

-----------------------------------------------------------------------

Summary of changes:
 testcases/kernel/containers/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)
 
diff --git a/testcases/kernel/containers/Makefile b/testcases/kernel/containers/Makefile
index 26f1856..29394c3 100644
--- a/testcases/kernel/containers/Makefile
+++ b/testcases/kernel/containers/Makefile
@@ -26,7 +26,7 @@ FILTER_OUT_DIRS		:= $(LIBDIR)
 
 LIB			:= $(LIBDIR)/libclone.a
 
-LIB			:= -ld
+LDLIB			:= -ldl
 
 INSTALL_TARGETS		:= *.sh 
 


hooks/post-receive
-- 
ltp

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
