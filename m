From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 1 Sep 2021 16:08:00 +0200
Subject: [LTP] [PATCH] syscalls/pread01: Convert to new API
In-Reply-To: <1629294657-28375-1-git-send-email-daisl.fnst@fujitsu.com>
References: <1629294657-28375-1-git-send-email-daisl.fnst@fujitsu.com>
Message-ID: <YS+JQLNhte4E3jxM@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Dai,

> diff --git a/testcases/kernel/syscalls/pwrite/pwrite01.c b/testcases/kernel/syscalls/pwrite/pwrite01.c
...
> -/*
> - * Test Name: pwrite01
> +/*\
> + * [Description]
>   *
> - * Test Description:
>   *  Verify the functionality of pwrite() by writing known data using pwrite()
>   *  to the file at various specified offsets and later read from the file from
>   *  various specified offsets, comparing the data written aganist the data
>   *  read using read().

You kept 2 spaces between * and text. That'll lead in docparse formatting (which
uses markdown) to formatted as code, which is wrong. It must be without space:

/*\
 * [Description]
 *
 * Verify the functionality of pwrite() by writing known data using pwrite()
 * to the file at various specified offsets and later read from the file from
 * various specified offsets, comparing the data written aganist the data
 * read using read().
 */

Again, I have already prepared fixes, just wait for others to review.

Kind regards,
Petr
