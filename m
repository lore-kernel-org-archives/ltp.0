From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 12 Oct 2017 20:33:24 +0200
Subject: [LTP] [PATCH v3 07/18] nfsv4/acl1: Exit with TCONF when libacl not
	available
In-Reply-To: <20171012183335.24568-1-pvorel@suse.cz>
References: <20171012183335.24568-1-pvorel@suse.cz>
Message-ID: <20171012183335.24568-8-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

+ cleanup dos/windows headers

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/nfsv4/acl/acl1.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/testcases/network/nfsv4/acl/acl1.c b/testcases/network/nfsv4/acl/acl1.c
index b8b67b4e3..1693d4347 100644
--- a/testcases/network/nfsv4/acl/acl1.c
+++ b/testcases/network/nfsv4/acl/acl1.c
@@ -4,31 +4,20 @@
  *	Purpose: setting an acl on a file a verifies that the accesses are right
  */
 
-#if defined (DOS) || defined (WIN32)
-/* If Dos, Windows or Win32 */
-#define DOSorWIN32
-#endif
-
-#ifndef DOSorWIN32
 #include <sys/param.h>
-#endif
 
 #include <stdlib.h>
 #include <sys/types.h>
-#ifdef DOSorWIN32
-#include <time.h>
-#else
 #include <sys/time.h>
-#endif
 #include <sys/stat.h>
 #include <stdio.h>
 #include <string.h>
-//#include "../tests.h"
 #include <dirent.h>
 #include <unistd.h>
 #include <errno.h>
 
-#include <config.h>
+#include "config.h"
+#include "tst_res_flags.h"
 
 #ifdef HAVE_SYS_ACL_H
 
@@ -378,11 +367,9 @@ int main(int argc, char *argv[])
 }
 
 #else
-
 int main(void)
 {
 	printf("The acl library was missing upon compilation.\n");
-	return 0;
+	return TCONF;
 }
-
 #endif /* HAVE_SYS_ACL_H */
-- 
2.14.2

