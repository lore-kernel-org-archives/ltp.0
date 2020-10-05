From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon,  5 Oct 2020 15:30:51 +0200
Subject: [LTP] [PATCH 08/11] make: Allow CLEAN_TARGETS to remove directories
In-Reply-To: <20201005133054.23587-1-chrubis@suse.cz>
References: <20201005133054.23587-1-chrubis@suse.cz>
Message-ID: <20201005133054.23587-9-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Petr Vorel <pvorel@suse.cz>

make clean on leaf target can contain also directories.

Changing delete to recursive delete (-r parameter for rm) should be safe
thus detection whether actually requited is not implemented.

This will be needed for metadata metadata.chunked target.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 include/mk/generic_leaf_target.inc | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/mk/generic_leaf_target.inc b/include/mk/generic_leaf_target.inc
index e6fa107d1..64953f89a 100644
--- a/include/mk/generic_leaf_target.inc
+++ b/include/mk/generic_leaf_target.inc
@@ -60,10 +60,10 @@
 # $(HOST_MAKE_TARGETS)	: Host tools which use $HOSTCC.
 #
 # $(CLEAN_TARGETS)		: What targets should be cleaned (must be
-#				  real files). This will automatically append
-#				  adds the .o suffix to all files referenced
-#				  by $(MAKE_TARGETS)) to CLEAN_TARGETS, if
-#				  MAKE_TARGETS wasn't defined (see
+#				  real files or directories). This will automatically append
+#				  adds the .o suffix to all files referenced by
+#				  $(MAKE_TARGETS)) to CLEAN_TARGETS, if MAKE_TARGETS wasn't
+#				  defined (see
 #				  $(MAKE_TARGETS)).
 # $(INSTALL_MODE)		: What mode should we using when calling
 # 				  install(1)?
@@ -103,7 +103,7 @@ $(MAKE_TARGETS): | $(MAKE_DEPS)
 all: $(MAKE_TARGETS)
 
 clean:: $(CLEAN_DEPS)
-	-$(RM) -f $(CLEAN_TARGETS)
+	-$(RM) -f -r $(CLEAN_TARGETS)
 
 $(INSTALL_FILES): | $(INSTALL_DEPS)
 
-- 
2.26.2

