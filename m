From: Li Wang <liwang@redhat.com>
Date: Sun, 16 Feb 2020 13:51:42 +0800
Subject: [LTP] [PATCH v2 1/3] tst_umount: Fail immediately when errno !=
 EBUSY
In-Reply-To: <20200210124043.14425-1-pvorel@suse.cz>
References: <20200210124043.14425-1-pvorel@suse.cz>
Message-ID: <CAEemH2fvK+d3V8W=sR4YtZpwmE=jq5TmS-g1TNTu+UbW2oU8CQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Feb 10, 2020 at 8:41 PM Petr Vorel <pvorel@suse.cz> wrote:

> Only on EBUSY makes sense to keep trying in a loop.
> This helps to use tst_umount() in safe_umount() (next commit).
>
> Suggested-by: Cyril Hrubis <chrubis@suse.cz>
> Reported-by: Jan Stancek <jstancek@redhat.com>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
>
Acked-by: Li Wang <liwang@redhat.com>


> ---
>  lib/tst_device.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/lib/tst_device.c b/lib/tst_device.c
> index 89b9c96de..6cad9bd4d 100644
> --- a/lib/tst_device.c
> +++ b/lib/tst_device.c
> @@ -363,6 +363,13 @@ int tst_umount(const char *path)
>                 if (!ret)
>                         return 0;
>
> +               if (err != EBUSY) {
> +                       tst_resm(TWARN, "umount('%s') failed with %s",
> +                        path, tst_strerrno(err));
> +                       errno = err;
> +                       return ret;
> +               }
>

Since we have guaranteed there is no other error besides EBUSY, maybe we
could cancel the 'err == EBUSY' in the next if() sentences.
Otherweise patch 1/3, 2/3 looks good.

if (i == 0 && err == EBUSY) {
    ...
}

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200216/e6d3f41b/attachment.htm>
