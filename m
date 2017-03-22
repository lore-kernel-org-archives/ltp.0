From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 22 Mar 2017 20:54:49 +0100
Subject: [LTP] [PATCH 1/1] open_posix_testsuite: Fix cross compilation of
	tools
Message-ID: <20170322195449.19552-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Petr Vorel <petr.vorel@gmail.com>

by including config-openposix.mk which contains cross compilation setup.

This fixes #144.

Reported-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
 testcases/open_posix_testsuite/tools/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/testcases/open_posix_testsuite/tools/Makefile b/testcases/open_posix_testsuite/tools/Makefile
index 9a9f0481d..8500d4259 100644
--- a/testcases/open_posix_testsuite/tools/Makefile
+++ b/testcases/open_posix_testsuite/tools/Makefile
@@ -4,6 +4,8 @@
 # Ngie Cooper, June 2010
 #
 
+include ../../../include/mk/config-openposix.mk
+
 top_srcdir?=	..
 
 srcdir=		$(top_srcdir)/tools
-- 
2.11.0

