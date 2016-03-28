From: Hangbin Liu <haliu@redhat.com>
Date: Mon, 28 Mar 2016 22:33:43 +0800
Subject: [LTP] [PATCHv3 3/3] network/stress/icmp: use ip xfrm for
 icmp4-uni-basic01 ipsec testing
In-Reply-To: <56F902BE.5040306@oracle.com>
References: <1458209056-18829-1-git-send-email-haliu@redhat.com>
 <1458209056-18829-4-git-send-email-haliu@redhat.com>
 <56F149FC.4030604@oracle.com>
 <20160323020243.GB8609@Leo.nay.redhat.com>
 <56F25211.5090902@oracle.com>
 <20160323133012.GC8609@Leo.nay.redhat.com>
 <56F902BE.5040306@oracle.com>
Message-ID: <20160328143343.GJ8609@Leo.nay.redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

On Mon, Mar 28, 2016 at 01:09:02PM +0300, Alexey Kodanev wrote:
> Hi,
> On 03/23/2016 04:30 PM, Hangbin Liu wrote:
> >Hi,
> >On Wed, Mar 23, 2016 at 11:21:37AM +0300, Alexey Kodanev wrote:
> >>Hi,
> >>>>>@@ -72,6 +65,7 @@ LINK_NUM=${LINK_NUM:-0}
> >>>>>  # The version of IP
> >>>>>  IP_VER=${IP_VER:-4}
> >>>>>+[ $IP_VER -eq 6 ] && TST_IPV6=6
> >>>>just "ipv=${TST_IPV6:-4}" instead of two lines.
> >>>This is not work. Because test_net.sh will set TST_IPV6= , and icmp4-uni-basic01
> >>>need source it before test. The relation looks like
> >>>
> >>>icmp6-uni-basic01
> >>>   . icmp4-uni-basic01
> >>>     . ipsec_lib.sh
> >>>       . test_net.sh
> >>>
> >>>If we want to use like ipv=${TST_IPV6:-4}, we need source test_net.sh in all
> >>>sub-testcases instead of in ipsec_lib.sh. Which will like
> >>>
> >>>icmp6-uni-basic01
> >>>   . test_net.sh
> >>>   . icmp4-uni-basic01
> >>>     . ipsec_lib.sh
> >>Could you add "ipv=..." to ipsec_lib.sh and we wouldn't set it in every
> >>test-case?
> >the IP_VER is to describe what the test run for. We shouldn't add it in
> >ipsec_lib.sh. There is no relations between them.
> 
> Looking at the tests structure there... basically, one file implements
> test-cases
> and the rest scripts source the first one along with changing a few
> parameters.
> I think it's better to leave only one file there and remove the rest.
> 
> icmp4-uni-basic01 -> icmp-uni-basic.
> 
> May be moving them all to the upper directory, so in the end we should have
> only 3 tests:
> icmp_multi_diffip.sh
> icmp_multi_diffnic.sh
> icmp_uni_basic.sh
> 
> Then, we could define each test-case in "runtests/", using env vars and
> parameters.

Does it looks like

icmp4-uni-basic01 icmp-uni-basic
icmp4-uni-basic02 DO_IPSEC=true IPSEC_PROTO=ah IPSEC_MODE=transport ICMP_SIZE_ARRAY="10 100 1000 10000 65483"; icmp-uni-basic
...
icmp6-uni-basic01 icmp-uni-basic -6
icmp6-uni-basic02 DO_IPSEC=true IPSEC_PROTO=ah IPSEC_MODE=transport ICMP_SIZE_ARRAY="10 100 1000 10000 65503"; icmp-uni-basic -6

> 
> >
> >>BTW, does the attached patch help in the first case (added export to
> >>TST_IPV6)?
> >I'm afraid not. I'd tried to use like
> >
> >icmp4-uni-basic01 icmp4-uni-basic01
> >icmp6-uni-basic01 icmp4-uni-basic01 -6
> >
> >Then I find this is not only different of IP version, ipsec protocol, mode. But
> >also different message sizes. So I give up to use like that.
> >
> >>
> >>>>-# Run a client
> >>>>-$LTP_RSH $RHOST "${LTPROOT}/testcases/bin/ns-echoclient -S $lhost_addr -f $IP_VER -s \"$ICMP_SIZE_ARRAY\"" &
> >>>>-
> >>>>-sleep $NS_DURATION
> >>>>-killall_icmp_traffic
> >>>>-wait
> >>>>+# Make sure the connectvity
> >>>>+for msg_size in $ICMP_SIZE_ARRAY; do
> >>>>+    tst_ping $lhost_ifname $rhost_addr $msg_size
> >>>>+    if [ $? -ne 0 ]; then
> >>>>+        tst_brkm TBROK "There is no IPv$IP_VER connectivity with msg_size $msg_size"
> >>>>+    else
> >>>>+        tst_resm TPASS "There has IPv$IP_VER connectivity with msg_size $msg_size"
> >>>>+    fi
> >>>>+done
> >>>>
> >>>>Is it really needed to ping with different message sizes? if yes, we
> >>>>couldadd this
> >>>>functionality to tst_ping().
> >>>Yes, we need to make sure ipsec can handle all kinds of message size. But we
> >>>could not make it in tst_ping because ah/esp and tunnel/transport have
> >>>different header length. e.g. when there is no ipsec, the max playload is
> >>>65507. If we test ah + transport, the max playload is 65483. etc. It's hard to
> >>>make tst_ping to handle all these scenarios.
> >>I thought we could add variable length parameters, something like this
> >>
> >>tst_ping p1 ... pN $ICMP_SIZE_ARRAY
> >>
> >>tst_ping()
> >>{
> >>     local msg_sizes=${@:N+1}
> >>
> >>     for size in msg_sizes; do
> >>     ...
> >>}
> >I think tst_ping() is a unit test to check the connectivity, we do not need to
> >add everything inside. Most time we only need to make sure the rhost is
> >online. Let's make the test case deside what message size they want to test.
> >
> >How to you think?
> 
> I still think we should add it to the library. tst_ping replaces
> 'icmp4/6_check_connectivity'. And adding variable message size there,
> will replace ns-echoclient library tool.

I did't find icmp4/6_check_connectivity will do icmp msg_size check. But anyway,
here is a msg_sizes version. how do you think? should we use ROD ping... directly?

tst_ping()
{
        # The max number of ICMP echo request
        PING_MAX=${PING_MAX:-"10"}

        local src_iface=${1:-"$(tst_iface)"}
        local dst_addr=${2:-"$(tst_ipaddr rhost)"}
        # ping cmd use 56 as default message size
        local msg_sizes=${3:-"56"}

        for size in $msg_sizes; do
                ping$TST_IPV6 -I $src_iface -c $PING_MAX $dst_addr \
                        -s $msg_size > /dev/null 2>&1
                if [ $? -ne 0 ]; then
                        tst_brkm TBROK "There is no IPv${IP_VER:-4} connectivity with msg_size $msg_size"
                else
                        tst_resm TPASS "There is IPv${IP_VER:-4} connectivity with msg_size $msg_size"
                fi
        done
}

Thanks & Best Regards
Hangbin Liu
