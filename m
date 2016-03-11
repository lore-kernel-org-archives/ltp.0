From: Hangbin Liu <haliu@redhat.com>
Date: Fri, 11 Mar 2016 11:00:00 +0800
Subject: [LTP] [PATCH 1/3] lib/test_net.sh: add tst_ping() to check icmp
 connectivity
In-Reply-To: <56E120E2.8050107@oracle.com>
References: <1457334114-10461-1-git-send-email-haliu@redhat.com>
 <1457334114-10461-2-git-send-email-haliu@redhat.com>
 <56E01222.6020909@oracle.com> <56E012F8.7020504@oracle.com>
 <20160310062208.GK2649@Leo.nay.redhat.com>
 <56E120E2.8050107@oracle.com>
Message-ID: <20160311030000.GO2649@Leo.nay.redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Mar 10, 2016 at 10:23:14AM +0300, Alexey Kodanev wrote:
> Hi,
> On 03/10/2016 09:22 AM, Hangbin Liu wrote:
> >>>
> >>>>+    if [ "$dst_addr" == "$(tst_ipaddr)" ]; then
> >>>>+        tst_rhost_run -c "$PING -I $src_iface -c $PING_MAX $dst_addr \
> >>>>+            -s $msg_size > /dev/null 2>&1"
> >>>>+    else
> >>>>+        $PING -I $src_iface -c $PING_MAX $dst_addr -s $msg_size > \
> >>>>+            /dev/null 2>&1
> >>>>+    fi
> >>>>+}
> >>>Do we actually need to run this command from remote host?
> >I'm OK with both side. but the previous test run check_icmp_connectivity from
> >remote.
> >
> >$LTP_RSH $RHOST ${LTPROOT}/testcases/bin/check_icmpv4_connectivity
> >
> >So how do you think.
> 
> If we're checking connectivity... it doesn't really matter,
> but running it from remote host is not so convenient.

That's also I think :) Will do it on local side.

Thanks
Hangbin
