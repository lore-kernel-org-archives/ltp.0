From: Li Wang <liwang@redhat.com>
Date: Tue, 12 Nov 2019 14:12:44 +0800
Subject: [LTP] [PATCH] mkswap01.sh: Add "udevadm trigger" before swap
 verification
In-Reply-To: <20191112035237.39839-1-yongxin.liu@windriver.com>
References: <20191112035237.39839-1-yongxin.liu@windriver.com>
Message-ID: <CAEemH2eJD5rLqi6bTZARrVW_963bi=SidaEzcEeWAYib8CkomA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Nov 12, 2019 at 1:01 PM Yongxin Liu <yongxin.liu@windriver.com>
wrote:

> Fix: https://github.com/linux-test-project/ltp/issues/458
>
> Sometimes the swap device cannot show up in /dev/disk/by-uuid/
> or /dev/disk/by-lable/ due to the issue #458. When this issue
> happens, "blkid -c /dev/null" and "ls /dev/disk/by-uuid/" show
> different UUID of the device.
>
> Signed-off-by: Yongxin Liu <yongxin.liu@windriver.com>
>
Acked-by: Li Wang <liwang@redhat.com>


> ---
>  testcases/commands/mkswap/mkswap01.sh | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/testcases/commands/mkswap/mkswap01.sh
> b/testcases/commands/mkswap/mkswap01.sh
> index 3a348c6e6..9437c4a4e 100755
> --- a/testcases/commands/mkswap/mkswap01.sh
> +++ b/testcases/commands/mkswap/mkswap01.sh
> @@ -129,6 +129,8 @@ mkswap_test()
>                 return
>         fi
>
> +       udevadm trigger --name-match=$TST_DEVICE
> +
>         if [ -n "$device" ]; then
>                 mkswap_verify "$mkswap_op" "$op_arg" "$device" "$size"
> "$dev_file"
>                 if [ $? -ne 0 ]; then
> --
> 2.14.4
>
>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20191112/ef065f8c/attachment.htm>
