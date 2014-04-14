Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <mats.liljegren@enea.com>) id 1WZcLt-00013J-87
	for ltp-list@lists.sourceforge.net; Mon, 14 Apr 2014 08:34:53 +0000
Received: from sestofw01.enea.se ([192.36.1.252] helo=mx-3.enea.com)
	by sog-mx-3.v43.ch3.sourceforge.com with smtp (Exim 4.76)
	id 1WZcLr-0002XK-HN
	for ltp-list@lists.sourceforge.net; Mon, 14 Apr 2014 08:34:53 +0000
From: Mats Liljegren <mats.liljegren@enea.com>
Date: Mon, 14 Apr 2014 10:34:25 +0200
Message-ID: <1397464465-34971-1-git-send-email-mats.liljegren@enea.com>
In-Reply-To: <534B5C8E.1070500@cn.fujitsu.com>
References: <534B5C8E.1070500@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] testcases/kernel/mem: Fixed compile error
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
To: ltp-list@lists.sourceforge.net

When compiling, the following error occurred:

make[6]: Entering directory `/nfs/hosts/sestonas06/homes/mlil/git/ltp/testcases/kernel/mem/lib'
make[6]: ../../../../../testcases/kernel/mem/lib/Makefile: No such file or directory

This is because the file libmem.mk tried to both change current working
to where the Makefile is as well as giving a relative path to it.

This has been fixed by simply removing the relative path to the Makefile since
make knows how to find the correct make file itself.

Reported-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Signed-off-by: Mats Liljegren <mats.liljegren@enea.com>
---
 testcases/kernel/mem/include/libmem.mk |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/mem/include/libmem.mk b/testcases/kernel/mem/include/libmem.mk
index 7ebcf05..a90ce8f 100644
--- a/testcases/kernel/mem/include/libmem.mk
+++ b/testcases/kernel/mem/include/libmem.mk
@@ -31,13 +31,13 @@ $(LIBMEM_DIR):
 	mkdir -p "$@"
 
 $(LIBMEM): $(LIBMEM_DIR)
-	$(MAKE) -C $^ -f "$(LIBMEM_SRCDIR)/Makefile" all
+	$(MAKE) -C $^ all
 
 MAKE_DEPS		+= $(LIBMEM)
 
 trunk-clean:: | lib-clean
 
 lib-clean:: $(LIBMEM_DIR)
-	$(MAKE) -C $^ -f "$(LIBMEM_SRCDIR)/Makefile" clean
+	$(MAKE) -C $^ clean
 
 include $(top_srcdir)/testcases/kernel/include/lib.mk
-- 
1.7.10.4


------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
