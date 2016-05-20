From: Hangbin Liu <haliu@redhat.com>
Date: Fri, 20 May 2016 10:38:21 +0800
Subject: [LTP] [PATCH 1/4] network/stress/icmp: add icmp-multi-diffip.sh
 to implement diffip stress test
In-Reply-To: <20160520012919.GH19992@Leo.nay.redhat.com>
References: <1462780623-26778-1-git-send-email-haliu@redhat.com>
 <573B0499.9020308@oracle.com>
 <20160519142900.GG19992@Leo.nay.redhat.com>
 <573DE35A.7060106@oracle.com>
 <20160520012919.GH19992@Leo.nay.redhat.com>
Message-ID: <20160520023821.GI19992@Leo.nay.redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, May 20, 2016 at 10:16:33AM +0800, Hangbin Liu wrote:
> > >>>+# Do Stress testing, ping flood
> > >>>+tst_resm TINFO "start ping flood stress testing"
> > >>>+for rhost_addr in ${rhost_addr_array[@]}; do
> > >>>+	for size in ${ICMP_SIZE_ARRAY}; do
> > >>>+		ping$TST_IPV6 -f -q -I $lhost_iface $rhost_addr -s $size &> /dev/null &
> > >>>+	done
> > >>>+done
> > 
> > Can we start ping test in background after adding each IP, i.e. after
> > tst_ping finished?

Ah, suddenly come in mind, If we start ping flood just after adding each IP,
there will have packets loose when we test later added IP address, which may
cause tst_ping failed. What do you think?

Thanks
Hangbin
