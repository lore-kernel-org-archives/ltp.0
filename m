From: Li Wang <liwang@redhat.com>
Date: Fri, 25 Sep 2020 11:20:02 +0800
Subject: [LTP] [PATCH 1/2] Fix formatting signal name in tst_strstatus()
In-Reply-To: <20200924144246.12750-1-mdoucha@suse.cz>
References: <20200924144246.12750-1-mdoucha@suse.cz>
Message-ID: <CAEemH2c4GRVPkNHS91dOLY-r417RpEGi5GC+izEY1P7w+kLkqw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Sep 24, 2020 at 10:43 PM Martin Doucha <mdoucha@suse.cz> wrote:

> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
>
Acked-by: Li Wang <liwang@redhat.com>


> ---
>  lib/tst_status.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/lib/tst_status.c b/lib/tst_status.c
> index f1affeac5..9124faaa3 100644
> --- a/lib/tst_status.c
> +++ b/lib/tst_status.c
> @@ -20,7 +20,8 @@ const char *exited(int status)
>
>  const char *signaled(int status)
>  {
> -       snprintf(buf, sizeof(buf), "killed by %s", tst_strsig(status));
> +       snprintf(buf, sizeof(buf), "killed by %s",
> +               tst_strsig(WTERMSIG(status)));
>
>         return buf;
>  }
> --
> 2.28.0
>
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>
>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200925/f5923914/attachment.htm>
