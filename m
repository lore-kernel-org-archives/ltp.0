From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 15 May 2020 11:32:14 +0200
Subject: [LTP] [PATCH v4 2/4] INSTALL: Document 32bit and cross-compilation
 setup
In-Reply-To: <20200515093216.829-1-pvorel@suse.cz>
References: <20200515093216.829-1-pvorel@suse.cz>
Message-ID: <20200515093216.829-3-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

which requires also to set pkg-config environment variables.

This setup is needed since c7d2a7458 ("rpc-tirpc: Detect libtirpc with
pkg-config")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 INSTALL | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/INSTALL b/INSTALL
index dccf7a072..d493c523c 100644
--- a/INSTALL
+++ b/INSTALL
@@ -214,14 +214,28 @@ contributions are welcome.
 
 Cross compiling
 ---------------
-
 To cross compile, you must specify the correct variables when running configure.
-e.g. CC, LDFLAGS, etc...
+e.g. CC, LDFLAGS, etc.
+For correct pkgconf / pkg-config detection you need to set
+PKG_CONFIG_SYSROOT_DIR=$SYSROOT
 
 After configure has run, it will generate include/mk/config.mk. You can tweak
 settings in there if need be, but you should not specificy settings on the
 command-line when running make.
 
+32 bit build on 64 bit machine
+------------------------------
+You need to set CFLAGS=-m32 LDFLAGS=-m32 and PKG_CONFIG_LIBDIR
+
+* RPM based distributions (openSUSE, Fedora, etc.)
+PKG_CONFIG_LIBDIR=/usr/lib/pkgconfig CFLAGS=-m32 LDFLAGS=-m32 ./configure
+
+* Debian / Ubuntu and derivates
+PKG_CONFIG_LIBDIR=/usr/lib/i386-linux-gnu/pkgconfig CFLAGS=-m32 LDFLAGS=-m32 ./configure
+
+* Arch Linux
+PKG_CONFIG_LIBDIR=/usr/lib32/pkgconfig CFLAGS=-m32 LDFLAGS=-m32 ./configure
+
 uClinux Users
 --------------
 Specify UCLINUX=1 when calling make; -DUCLINUX=1 use is deprecated and highly
-- 
2.26.2

