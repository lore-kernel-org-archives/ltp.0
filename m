From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon,  5 Oct 2020 15:30:50 +0200
Subject: [LTP] [PATCH 07/11] make: Allow {INSTALL,
 MAKE}_TARGETS be a directory
In-Reply-To: <20201005133054.23587-1-chrubis@suse.cz>
References: <20201005133054.23587-1-chrubis@suse.cz>
Message-ID: <20201005133054.23587-8-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Petr Vorel <pvorel@suse.cz>

by detecting it and adding required -d parameter for install
and installing whole directory with -t.

This will be needed for metadata metadata.chunked target.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 include/mk/functions.mk | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/mk/functions.mk b/include/mk/functions.mk
index 79c6193ca..e86dbccdc 100644
--- a/include/mk/functions.mk
+++ b/include/mk/functions.mk
@@ -35,7 +35,8 @@ INSTALL_FILES		+= $$(abspath $$(DESTDIR)/$(3)/$(1))
 
 $$(abspath $$(DESTDIR)/$(3)/$(1)): \
     $$(abspath $$(dir $$(DESTDIR)/$(3)/$(1)))
-	install -m $$(INSTALL_MODE) "$(2)/$(1)" "$$@"
+	install -m $$(INSTALL_MODE) $(shell test -d "$(2)/$(1)" && echo "-d") $(PARAM) "$(2)/$(1)" $$@
+	$(shell test -d "$(2)/$(1)" && echo "install -m "'$$(INSTALL_MODE) $(PARAM)' "$(2)/$(1)/*" -t '$$@')
 endef
 
 #
-- 
2.26.2

