From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 29 Mar 2017 15:31:56 +0200
Subject: [LTP] Out-of-tree build missing some data files.
In-Reply-To: <BN6PR11MB20517B46C814B90AB73E3D43CD320@BN6PR11MB2051.namprd11.prod.outlook.com>
References: <BN6PR11MB2051C2F128C4DC206D611144CD3F0@BN6PR11MB2051.namprd11.prod.outlook.com>
 <20170328133708.GF1045@rei>
 <BN6PR11MB20517B46C814B90AB73E3D43CD320@BN6PR11MB2051.namprd11.prod.outlook.com>
Message-ID: <20170329133156.GF7089@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Unfortunately, this doesn't seem to have had any effect. Changes were...
> 
> -INSTALL_TARGETS                := $(wildcard file*)
> +INSTALL_TARGETS                := $(wildcard $(abs_srcdir)/*.in)
> 
> -INSTALL_TARGETS                := $(wildcard *.c)
> +INSTALL_TARGETS                := $(wildcard $(abs_srcdir)/*.c)

Looking into the build system env_post.mk these are prefixed with
abs_srcdir automatically there so changing these to simply '*.c' or
'*.in' fixes the problem.

This patch fixes the installation for me:
(I will push it along with a few more out-of-tree build fixes)

diff --git a/testcases/commands/ar/datafiles/Makefile b/testcases/commands/ar/datafiles/Makefile
index 09dc029..ef99bca 100644
--- a/testcases/commands/ar/datafiles/Makefile
+++ b/testcases/commands/ar/datafiles/Makefile
@@ -15,5 +15,5 @@ top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/env_pre.mk
 INSTALL_DIR		:= testcases/data/ar01
-INSTALL_TARGETS		:= $(wildcard file*)
+INSTALL_TARGETS		:= file*
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/commands/file/datafiles/Makefile b/testcases/commands/file/datafiles/Makefile
index 6769fc6..d3cb847 100644
--- a/testcases/commands/file/datafiles/Makefile
+++ b/testcases/commands/file/datafiles/Makefile
@@ -15,5 +15,5 @@ top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/env_pre.mk
 INSTALL_DIR		:= testcases/data/file01
-INSTALL_TARGETS		:= $(wildcard in*)
+INSTALL_TARGETS		:= in*
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/commands/ld/datafiles/Makefile b/testcases/commands/ld/datafiles/Makefile
index 7b19207..4eb64ad 100644
--- a/testcases/commands/ld/datafiles/Makefile
+++ b/testcases/commands/ld/datafiles/Makefile
@@ -17,6 +17,6 @@ include $(top_srcdir)/include/mk/env_pre.mk
 
 INSTALL_DIR		:= testcases/data/ld01
 MAKE_TARGETS		:=
-INSTALL_TARGETS		:= $(wildcard *.c)
+INSTALL_TARGETS		:= *.c
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk

-- 
Cyril Hrubis
chrubis@suse.cz
