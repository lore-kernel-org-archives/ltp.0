From: Petr Vorel <pvorel@suse.cz>
Date: Tue,  3 Nov 2020 20:13:23 +0100
Subject: [LTP] [PATCH v2 07/11] make: Allow {INSTALL,
 MAKE}_TARGETS be a directory
In-Reply-To: <20201103191327.11081-1-pvorel@suse.cz>
References: <20201103191327.11081-1-pvorel@suse.cz>
Message-ID: <20201103191327.11081-8-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

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
2.29.1

