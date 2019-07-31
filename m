From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 31 Jul 2019 14:07:06 +0200
Subject: [LTP] [PATCH v7 1/3] lib: alter find_free_loopdev()
In-Reply-To: <1564569629-2358-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <20190730110555.GB7528@rei.lan>
 <1564569629-2358-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20190731120706.GD22537@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xu,

...
> +++ b/doc/test-writing-guidelines.txt
> @@ -1053,6 +1053,18 @@ IMPORTANT: All testcases should use 'tst_umount()' instead of 'umount(2)' to
>  -------------------------------------------------------------------------------
>  #include "tst_test.h"

> +int tst_find_free_loopdev(const char *path, size_t path_len);
> +-------------------------------------------------------------------------------
> +
> +This function finds a free loopdev and returns the free loopdev minor (-1 for no
> +free loopdev). If path is non-NULL, it will be filled with free loopdev path.
> +If you want to use a customized loop device, we can call tst_find_free_loopdev
> +(NULL, 0) in tests to get a free minor number. Then mknod.
Maybe (as "Then mknod." is a sentence without a verb):
   (NULL, 0) in tests to get a free minor number and then mknod.

(nitch, of course can be fixed during merge)

Kind regards,
Petr
