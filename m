From: xuyang2018.jy@fujitsu.com <xuyang2018.jy@fujitsu.com>
Date: Fri, 16 Jul 2021 01:23:01 +0000
Subject: [LTP] [PATCH v2,
 1/2] lib/tst_test.sh: Make tst_umount work with argument that
In-Reply-To: <20210715142448.GA30641@atcfdc88>
References: <20210715142448.GA30641@atcfdc88>
Message-ID: <60F0DF88.9020603@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Leo
> /proc/mounts shows the mount point without terminating slashes, e.g.
> ~ $ cat /proc/mounts
> xxx /root/cgroup cgroup rw,relatime,cpu 0 0
>
> So current tst_umount would not work with argument that has terminating slash, e.g.
> tst_umount cgroup/ would give "The device is not mounted".
>
> Fix this by using mountpoint command instead of grepping /proc/mounts.
>
> Signed-off-by: Leo Yu-Chi Liang<ycliang@andestech.com>
> ---
>   testcases/lib/tst_test.sh | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
> index c6aa2c487..7e77711f1 100644
> --- a/testcases/lib/tst_test.sh
> +++ b/testcases/lib/tst_test.sh
> @@ -282,7 +282,7 @@ tst_umount()
>
>   	[ -z "$device" ]&&  return
>
> -	if ! grep -q "$device" /proc/mounts; then
> +	if ! mountpoint -q "$device"; then
Honestly speaking, I don't want to introduce mountpoint command.
we can just filter the last "/" string for $device.

Best Regards
Yang Xu
>   		tst_res TINFO "The $device is not mounted, skipping umount"
>   		return
>   	fi
