From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 5 Jan 2021 14:15:39 +0100
Subject: [LTP] [PATCH 1/2] syscalls/open01.c: Don't continue when open()
 failed
In-Reply-To: <20210104125423.19183-1-yangx.jy@cn.fujitsu.com>
References: <20210104125423.19183-1-yangx.jy@cn.fujitsu.com>
Message-ID: <X/RmeykJSClh7a5/@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Avoid calling fstat() with invalid fd:
> -------------------------------------------
> ./open01
> ...
> open01.c:53: TBROK: fstat(-1,0x7fff731410a0) failed: EBADF (9)
> -------------------------------------------
> 
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---
>  testcases/kernel/syscalls/open/open01.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/testcases/kernel/syscalls/open/open01.c b/testcases/kernel/syscalls/open/open01.c
> index 1172f832b..2f0ad550a 100644
> --- a/testcases/kernel/syscalls/open/open01.c
> +++ b/testcases/kernel/syscalls/open/open01.c
> @@ -47,6 +47,9 @@ static void verify_open(unsigned int n)
>  
>  	TST_EXP_FD(open(tc->filename, tc->flag, tc->mode),
>  	           "open() with %s", tc->desc);
> +	if (!TST_PASS)
> +		return;
> +

Doesn't this only happen if the open() that is supposed to return a
valid file descriptor fails unexpectedly? In that the test fails, right?

But I guess that it does not harm, so:

Acked-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz
