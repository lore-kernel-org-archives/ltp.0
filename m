From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 3 Oct 2017 10:58:57 +0200
Subject: [LTP] [PATCH 1/1] lib/tst_net_vars.c: Fix warning for older
	toolchains
In-Reply-To: <20170908124714.698-1-pvorel@suse.cz>
References: <20170908124714.698-1-pvorel@suse.cz>
Message-ID: <20171003085856.rj2kybiaf7ksia5w@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> tst_net_iface_prefix.c:80: warning: comparison between signed and unsigned

> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/lib/tst_net_iface_prefix.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/testcases/lib/tst_net_iface_prefix.c b/testcases/lib/tst_net_iface_prefix.c
> index 803f1e717..3868d36b5 100644
> --- a/testcases/lib/tst_net_iface_prefix.c
> +++ b/testcases/lib/tst_net_iface_prefix.c
> @@ -57,7 +57,7 @@ static int read_iface_prefix(const char *ip_str, int is_ipv6)
>  	uint8_t family = is_ipv6 ? AF_INET6 : AF_INET;

>  	char buf[16384];
> -	int len;
> +	unsigned int len;

>  	struct {
>  		struct nlmsghdr nlhdr;

Hi,
ping.


Kind regards,
Petr
