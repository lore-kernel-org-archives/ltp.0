From: Jiri Slaby <jslaby@suse.cz>
Date: Tue, 25 Feb 2020 08:02:15 +0100
Subject: [LTP] [PATCH] pty: Test data transmission with SLIP line
 discipline
In-Reply-To: <20200220111349.9901-1-rpalethorpe@suse.com>
References: <20200220111349.9901-1-rpalethorpe@suse.com>
Message-ID: <5cc0f468-d952-9867-3882-e01076d4fb07@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 20. 02. 20, 12:13, Richard Palethorpe wrote:
> Basic transmission test and try to trigger a possible race between receiving
> and hangup (it appears there is none from my testing).
> 
> This only includes SLIP for now, but more disciplines can be added. Probably
> at least CAN. However the packet generation will be different for each.
> 
> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> ---
...
> --- /dev/null
> +++ b/testcases/kernel/pty/pty04.c
> @@ -0,0 +1,250 @@
...> +struct ldisc_info {
> +	int n;
> +	char *name;
> +	int max_mtu;
> +};
> +
> +static struct ldisc_info ldiscs[] = {
> +	{0, "TTY", 0},

Why not N_TTY?

Why do you define the line above btw?

> +	{1, "SLIP", 8192},

And N_SLIP?

> +};
...
> +static void read_netdev(void)
> +{
> +	char *data = SAFE_MALLOC(mtu - 1);
> +
> +	tst_res(TINFO, "Reading from socket %d", sk);
> +
> +	SAFE_READ(1, sk, data, mtu - 1);
> +	tst_res(TPASS, "Read netdev 1");
> +	SAFE_READ(1, sk, data, mtu - 1);
> +
> +	tst_res(TPASS, "Read netdev 2");
> +
> +	TST_CHECKPOINT_WAKE(0);
> +	while(read(sk, data, mtu - 1) > 0)

Could you check whether '_' is actually received here?

> +		;
> +
> +	tst_res(TPASS, "Reading data from netdev interrupted by hangup");
> +
> +	free(data);
> +}

thanks,
-- 
js
suse labs
