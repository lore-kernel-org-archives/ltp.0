From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 8 Aug 2018 14:16:59 +0300
Subject: [LTP] [PATCH 2/2] testcases: netns: Handle "Operation not
 supported" error
In-Reply-To: <20180802141251.1571-2-mylene.josserand@bootlin.com>
References: <20180802141251.1571-1-mylene.josserand@bootlin.com>
 <20180802141251.1571-2-mylene.josserand@bootlin.com>
Message-ID: <1ef13fe5-debb-57ff-422b-b2b5d3460523@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

On 02.08.2018 17:12, Mylène Josserand wrote:
> If there is no support for "dummy" or "veth", the tests will fail
> with errors:
>    RTNETLINK answers: Operation not supported
>    netns_sysfs 1 TBROK: failed to add a new (host) dummy device
> and
>    RTNETLINK answers: Operation not supported
>    netns_comm_ip_ipv6_ioctl 1 TBROK: unable to create veth pair devices
>    Cannot find device "veth0"
> 
> This commit is storing the output of the commands and verifies
> if there is any reference to "Operation not supported".
> This code is based on what it is already done in "ipsec_lib.sh"
> stress test.

Not sure if the same should be here. The test-cases with IPsec involve
various crypto drivers that are much easier and better to check with
ip/netlink, and we also check both: the support in iproute and kernel.
I guess, veth and dummy virtual drivers could be checked with:
  
   modprobe -q veth || tst_brkm TCONF ...

Perhaps, we could add tst_drivers_available() helper to the library.

Thanks,
Alexey

> 
> Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>
> ---
>  testcases/kernel/containers/netns/netns_helper.sh | 16 ++++++++++++++--
>  testcases/kernel/containers/netns/netns_sysfs.sh  |  6 +++++-
>  2 files changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/testcases/kernel/containers/netns/netns_helper.sh b/testcases/kernel/containers/netns/netns_helper.sh
> index 6aea10b47..58be60148 100755
> --- a/testcases/kernel/containers/netns/netns_helper.sh
> +++ b/testcases/kernel/containers/netns/netns_helper.sh
> @@ -199,8 +199,14 @@ netns_ns_exec_setup()
>  		tst_brkm TBROK "unable to create a new network namespace"
>  	fi
>  
> -	$NS_EXEC $NS_HANDLE0 $NS_TYPE ip link add veth0 type veth peer name veth1 || \
> +	local output=$($NS_EXEC $NS_HANDLE0 $NS_TYPE ip link add veth0 type \
> +				veth peer name veth1 2>&1 || echo 'TERR')
> +	if echo "$output" | grep -q "TERR"; then
> +		echo "$output" | grep -q \
> +			'RTNETLINK answers: Operation not supported' && \
> +			tst_brkm TCONF "Command not supported (maybe missing 'veth' support)"
>  		tst_brkm TBROK "unable to create veth pair devices"
> +	fi
>  
>  	$NS_EXEC $NS_HANDLE0 $NS_TYPE ns_ifmove veth1 $NS_HANDLE1
>  	ret=$?
> @@ -235,8 +241,14 @@ netns_ip_setup()
>  	ip netns add $NS_HANDLE1 || \
>  		tst_brkm TBROK "unable to create a new network namespace"
>  
> -	$NS_EXEC $NS_HANDLE0 ip link add veth0 type veth peer name veth1 || \
> +	local output=$($NS_EXEC $NS_HANDLE0 ip link add veth0 type \
> +				veth peer name veth1 2>&1 || echo 'TERR')
> +	if echo "$output" | grep -q "TERR"; then
> +		echo "$output" | grep -q \
> +			'RTNETLINK answers: Operation not supported' && \
> +			tst_brkm TCONF "Command not supported (maybe missing 'veth' support)"
>  		tst_brkm TBROK "unable to create veth pair devices"
> +	fi
>  
>  	$NS_EXEC $NS_HANDLE0 ip link set veth1 netns $NS_HANDLE1 || \
>  		tst_brkm TBROK "unable to add device veth1 to the separate network namespace"
> diff --git a/testcases/kernel/containers/netns/netns_sysfs.sh b/testcases/kernel/containers/netns/netns_sysfs.sh
> index 944a4c152..138d11402 100644
> --- a/testcases/kernel/containers/netns/netns_sysfs.sh
> +++ b/testcases/kernel/containers/netns/netns_sysfs.sh
> @@ -54,8 +54,12 @@ if [ $? -eq 1 ]; then
>  fi
>  TST_CLEANUP=cleanup
>  
> -ip link add $DUMMYDEV_HOST type dummy || \
> +output=$(ip link add $DUMMYDEV_HOST type dummy 2>&1 || echo 'TERR')
> +if echo "$output" | grep -q "TERR"; then
> +	echo "$output" | grep -q 'RTNETLINK answers: Operation not supported' && \
> +		tst_brkm TCONF "Command not supported (maybe missing 'dummy' support)"
>  	tst_brkm TBROK "failed to add a new (host) dummy device"
> +fi
>  
>  ns_exec $NS_HANDLE $NS_TYPE mount --make-rprivate /sys
>  ns_exec $NS_HANDLE $NS_TYPE ip link add $DUMMYDEV type dummy || \
> 

