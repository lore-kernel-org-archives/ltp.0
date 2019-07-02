From: Po-Hsu Lin <po-hsu.lin@canonical.com>
Date: Tue, 2 Jul 2019 19:21:07 +0800
Subject: [LTP] [PATCH] zram/zram_lib.sh: fix local variable assignment
 for DASH
In-Reply-To: <20190702110419.21221-1-po-hsu.lin@canonical.com>
References: <20190702110419.21221-1-po-hsu.lin@canonical.com>
Message-ID: <CAMy_GT_-OQ5XBE7A89HgRFx7sNVN-J9POjM6KxYfF9w1X5EtYg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

OK for this one I think there is a better way to keep it one-liner.

It fails because there are more than one value returned:
    [lzo] lz4 lz4hc 842 zstd

But if we use quotes to enclose it, it works
    local algs="$(cat /sys/block/zram0/comp_algorithm)"

Please ignore this patch, I will revise this.
Thanks!

On Tue, Jul 2, 2019 at 7:04 PM Po-Hsu Lin <po-hsu.lin@canonical.com> wrote:
>
> The /bin/sh was symbolically link to dash in Ubuntu.
> This is making the one-liner local variable assignment not working [1]:
>     /opt/ltp/testcases/bin/zram01.sh: 102: local: 842: bad variable name
>
> Break it into two lines to solve this issue.
>
> [1] https://wiki.ubuntu.com/DashAsBinSh#local
>
> Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
> ---
>  testcases/kernel/device-drivers/zram/zram_lib.sh | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/testcases/kernel/device-drivers/zram/zram_lib.sh b/testcases/kernel/device-drivers/zram/zram_lib.sh
> index 45116af3e..5cf1ba435 100755
> --- a/testcases/kernel/device-drivers/zram/zram_lib.sh
> +++ b/testcases/kernel/device-drivers/zram/zram_lib.sh
> @@ -98,11 +98,13 @@ zram_compress_alg()
>
>         tst_resm TINFO "test that we can set compression algorithm"
>
> -       local algs=$(cat /sys/block/zram0/comp_algorithm)
> +       local algs
> +       algs=$(cat /sys/block/zram0/comp_algorithm)
>         tst_resm TINFO "supported algs: $algs"
>         local i=0
>         for alg in $zram_algs; do
> -               local sys_path="/sys/block/zram${i}/comp_algorithm"
> +               local sys_path
> +               sys_path="/sys/block/zram${i}/comp_algorithm"
>                 echo "$alg" >  $sys_path || \
>                         tst_brkm TFAIL "can't set '$alg' to $sys_path"
>                 i=$(($i + 1))
> --
> 2.17.1
>
