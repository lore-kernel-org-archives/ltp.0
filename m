From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 18 May 2020 23:42:53 +0200
Subject: [LTP] [PATCH v2 1/1] rpc: TCONF when tests aren't compiled +
 remove kill warning
In-Reply-To: <5EC287EE.9070508@cn.fujitsu.com>
References: <20200512201416.8299-1-pvorel@suse.cz>
 <5EC287EE.9070508@cn.fujitsu.com>
Message-ID: <20200518214253.GB22879@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xiao,

> On 2020/5/13 4:14, Petr Vorel wrote:
> > Without this test failure was wrongly reported:
> > rpc_test 1 TFAIL: tirpc_rpcb_getaddr 10.0.0.2 536875000 failed unexpectedly
> Hi Petr,

> Do you know which caused this failure?
Certain tests compiled with TI-RPC on glibc (not on libtirpc): rpc_pmap_set,
rpc_pmap_unset, rpc_svc_register. NOTE glibc implementation is fading out,
nothing really important.

Before I just disable these tests, I've asked the experts [1] and posted
patchset to show some debug info.

Kind regards,
Petr

[1] https://sourceforge.net/p/libtirpc/mailman/message/37014386/
[2] https://patchwork.ozlabs.org/project/ltp/list/?series=177741&state=*
