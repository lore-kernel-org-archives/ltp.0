From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 8 Jun 2020 05:57:52 -0400 (EDT)
Subject: [LTP] [PATCH v1] Added test case to test mmap with
 MAP_FIXED_NOREPLACE flag
In-Reply-To: <20200608092635.15248-1-kushalchand@zilogic.com>
References: <20200608092635.15248-1-kushalchand@zilogic.com>
Message-ID: <472905204.15124870.1591610272008.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> 
> This patch adds a new test case for the mmap syscall. It tests the
> MAP_FIXED_NOREPLACE flag of mmap. The code checks if MAP_FIXED_NOREPLACE
> returns with EEXIST when mapped with an already mapped address. It does
> so by allocating an available address by passing NULL to first argument
> of mmap and tries to mmap with MAP_FIXED_NOREPLACE flag at the same
> address returned by the first mmap call. This fails as expected. It also
> does the necessary changes required to run the syscall using the runltp
> command after building the LTP test suite.
> Git Hub Issue link - https://github.com/linux-test-project/ltp/issues/299
> 
> Signed-off-by: Kushal Chand <kushalchand@zilogic.com>
> Reviewed-by: Vijay Kumar B. <vijaykumar@zilogic.com>
> 

Hi,

> +static void test_mmap(void)
> +{
> +	int str_len;
> +	void *address;
> +
> +	str_len = strlen(str);
> +
> +	SAFE_WRITE(1, fd_file1, str, str_len);
> +	mapped_address = SAFE_MMAP(NULL, str_len, PROT_WRITE,
> +				   MAP_PRIVATE, fd_file1, 0);
> +
> +	SAFE_WRITE(1, fd_file2, str, str_len);
> +
> +	address = mmap(mapped_address, str_len, PROT_WRITE,
> +		  MAP_PRIVATE | MAP_FIXED_NOREPLACE, fd_file2, 0);

This needs fallback definition in lapi/mmap.h, otherwise it won't compile
on older distros.

