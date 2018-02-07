From: Petr Vorel <pvorel@suse.cz>
Date: Wed,  7 Feb 2018 11:20:50 +0100
Subject: [LTP] [COMMITTED 1/1] configure: Fix default value of
	--without-numa switch in help
Message-ID: <20180207102050.12902-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The default value is no.

Fixes: 39a85a1f1 ("configure: add knob to control numa support")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index b39a31ddb..d66ea00e1 100644
--- a/configure.ac
+++ b/configure.ac
@@ -86,7 +86,7 @@ fi
 # Numa
 AC_ARG_WITH([numa],
   AC_HELP_STRING([--without-numa],
-    [without numa support (default=yes)]),
+    [without numa support (default=no)]),
   [with_numa=no],
   [with_numa=yes]
 )
-- 
2.16.1

