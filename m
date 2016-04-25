From: Hangbin Liu <haliu@redhat.com>
Date: Mon, 25 Apr 2016 09:51:57 +0800
Subject: [LTP] [PATCH v5 0/3] networking/stress/icmp: add ip xfrm ipsec
 support
In-Reply-To: <571A1361.4060909@oracle.com>
References: <1460517625-25960-1-git-send-email-haliu@redhat.com>
 <571A1361.4060909@oracle.com>
Message-ID: <20160425015157.GE10443@Leo.nay.redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Apr 22, 2016 at 03:04:49PM +0300, Alexey Kodanev wrote:
> Hi Hangbin,
> On 13.04.2016 6:20, Hangbin Liu wrote:
> >As we know, most of the network stress tests have IPsec testing, and we use
> >setkey for configuration. But setkey[1] hasn't updated for a long time. And
> >some distros, RHEL7 for example, even don't have ipset-tools package. On
> >other hand, iproute2 is recommend for network configuration. And ip xfrm is
> >more powerful than setkey. So let's use ip xfrm for ipsec testing.
> >
> >[1] http://ipsec-tools.sourceforge.net/
> 
> When running the tests with this patch-set on OL6 I've encountered with
> failed tests
> due to not supported ip options:
> 
> icmp-uni-basic 1 TINFO : - IPcomp [ transport ]
> Error: argument "transport" is wrong: unknown
> 
> icmp-uni-basic 1 TINFO : - IPcomp [ tunnel ]
> Error: argument "tunnel" is wrong: unknown
> 
> Have you tried running them on RHEL6?
> 
> It seems that iproute there requires some value passed after "... comp
> deflate ??? mode ..."

Yes, there is a iproute2 bug on RHEL6 with comp. We need to add a fake key after
compression. e.g.
ip xfrm state add src 1.1.1.1 dst 2.2.2.2 proto comp spi 1 mode tunnel comp deflate 0x

And the following patch fixed this issue.

commit f3b9aa3df848e6ce7f61a54f0f05aef3bdff24ca
Author: David Ward <david.ward@ll.mit.edu>
Date:   Mon Mar 25 04:23:17 2013 +0000

    ip/xfrm: Command syntax should not expect a key for compression

    Compression algorithms do not use a key.

    Signed-off-by: David Ward <david.ward@ll.mit.edu>

I opened a bug 1315927[1] for this issue. RHEL7 works OK.

[1] https://bugzilla.redhat.com/show_bug.cgi?id=1315927

Thanks
Hangbin
> 
> >Change from V4:
> >1. minimise icmp-uni-basic, remove some useless comment.
> >2. use tst_exit instead of exit 0
> >3. Fix max message size and add comment in network_stress.icmp to describe how
> >    we calculate them.
> >4. fix some typo
> >TODO: For icmp-uni-basic test, we test each message size to make sure the
> >connectivity. In icmp-multi-diffip/nic test, we will do ping flood test with
> >multi ip/nic for stress testing since we have already make sure the connectivity.
> >
> >
> >Change from V3:
> >1. use message size array in tst_ping
> >2. add tst_ipsec_cleanup in ipsec_lib
> >3. use lhost/rhost naming in ipsec_lib
> >4. add icmp-uni-basic in the upper icmp directory
> >5. some other small fixs.
> >
> >Change from V2:
> >1. remove c2x and use hexdump directly.
> >2. remove indent after "case".
> >3. remove useless export and old scripts like check_env.
> >4. remove tst_init_iface.
> >5. remove return value check after setup ipsec env.
> >6. remove addr config as Alexey said, we assume the address already added.
> >
> >Change from V1:
> >1. update tst_ping() to use default iface and addr. make ping from local side.
> >2. remove unused variables. add -s option when use tst_rhost_run. Use ROD
> >    before normal commands.
> >3. change all "tst_resm TBROK && exit" to "tst_brkm TBROK"
> >3. still keep tst_init_iface in test icmp4-uni-basic01 because we will
> >    set_ipv4/6addr each time.
> >
> >Hangbin Liu (3):
> >   lib/test_net.sh: add tst_ping() to check icmp connectivity
> >   network/stress: add ipsec lib
> >   network/stress/icmp: add icmp-uni-basic to implement all icmp basic
> >     stress test
> >
> >  runtest/network_stress.icmp                  |  46 +++++++----
> >  testcases/lib/test_net.sh                    |  30 ++++++++
> >  testcases/network/stress/icmp/Makefile       |   3 +
> >  testcases/network/stress/icmp/icmp-uni-basic | 105 +++++++++++++++++++++++++
> >  testcases/network/stress/ipsec/Makefile      |  28 +++++++
> >  testcases/network/stress/ipsec/ipsec_lib.sh  | 110 +++++++++++++++++++++++++++
> >  6 files changed, 308 insertions(+), 14 deletions(-)
> >  create mode 100755 testcases/network/stress/icmp/icmp-uni-basic
> >  create mode 100644 testcases/network/stress/ipsec/Makefile
> >  create mode 100644 testcases/network/stress/ipsec/ipsec_lib.sh
> >
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 

Thanks & Best Regards
Hangbin Liu <haliu@redhat.com>
Leo on #kernel-qe, #kernel, #eng-china
