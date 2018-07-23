From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 23 Jul 2018 09:22:58 +0300
Subject: [LTP] [RFC PATCH 2/2] netstress: Update help for -m behavior
In-Reply-To: <20180719125358.948-2-pvorel@suse.cz>
References: <20180719125358.948-1-pvorel@suse.cz>
 <20180719125358.948-2-pvorel@suse.cz>
Message-ID: <b83b4f3b-db6b-c085-bdbf-839157549628@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 19.07.2018 15:53, Petr Vorel wrote:
> For udp, udp_lite and DCCP on client is timeout set 100.
> For udp and udp_lite on server on low timeout it reaches "recv failed"
> error (due no listen in udp and udp_lite).
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> I documented the current state, but I it looks to me that udp and
> udp_lite on server is a bug. Or wanted behaviour?
> 
> 

Hi Petr,

Since the server waits for requests from the client, the timeout
value for UDP/DCCP is the same as for the other protocols. Also the
server starts earlier than the client, so it should wait some time
to get the client requests.

I've changed the client side only because either request from the
client or reply from the server might be lost.


> Kind regards,
> Petr
> ---
>  testcases/network/netstress/netstress.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/testcases/network/netstress/netstress.c b/testcases/network/netstress/netstress.c
> index 48fb0aabd..62301ca9f 100644
> --- a/testcases/network/netstress/netstress.c
> +++ b/testcases/network/netstress/netstress.c
> @@ -999,7 +999,7 @@ static struct tst_option options[] = {
>  	{"r:", &rarg, "-r x     Number of client requests"},
>  	{"n:", &narg, "-n x     Client message size"},
>  	{"N:", &Narg, "-N x     Server message size"},
> -	{"m:", &Targ, "-m x     Reply timeout in microsec."},
> +	{"m:", &Targ, "-m x     Reply timeout in microsec (only for tcp and sctp, also affects server on udp and udp_lite)."},

What about dccp? May be "Receive timeout in milliseconds (not affects UDP/DCCP client)"?

Thanks,
Alexey
