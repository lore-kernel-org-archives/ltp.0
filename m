From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 12 May 2021 14:28:39 +0200
Subject: [LTP] [PATCH] API: Give user hint when checkpoints were not
 initialised
In-Reply-To: <20210512101738.31118-1-rpalethorpe@suse.com>
References: <20210512101738.31118-1-rpalethorpe@suse.com>
Message-ID: <YJvJ91pXVluuzpvu@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> ---
>  lib/tst_checkpoint.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/tst_checkpoint.c b/lib/tst_checkpoint.c
> index 9e9dcf9e6..13d86c73b 100644
> --- a/lib/tst_checkpoint.c
> +++ b/lib/tst_checkpoint.c
> @@ -86,6 +86,9 @@ int tst_checkpoint_wait(unsigned int id, unsigned int msec_timeout)
>  	struct timespec timeout;
>  	int ret;
>  
> +	if (!tst_max_futexes)
> +		tst_brkm(TBROK, NULL, "Set test.needs_checkpoints = 1");
> +
>  	if (id >= tst_max_futexes) {
>  		errno = EOVERFLOW;
>  		return -1;
> @@ -107,7 +110,10 @@ int tst_checkpoint_wake(unsigned int id, unsigned int nr_wake,
>  {
>  	unsigned int msecs = 0, waked = 0;
>  
> -	if (id >= tst_max_futexes) {
> +	if (!tst_max_futexes)
> +		tst_brkm(TBROK, NULL, "Set test.needs_checkpoints = 1");
> +
> +        if (id >= tst_max_futexes) {
    ^
    Spaces instead of tabs...


Other than that this looks obviously fine.

-- 
Cyril Hrubis
chrubis@suse.cz
