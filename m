From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 16 May 2017 08:28:04 -0400 (EDT)
Subject: [LTP] [PATCH v2] move_pages12: Make sure hugepages are available
In-Reply-To: <20170516100759.10355-1-chrubis@suse.cz>
References: <20170516100759.10355-1-chrubis@suse.cz>
Message-ID: <1420231349.12458178.1494937684196.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> +
>  static void setup(void)
>  {
>  	int memfree, ret;
> @@ -137,6 +181,10 @@ static void setup(void)
>  	if (access(PATH_HUGEPAGES, F_OK))
>  		tst_brk(TCONF, "Huge page not supported");
>  
> +	ret = get_allowed_nodes(NH_MEMS, TEST_NODES, &node1, &node2);
> +	if (ret < 0)
> +		tst_brk(TBROK | TERRNO, "get_allowed_nodes: %d", ret);
> +
>  	pgsz = (int)get_page_size();
>  	SAFE_FILE_LINES_SCANF(PATH_MEMINFO, "Hugepagesize: %d", &hpsz);
>  
> @@ -148,18 +196,56 @@ static void setup(void)
>  
>  	hpsz *= 1024;
>  
> -	SAFE_FILE_SCANF(PATH_NR_HUGEPAGES, "%ld", &orig_hugepages);
> -	SAFE_FILE_PRINTF(PATH_NR_HUGEPAGES, "%ld", orig_hugepages + 4);
> +	snprintf(path_hugepages_node1, sizeof(path_hugepages_node1),
> +
> 		 "/sys/devices/system/node/node%u/hugepages/hugepages-2048kB/nr_hugepages",
> +		 node1);
> +
> +	snprintf(path_hugepages_node2, sizeof(path_hugepages_node2),
> +
> 		 "/sys/devices/system/node/node%u/hugepages/hugepages-2048kB/nr_hugepages",
> +		 node2);

Hi,

"hugepages-2048kB" in path above will work only on systems with 2M huge pages.

> +
> +	if (!access(path_hugepages_node1, F_OK)) {
> +		SAFE_FILE_SCANF(path_hugepages_node1,
> +				"%ld", &orig_hugepages_node1);
> +		tst_res(TINFO, "Increasing hugepages pool on node %u to %ld",
> +			node1, orig_hugepages_node1 + 4);
> +		SAFE_FILE_PRINTF(path_hugepages_node1,
> +				 "%ld", orig_hugepages_node1 + 4);

There doesn't seem to be any error if you ask for more:

# echo 20000 > /sys/devices/system/node/node0/hugepages/hugepages-2048kB/nr_hugepages
# cat /sys/devices/system/node/node0/hugepages/hugepages-2048kB/nr_hugepages
11650

So, maybe we can just read it back and if it doesn't match what we requested,
we can TCONF.

Rest looks good to me.
I've tested so far only on x86, no issues there.

Regards,
Jan
