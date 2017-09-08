From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Fri, 8 Sep 2017 10:13:00 +0300
Subject: [LTP] [RFC PATCH v9 1/7] lib/test_net.sh: Add unused IP address
 helper functions
In-Reply-To: <20170824234436.18145-2-pvorel@suse.cz>
References: <20170824234436.18145-1-pvorel@suse.cz>
 <20170824234436.18145-2-pvorel@suse.cz>
Message-ID: <25ee648d-e913-eba9-8454-0e6d30fd1e60@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
On 08/25/2017 02:44 AM, Petr Vorel wrote:
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/lib/test_net.sh | 66 ++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 65 insertions(+), 1 deletion(-)
> ...
> +
> +	[ "$TST_IPV6" ] && max_net_id=65535 || max_net_id=255
> +
> +	if [ $# -eq 0 -o "$1" = "lhost" -o "$1" = "rhost" ]; then
> +		[ -z "$counter" ] && counter=1
> +		[ $counter -lt 1 ] && counter=1
> +		type="${1:-lhost}"
> +		max_host_id=$((max_net_id - 1))
> +		tmp=$((counter * 2))
> +		[ "$type" = "rhost" ] && tmp=$((tmp - 1))
> +
> +		host_id=$((tmp % max_host_id))
> +		net_id=$((tmp / max_host_id))
> +
> +		if [ $host_id -eq 0 ]; then
> +			host_id=$max_host_id
> +			net_id=$((net_id - 1))
> +		fi
> +	else
> +		net_id="$1"
> +		host_id="${2:-0}"
> +		max_host_id=$max_net_id
> +		if [ "$TST_IPV6" ]; then
> +			net_id=$(printf %d $net_id)
> +			host_id=$(printf %d $host_id)
> +		fi
> +		[ $net_id -lt 0 ] && net_id=0
> +		[ $host_id -lt 0 ] && host_id=1
> +	fi
> +
> +	net_id=$((net_id % max_net_id))
> +	host_id=$((host_id % max_host_id))

Changed to 'max_net_id' here and applied, otherwise we would have
host_id 0 if counter = 254.

Thanks,
Alexey

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20170908/3c5cbb9d/attachment-0001.html>
