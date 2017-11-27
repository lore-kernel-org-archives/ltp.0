From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 27 Nov 2017 17:20:00 +0100
Subject: [LTP] [PATCH v2 02/13] thp: ensure THP/hugetlbfs is available
In-Reply-To: <20171114155929.24237-3-punit.agrawal@arm.com>
References: <20171114155929.24237-1-punit.agrawal@arm.com>
 <20171114155929.24237-3-punit.agrawal@arm.com>
Message-ID: <20171127162000.GA20047@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/testcases/kernel/mem/thp/thp01.c b/testcases/kernel/mem/thp/thp01.c
> index 2f2bb2bdb..939c01b98 100644
> --- a/testcases/kernel/mem/thp/thp01.c
> +++ b/testcases/kernel/mem/thp/thp01.c
> @@ -116,6 +116,9 @@ static void setup(void)
>  	int i;
>  	long arg_len, arg_count;
>  
> +	if (access(PATH_THP, F_OK) == -1)
> +		tst_brk(TCONF, "THP not enabled in kernel?");
> +
>  	bst = SAFE_MMAP(NULL, sizeof(*bst),
>  			   PROT_READ | PROT_WRITE,
>  			   MAP_SHARED | MAP_ANONYMOUS, -1, 0);

I do not get what is the problem with this test on a machine without
hugepages or transparent hugepages. The test just tries to execute true
with excessively large array of command line arguments, if that fails
without hugepages it's a kernel bug.

> diff --git a/testcases/kernel/mem/thp/thp02.c b/testcases/kernel/mem/thp/thp02.c
> index acc70e215..6502210e5 100644
> --- a/testcases/kernel/mem/thp/thp02.c
> +++ b/testcases/kernel/mem/thp/thp02.c
> @@ -90,6 +90,8 @@ static void setup(void)
>  	if (access(PATH_THP, F_OK) == -1)
>  		tst_brk(TCONF, "THP not enabled in kernel?");
>  
> +	check_hugepage();
> +
>  	ps = sysconf(_SC_PAGESIZE);
>  	hps = SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
>  	size = hps * 4;
> diff --git a/testcases/kernel/mem/thp/thp03.c b/testcases/kernel/mem/thp/thp03.c
> index 19db44944..c6062505f 100644
> --- a/testcases/kernel/mem/thp/thp03.c
> +++ b/testcases/kernel/mem/thp/thp03.c
> @@ -82,6 +82,8 @@ static void setup(void)
>  	if (access(PATH_THP, F_OK) == -1)
>  		tst_brk(TCONF, "THP not enabled in kernel?");
>  
> +	check_hugepage();
> +
>  	hugepage_size = SAFE_READ_MEMINFO("Hugepagesize:") * KB;
>  	unaligned_size = hugepage_size * 4 - 1;
>  	page_size = SAFE_SYSCONF(_SC_PAGESIZE);

Does this two fail on an attempt to find "Hugepagesize:" in meminfo
file? Otherwise I do not see how they can fail.

-- 
Cyril Hrubis
chrubis@suse.cz
