From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 15 Feb 2019 00:34:42 +0100
Subject: [LTP] [PATCH 2/4] netstress: allow setting MSG_ZEROCOPY for
 other protocols
In-Reply-To: <1549908467-15609-3-git-send-email-alexey.kodanev@oracle.com>
References: <1549908467-15609-1-git-send-email-alexey.kodanev@oracle.com>
 <1549908467-15609-3-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <20190214233442.GB12954@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>

> ---
>  testcases/network/netstress/netstress.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)

> diff --git a/testcases/network/netstress/netstress.c b/testcases/network/netstress/netstress.c
> index 2cdc91a..63d02c9 100644
> --- a/testcases/network/netstress/netstress.c
> +++ b/testcases/network/netstress/netstress.c
> @@ -942,13 +942,14 @@ static void setup(void)
>  		}
>  	}

> +	if (zcopy)
> +		send_flags |= MSG_ZEROCOPY;
> +
>  	switch (proto_type) {
>  	case TYPE_TCP:
>  		tst_res(TINFO, "TCP %s is using %s TCP API.",
>  			(client_mode) ? "client" : "server",
>  			(fastopen_api) ? "Fastopen" : "old");
> -		if (zcopy)
> -			send_flags |= MSG_ZEROCOPY;
>  		check_tfo_value();
>  	break;
>  	case TYPE_UDP:

BTW MSG_ZEROCOPY is enabled only for TCP and UDP, but we allow it to be set on
all, which leads to BROK:
./netstress -z -T sctp
tst_test.c:1096: INFO: Timeout per run is 0h 05m 00s
netstress.c:938: INFO: max requests '3'
netstress.c:990: INFO: SCTP server
netstress.c:693: INFO: assigning a name to the server socket...
netstress.c:700: INFO: bind to port 37196
safe_net.c:186: BROK: netstress.c:717: setsockopt(3, 1, 60, 0x7fff155701a4, 4) failed: ???


Kind regards,
Petr
