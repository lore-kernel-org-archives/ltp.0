From: Liam Howlett <liam.howlett@oracle.com>
Date: Mon, 10 May 2021 01:15:49 +0000
Subject: [LTP] [PATCH] syscall: remove PROT_WRITE|PROT_EXEC from brk02
In-Reply-To: <20210508061252.18337-1-liwang@redhat.com>
References: <20210508061252.18337-1-liwang@redhat.com>
Message-ID: <20210510011134.cegvehhbuyc5us24@revolver>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Reviewed-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

* Li Wang <liwang@redhat.com> [210508 02:13]:
> We got permission denied while performing the brk02 on x86_64/s390x
> (kernel-4.18). After looking at the manual page of mprotect(), seems
> the access issue caused by PROT_EXEC.
> 
>  " POSIX says that the behavior of mprotect() is unspecified if it is
>  applied to a region of memory that was not obtained via mmap(2). "
> 
>  # ./brk02
>  tst_test.c:1291: TINFO: Timeout per run is 0h 05m 00s
>  brk02.c:41: TFAIL: Cannot mprotect new VMA
> 
> From Liam Howlett:
>  Just removing the PROT_EXEC invalidates the test. However, if both
>  PROT_EXEC and PROT_WRITE are removed, then the test still does what
>  is intended.
> 
> So let's remove 'PROT_WRITE|PROT_EXEC' to make brk02 PASS with
> all platforms.
> 
> Suggested-by: Liam Howlett <liam.howlett@oracle.com>
> Signed-off-by: Li Wang <liwang@redhat.com>
> Cc: Cyril Hrubis <chrubis@suse.cz>
> ---
>  testcases/kernel/syscalls/brk/brk02.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/brk/brk02.c b/testcases/kernel/syscalls/brk/brk02.c
> index 4a272bac3..11e803cb4 100644
> --- a/testcases/kernel/syscalls/brk/brk02.c
> +++ b/testcases/kernel/syscalls/brk/brk02.c
> @@ -36,8 +36,7 @@ void brk_down_vmas(void)
>  		return;
>  	}
>  
> -	if (mprotect(addr - page_size, page_size,
> -		     PROT_READ|PROT_WRITE|PROT_EXEC)) {
> +	if (mprotect(addr - page_size, page_size, PROT_READ)) {
>  		tst_res(TFAIL | TERRNO, "Cannot mprotect new VMA");
>  		return;
>  	}
> -- 
> 2.30.2
> 
