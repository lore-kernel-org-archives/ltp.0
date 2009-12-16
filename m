Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <liubo2009@cn.fujitsu.com>) id 1NKsBm-0000lW-TW
	for ltp-list@lists.sourceforge.net; Wed, 16 Dec 2009 11:37:06 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NKsBh-0004hu-E0
	for ltp-list@lists.sourceforge.net; Wed, 16 Dec 2009 11:37:06 +0000
Received: from tang.cn.fujitsu.com (tang.cn.fujitsu.com [10.167.250.3])
	by song.cn.fujitsu.com (Postfix) with ESMTP id 24334170130
	for <ltp-list@lists.sourceforge.net>;
	Wed, 16 Dec 2009 19:36:49 +0800 (CST)
Received: from fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id nBGBal6j026786
	for <ltp-list@lists.sourceforge.net>; Wed, 16 Dec 2009 19:36:47 +0800
Received: from localhost.localdomain (unknown [10.167.141.167])
	by fnst.cn.fujitsu.com (Postfix) with ESMTPA id 36B66D45B6
	for <ltp-list@lists.sourceforge.net>;
	Wed, 16 Dec 2009 19:37:09 +0800 (CST)
Message-ID: <4B28C683.3030106@cn.fujitsu.com>
Date: Wed, 16 Dec 2009 19:37:39 +0800
From: liubo <liubo2009@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH 1/3] ade: fix the bug of objdump01
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

- LTP needs to test "objdump", but ade's Makefile exclude it.
- objdump01 case uses *.obj instead, so s/*.o/*.obj/

This patch fixed these.

Signed-off-by: Liu Bo <liubo2009@cn.fujitsu.com>

---
 testcases/commands/ade/Makefile          |    2 +-
 testcases/commands/ade/objdump/Makefile  |    4 ++--
 testcases/commands/ade/objdump/objdump01 |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/testcases/commands/ade/Makefile b/testcases/commands/ade/Makefile
index cf7a487..79de5ec 100644
--- a/testcases/commands/ade/Makefile
+++ b/testcases/commands/ade/Makefile
@@ -25,6 +25,6 @@ top_srcdir		?= ../../..
 include $(top_srcdir)/include/mk/env_pre.mk
 
 # XXX (garrcoop): objdump's Makefile needs fixing.
-FILTER_OUT_DIRS		:= objdump
+FILTER_OUT_DIRS		:= 
 
 include $(top_srcdir)/include/mk/generic_trunk_target.mk
diff --git a/testcases/commands/ade/objdump/Makefile b/testcases/commands/ade/objdump/Makefile
index 862438c..7fffc88 100644
--- a/testcases/commands/ade/objdump/Makefile
+++ b/testcases/commands/ade/objdump/Makefile
@@ -29,8 +29,8 @@ test: CPPFLAGS += -O
 test_arch.obj: test.o
 	mv $< "$@"
 
-test_D: test.o
-	$(LINK.o) $^ $(LOADLIBES) $(LDLIBS) $(OUTPUT_OPTION) $@
+test_D: test_arch.obj
+	$(LINK.o) $^ $(LOADLIBES) $(LDLIBS) $(OUTPUT_OPTION)
 
 INSTALL_TARGETS		:= objdump01
  
diff --git a/testcases/commands/ade/objdump/objdump01 b/testcases/commands/ade/objdump/objdump01
index 379a4f8..dd18e46 100755
--- a/testcases/commands/ade/objdump/objdump01
+++ b/testcases/commands/ade/objdump/objdump01
@@ -41,7 +41,7 @@ export DUMP=/usr/bin/objdump
 do_setup()
 {
 mkdir $TCtmp
-/usr/bin/ar -cr $TCtmp/lib.a $TCsrc/test_arch.o
+/usr/bin/ar -cr $TCtmp/lib.a $TCsrc/test_arch.obj
 
 echo 1; $DUMP -f $TCsrc/test > $TCtmp/er_dump_f
 echo 2; $DUMP -h $TCsrc/test > $TCtmp/er_dump_h
-- 
1.6.2.2






------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
