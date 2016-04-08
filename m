From: Hangbin Liu <haliu@redhat.com>
Date: Fri, 8 Apr 2016 22:12:34 +0800
Subject: [LTP] [PATCHv4 0/3] networking/stress: add ip xfrm ipsec support
In-Reply-To: <1460110369-30134-1-git-send-email-haliu@redhat.com>
References: <1460110369-30134-1-git-send-email-haliu@redhat.com>
Message-ID: <20160408141234.GG20571@Leo.nay.redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Sorry, the signoff info is incorrect. Please ignore this patch set.

Thanks
Hangbin
On Fri, Apr 08, 2016 at 06:12:46PM +0800, Hangbin Liu wrote:
> From: Hangbin Liu <liuhangbin@gmail.com>
> 
> As we know, most of the network stress tests have IPsec testing, and we use
> setkey for configuration. But setkey[1] hasn't updated for a long time. And
> some distros, RHEL7 for example, even don't have ipset-tools package. On
> other hand, iproute2 is recommend for network configuration. And ip xfrm is
> more powerful than setkey. So let's use ip xfrm for ipsec testing.
> 
> [1] http://ipsec-tools.sourceforge.net/
> 
> Change from V3:
> 1. use message size array in tst_ping
> 2. add tst_ipsec_cleanup in ipsec_lib
> 3. use lhost/rhost naming in ipsec_lib
> 4. add icmp-uni-basic in the upper icmp directory
> 5. some other small fixs.
> 
> Change from V2:
> 1. remove c2x and use hexdump directly.
> 2. remove indent after "case".
> 3. remove useless export and old scripts like check_env.
> 4. remove tst_init_iface.
> 5. remove return value check after setup ipsec env.
> 6. remove addr config as Alexey said, we assume the address already added.
> 
> Change from V1:
> 1. update tst_ping() to use default iface and addr. make ping from local side.
> 2. remove unused variables. add -s option when use tst_rhost_run. Use ROD
>    before normal commands.
> 3. change all "tst_resm TBROK && exit" to "tst_brkm TBROK"
> 3. still keep tst_init_iface in test icmp4-uni-basic01 because we will
>    set_ipv4/6addr each time.
> 
> Hangbin Liu (3):
>   lib/test_net.sh: add tst_ping() to check icmp connectivity
>   network/stress: add ipsec lib
>   network/stress/icmp: use ip xfrm for icmp uni-basic ipsec testing
> 
>  runtest/network_stress.icmp                  |  28 +++---
>  testcases/lib/test_net.sh                    |  31 +++++++
>  testcases/network/stress/icmp/Makefile       |   3 +
>  testcases/network/stress/icmp/icmp-uni-basic | 132 +++++++++++++++++++++++++++
>  testcases/network/stress/ipsec/Makefile      |  28 ++++++
>  testcases/network/stress/ipsec/ipsec_lib.sh  | 114 +++++++++++++++++++++++
>  6 files changed, 322 insertions(+), 14 deletions(-)
>  create mode 100755 testcases/network/stress/icmp/icmp-uni-basic
>  create mode 100644 testcases/network/stress/ipsec/Makefile
>  create mode 100644 testcases/network/stress/ipsec/ipsec_lib.sh
> 
> -- 
> 2.5.0
> 

-- 

Thanks & Best Regards
Hangbin Liu <haliu@redhat.com>
Leo on #kernel-qe, #kernel, #eng-china
