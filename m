From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 17 Sep 2015 04:29:11 -0400 (EDT)
Subject: [LTP] [PATCH] containers/netns/: fix kernel supporting check
In-Reply-To: <1442315791-20260-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
References: <1442315791-20260-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
Message-ID: <1341761858.13149182.1442478551576.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> From: "Guangwen Feng" <fenggw-fnst@cn.fujitsu.com>
> To: ltp@lists.linux.it
> Sent: Tuesday, 15 September, 2015 1:16:31 PM
> Subject: [LTP] [PATCH] containers/netns/: fix kernel supporting check
> 
> On RHEL5.11GA, test result should be TCONF but not TFAIL since
> setns() is not supported, so fix this.
> 
> Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
> ---
>  testcases/kernel/containers/netns/netns_helper.sh | 8 +++++++-
>  testcases/kernel/containers/netns/netns_sysfs.sh  | 9 ++++++++-
>  testcases/kernel/containers/share/ns_exec.c       | 6 ++----
>  3 files changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/testcases/kernel/containers/netns/netns_helper.sh
> b/testcases/kernel/containers/netns/netns_helper.sh
> index cea1541..f9d6cba 100755
> --- a/testcases/kernel/containers/netns/netns_helper.sh
> +++ b/testcases/kernel/containers/netns/netns_helper.sh
> @@ -188,8 +188,14 @@ netns_ns_exec_setup()
>  		tst_brkm TBROK "unable to create a new network namespace"
>  	fi
>  
> -	$NS_EXEC $NS_HANDLE0 ip link add veth0 type veth peer name veth1 || \
> +	$NS_EXEC $NS_HANDLE0 ip link add veth0 type veth peer name veth1
> +	if [ $? -eq 32 ]; then
> +		tst_brkm TCONF "setns not supported"
> +	fi
> +
> +	if [ $? -ne 0 ]; then
>  		tst_brkm TBROK "unable to create veth pair devices"
> +	fi

I'd suggest putting setns() check in a separate function, which we
then call as part of setup for these testcases.

netns_setup() already makes couple checks, can it check for setns()
availability too at the beginning of the test?

netns_sysfs.sh is not using netns_helper.sh helper, so it would need
to call that function too as part of its setup.

Regards,
Jan

>  
>  	$NS_EXEC $NS_HANDLE0 ns_ifmove veth1 $NS_HANDLE1
>  	if [ $? -eq 0 ]; then
> diff --git a/testcases/kernel/containers/netns/netns_sysfs.sh
> b/testcases/kernel/containers/netns/netns_sysfs.sh
> index c10fa36..6c95a7d 100755
> --- a/testcases/kernel/containers/netns/netns_sysfs.sh
> +++ b/testcases/kernel/containers/netns/netns_sysfs.sh
> @@ -43,8 +43,15 @@ TST_CLEANUP=cleanup
>  ls /sys/class/net >sysfs_before
>  
>  
> -ns_exec $NS_HANDLE ip link add dummy0 type dummy || \
> +ns_exec $NS_HANDLE ip link add dummy0 type dummy
> +if [ $? -eq 32 ]; then
> +	tst_brkm TCONF "setns not supported"
> +fi
> +
> +if [ $? -ne 0 ]; then
>  	tst_brkm TBROK "failed to add a new dummy device"
> +fi
> +
>  ns_exec $NS_HANDLE mount -t sysfs none /sys 2>/dev/null
>  
>  ns_exec $NS_HANDLE test -d /sys/class/net/dummy0
> diff --git a/testcases/kernel/containers/share/ns_exec.c
> b/testcases/kernel/containers/share/ns_exec.c
> index e2f068c..9148b46 100644
> --- a/testcases/kernel/containers/share/ns_exec.c
> +++ b/testcases/kernel/containers/share/ns_exec.c
> @@ -86,10 +86,8 @@ int main(int argc, char *argv[])
>  	int i, rv, pid;
>  
>  	rv = syscall(__NR_setns, -1, 0);
> -	if (rv == -1 && errno == ENOSYS) {
> -		tst_resm(TINFO, "setns is not supported in the kernel");
> -		return 1;
> -	}
> +	if (rv == -1 && errno == ENOSYS)
> +		tst_brkm(TCONF, NULL, "setns is not supported in the kernel");
>  
>  	if (argc < 3) {
>  		tst_resm(TINFO, "%s <NS_PID> <PROGRAM> [ARGS]\n", argv[0]);
> --
> 1.8.4.2
> 
> 
> --
> Mailing list info: http://lists.linux.it/listinfo/ltp
> 
