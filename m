From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 14 May 2020 20:49:01 +0200
Subject: [LTP] [PATCH 1/4] INSTALL: Update requirements
In-Reply-To: <20200514184904.4537-1-pvorel@suse.cz>
References: <20200514184904.4537-1-pvorel@suse.cz>
Message-ID: <20200514184904.4537-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

* mention pkgconf in both INSTALL and README.md (many distros migrated
  from pkg-config to pkgconf)
* replace links to old versions to projects' homepage
* modernize text a bit
* remove CVS tag :)

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 INSTALL   | 51 ++++++++++++++++++++++-----------------------------
 README.md |  5 +++--
 2 files changed, 25 insertions(+), 31 deletions(-)

diff --git a/INSTALL b/INSTALL
index 8bf6fe005..e4fa1adf3 100644
--- a/INSTALL
+++ b/INSTALL
@@ -1,42 +1,35 @@
-$Id: INSTALL,v 1.36 2010/01/18 23:46:09 yaberauneya Exp $
-
 Requirements
 -------------------
 
-1. In order to compile ltp you must have make 3.80+ (make 3.81 preferred).
-2. In order to compile and use ltp-scanner (a utility in the pan directory),
-   you must have bison/yacc, and flex installed.
-
-bison can be obtained here:
-- http://ftp.gnu.org/gnu/bison/bison-2.4.1.tar.gz
-
-Berkeley yacc can be obtained here:
-- ftp://invisible-island.net/byacc/byacc.tar.gz
+These tools are needed for LTP compilation. They should be available as a
+package in any Linux distribution (no specific version is required).
 
-flex can be obtained here:
-- http://downloads.sourceforge.net/project/flex/flex/flex-2.5.33/flex-2.5.33.tar.bz2
+For compilation from tarball
+* make
+https://www.gnu.org/software/make/
 
-make 3.81 can be obtained here:
-- http://ftp.gnu.org/gnu/make/make-3.81.tar.bz2
+For auto configuration from git
+* pkgconf / pkg-config
+https://git.sr.ht/~kaniini/pkgconf
+http://pkgconf.org/
+https://www.freedesktop.org/wiki/Software/pkg-config/
 
-If you want to use auto configuration you also need autoconf-2.61+, automake-1.10+
-and pkg-config.
+* autoconf
+https://www.gnu.org/software/autoconf/
 
-automake-1.10.2's sources can be downloaded from:
-- ftp://ftp.gnu.org/gnu/automake/automake-1.10.2.tar.bz2
-- ftp://ftp.gnu.org/gnu/automake/automake-1.10.2.tar.gz
+* automake
+https://www.gnu.org/software/automake/
 
-autoconf-2.61's sources can be downloaded from:
-- ftp://ftp.gnu.org/gnu/autoconf/autoconf-2.61.tar.bz2
-- ftp://ftp.gnu.org/gnu/autoconf/autoconf-2.61.tar.gz
+* m4 (autoconf requirement)
+https://www.gnu.org/software/m4/
 
-autoconf-2.61 also requires m4-1.4.7+ be installed. Its sources can be
-downloaded from:
-- http://ftp.gnu.org/gnu/m4/m4-1.4.7.tar.bz2
-- http://ftp.gnu.org/gnu/m4/m4-1.4.7.tar.gz
+For ltp-scanner
+* GNU Bison / Berkeley Yacc
+https://www.gnu.org/software/bison/
+https://invisible-island.net/byacc/byacc.html
 
-pkg-config can be downloaded from:
-- https://pkg-config.freedesktop.org/releases/
+* Flex
+https://github.com/westes/flex
 
 Configuration
 -------------------
diff --git a/README.md b/README.md
index a2a623f40..15f8814c3 100644
--- a/README.md
+++ b/README.md
@@ -37,8 +37,9 @@ on properly functioning systems, they are intended to find (or cause) problems.
 Quick guide to running the tests
 ================================
 
-If you have git, autoconf, automake, m4 and pkg-config, the linux headers and
-the common developer packages installed, the chances are the following will work:
+If you have git, autoconf, automake, m4, pkgconf / pkg-config, linux kernel
+headers and the common developer packages installed, the chances are the
+following will work:
 
 ```
 $ git clone https://github.com/linux-test-project/ltp.git
-- 
2.26.2

