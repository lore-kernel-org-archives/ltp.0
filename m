From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 18 Apr 2018 17:00:53 +0300
Subject: [LTP] [PATCH 2/2] network/in6_02: Don't use default value for
 LHOST_IFACES
In-Reply-To: <20180417124207.4561-2-pvorel@suse.cz>
References: <20180417124207.4561-1-pvorel@suse.cz>
 <20180417124207.4561-2-pvorel@suse.cz>
Message-ID: <f28265d1-10a0-f7d0-248d-e0b8b709eea8@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 04/17/2018 03:42 PM, Petr Vorel wrote:
> in6_02 can be test without help of network.sh. In that case LHOST_IFACES
> is not defined and "eth0" is used as default value. This can cause
> failures.
>
I think the fix should be before the conversion to the new API, otherwise
it unnecessary depends on it.

> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> I'm not sure if we can make all C network tests make independent on
> loading variables via tst_net.sh, but here it does not make much sense
> to me to fail when it's not done.
> ---
>  testcases/network/lib6/in6_02.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/testcases/network/lib6/in6_02.c b/testcases/network/lib6/in6_02.c
> index e3deb7b7b..c00e5dc0c 100644
> --- a/testcases/network/lib6/in6_02.c
> +++ b/testcases/network/lib6/in6_02.c
> @@ -33,14 +33,13 @@
>  
>  #define I2N_RNDCOUNT	10	/* random ints */
>  #define I2N_LOWCOUNT	10	/* sequential from 0 */
> -#define DEFAULT_IFACE	"eth0"
>  
>  static struct {
>  	char *name;
>  	int nonzero;
>  } test_case[] = {
>  	{ "lo", 1 },
> -	{ DEFAULT_IFACE, 1 },
> +	{ NULL, 1 },
>  	{ "hoser75", 0 },
>  	{ "6", 0 },
>  };
> @@ -61,6 +60,8 @@ void if_nametoindex_test(void)
>  	tst_res(TINFO, "IPv6 if_nametoindex() test");
>  
>  	for (i = 0; i < ARRAY_SIZE(test_case); ++i) {
> +		if (test_case[i].name == NULL)
> +			continue;


What about using TCONF if it skips the test-case because
LHOST_IFACE is not defined?

Thanks,
Alexey
