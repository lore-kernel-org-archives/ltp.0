Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1POalt-0006Cr-Dr
	for ltp-list@lists.sourceforge.net; Fri, 03 Dec 2010 18:54:17 +0000
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 787C5945D8
	for <ltp-list@lists.sourceforge.net>;
	Fri,  3 Dec 2010 19:54:09 +0100 (CET)
Date: Fri, 3 Dec 2010 20:07:23 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20101203190723.GA2420@saboteur.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline
Subject: [LTP] [PATCH] cleanup ar0 testcase
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


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!
The ar0 testcase, as the matter of a fact, doesn't need any of the object
files that are compiled from the file*.c. Attached patch removes them.

Signed-off-by: Cyril Hrubis chrubis@suse.cz

-- 
Cyril Hrubis
chrubis@suse.cz

--LQksG6bCIzRHxTLp
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="remove_unused_ar0_files.patch"

diff --git a/testcases/commands/ade/ar/Makefile b/testcases/commands/ade/ar/Makefile
index b6ab633..c9c189b 100644
--- a/testcases/commands/ade/ar/Makefile
+++ b/testcases/commands/ade/ar/Makefile
@@ -24,13 +24,6 @@ top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/env_pre.mk
 
-CPPFLAGS		+= -fpic
-
 INSTALL_TARGETS		:= ar01 *.in
 
-MAKE_TARGETS		:= $(patsubst $(abs_srcdir)/%.c,%.obj,$(wildcard $(abs_srcdir)/*.c))
-
-$(MAKE_TARGETS): %.obj: %.o
-	mv "$^" "$@"
-
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/commands/ade/ar/file1.c b/testcases/commands/ade/ar/file1.c
deleted file mode 100644
index 27b57b5..0000000
--- a/testcases/commands/ade/ar/file1.c
+++ /dev/null
@@ -1,7 +0,0 @@
-#include <stdio.h>
-
-int main(void)
-{
-        printf("Hello World\n");
-	return 0;
-}
diff --git a/testcases/commands/ade/ar/file2.c b/testcases/commands/ade/ar/file2.c
deleted file mode 100644
index 27b57b5..0000000
--- a/testcases/commands/ade/ar/file2.c
+++ /dev/null
@@ -1,7 +0,0 @@
-#include <stdio.h>
-
-int main(void)
-{
-        printf("Hello World\n");
-	return 0;
-}
diff --git a/testcases/commands/ade/ar/file3.c b/testcases/commands/ade/ar/file3.c
deleted file mode 100644
index 27b57b5..0000000
--- a/testcases/commands/ade/ar/file3.c
+++ /dev/null
@@ -1,7 +0,0 @@
-#include <stdio.h>
-
-int main(void)
-{
-        printf("Hello World\n");
-	return 0;
-}

--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Increase Visibility of Your 3D Game App & Earn a Chance To Win $500!
Tap into the largest installed PC base & get more eyes on your game by
optimizing for Intel(R) Graphics Technology. Get started today with the
Intel(R) Software Partner Program. Five $500 cash prizes are up for grabs.
http://p.sf.net/sfu/intelisp-dev2dev
--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--LQksG6bCIzRHxTLp--

