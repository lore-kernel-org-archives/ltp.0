From: Li Wang <liwang@redhat.com>
Date: Tue, 31 Dec 2019 17:05:24 +0800
Subject: [LTP] [PATCH v2] nm01: Remove prefix zeros of the addresses
 output by nm before comparing
In-Reply-To: <1577775768-134223-1-git-send-email-zhe.he@windriver.com>
References: <1577775768-134223-1-git-send-email-zhe.he@windriver.com>
Message-ID: <CAEemH2fjzJmerA+_BvGnGKBpStw9YAWWdze8RW4fzahg+NoTMw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Dec 31, 2019 at 3:03 PM <zhe.he@windriver.com> wrote:

> From: He Zhe <zhe.he@windriver.com>
>
> The latest nm v2.33.1.20191208 outputs symbols addresses without prefix
> zeros
> for "nm -f posix", which causes the following error.
> nm01 5 TFAIL: Got wrong format with -f bsd
>
> Let's remove the prefix zeros before comparing.
>
> Signed-off-by: He Zhe <zhe.he@windriver.com>
>
Reviewed-by: Li Wang <liwang@redhat.com>


> ---
> v2:
> Add boundary mark to RE pattern to exactly cover the prefix zeros
> Add one more temp file to contain trimmed output
>
>  testcases/commands/nm/nm01.sh | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/testcases/commands/nm/nm01.sh b/testcases/commands/nm/nm01.sh
> index 30c41bd..fd9d3d9 100755
> --- a/testcases/commands/nm/nm01.sh
> +++ b/testcases/commands/nm/nm01.sh
> @@ -84,8 +84,11 @@ test5()
>         EXPECT_PASS $NM -f bsd $TST_DATAROOT/f1 \> nm_bsd.out
>         EXPECT_PASS $NM -f posix $TST_DATAROOT/f1 \> nm_posix.out
>
> -       ROD awk '{print $3 $2 $1}' nm_bsd.out \> nm1.out
> -       ROD awk '{print $1 $2 $3}' nm_posix.out \> nm2.out
> +       ROD awk '{print gensub(/\y(0+)([0-9a-fA-F]+)\y/, "\\2", "g")}'
> nm_bsd.out \> trimmed_nm_bsd.out
> +       ROD awk '{print gensub(/\y(0+)([0-9a-fA-F]+)\y/, "\\2", "g")}'
> nm_posix.out \> trimmed_nm_posix.out
> +
> +       ROD awk '{print $3 $2 $1}' trimmed_nm_bsd.out \> nm1.out
> +       ROD awk '{print $1 $2 $3}' trimmed_nm_posix.out \> nm2.out
>
>         if diff nm1.out nm2.out > /dev/null; then
>                 tst_res TPASS "Got BSD format with -f bsd"
> --
> 2.7.4
>
>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20191231/01d7c5e8/attachment.htm>
