From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Mon, 14 Nov 2016 17:55:09 +0800
Subject: [LTP] [PATCH] runalltests.sh: remove obsolete data from Makefile
Message-ID: <1479117309-3611-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Installation failed because runalltests.sh has been removed in:

commit 7be6224fb296e0d506a4d48d0bc03ba3ea912210
Author: Petr Vorel <pvorel@suse.cz>
Date:   Thu Nov 10 12:54:41 2016 +0100

    runalltests.sh: removed

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 297f8e7..94f2532 100644
--- a/Makefile
+++ b/Makefile
@@ -163,7 +163,7 @@ clean:: $(CLEAN_TARGETS)
 $(foreach tgt,$(MAKE_TARGETS) include-all lib-all $(filter-out clean_install_dir,$(CLEAN_TARGETS)) $(INSTALL_TARGETS) include-install lib-install,$(eval $(call target_to_dir_dep_mapping,$(tgt))))
 
 BINDIR_INSTALL_SCRIPTS	:= execltp
-SRCDIR_INSTALL_SCRIPTS	:= IDcheck.sh runalltests.sh runltp runltplite.sh ver_linux
+SRCDIR_INSTALL_SCRIPTS	:= IDcheck.sh runltp runltplite.sh ver_linux
 SRCDIR_INSTALL_READONLY	:= Version
 SRCDIR_INSTALL_TARGETS	:= $(SRCDIR_INSTALL_SCRIPTS) $(SRCDIR_INSTALL_READONLY)
 
-- 
1.8.3.1



