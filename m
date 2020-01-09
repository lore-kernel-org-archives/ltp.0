From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 9 Jan 2020 11:19:09 +0100
Subject: [LTP] LTP Release plans
In-Reply-To: <20200106150329.GC26880@rei.lan>
References: <20191213125435.GB20795@rei.lan> <20200106150329.GC26880@rei.lan>
Message-ID: <20200109101909.GD23230@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> Anything else I should look at?
I'd like to have TI-RPC related patch-set

* RFC,1/1] rpc-tirpc: Remove authdes related tests
https://patchwork.ozlabs.org/patch/1216506/
Acked by Li, waiting for Steve (libtirpc maintainer) to be acked.

And if you have time then this one (not that important, fixing
https://github.com/linux-test-project/ltp/pull/628
and adding libntirpc support):
* TI-RPC: enhancements (pkg-config, libntirpc, travis)
https://patchwork.ozlabs.org/project/ltp/list/?series=151849
(first 2 commits are relevant, the others are travis)

Thanks!

Kind regards,
Petr
