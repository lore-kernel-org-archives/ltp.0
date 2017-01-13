From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 13 Jan 2017 10:07:06 +0100
Subject: [LTP] [PATCH v2 2/2] make: print compiler version
In-Reply-To: <20170113090706.29130-1-pvorel@suse.cz>
References: <20170113090706.29130-1-pvorel@suse.cz>
Message-ID: <20170113090706.29130-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
I thought it might be useful for non-travis builds to see from logs compiler
version.
---
 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index 94f2532fd..229f29d81 100644
--- a/Makefile
+++ b/Makefile
@@ -173,6 +173,7 @@ SRCDIR_INSTALL_TARGETS	:= $(SRCDIR_INSTALL_SCRIPTS) $(SRCDIR_INSTALL_READONLY)
 #
 .PHONY: Version
 Version:
+	$(CC) --version
 	if git describe >/dev/null 2>&1; then \
 		git describe > "$@"; \
 	else \
-- 
2.11.0

