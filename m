From: Hangbin Liu <haliu@redhat.com>
Date: Fri, 20 May 2016 10:16:33 +0800
Subject: [LTP] [PATCH 1/4] network/stress/icmp: add icmp-multi-diffip.sh
 to implement diffip stress test
In-Reply-To: <573DE35A.7060106@oracle.com>
References: <1462780623-26778-1-git-send-email-haliu@redhat.com>
 <573B0499.9020308@oracle.com>
 <20160519142900.GG19992@Leo.nay.redhat.com>
 <573DE35A.7060106@oracle.com>
Message-ID: <20160520012919.GH19992@Leo.nay.redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

On Thu, May 19, 2016 at 07:01:30PM +0300, Alexey Kodanev wrote:
> >>>+	rhost_addr_array[$cnt]=$rhost_addr
> >>Please don't use arrays, it's a bash extension.
> >Is there a better way to store the addresses? Use a temp file?
> 
> We can easily calculate them again, why store them... number might be quite
> big.

OK

> 
> >>>+done
> >>>+
> >>>+# Do Stress testing, ping flood
> >>>+tst_resm TINFO "start ping flood stress testing"
> >>>+for rhost_addr in ${rhost_addr_array[@]}; do
> >>>+	for size in ${ICMP_SIZE_ARRAY}; do
> >>>+		ping$TST_IPV6 -f -q -I $lhost_iface $rhost_addr -s $size &> /dev/null &
> >>>+	done
> >>>+done
> 
> Can we start ping test in background after adding each IP, i.e. after
> tst_ping finished?

OK

> 
> >>>+
> >>>+sleep ${NS_DURATION}
> >>>+
> >>>+tst_resm TPASS "$TCID IPv${TST_IPV6:-4} $IPSEC_PROTO $IPSEC_MODE stress test"
> >>Is the test always passing here with no checks?
> >Yes, if the system under test do not crash with ping flood after ${NS_DURATION}
> >seconds, we can pass the test.
> 
> What if remote host crashed somehow, and local not... test would pass in
> that case.
> 
> May be we should kill ping processes (or add -w deadline) and check
> connectivity again,
> what do you think?

Good advice. Will add this check.

Thanks
Hangbin
