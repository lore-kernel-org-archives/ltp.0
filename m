From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 22 Aug 2017 17:50:34 +0200
Subject: [LTP] [PATCH] numa: Add new regression test for MPOL_PREFERRED
 poliy
In-Reply-To: <20170816091257.5097-1-liwang@redhat.com>
References: <20170816091257.5097-1-liwang@redhat.com>
Message-ID: <20170822155034.GB26138@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +# Verification of THP memory allocated on preferred node
> +test12()
> +{
> +	Mem_curr=0
> +
> +	COUNTER=1
> +	for node in $nodes_list; do
> +
> +		if [ $COUNTER -eq $total_nodes ]; then   #wrap up for last node
> +			Preferred_node=$(echo $nodes_list | cut -d ' ' -f 1)
> +		else
> +			# always next node is preferred node
> +			Preferred_node=$(echo $nodes_list | cut -d ' ' -f $((COUNTER+1)))
> +		fi
> +
> +		numactl --cpunodebind=$node --preferred=$Preferred_node support_numa alloc_1GB_THP &
> +		pid=$!
> +
> +		wait_for_support_numa $pid
> +
> +		Mem_curr=$(echo "$(extract_numastat_p $pid $Preferred_node) * $MB" |bc)
> +		if [ $(echo "$Mem_curr < $GB" |bc ) -eq 1 ]; then
> +			tst_res TFAIL \
> +				"NUMA memory allocated in node$Preferred_node is less than expected"
> +			kill -CONT $pid >/dev/null 2>&1
> +			return
> +		fi
> +
> +		COUNTER=$((COUNTER+1))
> +		kill -CONT $pid >/dev/null 2>&1
> +	done
> +
> +	tst_res TPASS "NUMA preferred node policy verified with THP enabled"
> +}

I suppose that we should check that transparent huge pages are enabled
before we run this test, i.e. that the file
/sys/kernel/mm/transparent_hugepage/enabled exists and that it's set to
always. Otherwise the helper would allocate 1GB of ordinary memory.

Also do we really need to allocate 1GB? Shouldn't be one huge page
enough? Or do we need to allocate a few of them?

>  tst_run
> diff --git a/testcases/kernel/numa/support_numa.c b/testcases/kernel/numa/support_numa.c
> index 4904cc5..37790e7 100644
> --- a/testcases/kernel/numa/support_numa.c
> +++ b/testcases/kernel/numa/support_numa.c
> @@ -53,6 +53,7 @@ static void help(void)
>  	printf("Input:	Describe input arguments to this program\n");
>  	printf("	argv[1] == \"alloc_1MB\" then allocate 1MB of memory\n");
>  	printf("	argv[1] == \"alloc_1MB_shared\" then allocate 1MB of share memory\n");
> +	printf("	argv[1] == \"alloc_1GB_THP\" then allocate 1GB of THP memory\n");
>  	printf("        argv[1] == \"alloc_1huge_page\" then allocate 1HUGE PAGE SIZE of memory\n");
>  	printf("        argv[1] == \"pause\" then pause the program to catch sigint\n");
>  	printf("Exit:	On failure - Exits with non-zero value\n");
> @@ -138,6 +139,22 @@ int main(int argc, char *argv[])
>  		munmap(buf, sb.st_size);
>  		close(fd);
>  		remove(TEST_SFILE);
> +	} else if (!strcmp(argv[1], "alloc_1GB_THP")) {
> +		size_t size = 1024 * MB;
> +
> +		buf = mmap(NULL, size, PROT_READ | PROT_WRITE,
> +				MAP_PRIVATE | MAP_ANONYMOUS,
> +				-1, 0);
> +		if (buf == MAP_FAILED) {
> +			perror("mmap failed");
> +			exit(1);
> +		}
> +
> +		memset(buf, 'a', size);
> +
> +		raise(SIGSTOP);
> +
> +		munmap(buf, size);
>  	} else if (!strcmp(argv[1], "alloc_1huge_page")) {
>  		hpsz = read_hugepagesize();
>  		if (hpsz == 0)
> -- 
> 2.9.3
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
