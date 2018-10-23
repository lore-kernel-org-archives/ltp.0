From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 23 Oct 2018 17:03:51 +0300
Subject: [LTP] [PATCH 1/4] net/dhcp: Use paths allowed by AppArmor for
	dnsmasq
In-Reply-To: <20181011220525.24628-2-pvorel@suse.cz>
References: <20181011220525.24628-1-pvorel@suse.cz>
 <20181011220525.24628-2-pvorel@suse.cz>
Message-ID: <85563193-f74e-8287-8f59-debbf9ff6705@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 12.10.2018 01:05, Petr Vorel wrote:
> Fixes for --log-facility and --dhcp-leasefile.
> 
> Path for log file expects AppArmor commit
> 025c7dc6 ("dnsmasq: Add permission to open log files").
> 
> NOTE: AppArmor optimization isn't needed for dhcpd.
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Changing path to /var/log require root, but we run most of network tests
> under root anyway, at least for network  namespaces.
> I didn't add TST_NEEDS_ROOT=1, maybe I should.
> 
> 
> Kind regards,
> Petr
> ---
>  testcases/network/dhcp/dnsmasq_tests.sh | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/testcases/network/dhcp/dnsmasq_tests.sh b/testcases/network/dhcp/dnsmasq_tests.sh
> index ad5885c84..43961f85f 100755
> --- a/testcases/network/dhcp/dnsmasq_tests.sh
> +++ b/testcases/network/dhcp/dnsmasq_tests.sh
> @@ -9,9 +9,11 @@ dhcp_name="dnsmasq"
>  
>  . dhcp_lib.sh
>  
> +log="/var/log/tst_dnsmasq.log"
> +
>  common_opt="--no-hosts --no-resolv --dhcp-authoritative \
> -	--log-facility=./tst_dnsmasq.log --interface=$iface0 \
> -	--dhcp-leasefile=tst_dnsmasq.lease --port=0 --conf-file= "
> +	--log-facility=$log --interface=$iface0 \

It could be stderr with writing the output of dnsmasq to the test directory:

  --log-facility=-

> +	--dhcp-leasefile=/var/lib/misc/dnsmasq.tst.leases --port=0 --conf-file= "
>  

What if this directory doesn't exist? Why not to use the standard one for dnsmasq /var/lib/dnsmasq/?

Forgot to remove this file in cleanup? BTW, it's better to have "ltp" instead of "tst" in this path.


>  start_dhcp()
>  {
> @@ -33,12 +35,12 @@ start_dhcp6()
>  
>  cleanup_dhcp()
>  {
> -	rm -f tst_dnsmasq.log
> +	rm -f $log
>  }
>  
>  print_dhcp_log()
>  {
> -	cat tst_dnsmasq.log
> +	cat $log
>  }
>  
>  print_dhcp_version()
> 

