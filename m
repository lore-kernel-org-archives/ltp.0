From: Hangbin Liu <haliu@redhat.com>
Date: Thu, 10 Mar 2016 14:22:09 +0800
Subject: [LTP] [PATCH 1/3] lib/test_net.sh: add tst_ping() to check icmp
 connectivity
In-Reply-To: <56E012F8.7020504@oracle.com>
References: <1457334114-10461-1-git-send-email-haliu@redhat.com>
 <1457334114-10461-2-git-send-email-haliu@redhat.com>
 <56E01222.6020909@oracle.com> <56E012F8.7020504@oracle.com>
Message-ID: <20160310062208.GK2649@Leo.nay.redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

Thanks for the reply, please see comments in the mail.

On Wed, Mar 09, 2016 at 03:11:36PM +0300, Alexey Kodanev wrote:
> re-sending to the new ltp list...
> 
> On 03/09/2016 03:08 PM, Alexey Kodanev wrote:
> >Hi,
> >On 03/07/2016 10:01 AM, Hangbin Liu wrote:
> >>Signed-off-by: Hangbin Liu <haliu@redhat.com>
> >>---
> >>  testcases/lib/test_net.sh | 37 +++++++++++++++++++++++++++++++++++++
> >>  1 file changed, 37 insertions(+)
> >>
> >>diff --git a/testcases/lib/test_net.sh b/testcases/lib/test_net.sh
> >>index 418fed3..f75e78e 100644
> >>--- a/testcases/lib/test_net.sh
> >>+++ b/testcases/lib/test_net.sh
> >>@@ -314,3 +314,40 @@ tst_netload()
> >>        return $ret
> >>  }
> >>+
> >>+# tst_ping IFACE ADDR [SIZE]
> >>+# Check icmp connectivity
> >>+# IFACE: source interface name
> >>+# ADDR: destination IPv4 or IPv6 address
> >>+# SIZE: message size
> >>+tst_ping()
> >>+{
> >>+    # The max number of ICMP echo request
> >>+    PING_MAX=${PING_MAX:-"10"}
> >>+
> >>+    # Check the arguments
> >>+    if [ $# -lt 2 ]; then
> >>+        tst_resm TBROK "tst_ping src_iface dest_ipv4/6_addr [msg_size]"
> >>+        return 1
> >>+    fi
> >>+
> >>+    local src_iface=$1
> >>+    local dst_addr=$2
> >
> >They could be defaulted to $(tst_iface) and $(tst_ipaddr rhost)
> >accordingly.
> >Then, we don't have to check the number of arguments and it fits for the
> >most cases.

ok, I will fix it.

> >
> >>+    # ping cmd use 56 as default message size
> >>+    local msg_size=${3:-"56"}
> >>+
> >>+    if echo $dst_addr | grep ":"; then
> >>+        local PING="ping6"
> >>+        TST_IPV6=6
> >>+    else
> >>+        local PING="ping"
> >>+    fi
> >>+
> >
> >if test runs with -6 option, TST_IPV6 will be defined as 6, otherwise is
> >"".
> >We can use it inside test_net.sh and tests. So here, we could call ping
> >command
> >as follows: "ping$TST_IPV6 ..."

Good idea.

> >
> >
> >>+    if [ "$dst_addr" == "$(tst_ipaddr)" ]; then
> >>+        tst_rhost_run -c "$PING -I $src_iface -c $PING_MAX $dst_addr \
> >>+            -s $msg_size > /dev/null 2>&1"
> >>+    else
> >>+        $PING -I $src_iface -c $PING_MAX $dst_addr -s $msg_size > \
> >>+            /dev/null 2>&1
> >>+    fi
> >>+}
> >
> >Do we actually need to run this command from remote host?

I'm OK with both side. but the previous test run check_icmp_connectivity from
remote.

$LTP_RSH $RHOST ${LTPROOT}/testcases/bin/check_icmpv4_connectivity

So how do you think.

Thanks & Best Regards
Hangbin
