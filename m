From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 3 Nov 2015 03:24:57 -0500 (EST)
Subject: [LTP] [PATCH 6/11 v2] mmap/mmap12: Testcase failed for non-root
 user
In-Reply-To: <563869D2.2060607@huawei.com>
References: <1446001907-43525-1-git-send-email-cuibixuan@huawei.com>
 <20151029115746.GA23990@rei> <563330C4.2060809@huawei.com>
 <492224674.39010592.1446197341093.JavaMail.zimbra@redhat.com>
 <5634112F.1030203@huawei.com>
 <322055225.38333.1446279322374.JavaMail.zimbra@redhat.com>
 <20151102115419.GA28478@rei> <563869D2.2060607@huawei.com>
Message-ID: <547742230.1412756.1446539097815.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "Cui Bixuan" <cuibixuan@huawei.com>
> To: "Cyril Hrubis" <chrubis@suse.cz>
> Cc: "Jan Stancek" <jstancek@redhat.com>, zhuyanpeng@huawei.com, zhanyongming@huawei.com, ltp@lists.linux.it
> Sent: Tuesday, 3 November, 2015 9:01:22 AM
> Subject: [LTP] [PATCH 6/11 v2] mmap/mmap12: Testcase failed for non-root user
> 
> Unprivileged user open /proc/self/pagemap fail so add check for it
> 
> Signed-off-by: Cui Bixuan <cuibixuan@huawei.com>

Pushed with more verbose commit message and small changes to style.

Regards,
Jan

> ---
>  testcases/kernel/syscalls/mmap/mmap12.c |   10 ++++++++--
>  1 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/mmap/mmap12.c
> b/testcases/kernel/syscalls/mmap/mmap12.c
> index ba8c646..ebc44ae 100644
> --- a/testcases/kernel/syscalls/mmap/mmap12.c
> +++ b/testcases/kernel/syscalls/mmap/mmap12.c
> @@ -108,8 +108,14 @@ static int page_check(void)
>  	index = (vmstart / page_sz) * sizeof(uint64_t);
> 
>  	pm = open("/proc/self/pagemap", O_RDONLY);
> -	if (pm == -1)
> -		tst_brkm(TFAIL | TERRNO, NULL, "Open dev pagemap failed");
> +	if (pm == -1) {
> +		if ((0 != geteuid()) && (errno == EPERM))
> +			tst_brkm(TCONF | TERRNO, NULL,
> +				"don't have permission to open dev pagemap");
> +		else
> +			tst_brkm(TFAIL | TERRNO, NULL,
> +				"Open dev pagemap failed");
> +	}
> 
>  	offset = lseek(pm, index, SEEK_SET);
>  	if (offset != index)
> --
> 1.6.0.2
> 
