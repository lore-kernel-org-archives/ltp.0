From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 5 May 2017 11:34:12 +0200
Subject: [LTP] [PATCH] Fix getcwd03 testcase by zeroing target buffer
 for readlink()
In-Reply-To: <20170504182346.GA4959@ls3530.fritz.box>
References: <20170504182346.GA4959@ls3530.fritz.box>
Message-ID: <20170505093412.GB16729@rei.suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> According to the man(2) page of readlink(), a null byte is not appended to the
> target buffer. So applications need to make sure that the target buffer is
> zero-initialized, otherwise random bytes at the end of the returned string may
> exist. 

Good catch.

> This patch zero-initializes the on-stack char array "link" and thus fixes the
> testcase failure of getcwd03 on the hppa/parisc architecture (and maybe others).

Can we use the return value form the readlink instead?

	r = SAFE_READLINK(.., buf, sizeof(buf)-1);
	buf[r] = '\0';

The SAFE_READLINK() does catch the case where readlink() returns -1 and
passing size decreased by one should handle the corner case where the
path is truncated and return value is the size of the buffer we passed
to the readlink() call.

> Signed-off-by: Helge Deller <deller@gmx.de>
> 
> --
>  testcases/kernel/syscalls/getcwd/getcwd03.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> 
> diff --git a/testcases/kernel/syscalls/getcwd/getcwd03.c b/testcases/kernel/syscalls/getcwd/getcwd03.c
> index 4f8f872cf..ec1cacea9 100644
> --- a/testcases/kernel/syscalls/getcwd/getcwd03.c
> +++ b/testcases/kernel/syscalls/getcwd/getcwd03.c
> @@ -74,6 +74,7 @@ static void verify_getcwd(void)
>  	}
>  
>  	SAFE_CHDIR("..");
> +	memset(link, 0, sizeof(link));
>  	SAFE_READLINK(dir_link, link, sizeof(link));
>  
>  	if (strcmp(link, SAFE_BASENAME(res1))) {
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
