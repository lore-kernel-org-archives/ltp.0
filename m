Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@users.sourceforge.net>) id 1NpEWx-0006y3-A6
	for ltp-list@lists.sourceforge.net; Wed, 10 Mar 2010 05:32:27 +0000
Received: from sfp-scmshell-1.v30.ch3.sourceforge.com ([172.29.30.123])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NpEWx-0005GB-84
	for ltp-list@lists.sourceforge.net; Wed, 10 Mar 2010 05:32:27 +0000
Received: from localhost ([127.0.0.1]
	helo=sfp-scmshell-1.v30.ch3.sourceforge.com)
	by sfp-scmshell-1.v30.ch3.sourceforge.com with smtp (Exim 4.69)
	(envelope-from <risrajak@users.sourceforge.net>) id 1NpEWu-0001sD-51
	for ltp-list@lists.sourceforge.net; Wed, 10 Mar 2010 05:32:27 +0000
From: "Rishi kesh K Rajak" <risrajak@linux.vnet.ibm.com>
Date: Wed, 10 Mar 2010 05:32:18 +0000
Message-Id: <E1NpEWu-0001sD-51@sfp-scmshell-1.v30.ch3.sourceforge.com>
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
       via  1a5506c97dcfda0bd16f83ca855bb633c47eea4c (commit)
      from  48c52fcd4e7668bc36bbe080f53462d410712b69 (commit)


- Log -----------------------------------------------------------------
commit 1a5506c97dcfda0bd16f83ca855bb633c47eea4c
Author: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Date:   Wed Mar 10 11:01:47 2010 +0530

    Fix make filed,, reported by Shi Weihua <shiwh@cn.fujitsu.com>
    It was my bad :( .
    
    Signed-off-by: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>

-----------------------------------------------------------------------

Summary of changes:
 testcases/kernel/containers/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)
 
diff --git a/testcases/kernel/containers/Makefile b/testcases/kernel/containers/Makefile
index 29394c3..75eda63 100644
--- a/testcases/kernel/containers/Makefile
+++ b/testcases/kernel/containers/Makefile
@@ -26,7 +26,7 @@ FILTER_OUT_DIRS		:= $(LIBDIR)
 
 LIB			:= $(LIBDIR)/libclone.a
 
-LDLIB			:= -ldl
+LDLIBS			:= -ldl
 
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
