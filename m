From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 24 May 2016 10:01:12 -0400 (EDT)
Subject: [LTP] [PATCH v1 1/1] test_robind: add "-f" mkfs option for xfs
 and	btrfs
In-Reply-To: <20160524074936.11253-1-bxue@redhat.com>
References: <20160524074936.11253-1-bxue@redhat.com>
Message-ID: <882847003.325886.1464098472012.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "Boyang Xue" <bxue@redhat.com>
> To: ltp@lists.linux.it
> Sent: Tuesday, 24 May, 2016 9:49:36 AM
> Subject: [LTP] [PATCH v1 1/1] test_robind: add "-f" mkfs option for xfs and	btrfs
> 
> Add "-f" mkfs option for xfs and btrfs to aid the failure in creating
> filesystem due to commit a7f854472ebc ("tst_mkfs: drop -f from mkfs").
> 
> Signed-off-by: Boyang Xue <bxue@redhat.com>

Alternative would be to zero-erase first blocks of LTP_BIG_DEV
in runltp, but I'm not sure we want to assume that all tests
are going to write over it.

I found only 3 tests using LTP_BIG_DEV, this is the only
one that is using xfs/btrfs, the other two are ext3/4.

So, this is fine by me, ACK.
@Stanislav: Any thoughts?

Regards,
Jan

> ---
>  testcases/kernel/fs/fs_readonly/test_robind.sh | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/testcases/kernel/fs/fs_readonly/test_robind.sh
> b/testcases/kernel/fs/fs_readonly/test_robind.sh
> index dfe6f7e..181ae9e 100755
> --- a/testcases/kernel/fs/fs_readonly/test_robind.sh
> +++ b/testcases/kernel/fs/fs_readonly/test_robind.sh
> @@ -198,6 +198,10 @@ for fstype in $FSTYPES; do
>  		opts="-f --journal-size 513 -q"
>  	elif echo "$fstype" | grep -q "ext"; then
>  		opts="-F"
> +	elif [ "$fstype" = "xfs" ]; then
> +		opts="-f"
> +	elif [ "$fstype" = "btrfs" ]; then
> +		opts="-f"
>  	fi
>  
>  	if [ "$fstype" != "ramfs" ]; then
> --
> 2.8.3
> 
> 
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
> 
