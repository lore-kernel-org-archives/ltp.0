From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 10 Sep 2020 17:14:03 +0300
Subject: [LTP] [PATCH 1/1] fanotify10: Treat ignore mask bug as TCONF
 for < v5.9
In-Reply-To: <20200910121628.18505-1-pvorel@suse.cz>
References: <20200910121628.18505-1-pvorel@suse.cz>
Message-ID: <CAOQ4uxhshKD-gCuW94cvKee8W==Y6y6TNyEJmxifEagxs1BhOA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Sep 10, 2020 at 3:16 PM Petr Vorel <pvorel@suse.cz> wrote:
>
> Suggested-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Hi Amir,
>
> based on suggestion http://lists.linux.it/pipermail/ltp/2020-September/018891.html,
> but not really sure if it should be applied, because we loose warning:
>
> HINT: You _MAY_ be missing kernel fixes, see:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9bdda4e9cf2d
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2f02fd3fa13e
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=497b0c5a7c06
>

I think your change is fine, because this warning would only send poor
stable kernel maintainers on a quest to find a patch to backport, which IMO
is not going to end with a fix.

The situation with ignored mask logic is that it was broken or not properly
defined from day 1 of fanotify, so people are probably using ignored mask
only in the very basic combinations.

Lately, along with FAN_MARK_FILESYSTEM and related work, more
opportunities for using ignored mask have materialized and many old bugs
have surfaced.

But I'm afraid it will not be feasible to backport all the fixes, so
once the ignored
logic settles (there are still several bugs left) I will try to
properly document
what is expected to work in which kernel and will update the man page
BUGS section.

Jan,

Please let me know if we are on the same page in that regard.

Thanks,
Amir.

> Kind regards,
> Petr
>
>
>  testcases/kernel/syscalls/fanotify/fanotify10.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify10.c b/testcases/kernel/syscalls/fanotify/fanotify10.c
> index 2c4401f61..5b4591b4a 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify10.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify10.c
> @@ -508,8 +508,8 @@ static void test_fanotify(unsigned int n)
>                                         "zero length read from fanotify fd");
>                         }
>                         if (ret > 0) {
> -                               tst_res(TFAIL, "group %d (%x) with %s and "
> -                                       "%s ignore mask got event",
> +                               tst_res((tst_kvercmp(5, 9, 0)) < 0 ? TCONF : TFAIL,
> +                                       "group %d (%x) with %s and %s ignore mask got event",
>                                         i, fanotify_class[p], mark->name, ignore_mark->name);
>                                 if (event->fd != FAN_NOFD)
>                                         SAFE_CLOSE(event->fd);
> --
> 2.28.0
>
