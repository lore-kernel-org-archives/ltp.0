From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date: Mon, 28 May 2018 15:38:59 +0900
Subject: [LTP] [PATCH] zram03: drop obsolete sysfs interfaces
In-Reply-To: <1527095646-77998-1-git-send-email-yang.shi@linux.alibaba.com>
References: <1527095646-77998-1-git-send-email-yang.shi@linux.alibaba.com>
Message-ID: <20180528063859.GA495@jagdpanzerIV>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

>  testcases/kernel/device-drivers/zram/zram03.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/testcases/kernel/device-drivers/zram/zram03.c b/testcases/kernel/device-drivers/zram/zram03.c
> index 3f7ab4e..f2c166c 100644
> --- a/testcases/kernel/device-drivers/zram/zram03.c
> +++ b/testcases/kernel/device-drivers/zram/zram03.c
> @@ -185,11 +185,5 @@ static void print(char *string)
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
>  }

Is this against the Linux kernel code or some 3-rd party code?

	-ss
