From: Jiri Slaby <jslaby@suse.cz>
Date: Fri, 6 Mar 2020 08:58:32 +0100
Subject: [LTP] [PATCH v2] pty: Test data transmission with SLIP line
 discipline
In-Reply-To: <20200305110125.24554-1-rpalethorpe@suse.com>
References: <20200305110125.24554-1-rpalethorpe@suse.com>
Message-ID: <1d44c203-958a-5ec1-fcc6-862a24f4606b@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 05. 03. 20, 12:01, Richard Palethorpe wrote:
> Basic transmission test and try to trigger a possible race between receiving
> and hangup (it appears there is none from my testing).
> 
> This only includes SLIP for now, but more disciplines can be added. Probably
> at least CAN. However the packet generation will be different for each.
> 
> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
...
> --- /dev/null
> +++ b/testcases/kernel/pty/pty04.c
> @@ -0,0 +1,278 @@
...
> +struct ldisc_info {
> +	int n;
> +	char *name;
> +	int max_mtu;
> +};
> +
> +static struct ldisc_info ldiscs[] = {
> +	{1, "N_SLIP", 8192},

I meant using N_SLIP instead of magic "1", not in the string :).

thanks,
-- 
js
suse labs
