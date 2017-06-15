From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 15 Jun 2017 18:02:51 +0300
Subject: [LTP] [RFC PATCH v6 11/11] network: Use tst_net_vars to set up
 IPv4 and IPv6 related variables
In-Reply-To: <20170603120022.13415-12-pvorel@suse.cz>
References: <20170603120022.13415-1-pvorel@suse.cz>
 <20170603120022.13415-12-pvorel@suse.cz>
Message-ID: <dac37c16-9045-c637-8258-43dee654fbcc@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 06/03/2017 03:00 PM, Petr Vorel wrote:
> tst_net_vars simplifies setup as it only needs to have passed 4 IP
> addresses (2x IPv4 and 2 IPv6) and alows to define different network
> part for local and remote hosts.
>
> Rename variables in rewritten tests to use variables defined by
> tst_net_vars. These scripts are run by testscripts/network.sh script
> which defined these variables by setting test_net.sh, so it makes a
> sense to use them.
>
> Old tests still use IPV4_NETWORK variable instead of IPV4_LNETWORK and
> IPV4_RNETWORK and have it defined locally.
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/lib/test_net.sh                          | 59 ++++++++++------------
>  testcases/network/stress/interface/if4-addr-change |  2 +-
>  .../stress/multicast/grp-operation/mcast4-lib.sh   |  6 +--
>  .../network/stress/ns-tools/test_stress_net.sh     | 18 ++++---
>  testcases/network/stress/route/route4-change-dst   |  4 +-
>  testcases/network/stress/route/route4-change-gw    |  4 +-
>  testcases/network/stress/route/route4-change-if    |  4 +-
>  testcases/network/stress/route/route4-ifdown       |  8 +--
>  testcases/network/stress/route/route4-lib.sh       | 20 ++++----
>  testcases/network/stress/route/route4-redirect     |  4 +-
>  testcases/network/stress/route/route4-rmmod        |  8 +--
>  11 files changed, 68 insertions(+), 69 deletions(-)
>
> diff --git a/testcases/lib/test_net.sh b/testcases/lib/test_net.sh
> index 91a62f9f6..a470d1c45 100644
> --- a/testcases/lib/test_net.sh
> +++ b/testcases/lib/test_net.sh
> @@ -197,19 +197,10 @@ tst_read_opts $*

[...]
> +IPV4_LHOST="${IPV4_LHOST:-10.0.0.2}"
> +IPV4_RHOST="${IPV4_RHOST:-10.0.0.1}"
> +IPV6_LHOST="${IPV6_LHOST:-fd00:1:1:1::2}"
> +IPV6_RHOST="${IPV6_RHOST:-fd00:1:1:1::1}"
> +
> +# tst_net_vars exports environment variables related to test links and networks
> +# that aren't reachable through the test links.
> +# See tst_net_vars -h for a list of exported variables.
> +if [ -z "$TST_PARSE_VARIABLES" ]; then
> +	tst_resm TINFO "Parsing variables for $IPV4_LHOST $IPV4_RHOST"
> +	eval $(tst_net_vars $IPV4_LHOST $IPV4_RHOST)
> +	tst_resm TINFO "Parsing variables for $IPV6_LHOST $IPV6_RHOST"
> +	eval $(tst_net_vars $IPV6_LHOST $IPV6_RHOST)

We should really check whether tst_net_vars failed or not here, and exit
on error.

  eval $(tst_net_vars $IPV6_LHOST $IPV6_RHOST || echo "exit $?")

> +	TST_PARSE_VARIABLES="yes"

export TST_PARSE_VARIABLES="yes"


Thanks,
Alexey

