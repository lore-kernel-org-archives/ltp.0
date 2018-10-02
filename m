From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 2 Oct 2018 10:24:49 +0200
Subject: [LTP] LTP network tests
In-Reply-To: <BL0PR06MB4257D11CFDE625F69F318E8793140@BL0PR06MB4257.namprd06.prod.outlook.com>
References: <BL0PR06MB4257D11CFDE625F69F318E8793140@BL0PR06MB4257.namprd06.prod.outlook.com>
Message-ID: <20181002082449.GA24414@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Yulu,

there are 3 ways of running LTP network tests (see testcases/lib/tst_net.sh):
* single host configuration using network namespaces (TST_USE_NETNS, it's
  default one if you don't set RHOST). It requires kernel with network
  namespaces support (CONFIG_NET_NS) + veth support (CONFIG_VETH), some tests
  require additional support.
* using SSH (via TST_USE_SSH and RHOST variables): need to setup SSH access with keys or
  define password in PASSWD variable
* using RSH (via RHOST variable)
There is a helper script testscripts/network.sh (installed into
/opt/ltp/testscripts/network.sh), which you can use instead of /opt/ltp/runltp.

I removed RHOST to have the same default behavior for both runltp and
network.sh. So, running "runltp -N" now performs testing via network namespaces.

LTP/net doc (somehow obsolete, we need to update it):
https://github.com/linux-test-project/ltp/tree/master/testcases/network
https://github.com/linux-test-project/ltp/blob/master/INSTALL#L190

Some tests aren't ported to use tst_net.sh (route and multicast stress tests,
RPC and TCP tests, ...) and still use rsh via LTP_RSH variable. These tests needs
to be rewritten:
https://github.com/linux-test-project/ltp/issues/128
https://github.com/linux-test-project/ltp/issues/310

Kind regards,
Petr

PS: CC LTP mailing list in case somebody is interested.

> Hi Petr,

> I'm new to LTP and trying to get LTP running in our environment. One particular area I'm having problem with is running network tests. I looked at the commit history of the LTP test and saw that you recently made some changes on how to run network tests. I wonder if you can help me on this.

> Do you need a remote host to run the network tests?
> If so, how do you specify the remote host? When I did "runltp -N", it didn't ask for any information on a remote host. Are there any setup I have to perform before issuing "runltp -N".

> Regards,
> Yulu Diao

> commit 22a0cb31a5cb66bdeabbeb5d42299ecb4898fc2e
> Author: Petr Vorel <pvorel@suse.cz>
> Date:   Mon Sep 3 12:41:34 2018 +0200

>     runltp: Remove RHOST setup

>     as RSH is deprecated. The default management link of network tests are
>     network namespaces.

>     For remote management is (instead of RSH) recommended to use SSH. Setup:
>     TST_USE_SSH=1

>     Signed-off-by: Petr Vorel <pvorel@suse.cz>



