From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 27 Feb 2018 08:05:14 +0100
Subject: [LTP] [PATCH] netstress: load dccp module manually
In-Reply-To: <1519647255-11671-1-git-send-email-alexey.kodanev@oracle.com>
References: <1519647255-11671-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <20180227070514.GC876@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> RHEL7.5 distro blacklisted dccp module by default, so for DCCP tests
> we should enable it manually.

> Reported-by: Lianwen Sun <sunlw.fnst@cn.fujitsu.com>
> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
> ---
>  testcases/network/netstress/netstress.c |   10 ++++++++--
>  1 files changed, 8 insertions(+), 2 deletions(-)

> diff --git a/testcases/network/netstress/netstress.c b/testcases/network/netstress/netstress.c
> index 9751cf6..d8354b8 100644
> --- a/testcases/network/netstress/netstress.c
> +++ b/testcases/network/netstress/netstress.c
> @@ -941,13 +941,19 @@ static void setup(void)
>  		sock_type = SOCK_DGRAM;
>  		protocol = IPPROTO_UDPLITE;
>  	break;
> -	case TYPE_DCCP:
> +	case TYPE_DCCP: {
> +		/* dccp module can be blacklisted, load it manually */
> +		static const char * const argv[] = {"modprobe", "dccp", NULL};
> +
> +		if (tst_run_cmd(argv, NULL, NULL, 1))
> +			tst_res(TWARN, "Failed to load DCCP module");
> +
>  		tst_res(TINFO, "DCCP %s", (client_mode) ? "client" : "server");
>  		fastopen_api = fastopen_sapi = NULL;
>  		sock_type = SOCK_DCCP;
>  		protocol = IPPROTO_DCCP;
>  		service_code = htonl(service_code);
> -	break;
> +	} break;
>  	case TYPE_SCTP:
>  		tst_res(TINFO, "SCTP %s", (client_mode) ? "client" : "server");
>  		fastopen_api = fastopen_sapi = NULL;

Acked-by: Petr Vorel <pvorel@suse.cz>
