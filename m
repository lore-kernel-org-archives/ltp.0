From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 1 Dec 2020 13:54:37 +0300
Subject: [LTP] [PATCH] net/ip_tests: Return TCONF if ip command can not
 create dummy interface
In-Reply-To: <20201130160235.25105-1-kory.maincent@bootlin.com>
References: <20201130160235.25105-1-kory.maincent@bootlin.com>
Message-ID: <1fac3929-a7ce-e35f-0adb-914a74e38843@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 30.11.2020 19:02, Kory Maincent wrote:
> Test if the dummy interface can be created, return TCONF if not.
> Move ip4_addr before, to have it defined and avoid cleanup error.
> 

There is TST_NEEDS_DRIVERS for checking missing modules, so it
should TCONF if some are not found.

TST_NEEDS_DRIVERS="dummy"


> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
>  testcases/network/iproute/ip_tests.sh | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/network/iproute/ip_tests.sh b/testcases/network/iproute/ip_tests.sh
> index 41c515696..1f0c4634d 100755
> --- a/testcases/network/iproute/ip_tests.sh
> +++ b/testcases/network/iproute/ip_tests.sh
> @@ -23,11 +23,14 @@ init()
>  	tst_res TINFO "inititalizing tests"
>  
>  	iface=ltp_dummy
> +	ip4_addr=${IPV4_NET16_UNUSED}.6.6
>  	lsmod | grep -q dummy || rm_dummy=1
>  
> -	ROD ip li add $iface type dummy
> +	if ! ip li add $iface type dummy >/dev/null; then
> +		rm_dummy=
> +		tst_brk TCONF "Module 'dummy' not found"
> +	fi
>  
> -	ip4_addr=${IPV4_NET16_UNUSED}.6.6
>  	ROD ip a add ${ip4_addr}/24 dev $iface
>  
>  	cat > tst_ip02.exp <<-EOF
> 

