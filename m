From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 14 May 2020 15:39:18 +0200
Subject: [LTP] [PATCH] pty04: Fix read retries
In-Reply-To: <20200514133201.12829-1-rpalethorpe@suse.com>
References: <20200514133201.12829-1-rpalethorpe@suse.com>
Message-ID: <20200514133918.GA6087@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> We need to increase the data pointer by the amount already read.

Applied, thanks.

> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> ---
>  testcases/kernel/pty/pty04.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/pty/pty04.c b/testcases/kernel/pty/pty04.c
> index 68a84ea87..d574d8b2c 100644
> --- a/testcases/kernel/pty/pty04.c
> +++ b/testcases/kernel/pty/pty04.c
> @@ -294,7 +294,7 @@ static void try_read(int fd, char *data, ssize_t size)
>  	int retry = mtu;
>  
>  	while (retry--) {
> -		ret = read(fd, data, size - n);
> +		ret = read(fd, data + n, size - n);

Sorry for not catching that during the review...

-- 
Cyril Hrubis
chrubis@suse.cz
