From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 20 Apr 2021 10:22:39 +0200
Subject: [LTP] [PATCH] mkfs: print more info for debugging
In-Reply-To: <20210420075351.16059-1-liwang@redhat.com>
References: <20210420075351.16059-1-liwang@redhat.com>
Message-ID: <YH6PT2HKt6t1xZxR@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> We can NOT reproduce the problem by manual with both ppc64le and s390x,
> so let's print more useful info from test when getting fail.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

LGTM, just some remarks below

>  mkfs01 1 TPASS: 'mkfs -t ext4  /dev/loop0 ' passed.
>  mkfs01 2 TFAIL: 'mkfs -t ext4  /dev/loop0 16000' failed, not expected.
>  mkfs01 3 TPASS: 'mkfs -t ext4 -c /dev/loop0 ' passed.
>  mkfs01 4 TPASS: 'mkfs -V   ' passed.
>  mkfs01 5 TPASS: 'mkfs -h   ' passed.

> Signed-off-by: Li Wang <liwang@redhat.com>
> ---
>  testcases/commands/mkfs/mkfs01.sh | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

> diff --git a/testcases/commands/mkfs/mkfs01.sh b/testcases/commands/mkfs/mkfs01.sh
> index 90368190d..55296c8df 100755
> --- a/testcases/commands/mkfs/mkfs01.sh
> +++ b/testcases/commands/mkfs/mkfs01.sh
> @@ -128,7 +128,8 @@ mkfs_test()
>  	if [ -n "$device" ]; then
>  		mkfs_verify_type "$fs_type" "$device"
>  		if [ $? -ne 0 ]; then
> -			tst_res TFAIL "'${mkfs_cmd}' failed, not expected."
> +			tst_res TFAIL "'${mkfs_cmd}' failed, not expected type."
Maybe "unexpected type"?

I'd also change ${mkfs_cmd} to $mkfs_cmd (more readable).

> +			cat temp
>  			return
>  		fi
>  	fi
> @@ -136,7 +137,8 @@ mkfs_test()
>  	if [ -n "$size" ]; then
>  		mkfs_verify_size "$fs_type" "$size"
>  		if [ $? -ne 0 ]; then
> -			tst_res TFAIL "'${mkfs_cmd}' failed, not expected."
> +			tst_res TFAIL "'${mkfs_cmd}' failed, not expected size."
The same here.

Kind regards,
Petr

> +			cat temp
>  			return
>  		fi
>  	fi
