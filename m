From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 11 Sep 2020 10:38:52 +0300
Subject: [LTP] [PATCH v2 1/1] fanotify10: Skip non zero ignored_onchild
 tests for < v5.9
In-Reply-To: <20200911065124.18992-1-pvorel@suse.cz>
References: <20200911065124.18992-1-pvorel@suse.cz>
Message-ID: <CAOQ4uxjUj35ePAzQuEO6BrTskrrp0TLX-tnV7L4Opcda0Mm8gg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Sep 11, 2020 at 9:51 AM Petr Vorel <pvorel@suse.cz> wrote:
>
> ignored mask in combination with flag FAN_EVENT_ON_CHILD has
> undefined behavior on kernel < 5.9.
>
> Also remove wrong kernel commit (left in e8189ff3c).
>
> Acked-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  testcases/kernel/syscalls/fanotify/fanotify10.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify10.c b/testcases/kernel/syscalls/fanotify/fanotify10.c
> index 2c4401f61..64426b876 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify10.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify10.c
> @@ -20,10 +20,10 @@
>   *
>   *     2f02fd3fa13e fanotify: fix ignore mask logic for events on child...
>   *
> - * Test cases #17-#23 are regression tests for commit:
> + * Test cases #17-#23 are regression tests for commit (from v5.9, unlikely to be
> + * backported thus not in .tags):

If we are being accurate, it is only the 4 test cases with non zero
ignored_onchild
that are regression tests for this commit. The other 3 test cases are
just completing
the test matrix of possible combinations of marks.

So you may rephrase above as "Test cases with 'ignored_onchild'..."
or what not.

Thanks,
Amir.

>   *
>   *     497b0c5a7c06 fsnotify: send event to parent and child with single...
> - *     eca4784cbb18 fsnotify: send event to parent and child with single...
>   */
>  #define _GNU_SOURCE
>  #include "config.h"
> @@ -451,6 +451,12 @@ static void test_fanotify(unsigned int n)
>
>         tst_res(TINFO, "Test #%d: %s", n, tc->tname);
>
> +       if (tc->ignored_onchild && tst_kvercmp(5, 9, 0) < 0) {
> +               tst_res(TCONF, "ignored mask in combination with flag FAN_EVENT_ON_CHILD"
> +                               " has undefined behavior on kernel < 5.9");
> +               return;
> +       }
> +
>         if (create_fanotify_groups(n) != 0)
>                 goto cleanup;
>
> @@ -567,7 +573,6 @@ static struct tst_test test = {
>         .tags = (const struct tst_tag[]) {
>                 {"linux-git", "9bdda4e9cf2d"},
>                 {"linux-git", "2f02fd3fa13e"},
> -               {"linux-git", "497b0c5a7c06"},
>                 {}
>         }
>  };
> --
> 2.28.0
>
