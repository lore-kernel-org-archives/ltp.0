From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 14 Sep 2015 12:56:51 +0300
Subject: [LTP] [PATCH v6 2/7] SAFE_MACROS: Add socket(), bind(), listen(),
 connect() and getsockname()
In-Reply-To: <1441016132-18804-2-git-send-email-zenglg.jy@cn.fujitsu.com>
References: <20150805172957.GB4216@rei.suse.de>
 <1441016132-18804-1-git-send-email-zenglg.jy@cn.fujitsu.com>
 <1441016132-18804-2-git-send-email-zenglg.jy@cn.fujitsu.com>
Message-ID: <55F699E3.9010104@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
On 08/31/2015 01:15 PM, Zeng Linggang wrote:
> Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>   include/safe_macros.h |   1 +
>   include/safe_net.h    |  59 +++++++++++++++++++++++++
>   lib/safe_net.c        | 117 ++++++++++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 177 insertions(+)
>   create mode 100644 include/safe_net.h
>   create mode 100644 lib/safe_net.c
>
...
> +
> +#define	GET_ADDR(sock_addr) \
> +	(inet_ntoa(((struct sockaddr_in *)sock_addr)->sin_addr))
> +

It won't work with IPv6. inet_ntoa is considered as deprecated, please 
use inet_ntop() instead. Also the name of the macro should be with the 
prefix TST_ or LTP_. I would use LTP_SOCK_ADDR or similar. In case of 
different ai_family, defining it as a function is more appropriate.

...
> +
> +int safe_bind(const char *file, const int lineno, void (cleanup_fn)(void),
> +	      int socket, const struct sockaddr *address,
> +	      socklen_t address_len)
> +{
> +	int i;
> +
> +	for (i = 0; i < 120; i++) {
> +		if (!bind(socket, address, address_len)) {
> +			tst_resm(TINFO, "bind is OK now");
> +			return 0;
> +		}
> +
> +		if (errno != EADDRINUSE) {
> +			tst_brkm(TBROK | TERRNO, cleanup_fn,
> +				 "%s:%d: bind(%d, %s, %d) failed", file, lineno,
> +				 socket, GET_ADDR(address), address_len);

In bind(), the port address is more important.

> +		}
> +
> +		if ((i + 1) % 10 == 1) {
> +			tst_resm(TINFO, "address is in use, waited %3i sec",
> +				 i + 1);
> +		}

"if" block should go after sleep. Also why "==1"? May be "== 0" instead. 
Otherwise you will print it after 1s, 11s, 21s, ... etc.

> +
> +		sleep(1);
> +	}
> +
> +	tst_brkm(TBROK | TERRNO, cleanup_fn,
> +		 "%s:%d: Failed to bind(%d, %p, %d) after 30 retries", file,
> +		 lineno, socket, GET_ADDR(address), address_len);

Please correct the message. I would remove "after 30 retries".

Thanks,
Alexey
