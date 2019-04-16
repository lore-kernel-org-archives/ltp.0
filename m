From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 16 Apr 2019 10:59:01 +0200
Subject: [LTP] [PATCH] mem02: calculate the order of pagesize instead to
 hardcode
In-Reply-To: <20190416081655.23749-1-bala24@linux.vnet.ibm.com>
References: <20190416081655.23749-1-bala24@linux.vnet.ibm.com>
Message-ID: <20190416085901.GA28671@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Applied with minor style changes, thanks.

> +static int get_pagesize_order()
                                 ^
				 added void
> +{
> +	int i, pagesize, size = 0;
> +	pagesize = sysconf(_SC_PAGESIZE);
> +	for (i = 0; size != pagesize; i++)
> +		size = 1 << i;
> +	return (i - 1);
> +}
> +
>  int main(int argc, char **argv)
>  {
>  	int i;
>  	char *pm1, *pm2, *pm3, *pm4;
> -	long pm6;
>  	void *memptr;
>  	long laddr;
>  	int iteration_count;
>  	int size;		/* Size to memory to be valloced */
> -	int pagesize = 12;	/* 2^12 = 4096, PAGESIZE      */
> +	/* calculate the order of pagesize */
             ^
	     Removed this redundant comment as it was commenting the
	     obvious.

> +	int pagesize_order = get_pagesize_order();
>  	int memsize = MEMSIZE;	/* Size of memory to allocate */
>  	extern char *optarg;	/* getopt() function global variables */
>  	extern int optopt;	/* stores bad option passed to the program */

-- 
Cyril Hrubis
chrubis@suse.cz
