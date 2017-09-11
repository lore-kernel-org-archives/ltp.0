From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 11 Sep 2017 16:35:55 +0300
Subject: [LTP] [PATCH v2 2/2] lib6/in6_01: Fix compiler warning 'set but
 not used variable'
In-Reply-To: <20170907112521.23881-2-pvorel@suse.cz>
References: <20170907112521.23881-1-pvorel@suse.cz>
 <20170907112521.23881-2-pvorel@suse.cz>
Message-ID: <7e985f2a-0c64-529a-12a8-685d2d0e9d04@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
On 09/07/2017 02:25 PM, Petr Vorel wrote:
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/network/lib6/in6_01.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/testcases/network/lib6/in6_01.c b/testcases/network/lib6/in6_01.c
> index 70e771357..0b279dd10 100644
> --- a/testcases/network/lib6/in6_01.c
> +++ b/testcases/network/lib6/in6_01.c
> @@ -117,7 +117,7 @@ static void test_sockaddr_in6(void)
>  	uint32_t ui16 = 2;
>  	uint32_t ui32 = 3;
>  	struct in6_addr in6;
> -	struct sockaddr_in6 sin6;
> +	LTP_ATTRIBUTE_UNUSED struct sockaddr_in6 sin6;


May be extend this test-case a little bit and avoid compiler optimizations
because the test-case just sets sockaddr_in6 fields... for example create
a socket and try bind() with sin6?

int sd = SAFE_SOCKET(AF_INET6, SOCK_STREAM, 0);
bind(sd, (struct sockaddr *)&sin6, sizeof(sin6));
SAFE_CLOSE(sd);

Thanks,
Alexey
