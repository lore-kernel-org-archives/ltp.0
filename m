From: Li Wang <liwang@redhat.com>
Date: Fri, 19 Feb 2021 15:45:13 +0800
Subject: [LTP] [PATCH] openposix/fork/11-1.c: Clean up temporary file
In-Reply-To: <20210219050439.179039-1-zhaogongyi@huawei.com>
References: <20210219050439.179039-1-zhaogongyi@huawei.com>
Message-ID: <CAEemH2e75x8Jbc=ST5VQdg9i-nJDX8zDp=HCt3HaVhVxsVOA2Q@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Gongyi,

On Fri, Feb 19, 2021 at 1:05 PM zhao gongyi <zhaogongyi@huawei.com> wrote:

> We need to clean up temporary file /tmp/fork-11-1-XXXXXX which created by
> mkstemp.
>
> Signed-off-by: zhao gongyi <zhaogongyi@huawei.com>
> ---
>  .../open_posix_testsuite/conformance/interfaces/fork/11-1.c     | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git
> a/testcases/open_posix_testsuite/conformance/interfaces/fork/11-1.c
> b/testcases/open_posix_testsuite/conformance/interfaces/fork/11-1.c
> index a43bc274c..e9b18958c 100644
> --- a/testcases/open_posix_testsuite/conformance/interfaces/fork/11-1.c
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/fork/11-1.c
> @@ -79,6 +79,8 @@ int main(void)
>                 return result;
>         }
>
> +       unlink(path_template);
>

Why do we need to delete the tempfile before acquiring a lock?
Or did you mean doing this after the testing(in the cleanup phase).

BTW, seems the child report a wrong status of the locked file, while
fcntl(fd, F_SETLK, &fl) return -1 and sets errno to EACCES or EAGAIN,
shouldn't that mean the file already been locked by the parent?



> +
>         if (fcntl(fd, F_SETLK, &fl) == -1) {
>                 printf("Could not set initial lock: %s (%d)\n",
>                        strerror(errno), errno);
> --
> 2.17.1
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
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210219/67f68260/attachment-0001.htm>
