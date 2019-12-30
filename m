From: Li Wang <liwang@redhat.com>
Date: Mon, 30 Dec 2019 21:13:51 +0800
Subject: [LTP] [PATCH] nm01: Remove prefix zeros of the addresses output
 by nm before comparing
In-Reply-To: <1577257063-246792-1-git-send-email-zhe.he@windriver.com>
References: <1577257063-246792-1-git-send-email-zhe.he@windriver.com>
Message-ID: <CAEemH2fAwMjPoVX17ydSJ3jchpiLgsXQwr=PN6t77Kpq12puHQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Zhe,

On Wed, Dec 25, 2019 at 2:58 PM <zhe.he@windriver.com> wrote:

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
> ---
>  testcases/commands/nm/nm01.sh | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/testcases/commands/nm/nm01.sh b/testcases/commands/nm/nm01.sh
> index 30c41bd..29b6bd7 100755
> --- a/testcases/commands/nm/nm01.sh
> +++ b/testcases/commands/nm/nm01.sh
> @@ -84,6 +84,9 @@ test5()
>         EXPECT_PASS $NM -f bsd $TST_DATAROOT/f1 \> nm_bsd.out
>         EXPECT_PASS $NM -f posix $TST_DATAROOT/f1 \> nm_posix.out
>
> +       ROD awk '{print gensub(/(0+)([0-9a-fA-F]+)/, "\\2", "g")}'
> nm_bsd.out \> nm_bsd.out
>

AWK is base on stream editing, maybe we need the output to a new log file.

> +       ROD awk '{print gensub(/(0+)([0-9a-fA-F]+)/, "\\2", "g")}'
> nm_posix.out \> nm_posix.out
>

The regex is not fit for nm_posix.out since this format of address does not
start with 0000000000, e.g.

# cat nm_posix.out | grep 40108f
.annobin_init.c t 40108f
.annobin_init.c_end t 40108f

# echo 40108f | awk '{print gensub(/(0+)([0-9a-fA-F]+)/, "\\2", "g")}'
4108f


> +
>         ROD awk '{print $3 $2 $1}' nm_bsd.out \> nm1.out
>         ROD awk '{print $1 $2 $3}' nm_posix.out \> nm2.out
>
> --
> 2.7.4
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
URL: <http://lists.linux.it/pipermail/ltp/attachments/20191230/9a3f1471/attachment.htm>
