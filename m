From: Petr Vorel <pvorel@suse.cz>
Date: Fri,  2 Aug 2019 17:04:42 +0200
Subject: [LTP] [PATCH v2 1/4] make: Remove C++ related flags
In-Reply-To: <20190802150445.10984-1-pvorel@suse.cz>
References: <20190802150445.10984-1-pvorel@suse.cz>
Message-ID: <20190802150445.10984-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

as we have no C++ code. Removed:
CXXFLAGS, DEBUG_CXXFLAGS, OPT_CXXFLAGS, WCXXFLAGS

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 INSTALL                      |  4 +---
 build.sh                     |  2 +-
 doc/build-system-guide.txt   | 10 ----------
 include/mk/config.mk.default |  4 ----
 include/mk/config.mk.in      |  4 ----
 5 files changed, 2 insertions(+), 22 deletions(-)

diff --git a/INSTALL b/INSTALL
index b2fe630bf..6e3b26e24 100644
--- a/INSTALL
+++ b/INSTALL
@@ -239,7 +239,7 @@ Cross compiling
 ---------------
 
 To cross compile, you must specify the correct variables when running configure.
-e.g. CC, CXX, CXXFLAGS, LDFLAGS, etc...
+e.g. CC, LDFLAGS, etc...
 
 After configure has run, it will generate include/mk/config.mk. You can tweak
 settings in there if need be, but you should not specificy settings on the
@@ -264,8 +264,6 @@ The conventions enforced are standard ones. Here's a quick summary:
 
 CFLAGS   - used when compiling/linking C code, e.g. -D_GNU_SOURCE (no CPPFLAGS!)
 
-CXXFLAGS - used when compiling/linking C++ code (no CPPFLAGS!)
-
 CPPFLAGS - used when preprocessor is run (so C/C++ compiling with $(CPP)
 	   functions, e.g. -I$SYSROOT/usr/include -I$SYSROOT/include -I$SYSROOT
 
diff --git a/build.sh b/build.sh
index ae3b86ff2..634ef51b5 100755
--- a/build.sh
+++ b/build.sh
@@ -21,7 +21,7 @@ CC=gcc
 build_32()
 {
 	echo "===== 32-bit ${1}-tree build into $PREFIX ====="
-	build $1 CFLAGS="-m32" CXXFLAGS="-m32" LDFLAGS="-m32"
+	build $1 CFLAGS="-m32" LDFLAGS="-m32"
 }
 
 build_native()
diff --git a/doc/build-system-guide.txt b/doc/build-system-guide.txt
index e9717f1ae..c4b36239b 100644
--- a/doc/build-system-guide.txt
+++ b/doc/build-system-guide.txt
@@ -137,20 +137,14 @@ $(AR)			: The library archiver.
 
 $(CC)			: The system C compiler.
 
-$(CXX)			: The system C++ compiler.
-
 $(CPP)			: The system C preprocessor.
 
 $(CFLAGS)		: C compiler flags.
 
 $(CPPFLAGS)		: Preprocessor flags, e.g. -I arguments.
 
-$(CXXFLAGS)		: C++ compiler flags, e.g. -I arguments.
-
 $(DEBUG_CFLAGS)		: Debug flags to pass to $(CC), -g, etc.
 
-$(DEBUG_CXXFLAGS)	: Debug flags to pass to $(CXX).
-
 $(LD)			: The system linker (typically $(CC), but not
 			  necessarily).
 
@@ -179,14 +173,10 @@ $(OPT_CFLAGS)		: Optimization flags to pass into the C compiler, -O2,
 			  logic in the tree-optimization portion of the gcc
 			  compiler, from 3.3.x to 4.4.
 
-$(OPT_CXXFLAGS)		: Optimization flags to pass to the C++ compiler.
-
 $(RANLIB)		: What to run after archiving a library.
 
 $(WCFLAGS)		: Warning flags to pass to $(CC), e.g. -Werror,
 			  -Wall, etc.
-
-$(WCXXFLAGS)		: Same as $(WCFLAGS), but for $(CXX).
 -------------------------------------------------------------------------------
 
 Make System Variables
diff --git a/include/mk/config.mk.default b/include/mk/config.mk.default
index 0934d9453..857067cb3 100644
--- a/include/mk/config.mk.default
+++ b/include/mk/config.mk.default
@@ -59,18 +59,14 @@ LDLIBS			:=
 LDFLAGS			:=
 
 DEBUG_CFLAGS		?= -g
-DEBUG_CXXFLAGS		?= $(DEBUG_CFLAGS)
 
 # Please see README.mk-devel about -fstrict-aliasing.
 OPT_CFLAGS		?= -O2 -fno-strict-aliasing -pipe
-OPT_CXXFLAGS		?= $(OPT_CFLAGS)
 
 WCFLAGS			?= -Wall
-WCXXFLAGS		?= $(WCFLAGS)
 
 LDFLAGS			+= $(WLDFLAGS)
 CFLAGS			+= $(DEBUG_CFLAGS) $(OPT_CFLAGS) $(WCFLAGS)
-CXXFLAGS		+= $(DEBUG_CXXFLAGS) $(OPT_CXXFLAGS) $(WCXXFLAGS)
 
 LINUX_VERSION		:=
 LINUX_DIR		:=
diff --git a/include/mk/config.mk.in b/include/mk/config.mk.in
index d55fe9602..0bc59887a 100644
--- a/include/mk/config.mk.in
+++ b/include/mk/config.mk.in
@@ -63,18 +63,14 @@ LDLIBS			:= @LIBS@
 LDFLAGS			:= @LDFLAGS@
 
 DEBUG_CFLAGS		?= -g
-DEBUG_CXXFLAGS		?= $(DEBUG_CFLAGS)
 
 # Please see README.mk-devel about -fstrict-aliasing.
 OPT_CFLAGS		?= -O2 -fno-strict-aliasing -pipe
-OPT_CXXFLAGS		?= $(OPT_CFLAGS)
 
 WCFLAGS			?= -Wall -W @GCC_WARN_OLDSTYLE@
-WCXXFLAGS		?= $(WCFLAGS)
 
 LDFLAGS			+= $(WLDFLAGS)
 CFLAGS			+= $(DEBUG_CFLAGS) $(OPT_CFLAGS) $(WCFLAGS)
-CXXFLAGS		+= $(DEBUG_CXXFLAGS) $(OPT_CXXFLAGS) $(WCXXFLAGS)
 
 LINUX_VERSION		:= @LINUX_VERSION@
 LINUX_DIR		:= @LINUX_DIR@
-- 
2.22.0

