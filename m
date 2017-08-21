From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 21 Aug 2017 16:31:41 +0300
Subject: [LTP] [RFC PATCH v8 01/11] lib/test_net.sh: Add unused IP
 address helper functions
In-Reply-To: <20170818164437.13556-2-pvorel@suse.cz>
References: <20170818164437.13556-1-pvorel@suse.cz>
 <20170818164437.13556-2-pvorel@suse.cz>
Message-ID: <90408ccf-db5b-40a3-dac1-150088c00ca7@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,
On 08/18/2017 07:44 PM, Petr Vorel wrote:
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/lib/test_net.sh | 78 +++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 75 insertions(+), 3 deletions(-)
>
> diff --git a/testcases/lib/test_net.sh b/testcases/lib/test_net.sh
> index c11747a27..6575c77f4 100644
> --- a/testcases/lib/test_net.sh
> +++ b/testcases/lib/test_net.sh
> @@ -219,7 +219,7 @@ tst_ipaddr()
>  {
>  	local type="${1:-lhost}"
>  	local ipv="${TST_IPV6:-4}"
> -	local tst_host=
> +	local tst_host
>  
>  	if [ "$type" = "lhost" ]; then
>  		eval "tst_host=\$LHOST_IPV${ipv}_HOST"
> @@ -234,6 +234,77 @@ tst_ipaddr()
>  	fi
>  }
>  
> +# Get IP address of unused network, specified by type and counter.
> +# This is useful for generating row of unique addresses based on lhost/rhost.
> +# tst_ipaddr_un_host [TYPE] [COUNTER]
> +# TYPE: { lhost | rhost }; Default value is 'lhost'.
> +# COUNTER: Integer value for counting 4th octet and 3rd octet; Default is 1.
> +tst_ipaddr_un_host()
> +{
> +	local type="${1:-lhost}"
> +	local counter="${2:-1}"
> +	local octet_3 octet_4 max_octet_3 max_octet_4 tmp
> +
> +	[ $counter -lt 1 ] && counter=1
> +	[ "$TST_IPV6" ] && max_octet_3=65535 || max_octet_3=255
> +	max_octet_4=$((max_octet_3 - 1))
> +	tmp=$((counter * 2))
> +	[ "$type" = "rhost" ] && tmp=$((tmp - 1))
> +
> +	octet_4=$((tmp % max_octet_4))
> +	octet_3=$((tmp / max_octet_4))
> +
> +	if [ $octet_4 -eq 0 ]; then
> +		octet_4=$max_octet_4
> +		octet_3=$((octet_3 - 1))
> +	fi
> +
> +	[ $octet_3 -gt $max_octet_3 ] && octet_3=$max_octet_3
> +	[ $octet_4 -gt $max_octet_4 ] && octet_4=$max_octet_4
> +
> +	if [ "$TST_IPV6" ]; then
> +		[ $octet_3 -gt 0 ] && octet_3="$(printf %x $octet_3)" || octet_3=
> +		[ $octet_4 -gt 0 -o "$octet_3" ] && octet_4="$(printf %x $octet_4)" || octet_4=
> +		[ "$octet_3" -a "$octet_4" ] && octet_4=":$octet_4"
> +		echo "${IPV6_NET32_UNUSED}::${octet_3}${octet_4}"
> +	else
> +		echo "${IPV4_NET16_UNUSED}.${octet_3}.${octet_4}"
> +	fi
> +}
> +
> +# Get IP address of unused network, specified by 3rd and 4th octet.
> +# This is useful when 3rd and/or 4th octet are needed to be defined.
> +# tst_ipaddr_un_ip [OCTET_3] [OCTET_4]

3rd and 4th octet are only meaningful for IPv4, what about 'net_id' and
'host_id' instead?

> +# OCTET_3: Integer or hex value of 3rd octet; Default value is 0.
> +# OCTET_4: Integer or hex value of 4th octet; Default value is 0.
> +tst_ipaddr_un_ip()
> +{
> +	local octet_3="${1:-0}"
> +	local octet_4="${2:-0}"
> +	local max
> +
> +	[ "$TST_IPV6" ] && max=65535 || max=255
> +
> +	if [ "$TST_IPV6" ]; then
> +		octet_3=$(printf %d $octet_3)
> +		octet_4=$(printf %d $octet_4)
> +	fi
> +
> +	[ $octet_3 -lt 0 ] && octet_3=0
> +	[ $octet_4 -lt 0 ] && octet_4=1
> +	[ $octet_3 -gt $max ] && octet_3=$max
> +	[ $octet_4 -gt $max ] && octet_4=$max
> +
> +	if [ "$TST_IPV6" ]; then
> +		[ $octet_3 -gt 0 ] && octet_3="$(printf %x $octet_3)" || octet_3=
> +		[ $octet_4 -gt 0 -o "$octet_3" ] && octet_4="$(printf %x $octet_4)" || octet_4=
> +		[ "$octet_3" -a "$octet_4" ] && octet_4=":$octet_4"
> +		echo "${IPV6_NET32_UNUSED}::${octet_3}${octet_4}"

'${octet_3}${octet_4}' - if max is 65K, it's 4 bytes, ':' missed?


I assume this is needed for getting subnets/routes, in most cases we would
have 64-bit netmask that's why I would move one parameter before '::'

echo "${IPV6_NET32_UNUSED}:${octet_3}::${octet_4}"


> +	else
> +		echo "${IPV4_NET16_UNUSED}.${octet_3}.${octet_4}"
> +	fi
> +}


Can we have getopts in a single function to prevent code duplication?

Best regards,
Alexey
