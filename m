From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 29 Apr 2020 14:06:09 +0200
Subject: [LTP] [PATCH 2/3] lib: Add TST_ASSERT_FILE_INT and
 TST_ASSERT_FILE_STR
In-Reply-To: <1587450108-31100-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1587450108-31100-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1587450108-31100-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20200429120609.GA668@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  #endif /* TST_ASSERT_H__ */
> diff --git a/lib/tst_assert.c b/lib/tst_assert.c
> index 8ef3cd72e..65ee76473 100644
> --- a/lib/tst_assert.c
> +++ b/lib/tst_assert.c
> @@ -4,6 +4,7 @@
>   * Author: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
>   * Copyright (c) 2020 Cyril Hrubis <chrubis@suse.cz>
>   */
> +#include <stdio.h>
>  #define TST_NO_DEFAULT_MAIN
>  #include "tst_assert.h"
>  #include "tst_test.h"
> @@ -22,6 +23,22 @@ void tst_assert_int(const char *file, const int lineno, const char *path, int va
>  	tst_res_(file, lineno, TFAIL, "%s != %d got %d", path, val, sys_val);
>  }
>  
> +void tst_assert_file_int(const char *file, const int lineno, const char *path, const char *buf, int val)
> +{
> +	int sys_val;
> +	char fmt[1024];
> +
> +	sprintf(fmt, "%s: %%d", buf);

If we want to keep the function as generic as possible we shouldn't add
the colon and space after the %s here.

There is no standard on proc files, for instance it wouldn't be possible
to parse /proc/vmstat if we hardcode the format string like that.

So I would just change this to "%s%%d" instead and pass "Foo: " instead
just "Foo" in the testcases.

Also I guess that we should call it prefix rather than buf, but that's
minor.

-- 
Cyril Hrubis
chrubis@suse.cz
