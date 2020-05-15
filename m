From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 15 May 2020 11:32:15 +0200
Subject: [LTP] [PATCH v4 3/4] INSTALL: Remove uClinux and "What's in a
 Path?" sections
In-Reply-To: <20200515093216.829-1-pvorel@suse.cz>
References: <20200515093216.829-1-pvorel@suse.cz>
Message-ID: <20200515093216.829-4-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

uClinux is not active project any more.
And we have started to remove the code anyway.

Note about reasonable PATH it's kind of obvious, we don't have to
point that out.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 INSTALL | 23 -----------------------
 1 file changed, 23 deletions(-)

diff --git a/INSTALL b/INSTALL
index d493c523c..89ee81e8d 100644
--- a/INSTALL
+++ b/INSTALL
@@ -45,24 +45,6 @@ what to do next.
 Compiling LTP
 -------------------
 
-"What's in a Path?"
--------------------
-
-Before getting started, you should make sure that your build directory and
-source directory are as basic as possible: no commas, colons, semicolons,
-spaces, etc. In fact, this is a relatively good rule of thumb when dealing
-with any [Gnu?] make based opensource project.
-
-We won't `fix' the `issues' associated with these particular set of build
-errors resulting from non-sane pathnames, because it would introduce unneeded
-complexity into the build system and would require non-trivial effort to fix
-and validate the third-party packages, and thus wouldn't be a sustainable
-model to follow.
-
-So, we apologize for the inconvenience, but using other characters like
-underscores and dashes should help when disambiguating words between build
-and source pathnames.
-
 In-build-tree
 -------------------
 In-build-tree support is when you build binaries (applications, binary objects)
@@ -236,11 +218,6 @@ PKG_CONFIG_LIBDIR=/usr/lib/i386-linux-gnu/pkgconfig CFLAGS=-m32 LDFLAGS=-m32 ./c
 * Arch Linux
 PKG_CONFIG_LIBDIR=/usr/lib32/pkgconfig CFLAGS=-m32 LDFLAGS=-m32 ./configure
 
-uClinux Users
---------------
-Specify UCLINUX=1 when calling make; -DUCLINUX=1 use is deprecated and highly
-discouraged.
-
 Android Users
 -------------
 Specify ANDROID=1 when calling make. Many tests which would otherwise work are
-- 
2.26.2

