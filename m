From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 14 May 2020 20:49:03 +0200
Subject: [LTP] [PATCH 3/4] INSTALL: Remove uClinux docs
In-Reply-To: <20200514184904.4537-1-pvorel@suse.cz>
References: <20200514184904.4537-1-pvorel@suse.cz>
Message-ID: <20200514184904.4537-4-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

uClinux is not active project any more.

And we have started to remove the code anyway.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 INSTALL | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/INSTALL b/INSTALL
index f73bec54c..1eda570b5 100644
--- a/INSTALL
+++ b/INSTALL
@@ -241,11 +241,6 @@ PKG_CONFIG_LIBDIR=/usr/lib/i386-linux-gnu/pkgconfig CFLAGS=-m32 LDFLAGS=-m32 ./c
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

