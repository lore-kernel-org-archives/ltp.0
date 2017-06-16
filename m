From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Fri, 16 Jun 2017 12:13:06 +0300
Subject: [LTP] [RFC PATCH v6 0/2] *** Rmmod causes failures of netns
 based tests ***
In-Reply-To: <66ae64fd-d7e2-45cc-002e-8c952ae68579@oracle.com>
References: <20170616015652.11169-1-pvorel@suse.cz>
 <66ae64fd-d7e2-45cc-002e-8c952ae68579@oracle.com>
Message-ID: <4f361d07-3ee7-2b6b-8775-3641dcc30bf1@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 06/16/2017 11:25 AM, Alexey Kodanev wrote:
> On 06/16/2017 04:56 AM, Petr Vorel wrote:
>> Hi Alexey,
>>
>> this patch tries to fix problems with dhcp based tests when they call TCONF:
>> /opt/ltp/testscripts/network.sh -6
>> dhcpd 1 TCONF: 'dhcpd' not found
>> ...
>> cat: /sys/class/net/ltp_ns_veth2/address: No such file or directory
>>
>> With this patchset:
>> /opt/ltp/testscripts/network.sh -6
>> dhcpd 1 TCONF: 'dhcpd' not found
>> ...
>> ns_exec     0  TINFO  :  no namespace entries in /proc/2699/ns/
>>
>> It doesn't help to kill also ns_exec. reset_ltp_netspace() is obviously wrong.
>> IMHO without trying to manually call reset_ltp_netspace() we should have better
>> detection of netns problems in init_ltp_netspace().
> Hi Petr,
>
> This can be fixed by moving the check before possible exit with TCONF:
>
> diff --git a/testcases/network/dhcp/dhcp_lib.sh
> b/testcases/network/dhcp/dhcp_lib.sh
> index 85f9b88..1641368 100755
> --- a/testcases/network/dhcp/dhcp_lib.sh
> +++ b/testcases/network/dhcp/dhcp_lib.sh
> @@ -37,11 +37,10 @@ stop_dhcp()
>  
>  init()
>  {
> -       tst_require_root
> -       tst_check_cmds cat $dhcp_name awk ip pgrep pkill dhclient
> +       lsmod | grep -q '^veth ' && veth_loaded=1 || veth_loaded=
>  
> -       veth_loaded=
> -       lsmod | grep -q '^veth ' && veth_loaded=1
> +       tst_require_root
> +       tst_check_cmds cat $dhcp_name awk ip pgrep pkill dhclient
>  
>         tst_resm TINFO "create veth interfaces"
>         ip li add $iface0 type veth peer name $iface1 || \
>
>
> Also we could add a flag that cleanup might be needed after tst_check_cmds()


diff --git a/testcases/network/dhcp/dhcp_lib.sh
b/testcases/network/dhcp/dhcp_lib.sh
index 85f9b88..5001232 100755
--- a/testcases/network/dhcp/dhcp_lib.sh
+++ b/testcases/network/dhcp/dhcp_lib.sh
@@ -40,8 +40,7 @@ init()
        tst_require_root
        tst_check_cmds cat $dhcp_name awk ip pgrep pkill dhclient
 
-       veth_loaded=
-       lsmod | grep -q '^veth ' && veth_loaded=1
+       lsmod | grep -q '^veth ' && veth_loaded=yes || veth_loaded=no
 
        tst_resm TINFO "create veth interfaces"
        ip li add $iface0 type veth peer name $iface1 || \
@@ -68,6 +67,8 @@ init()
 
 cleanup()
 {
+       [ -z "$veth_loaded" ] && return
+
        stop_dhcp
 
        pkill -f "dhclient -$ipv $iface1"
@@ -81,9 +82,7 @@ cleanup()
 
        [ $veth_added ] && ip li del $iface0
 
-       if [ -z $veth_loaded ]; then
-               lsmod | grep -q '^veth ' && rmmod veth
-       fi
+       [ "$veth_loaded" = "no" ] && lsmod | grep -q '^veth ' && rmmod veth
 
        tst_rmdir
 }


>
> Thanks,
> Alexey
>
>
>> Kind regards,
>> Petr
>>
>>
>> Petr Vorel (2):
>>   lib/test_net.sh: reset_ltp_netspace()
>>   network/dhcp: Fix netns after removing kernel module
>>
>>  testcases/lib/test_net.sh          | 10 +++++++++-
>>  testcases/network/dhcp/dhcp_lib.sh |  2 +-
>>  2 files changed, 10 insertions(+), 2 deletions(-)
>>
>

