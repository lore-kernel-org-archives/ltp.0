From: Li Wang <liwang@redhat.com>
Date: Mon, 13 Mar 2017 19:26:47 +0800
Subject: [LTP] [PATCH] ioctl06: test id usually same as test filename
In-Reply-To: <20170313090754.13414-1-liwang@redhat.com>
References: <20170313090754.13414-1-liwang@redhat.com>
Message-ID: <CAEemH2c2E69vZxx4CGsQMr-W4rdY3vMP+=V8=1YMaUSf=Et95A@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Please ignore this one. I'm trying to fix all of the typos in a new patch.

On Mon, Mar 13, 2017 at 5:07 PM, Li Wang <liwang@redhat.com> wrote:
> Signed-off-by: Li Wang <liwang@redhat.com>
> ---
>  testcases/kernel/syscalls/ioctl/ioctl06.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/testcases/kernel/syscalls/ioctl/ioctl06.c b/testcases/kernel/syscalls/ioctl/ioctl06.c
> index 9046a3f..d05aa45 100644
> --- a/testcases/kernel/syscalls/ioctl/ioctl06.c
> +++ b/testcases/kernel/syscalls/ioctl/ioctl06.c
> @@ -63,7 +63,7 @@ static void cleanup(void)
>  }
>
>  static struct tst_test test = {
> -       .tid = "ioctl07",
> +       .tid = "ioctl06",
>         .needs_device = 1,
>         .setup = setup,
>         .cleanup = cleanup,
> --
> 2.9.3
>
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp



-- 
Regards,
Li Wang
Email: liwang@redhat.com
