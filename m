From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 19 Nov 2018 13:44:15 +0300
Subject: [LTP] [PATCH v4 1/2] net: Add tst_net_run helper
In-Reply-To: <20181116142411.GA24956@dell5510>
References: <20181113163008.9093-1-pvorel@suse.cz>
 <09aff1dd-a89f-479b-49da-c0c776b08b91@oracle.com>
 <20181116142411.GA24956@dell5510>
Message-ID: <37a6f27b-096e-8701-b8ee-4132d10ef889@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,
On 16.11.2018 17:24, Petr Vorel wrote:
> Hi Alexey,
> 
>>> Maybe we could signal where error occurred:
>>> * return 0: ok on both lhost and rhost
>>> * return 1: failure on lhost
>>> * return 2: failure on rhost
>>> * return 3: failure on both lhost and rhost
> 
> 
>> It is only when there is no "safe" option, right?
> yes, as safe exit with TCONF and warning.
> 
>> when doing cleanup?
> IMHO in any "non-safe" run.
> 
>> Could we print TWARN message inside tst_net_run() in such case?
> I wanted tst_net_run() to behave similarly as tst_rhost_run(), which doesn't
> warn about it. So I propose to add warning to both functions, but also add -q
> flag (quiet), which suppress this warning.

I think we don't need it for tst_rhost_run() as it is clear where the
error has happened. Unlike tst_net_run() without safe option.

> 
> The reason for quiet mode is, that (I suppose) there are cases when some
> features is tested and TWARN isn't wanted. Some examples (looks -s is used often
> in cleanup functions):

'-s' is used often in cleanup with tst_rhost_run()?

>
> testcases/network/stress/multicast/grp-operation/mcast-lib.sh:
> 
> mcast_cleanup()
> {
>     [ "$TST_IPV6" ] && mcast_cleanup6 || mcast_cleanup4
> 
>     pkill -SIGHUP -f "$MCAST_LCMD"
>     tst_sleep 10ms
>     pkill -9 -f "$MCAST_LCMD"
> 
>     tst_rhost_run -c "pkill -SIGHUP -f '$MCAST_RCMD'"
> }
> 
> testcases/network/virt/virt_lib.sh
> virt_cleanup_rmt()
> {
>     cleanup_vifaces
>     tst_rhost_run -c "ip link delete ltp_v0 2>/dev/null"
>     if [ "$virt_tcp_syn" ]; then
>         sysctl -q net.ipv4.tcp_syn_retries=$virt_tcp_syn
>         virt_tcp_syn=
>     fi
> }
> 
> nfs_setup_server() in testcases/network/nfs/nfs_stress/nfs_lib.sh:
> 
> 	if ! tst_rhost_run -c "test -d $remote_dir"; then
>         tst_rhost_run -s -c "mkdir -p $remote_dir; $export_cmd"
>     fi
> 
> 
> Kind regards,
> Petr
> 

