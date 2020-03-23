From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 23 Mar 2020 17:11:29 +0100
Subject: [LTP] [PATCH v2 3/9] safe_macros: Add SAFE_SETNS()
In-Reply-To: <20200318153801.3529-4-chrubis@suse.cz>
References: <20200318153801.3529-1-chrubis@suse.cz>
 <20200318153801.3529-4-chrubis@suse.cz>
Message-ID: <20200323161129.GA28014@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

...
> diff --git a/lib/tst_safe_macros.c b/lib/tst_safe_macros.c
> index f5413a18e..353ef5b1d 100644
> --- a/lib/tst_safe_macros.c
> +++ b/lib/tst_safe_macros.c
> @@ -6,6 +6,7 @@
>  #define _GNU_SOURCE
>  #include <unistd.h>
>  #include <errno.h>
> +#include "lapi/setns.h"
One more fix needed: lapi file needs to be loaded later:

diff --git lib/tst_safe_macros.c lib/tst_safe_macros.c
index 353ef5b1d..7d33f2b79 100644
--- lib/tst_safe_macros.c
+++ lib/tst_safe_macros.c
@@ -6,7 +6,6 @@
 #define _GNU_SOURCE
 #include <unistd.h>
 #include <errno.h>
-#include "lapi/setns.h"
 #include <sched.h>
 #include "config.h"
 #ifdef HAVE_SYS_FANOTIFY_H
@@ -14,6 +13,7 @@
 #endif
 #define TST_NO_DEFAULT_MAIN
 #include "tst_test.h"
+#include "lapi/setns.h"
 #include "tst_safe_macros.h"
 #include "lapi/personality.h"
 
to prevent failure:
In file included from /usr/src/ltp/lib/tst_safe_macros.c:9:
/usr/src/ltp/include/lapi/setns.h: In function 'setns':
/usr/src/ltp/include/lapi/setns.h:16: error: implicit declaration of function 'tst_brk'
/usr/src/ltp/include/lapi/setns.h:16: error: 'TCONF' undeclared (first use in this function)
/usr/src/ltp/include/lapi/setns.h:16: error: (Each undeclared identifier is reported only once

The rest of the patchset looks ok to me:

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr
