From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 5 Nov 2019 14:05:05 +0100
Subject: [LTP] [PATCH] lib/tst_test: Warn on repeated options
In-Reply-To: <20191105120053.9173-1-chrubis@suse.cz>
References: <20191105120053.9173-1-chrubis@suse.cz>
Message-ID: <20191105130505.GD8511@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> CC: Jan Stancek <jstancek@redhat.com>
> ---
>  lib/tst_test.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index c7b46d0d5..f41baf3cf 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -468,6 +468,9 @@ static void parse_topt(unsigned int topts_len, int opt, char *optarg)
>  	if (i >= topts_len)
>  		tst_brk(TBROK, "Invalid option '%c' (should not happen)", opt);
>  
> +	if (*toptions[i].arg)
> +		tst_res(TWARN, "Option passed -%c multiple times", opt);

Obviously the -%c and passed should be swapped, I can do that before
pushing if the patch gets ack.

-- 
Cyril Hrubis
chrubis@suse.cz
