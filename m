From: Li Wang <liwang@redhat.com>
Date: Tue, 16 Mar 2021 15:33:32 +0800
Subject: [LTP] [PATCH] kernel/syscalls/brk: Update file list for
 .gitignore
In-Reply-To: <20210316033837.7813-1-xieziyao@huawei.com>
References: <20210316033837.7813-1-xieziyao@huawei.com>
Message-ID: <CAEemH2de1anhbvgbR-2j=w4diAqqCUbQEYEp-BmeYnu5fL5RjA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Ziyao,

I have mergeed the two fixes, thanks!

On Tue, Mar 16, 2021 at 11:39 AM Xie Ziyao <xieziyao@huawei.com> wrote:

> Add brk02 to .gitignore, which was previously ignored by the author.
>
> Signed-off-by: Xie Ziyao <xieziyao@huawei.com>
> ---
>  testcases/kernel/syscalls/brk/.gitignore | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/testcases/kernel/syscalls/brk/.gitignore
> b/testcases/kernel/syscalls/brk/.gitignore
> index b16ea36c7..60e16e591 100644
> --- a/testcases/kernel/syscalls/brk/.gitignore
> +++ b/testcases/kernel/syscalls/brk/.gitignore
> @@ -1 +1,2 @@
>  /brk01
> +/brk02
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
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210316/ec3a6d2c/attachment.htm>
