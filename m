From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 12 Jun 2018 14:48:22 +0200
Subject: [LTP] [PATCH] swapon: commit swapfile caches to disk
In-Reply-To: <1528806239-14297-1-git-send-email-liwang@redhat.com>
References: <1528806239-14297-1-git-send-email-liwang@redhat.com>
Message-ID: <20180612124822.GA18870@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Testcase include swapon(8) fails on mainline kernel-v4.17+ as:
>   swapon01    1  TFAIL  :  swapon01.c:47: Failed to turn on swapfile: TEST_ERRNO=EINVAL(22): Invalid argument
>   swapon02    4  TFAIL  :  swapon02.c:91: swapon(2) failed to produce expected error: 16, errno: EBUSY and got 22.
>   swapon03    1  TFAIL  :  swapon03.c:243: Failed to setup swaps
>   swapoff01   1  TBROK  :  swapoff01.c:64: Failed to turn on the swap file, skipping test iteration

4.17+ means that this is yet to be release kernel, right? In that
situation we wait if the change will survive upon the official release
before changing the LTP test.

> diff --git a/testcases/kernel/syscalls/swapoff/swapoff01.c b/testcases/kernel/syscalls/swapoff/swapoff01.c
> index a63e661..b587b0d 100644
> --- a/testcases/kernel/syscalls/swapoff/swapoff01.c
> +++ b/testcases/kernel/syscalls/swapoff/swapoff01.c
> @@ -105,6 +105,8 @@ static void setup(void)
>  
>  	if (system("mkswap swapfile01 > tmpfile 2>&1") != 0)
>  		tst_brkm(TBROK, cleanup, "Failed to make swapfile");
> +
> +	sync();

Can we rather use fsync() and/or fdatasync()? I would like the avoid the
system wide sync() here since that may slow down the test unnecessarily.

-- 
Cyril Hrubis
chrubis@suse.cz
