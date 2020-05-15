From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 15 May 2020 09:00:22 +0200
Subject: [LTP] [PATCH v3 1/4] INSTALL: Update requirements, modernise text
Message-ID: <20200515070022.16407-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

* replace links to several years old versions with installation commands
  for various distros
* mention pkgconf in both INSTALL and README.md (many distros migrated
  from pkg-config to pkgconf)
* remove make version requirement (make 3.81 is in CentOS 6, which
  support were going to drop)
* remove CVS tag :)

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
v2->v3:
* replace tools homepages (useless) with installation commands
* add more dependencies (gcc, git, headers)
* mention travis/*.sh in both INSTALL and README.md (I was lazy to add
all dev/devel packages + why to sync it on both places?)

Kind regards,
Petr

 INSTALL   | 44 +++++++++++++++-----------------------------
 README.md |  5 +++--
 2 files changed, 18 insertions(+), 31 deletions(-)

diff --git a/INSTALL b/INSTALL
index 8bf6fe005..de313e65f 100644
--- a/INSTALL
+++ b/INSTALL
@@ -1,42 +1,28 @@
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
+Tools are needed for LTP compilation. They should be available as a
+package in any Linux distribution (no specific version is required).
 
-flex can be obtained here:
-- http://downloads.sourceforge.net/project/flex/flex/flex-2.5.33/flex-2.5.33.tar.bz2
+Debian / Ubuntu
+# apt install gcc git make pkgconf autoconf automake bison flex m4 linux-headers-$(uname -r) libc6-dev
 
-make 3.81 can be obtained here:
-- http://ftp.gnu.org/gnu/make/make-3.81.tar.bz2
+OpenSUSE / SLES
+# zypper install gcc git make pkgconf autoconf automake bison flex m4 linux-glibc-devel glibc-devel
 
-If you want to use auto configuration you also need autoconf-2.61+, automake-1.10+
-and pkg-config.
+Fedora / CentOS / RHEL
+# yum install gcc git make pkgconf autoconf automake bison flex m4 kernel-headers glibc-headers
 
-automake-1.10.2's sources can be downloaded from:
-- ftp://ftp.gnu.org/gnu/automake/automake-1.10.2.tar.bz2
-- ftp://ftp.gnu.org/gnu/automake/automake-1.10.2.tar.gz
+autoconf, automake, m4 (autoconf requirement), git and pkgconf (or pkg-config
+on older distros) are required for compilation from git (used for creating
+configure file).
 
-autoconf-2.61's sources can be downloaded from:
-- ftp://ftp.gnu.org/gnu/autoconf/autoconf-2.61.tar.bz2
-- ftp://ftp.gnu.org/gnu/autoconf/autoconf-2.61.tar.gz
+pkgconf is recommended also for compilation from tarball as it
+does automatic detection of some library support.
 
-autoconf-2.61 also requires m4-1.4.7+ be installed. Its sources can be
-downloaded from:
-- http://ftp.gnu.org/gnu/m4/m4-1.4.7.tar.bz2
-- http://ftp.gnu.org/gnu/m4/m4-1.4.7.tar.gz
+Some other development libraries are also recommended, see travis/*.sh.
 
-pkg-config can be downloaded from:
-- https://pkg-config.freedesktop.org/releases/
+GNU Bison / Berkeley Yacc is needed for ltp-scanner.
 
 Configuration
 -------------------
diff --git a/README.md b/README.md
index a2a623f40..56d10d450 100644
--- a/README.md
+++ b/README.md
@@ -37,8 +37,9 @@ on properly functioning systems, they are intended to find (or cause) problems.
 Quick guide to running the tests
 ================================
 
-If you have git, autoconf, automake, m4 and pkg-config, the linux headers and
-the common developer packages installed, the chances are the following will work:
+If you have git, autoconf, automake, m4, pkgconf / pkg-config, libc headers,
+linux kernel headers and other common development packages installed (see
+INSTALL and travis/*.sh), the chances are the following will work:
 
 ```
 $ git clone https://github.com/linux-test-project/ltp.git
-- 
2.26.2

