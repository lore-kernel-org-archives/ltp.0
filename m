From: Hangbin Liu <haliu@redhat.com>
Date: Wed, 6 Apr 2016 20:58:23 +0800
Subject: [LTP] [PATCHv3 3/3] network/stress/icmp: use ip xfrm for
 icmp4-uni-basic01 ipsec testing
In-Reply-To: <5704DBBE.20804@oracle.com>
References: <1458209056-18829-4-git-send-email-haliu@redhat.com>
 <56F149FC.4030604@oracle.com>
 <20160323020243.GB8609@Leo.nay.redhat.com>
 <56F25211.5090902@oracle.com>
 <20160323133012.GC8609@Leo.nay.redhat.com>
 <56F902BE.5040306@oracle.com>
 <20160328143343.GJ8609@Leo.nay.redhat.com>
 <56FBC980.1030702@oracle.com>
 <20160406075217.GC8609@Leo.nay.redhat.com>
 <5704DBBE.20804@oracle.com>
Message-ID: <20160406125822.GG8609@Leo.nay.redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Apr 06, 2016 at 12:49:50PM +0300, Alexey Kodanev wrote:
> Hi,
> 
> On 04/06/2016 10:52 AM, Hangbin Liu wrote:
> >Hi,
> >On Wed, Mar 30, 2016 at 03:41:36PM +0300, Alexey Kodanev wrote:
> >>>Does it looks like
> >>>
> >>>icmp4-uni-basic01 icmp-uni-basic
> >>>icmp4-uni-basic02 DO_IPSEC=true IPSEC_PROTO=ah IPSEC_MODE=transport ICMP_SIZE_ARRAY="10 100 1000 10000 65483"; icmp-uni-basic
> >>>...
> >>>icmp6-uni-basic01 icmp-uni-basic -6
> >>>icmp6-uni-basic02 DO_IPSEC=true IPSEC_PROTO=ah IPSEC_MODE=transport ICMP_SIZE_ARRAY="10 100 1000 10000 65503"; icmp-uni-basic -6
> >>Or something like network/virt_lib.sh does with getopts, so instead of
> >>setting
> >>environment variables we would have easy to look at runtest lines, e.g.:
> >>
> >>icmp6-uni-basic01 icmp-uni-basic -6
> >>icmp6-uni-basic02 icmp-uni-basic -6 -p ah -m transport -s "10 100 1000 10000 65503"
> >OK, I will try this way
> >
> >>>>I still think we should add it to the library. tst_ping replaces
> >>>>'icmp4/6_check_connectivity'. And adding variable message size there,
> >>>>will replace ns-echoclient library tool.
> >>>I did't find icmp4/6_check_connectivity will do icmp msg_size check. But anyway,
> >>>here is a msg_sizes version. how do you think? should we use ROD ping... directly?
> >>It's in "ns-echoclient".
> >ns-echoclient only ping remote but do not check the return status.
> 
> Yeah, I know, that's the reason you removed it in your patch.
> 
> >
> >>About ROD in tst_ping()... may be we shouldn't use it here. It's quite
> >>simple
> >>to call "ROD tst_ping" anyway.
> >>
> >>Also I'm not sure we won't have tests that pass on failed ping. For example,
> >>vxlan tests set different IDs and check that there is no connectivity. In
> >>this particular cases,
> >>the test shouldn't exit with TBROK but return TPASS status. We could simply
> >>return ping
> >>status here and let test to decide what to do next.
> >Here comes back the old discuss. tst_ping is used for check connectivity. If
> >we use msg_sizes="10 100 1000 10000 65530" and failed when send msg_size
> >10000 and return -1. How the test know which msg size failed? That's the
> >reason I feel we should let tst_ping check one msg_size each time.
> 
> We could print it in tst_ping() as information message before 'return 1',
> will it be enough?

Yes, that would be fine. Thanks for the advice.

Regards
Hangbin
> 
> 
> Thanks,
> Alexey
> 
> >Thanks
> >Hangbin
> >
> >>>tst_ping()
> >>>{
> >>>         # The max number of ICMP echo request
> >>>         PING_MAX=${PING_MAX:-"10"}
> >>>
> >>>         local src_iface=${1:-"$(tst_iface)"}
> >>>         local dst_addr=${2:-"$(tst_ipaddr rhost)"}
> >>>         # ping cmd use 56 as default message size
> >>>         local msg_sizes=${3:-"56"}
> >>local msg_sizes=${@:3}
> >>
> >>for size in ${msg_sizes:-"56"}; do
> >>     ping...
> >>
> >>
> >>Best regards,
> >>Alexey
> >>
> >>>         for size in $msg_sizes; do
> >>>                 ping$TST_IPV6 -I $src_iface -c $PING_MAX $dst_addr \
> >>>                         -s $msg_size > /dev/null 2>&1
> >>>                 if [ $? -ne 0 ]; then
> >>>                         tst_brkm TBROK "There is no IPv${IP_VER:-4} connectivity with msg_size $msg_size"
> >>>                 else
> >>>                         tst_resm TPASS "There is IPv${IP_VER:-4} connectivity with msg_size $msg_size"
> >>>                 fi
> >>>         done
> >>>}
> >>>
> >>>Thanks & Best Regards
> >>>Hangbin Liu
> >>
> >>-- 
> >>Mailing list info: https://lists.linux.it/listinfo/ltp
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 

Thanks & Best Regards
Hangbin Liu <haliu@redhat.com>
Leo on #kernel-qe, #kernel, #eng-china
