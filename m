From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 9 Apr 2020 17:44:30 +0300
Subject: [LTP] [RFC PATCH v3 1/2] net: Move setup_addrinfo() into
 tst_net.h
In-Reply-To: <20200403165432.19358-2-pvorel@suse.cz>
References: <20200403165432.19358-1-pvorel@suse.cz>
 <20200403165432.19358-2-pvorel@suse.cz>
Message-ID: <608a0875-7bbb-405e-c535-5af4c1fd6fb0@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,
On 03.04.2020 19:54, Petr Vorel wrote:
> as tst_setup_addrinfo().
> 
> This allows reusing it in next commit.
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Changes v1->v2:
> * setup_addrinfo() renamed to tst_setup_addrinfo()
> * rebase
> 
>  include/tst_net.h                       |  9 +++++++--
>  include/tst_private.h                   |  1 +
>  lib/tst_net.c                           | 14 ++++++++++++++
>  testcases/network/netstress/netstress.c | 20 ++++----------------
>  4 files changed, 26 insertions(+), 18 deletions(-)
> 
> diff --git a/include/tst_net.h b/include/tst_net.h
> index 855f4fc13..34025eb81 100644
> --- a/include/tst_net.h
> +++ b/include/tst_net.h
> @@ -7,9 +7,10 @@
>  #define TST_NET_H_
>  
>  #include <arpa/inet.h>
> -#include <sys/types.h>
> +#include <netdb.h>
>  #include <netinet/in.h>
>  #include <netinet/ip.h>
> +#include <sys/types.h>
>  
>  void tst_get_in_addr(const char *ip_str, struct in_addr *ip);
>  void tst_get_in6_addr(const char *ip_str, struct in6_addr *ip6);
> @@ -27,4 +28,8 @@ void tst_init_sockaddr_inet_bin(struct sockaddr_in *sa, uint32_t ip_val, uint16_
>  void tst_init_sockaddr_inet6(struct sockaddr_in6 *sa, const char *ip_str, uint16_t port);
>  void tst_init_sockaddr_inet6_bin(struct sockaddr_in6 *sa, const struct in6_addr *ip_val, uint16_t port);
>  
> -#endif
> +void tst_setup_addrinfo(const char *src_addr, const char *port,
> +		    const struct addrinfo *hints,
> +		    struct addrinfo **addr_info);
> +
> +#endif /* TST_NET_H_ */
> diff --git a/include/tst_private.h b/include/tst_private.h
> index 00cd17fce..e30d34740 100644
> --- a/include/tst_private.h
> +++ b/include/tst_private.h
> @@ -10,6 +10,7 @@
>  #define TST_PRIVATE_H_
>  
>  #include <stdio.h>
> +#include <netdb.h>
>  
>  #define MAX_IPV4_PREFIX 32
>  #define MAX_IPV6_PREFIX 128
> diff --git a/lib/tst_net.c b/lib/tst_net.c
> index 22c990e62..7c5fa77cd 100644
> --- a/lib/tst_net.c
> +++ b/lib/tst_net.c
> @@ -5,6 +5,7 @@
>   */
>  
>  #include <errno.h>
> +#include <netdb.h>
>  #include <string.h>
>  #include <stdlib.h>
>  
> @@ -204,3 +205,16 @@ void tst_init_sockaddr_inet6_bin(struct sockaddr_in6 *sa, const struct in6_addr
>  	sa->sin6_port = htons(port);
>  	memcpy(&sa->sin6_addr, ip_val, sizeof(struct in6_addr));
>  }
> +
> +void tst_setup_addrinfo(const char *src_addr, const char *port,
> +		    const struct addrinfo *hints,
> +		    struct addrinfo **addr_info)
> +{
> +	int err = getaddrinfo(src_addr, port, hints, addr_info);
> +
> +	if (err)
> +		tst_brk(TBROK, "getaddrinfo failed, %s", gai_strerror(err));
> +
> +	if (!*addr_info)
> +		tst_brk(TBROK, "failed to get the address");
> +}
> diff --git a/testcases/network/netstress/netstress.c b/testcases/network/netstress/netstress.c
> index 6797be018..b66eed56e 100644
> --- a/testcases/network/netstress/netstress.c
> +++ b/testcases/network/netstress/netstress.c
> @@ -29,6 +29,7 @@
>  #include "tst_safe_stdio.h"
>  #include "tst_safe_pthread.h"
>  #include "tst_test.h"
> +#include "tst_net.h"
>  
>  static const int max_msg_len = (1 << 16) - 1;
>  static const int min_msg_len = 5;
> @@ -441,19 +442,6 @@ static int parse_client_request(const char *msg)
>  static struct timespec tv_client_start;
>  static struct timespec tv_client_end;
>  
> -static void setup_addrinfo(const char *src_addr, const char *port,
> -			   const struct addrinfo *hints,
> -			   struct addrinfo **addr_info)
> -{
> -	int err = getaddrinfo(src_addr, port, hints, addr_info);
> -
> -	if (err)
> -		tst_brk(TBROK, "getaddrinfo failed, %s", gai_strerror(err));
> -
> -	if (!*addr_info)
> -		tst_brk(TBROK, "failed to get the address");
> -}
> -
>  static void client_init(void)
>  {
>  	if (clients_num >= MAX_THREADS) {
> @@ -471,8 +459,8 @@ static void client_init(void)
>  	hints.ai_protocol = 0;
>  
>  	if (source_addr)
> -		setup_addrinfo(source_addr, NULL, &hints, &local_addrinfo);
> -	setup_addrinfo(server_addr, tcp_port, &hints, &remote_addrinfo);
> +		tst_setup_addrinfo(source_addr, NULL, &hints, &local_addrinfo);
> +	tst_setup_addrinfo(server_addr, tcp_port, &hints, &remote_addrinfo);
>  
>  	tst_res(TINFO, "Running the test over IPv%s",
>  		(remote_addrinfo->ai_family == AF_INET6) ? "6" : "4");
> @@ -667,7 +655,7 @@ static void server_init(void)
>  
>  	if (source_addr && !strchr(source_addr, ':'))
>  		SAFE_ASPRINTF(&src_addr, "::ffff:%s", source_addr);
> -	setup_addrinfo(src_addr ? src_addr : source_addr, tcp_port,
> +	tst_setup_addrinfo(src_addr ? src_addr : source_addr, tcp_port,
>  		       &hints, &local_addrinfo);
>  	free(src_addr);
>  

Acked-by: Alexey Kodanev <alexey.kodanev@oracle.com>
