From: sunlianwen <sunlw.fnst@cn.fujitsu.com>
Date: Mon, 26 Feb 2018 19:28:26 +0800
Subject: [LTP] [error] report a hangup error about test route4[6]-change-gw
Message-ID: <1072a295-2c2e-75cf-d488-5150ce44622e@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi Alexey

    I find the runnig  route4-change-gw and route6-change-gw often hangup,

I debug this two case and testing environment is below:

     ______                          _______
    |         |-eth0------ eth0-|          |
    |host1|                         |host2  |
    |         |-eth1------ eth1-|          |
    -------                            ---------

the ip address of eth0 is used for rshd so that host1  can rsh to host2 
through eth0.

and the eth1 is use for ltp testcase. and I set the eth1 for test 
interfaces in test_net.sh

file path: ltp/./testcases/lib/test_net.sh

687 # Set names for test interfaces, e.g. "eth0 eth1"
688 # This is fallback for LHOST_IFACES in case tst_net_vars finds 
nothing or we
689 # want to use more ifaces.
690 export LHOST_IFACES="${LHOST_IFACES:-eth1}"
691 export RHOST_IFACES="${RHOST_IFACES:-eth1}"

but the case route4-change-gw and route6-change -gw is use eth0 for test 
interfaces,

so when running this two case, the eth0 will ifdown/up this lead to  
host1 can not rsh host2

and hangup will happen.

I think this case should use $LHOST_IFACES/$RHOST_IFACES as  test 
interface and should not fixed use eth0.

if I think right , I hope you can revise this  two case.


file path:ltp/testcases/network/stress/route/route4-change-gw

   67 # The number of the test link where tests run
  68 LINK_NUM=${LINK_NUM:-0}
   ...

109     # Get the Interface name of local host
110     lhost_ifname=`get_ifname lhost ${LINK_NUM}`

line 110 ,we can know the eth0 is the test interface

That's all

Thanks

Lianwen Sun




-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180226/6ab00f35/attachment.html>
