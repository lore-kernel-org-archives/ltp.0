From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 15 May 2020 11:32:16 +0200
Subject: [LTP] [PATCH v4 4/4] doc: Remove links to README.mk-devel
In-Reply-To: <20200515093216.829-1-pvorel@suse.cz>
References: <20200515093216.829-1-pvorel@suse.cz>
Message-ID: <20200515093216.829-5-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

It was removed in f7f66820c ("Update some docs."),
mention doc/build-system-guide.txt instead.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 INSTALL                 | 3 ++-
 include/mk/config.mk.in | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/INSTALL b/INSTALL
index 89ee81e8d..120f030b5 100644
--- a/INSTALL
+++ b/INSTALL
@@ -241,7 +241,8 @@ LDFLAGS  - linker flags, e.g. "-L$SYSROOT/usr/lib" "-L$SYSROOT/lib". DO NOT
 LDLIBS   - libraries listed after objects during link, e.g. -lc, -lpthread,
 	   -lltp.
 
-See README.mk-devel for a more terse description of what's available.
+For other variables and more info about the build systems see
+doc/build-system-guide.txt.
 
 Common Issues
 ----------------------
diff --git a/include/mk/config.mk.in b/include/mk/config.mk.in
index 87b2c833d..427608a17 100644
--- a/include/mk/config.mk.in
+++ b/include/mk/config.mk.in
@@ -62,7 +62,7 @@ LDFLAGS			:= @LDFLAGS@
 
 DEBUG_CFLAGS		?= -g
 
-# Please see README.mk-devel about -fstrict-aliasing.
+# for -fstrict-aliasing see doc/build-system-guide.txt
 OPT_CFLAGS		?= -O2 -fno-strict-aliasing -pipe
 
 WCFLAGS			?= -Wall -W @GCC_WARN_OLDSTYLE@
-- 
2.26.2

