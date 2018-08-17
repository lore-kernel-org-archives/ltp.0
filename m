From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Fri, 17 Aug 2018 14:12:07 +0300
Subject: [LTP] [PATCH 1/2] netstress: Update help for -m behavior for
 client and server
In-Reply-To: <20180816172047.6281-1-pvorel@suse.cz>
References: <20180816172047.6281-1-pvorel@suse.cz>
Message-ID: <6b130bd3-596a-ba85-47b4-4d9b136bb1c4@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 16.08.2018 20:20, Petr Vorel wrote:
> Different udp/udp_lite behaviour for server is due no listen() call.
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---

Hi Petr,

>  testcases/network/netstress/netstress.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/testcases/network/netstress/netstress.c b/testcases/network/netstress/netstress.c
> index acce26f00..0de3fde1a 100644
> --- a/testcases/network/netstress/netstress.c
> +++ b/testcases/network/netstress/netstress.c
> @@ -1002,12 +1002,13 @@ static struct tst_option options[] = {
>  	{"r:", &rarg, "-r x     Number of client requests"},
>  	{"n:", &narg, "-n x     Client message size"},
>  	{"N:", &Narg, "-N x     Server message size"},
> -	{"m:", &Targ, "-m x     Reply timeout in microsec."},
> +	{"m:", &Targ, "-m x     Reply timeout in microsec (for udp, udp_lite, dccp is timeout always 100 microsec)"},

The timeout value not in microseconds, but in milliseconds.

What is "dccp is timeout always 100 microsec"?

>  	{"d:", &rpath, "-d x     x is a path to file where result is saved"},
>  	{"A:", &Aarg, "-A x     x max payload length (generated randomly)\n"},
>  
>  	{"R:", &Rarg, "Server:\n-R x     x requests after which conn.closed"},
>  	{"q:", &qarg, "-q x     x - TFO queue"},
> +	{"m:", &Targ, "-m x     Connect timeout in microsec (only for udp, udp_lite)"},

This is misleading actually, connect is for the client...

Why not to stick with what we had already discussed some time ago,
something like this?

"-m x   Receive timeout in milliseconds (not used by UDP/DCCP client)"

Thanks,
Alexey


>  	{"B:", &server_bg, "-B x     run in background, x - process directory"},
>  	{NULL, NULL, NULL}
>  };
> 

