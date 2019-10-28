From: Li Wang <liwang@redhat.com>
Date: Mon, 28 Oct 2019 20:50:12 +0800
Subject: [LTP] [PATCH]kernel/mem/mtest01:Fix mtest01's options
In-Reply-To: <1572255092-105929-1-git-send-email-songjian15@huawei.com>
References: <1572255092-105929-1-git-send-email-songjian15@huawei.com>
Message-ID: <CAEemH2dHX0vry_p=RRwRGbMe2NYf_7_PB4LG5sUpDSXDFB2g1Q@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Oct 28, 2019 at 5:30 PM Song Jian <songjian15@huawei.com> wrote:

> Signed-off-by: Song Jian <songjian15@huawei.com>
> ---
>  testcases/kernel/mem/mtest01/mtest01.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/testcases/kernel/mem/mtest01/mtest01.c
> b/testcases/kernel/mem/mtest01/mtest01.c
> index eaf1026..960a2ce 100644
> --- a/testcases/kernel/mem/mtest01/mtest01.c
> +++ b/testcases/kernel/mem/mtest01/mtest01.c
> @@ -58,7 +58,7 @@ static char *opt_chunksize, *opt_maxbytes,
> *opt_maxpercent;
>  static struct tst_option mtest_options[] = {
>         {"c:", &opt_chunksize,  "-c  size of chunk in bytes to malloc on
> each pass"},
>         {"b:", &opt_maxbytes,   "-b  maximum number of bytes to allocate
> before stopping"},
> -       {"p:", &opt_maxpercent, "-u  percent of total memory used at which
> the program stops"},
> +       {"p:", &opt_maxpercent, "-p  percent of total memory used at which
> the program stops"},
>

Good catch. Pushed.

>         {"w",  &dowrite,        "-w  write to the memory after
> allocating"},
>         {"v",  &verbose,        "-v  verbose"},
>         {NULL, NULL,            NULL}
> --
> 2.6.2
>
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>


-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20191028/2fe78383/attachment.htm>
