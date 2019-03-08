From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri,  8 Mar 2019 15:55:54 +0100
Subject: [LTP] [PATCH] Fix out-of-tree build.
Message-ID: <20190308145554.17299-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Ths fixes out of tree build by making the libs directory to be
dependency of libs-all.

Not that the the lib and include directory are created as the side efect
of the AC_CONFIG_FILES() and hence don't need to be created in the
top-level Makefile.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
CC: Petr Vorel <pvorel@suse.cz>
CC: Jan Stancek <jstancek@redhat.com>
---

This should be last fix for the numa build troubles.

I still have out-of-tree build failures in ffsb configure but I had
enough autoconf and make for today...

 Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Makefile b/Makefile
index bc6e9a3e0..170c2da20 100644
--- a/Makefile
+++ b/Makefile
@@ -110,6 +110,11 @@ $(sort $(addprefix $(abs_top_builddir)/,$(BOOTSTRAP_TARGETS)) $(INSTALL_DIR) $(D
 ## Pattern based subtarget rules.
 lib-install: lib-all
 
+$(abs_top_builddir)/libs:
+	mkdir -m 00755 -p "$@"
+
+libs-all: $(abs_top_builddir)/libs
+
 $(MAKE_TARGETS) include-all lib-all libs-all:
 	$(MAKE) -C "$(subst -all,,$@)" \
 		-f "$(abs_top_srcdir)/$(subst -all,,$@)/Makefile" all
-- 
2.19.2

