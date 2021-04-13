From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 13 Apr 2021 10:34:47 +0200
Subject: [LTP] [PATCH v4 1/7] fzsync: Add self tests
In-Reply-To: <20210413070753.1691-2-rpalethorpe@suse.com>
References: <20210413070753.1691-1-rpalethorpe@suse.com>
 <20210413070753.1691-2-rpalethorpe@suse.com>
Message-ID: <YHVXpxfK1uU5co9p@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/lib/newlib_tests/test16.c b/lib/newlib_tests/test16.c
> index 0d74e1eae..7a9b5f20e 100644
> --- a/lib/newlib_tests/test16.c
> +++ b/lib/newlib_tests/test16.c
> @@ -9,6 +9,8 @@
>   * which they should take it in turns to update.
>   */
>  
> +#define _GNU_SOURCE
> +
>  #include <stdlib.h>
>  #include "tst_test.h"
>  #include "tst_safe_pthread.h"

I've removed this forgotten _GNU_SOURCE defition and pushed.

Thanks a lot for the fixes.

-- 
Cyril Hrubis
chrubis@suse.cz
