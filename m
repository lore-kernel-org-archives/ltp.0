From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 12 Jun 2018 14:02:39 +0200
Subject: [LTP] [PATCH v2] zram03: drop obsolete sysfs interfaces
In-Reply-To: <1528412099-50431-1-git-send-email-yang.shi@linux.alibaba.com>
References: <1528412099-50431-1-git-send-email-yang.shi@linux.alibaba.com>
Message-ID: <20180612120239.vhzwj524oi4qs27m@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Yang,

> Due to upstream linux commit c87d1655c29500b459fb135258a93f8309ada9c7
> ("zram: remove obsolete sysfs attrs"), some sysfs interfaces are not
> available anymore.
From the commit is seen, that most of them (missing num_reads and
num_writes) has been accessible for some time from /sys/block/zram<id>/mm_stat.
And indeed the docs [1] confirm that. Maybe it'd make sense to parse this file
and use the data.

/sys/block/zram<id>/mm_stat was added in 4f2109f608815 (v4.1-rc1)
Interesting, it's also in Centos7 3.10.0-693 kernel, it must have been
backported there (obviously not in 3.16 from Debian).

[1] https://www.kernel.org/doc/Documentation/blockdev/zram.txt


Kind regards,
Petr

> Check kernel version, and remove dumping them on >= 4.10 kernel to avoid
> test case failure.

> Suggested-by: Li Wang <liwang@redhat.com>
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> ---
> v1 --> v2:
> Check kernel version to dump proper stats per Li Wang's suggestion

>  testcases/kernel/device-drivers/zram/zram03.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)

> diff --git a/testcases/kernel/device-drivers/zram/zram03.c b/testcases/kernel/device-drivers/zram/zram03.c
> index 3f7ab4e..58d88bc 100644
> --- a/testcases/kernel/device-drivers/zram/zram03.c
> +++ b/testcases/kernel/device-drivers/zram/zram03.c
> @@ -185,11 +185,15 @@ static void print(char *string)
>  static void dump_info(void)
>  {
>  	print("initstate");
> -	print("compr_data_size");
> -	print("orig_data_size");
>  	print("disksize");
> -	print("mem_used_total");
> -	print("num_reads");
> -	print("num_writes");
> -	print("zero_pages");
> +
> +	if ((tst_kvercmp(4, 10, 0)) < 0) {
> +		/* The below stats are not available on 4.10 or newer kernel */
> +		print("compr_data_size");
> +		print("orig_data_size");
> +		print("mem_used_total");
> +		print("num_reads");
> +		print("num_writes");
> +		print("zero_pages");
> +	}
>  }
