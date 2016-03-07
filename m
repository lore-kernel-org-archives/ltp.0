From: Hangbin Liu <haliu@redhat.com>
Date: Mon,  7 Mar 2016 15:20:57 +0800
Subject: [LTP]  [PATCH 0/3] networking/stress: add ip xfrm ipsec support
Message-ID: <1457335260-11455-1-git-send-email-haliu@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey and Cyril,

Sorry for the late patches. I was bussy with other stuff durning previous
months. Here I only add an ipsec lib and add ip xfrm support for
icmp4-uni-basic01. I will fix other tests when you feel these patches are
OK.

As we know, most of the network stress tests have IPsec testing, and we use
setkey for configuration. But setkey[1] hasn't updated for a long time. And
some distros, RHEL7 for example, even don't have ipset-tools package. On
other hand, iproute2 is recommend for network configuration. And ip xfrm is
more powerful than setkey. So let's use ip xfrm for ipsec testing.

For c2x function in ipsec_lib.sh. It's only a convert function and do not
print any info. So I kept it with the old style.

[1] http://ipsec-tools.sourceforge.net/

Here is the test result:
# ./networkstress.sh -i
<<<test_start>>>
tag=icmp4-uni-basic01 stime=1457331713
cmdline="icmp4-uni-basic01"
contacts=""
analysis=exit
<<<test_output>>>
icmp4-uni-basic01 1 TINFO : Verify that the kernel is not crashed with receiving and sending various size of ICMP message with the following conditions
icmp4-uni-basic01 1 TINFO : - Test duration is 3600 [sec]
icmp4-uni-basic01 1 TINFO : - Version of IP is IPv4
icmp4-uni-basic01 1 TINFO : - Size of packets are ( 10 100 1000 10000 65507 )
icmp4-uni-basic01 1 TINFO : initialize 'lhost' 'eth1' interface
icmp4-uni-basic01 1 TINFO : initialize 'rhost' 'eth1' interface
icmp4-uni-basic01 1 TPASS : There has IPv4 connectivity with msg_size 10
icmp4-uni-basic01 2 TPASS : There has IPv4 connectivity with msg_size 100
icmp4-uni-basic01 3 TPASS : There has IPv4 connectivity with msg_size 1000
icmp4-uni-basic01 4 TPASS : There has IPv4 connectivity with msg_size 10000
icmp4-uni-basic01 5 TPASS : There has IPv4 connectivity with msg_size 65507
icmp4-uni-basic01 6 TPASS : Test is finished successfully.
icmp4-uni-basic01 7 TINFO : initialize 'lhost' 'eth1' interface
icmp4-uni-basic01 7 TINFO : initialize 'rhost' 'eth1' interface
<<<execution_status>>>
initiation_status="ok"
duration=49 termination_type=exited termination_id=0 corefile=no
cutime=48 cstime=10
<<<test_end>>>
<<<test_start>>>
tag=icmp4-uni-basic02 stime=1457331762
cmdline="icmp4-uni-basic02"
contacts=""
analysis=exit
<<<test_output>>>
incrementing stop
icmp4-uni-basic02 1 TINFO : Verify that the kernel is not crashed with receiving and sending various size of ICMP message with the following conditions
icmp4-uni-basic02 1 TINFO : - Test duration is 3600 [sec]
icmp4-uni-basic02 1 TINFO : - Version of IP is IPv4
icmp4-uni-basic02 1 TINFO : - Size of packets are ( 10 100 1000 10000 65507 )
icmp4-uni-basic02 1 TINFO : - IPsec [ AH / transport ]
icmp4-uni-basic02 1 TINFO : initialize 'lhost' 'eth1' interface
icmp4-uni-basic02 1 TINFO : initialize 'rhost' 'eth1' interface
src 10.0.0.1 dst 10.0.0.2
        proto ah spi 0x00001001 reqid 0 mode transport
        replay-window 0
        auth hmac(sha1) 0x626565665f666973685f706f726b5f73616c6164
        sel src 10.0.0.1/32 dst 10.0.0.2/32
src 10.0.0.2 dst 10.0.0.1
        proto ah spi 0x00001000 reqid 0 mode transport
        replay-window 0
        auth hmac(sha1) 0x626565665f666973685f706f726b5f73616c6164
        sel src 10.0.0.2/32 dst 10.0.0.1/32
src 10.0.0.1/32 dst 10.0.0.2/32
        dir in priority 0 ptype main
        tmpl src 10.0.0.1 dst 10.0.0.2
                proto ah reqid 0 mode transport
src 10.0.0.2/32 dst 10.0.0.1/32
        dir out priority 0 ptype main
        tmpl src 10.0.0.2 dst 10.0.0.1
                proto ah reqid 0 mode transport
src 10.0.0.2 dst 10.0.0.1
        proto ah spi 0x00001000 reqid 0 mode transport
        replay-window 0
        auth-trunc hmac(sha1) 0x626565665f666973685f706f726b5f73616c6164 96
        sel src 10.0.0.2/32 dst 10.0.0.1/32
src 10.0.0.1 dst 10.0.0.2
        proto ah spi 0x00001001 reqid 0 mode transport
        replay-window 0
        auth-trunc hmac(sha1) 0x626565665f666973685f706f726b5f73616c6164 96
        sel src 10.0.0.1/32 dst 10.0.0.2/32
src 10.0.0.2/32 dst 10.0.0.1/32
        dir in priority 0 ptype main
        tmpl src 10.0.0.2 dst 10.0.0.1
                proto ah reqid 0 mode transport
src 10.0.0.1/32 dst 10.0.0.2/32
        dir out priority 0 ptype main
        tmpl src 10.0.0.1 dst 10.0.0.2
                proto ah reqid 0 mode transport
icmp4-uni-basic02 1 TPASS : There has IPv4 connectivity with msg_size 10
icmp4-uni-basic02 2 TPASS : There has IPv4 connectivity with msg_size 100
icmp4-uni-basic02 3 TPASS : There has IPv4 connectivity with msg_size 1000
icmp4-uni-basic02 4 TPASS : There has IPv4 connectivity with msg_size 10000
icmp4-uni-basic02 5 TBROK : There is no IPv4 connectivity with msg_size 65507

       ^^ here is a TBROK in icmp4-uni-basic02, I will fix it in next patch

icmp4-uni-basic02 5 TINFO : initialize 'lhost' 'eth1' interface
icmp4-uni-basic02 5 TINFO : initialize 'rhost' 'eth1' interface
icmp4-uni-basic02 5 TINFO : initialize 'lhost' 'eth1' interface
icmp4-uni-basic02 5 TINFO : initialize 'rhost' 'eth1' interface
<<<execution_status>>>
initiation_status="ok"
duration=62 termination_type=exited termination_id=2 corefile=no
cutime=78 cstime=17
<<<test_end>>>
ltp-pan reported FAIL


Hangbin Liu (3):
  lib/test_net.sh: add tst_ping() to check icmp connectivity
  network/stress: add ipsec lib
  network/stress/icmp: use ip xfrm for icmp4-uni-basic01 ipsec testing

 testcases/lib/test_net.sh                          |  37 ++++++
 .../stress/icmp/uni-basic/icmp4-uni-basic01        |  66 ++++------
 testcases/network/stress/ipsec/Makefile            |  31 +++++
 testcases/network/stress/ipsec/ipsec_lib.sh        | 134 +++++++++++++++++++++
 4 files changed, 224 insertions(+), 44 deletions(-)
 create mode 100644 testcases/network/stress/ipsec/Makefile
 create mode 100644 testcases/network/stress/ipsec/ipsec_lib.sh

-- 
2.5.0

