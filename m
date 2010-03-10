Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@users.sourceforge.net>) id 1NpEZd-0002BD-RU
	for ltp-list@lists.sourceforge.net; Wed, 10 Mar 2010 05:35:13 +0000
Received: from sfp-scmshell-2.v30.ch3.sourceforge.com ([172.29.30.124])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NpEZd-0000RU-NF
	for ltp-list@lists.sourceforge.net; Wed, 10 Mar 2010 05:35:13 +0000
Received: from localhost ([127.0.0.1]
	helo=sfp-scmshell-2.v30.ch3.sourceforge.com)
	by sfp-scmshell-2.v30.ch3.sourceforge.com with smtp (Exim 4.69)
	(envelope-from <risrajak@users.sourceforge.net>) id 1NpEZZ-0005mI-LI
	for ltp-list@lists.sourceforge.net; Wed, 10 Mar 2010 05:35:13 +0000
From: "Rishi kesh K Rajak" <risrajak@linux.vnet.ibm.com>
Date: Wed, 10 Mar 2010 05:35:08 +0000
Message-Id: <E1NpEZZ-0005mI-LI@sfp-scmshell-2.v30.ch3.sourceforge.com>
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

The branch, next, has been updated
       via  ce944320bea9e3d7044a36c64ef2e1719312370d (commit)
       via  1a5506c97dcfda0bd16f83ca855bb633c47eea4c (commit)
       via  48c52fcd4e7668bc36bbe080f53462d410712b69 (commit)
       via  c962f51674b971496e14ac4be0cc75da98b75fca (commit)
       via  17905ceabf2dc20e978dfa4ea3682197ad01bf9a (commit)
      from  bdfe0b2a9dd720c3013225cc4aa1628e77888b24 (commit)


- Log -----------------------------------------------------------------
commit ce944320bea9e3d7044a36c64ef2e1719312370d
Author: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Date:   Wed Mar 10 11:03:42 2010 +0530

    Merge branches 'master' and 'next' into next

-----------------------------------------------------------------------

Summary of changes:
 TODO                                 |    2 +-
 testcases/kernel/containers/Makefile |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
 
diff --git a/TODO b/TODO
index 9eec828..1756168 100644
--- a/TODO
+++ b/TODO
@@ -1,4 +1,4 @@
-The following things need to be rewritten // fixed:
+The following things need to be rewritten // fixed
 
 get_mempolicy01 // mbind01: They're using numa v1 calls which means that all
 versions of Linux / numa as of a few years ago aren't compatible with the API
diff --git a/testcases/kernel/containers/Makefile b/testcases/kernel/containers/Makefile
index 26f1856..75eda63 100644
--- a/testcases/kernel/containers/Makefile
+++ b/testcases/kernel/containers/Makefile
@@ -26,7 +26,7 @@ FILTER_OUT_DIRS		:= $(LIBDIR)
 
 LIB			:= $(LIBDIR)/libclone.a
 
-LIB			:= -ld
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
