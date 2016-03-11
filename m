From: Hangbin Liu <haliu@redhat.com>
Date: Fri, 11 Mar 2016 11:08:36 +0800
Subject: [LTP] [PATCH 3/3] network/stress/icmp: use ip xfrm for
 icmp4-uni-basic01 ipsec testing
In-Reply-To: <56E122F6.9060504@oracle.com>
References: <1457334883-11086-1-git-send-email-haliu@redhat.com>
 <1457334883-11086-4-git-send-email-haliu@redhat.com>
 <56E01CDE.9090101@oracle.com>
 <20160310065045.GM2649@Leo.nay.redhat.com>
 <56E122F6.9060504@oracle.com>
Message-ID: <20160311030836.GP2649@Leo.nay.redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Mar 10, 2016 at 10:32:06AM +0300, Alexey Kodanev wrote:
> On 03/10/2016 09:50 AM, Hangbin Liu wrote:
> >>>      # Unset SAD/SPD
> >>>-    output_ipsec_conf flush | setkey -c >/dev/null 2>&1
> >>>-    $LTP_RSH $RHOST ${LTPROOT}/'testcases/bin/output_ipsec_conf flush | PATH=/sbin:/usr/sbin:$PATH setkey -c' >/dev/null 2>&1
> >>>+    tst_ipsec flush
> >>>      # Clean up each interface
> >>>-    initialize_if lhost ${LINK_NUM}
> >>>-    initialize_if rhost ${LINK_NUM}
> >>>+    tst_init_iface lhost ${LINK_NUM}
> >>>+    tst_init_iface rhost ${LINK_NUM}
> >>Can we remove them instead? Most tests expect that they are already
> >>initialized.
> >I think we'd better not remove them. uni-basic is still OK. But multi-diffip
> >tests will add multi ip addresses. We need clean the env after each test.
> 
> OK, let's keep it only in tests which add/remove IP addresses.

OK

> 
> By the way, if you are going to fix such tests please use IP range
> that is defined with the following env vars:
> 
> export IPV4_NET16_UNUSED=${IPV4_NET16_UNUSED:-"10.23"}
> export IPV6_NET32_UNUSED=${IPV6_NET32_UNUSED:-"fd00:23"}
> 
> it's from testscripts/network.sh.

Thanks for this tip. multi-diffip and multi-diffnic use multi different subnets.
So I think we still need keep using the previous method.

while [ $ipaddr_pair_num -lt $IP_TOTAL_FOR_TCPIP ]; do
    # Add new IP addresses
    x=`expr $ipaddr_pair_num \/ 255 % 255`
    y=`expr $ipaddr_pair_num % 255`
    if [ $x -ge 255 ]; then
        tst_info TINFO "This script cannot add more than $ipaddr_pair_num addresses"
        break
    fi

    case $IP_VER in
        4)
        network_part="10.${x}.${y}"
        network_broadcast=${network_part}.255


while [ $link_num -lt $link_total ]; do
    # name of interface of the local/remote host
    lhost_ifname=`get_ifname lhost $link_num`
    rhost_ifname=`get_ifname rhost $link_num`

    # Set the IP address to each interface
    case $IP_VER in
        4)
        network_part="10.0.${link_num}"
        network_mask=24
        lhost_host_part="2"     # local host
        rhost_host_part="1"     # remote host

Thanks
Hangbin
