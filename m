From: Jiri Jaburek <jjaburek@redhat.com>
Date: Thu, 9 Jun 2016 16:05:08 +0200
Subject: [LTP] [PATCH] containers/netns/sysfs: check for known iface
 names, explicitly
In-Reply-To: <1465480705-23649-1-git-send-email-jjaburek@redhat.com>
References: <1465480705-23649-1-git-send-email-jjaburek@redhat.com>
Message-ID: <57597794.8040906@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 06/09/16 15:58, Jiri Jaburek wrote:
> The original code tries to check that no existing host interfaces
> made it into the new netns. This needs exceptions for ifaces that
> are created automatically, ie. 'lo', 'dummy0' and (on newer kernels)
> 'ip_vti0', which is not a long-term sustainable solution.
> 
> It also hade a corner case of always PASSing if the host had no
> network interfaces of its own - it only checked for "no extra ifaces
> in the new ns".
> 
> This change makes it use explicit pre-created interface names in
> both the host and the new ns, avoiding any (existing) ones.
> 
> Signed-off-by: Jiri Jaburek <jjaburek@redhat.com>
> ---
>  testcases/kernel/containers/netns/netns_sysfs.sh | 33 +++++++++---------------
>  1 file changed, 12 insertions(+), 21 deletions(-)
>  mode change 100755 => 100644 testcases/kernel/containers/netns/netns_sysfs.sh
> 
> diff --git a/testcases/kernel/containers/netns/netns_sysfs.sh b/testcases/kernel/containers/netns/netns_sysfs.sh
> old mode 100755
> new mode 100644
> index 4c6e7e4..a887fa6
> --- a/testcases/kernel/containers/netns/netns_sysfs.sh
> +++ b/testcases/kernel/containers/netns/netns_sysfs.sh
> @@ -25,7 +25,8 @@
>  TCID="netns_sysfs"
>  TST_TOTAL=3
>  NS_TYPE="net,mnt"
> -DUMMYDEV="dummy_test0"
> +DUMMYDEV_HOST="dummy_test0"
> +DUMMYDEV="dummy_test1"
>  . test.sh
>  
>  setns_check
> @@ -36,6 +37,7 @@ fi
>  cleanup()
>  {
>  	tst_rmdir
> +	ip link del $DUMMYDEV_HOST 2>/dev/null
>  	ip link del $DUMMYDEV 2>/dev/null
>  	kill -9 $NS_HANDLE 2>/dev/null
>  }
> @@ -48,9 +50,8 @@ if [ $? -eq 1 ]; then
>  fi
>  TST_CLEANUP=cleanup
>  
> -# exclude dummy0 (dummy1, etc.) from comparison as it gets automatically created
> -# by the dummy device driver upon insmod/modprobe (during ip link add)
> -ls /sys/class/net | grep -v 'dummy[0-9]\+' >sysfs_before
> +ip link add $DUMMYDEV_HOST type dummy || \
> +	tst_brkm TBROK "failed to add a new (host) dummy device"
>  
>  ns_exec $NS_HANDLE $NS_TYPE mount --make-rprivate /sys
>  ns_exec $NS_HANDLE $NS_TYPE ip link add $DUMMYDEV type dummy || \
> @@ -59,7 +60,7 @@ ns_exec $NS_HANDLE $NS_TYPE mount -t sysfs none /sys 2>/dev/null
>  
>  
>  # TEST CASE #1
> -ns_exec $NS_HANDLE $NS_TYPE test -d /sys/class/net/$DUMMYDEV
> +ns_exec $NS_HANDLE $NS_TYPE test -e /sys/class/net/$DUMMYDEV
>  if [ $? -eq 0 ]; then
>  	tst_resm TPASS "sysfs in new namespace has $DUMMYDEV interface"
>  else
> @@ -69,27 +70,17 @@ fi
>  
>  # TEST CASE #2
>  res=0

Seems I missed this (now unused) variable, feel free to remove it
as well.

> -for d in $(ns_exec $NS_HANDLE $NS_TYPE ls /sys/class/net/); do
> -	case "$d" in
> -		lo|$DUMMYDEV)
> -			;;
> -		*)
> -			tst_resm TINFO "sysfs in new namespace should not contain: $d"
> -			res=1
> -			;;
> -	esac
> -done
> -if [ $res -eq 0 ]; then
> -	tst_resm TPASS "sysfs in new namespace has only lo and $DUMMYDEV interfaces"
> +ns_exec $NS_HANDLE $NS_TYPE test -e /sys/class/net/$DUMMYDEV_HOST
> +if [ $? -ne 0 ]; then
> +	tst_resm TPASS "sysfs in new namespace does not have $DUMMYDEV_HOST interface"
>  else
> -	tst_resm TFAIL "sysfs in new namespace has more than lo and $DUMMYDEV interfaces"
> +	tst_resm TFAIL "sysfs in new namespace contains $DUMMYDEV_HOST interface"
>  fi
>  
>  
>  # TEST CASE #3
> -ls /sys/class/net | grep -v 'dummy[0-9]\+' >sysfs_after
> -diff sysfs_before sysfs_after
> -if [ $? -eq 0 ]; then
> +test -e /sys/class/net/$DUMMYDEV
> +if [ $? -ne 0 ]; then
>  	tst_resm TPASS "sysfs not affected by a separate namespace"
>  else
>  	tst_resm TFAIL "sysfs affected by a separate namespace"
> 

