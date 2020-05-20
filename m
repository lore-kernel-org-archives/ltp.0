From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 20 May 2020 15:25:01 +0200
Subject: [LTP] [PATCH] tirpc: Pass all extra client options to client
 program
In-Reply-To: <20200520072605.12614-1-yangx.jy@cn.fujitsu.com>
References: <20200520072605.12614-1-yangx.jy@cn.fujitsu.com>
Message-ID: <20200520132501.GA22418@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Yang,

> New rpc_test.sh only passes the first extra client option to
> client program if extra client options are two or more.
> For example, only "1" is passed into tirpc_rpc_broadcast_exp:
> -------------------------------------------
> ./runltp -f net.tirpc_tests -s tirpc_rpc_broadcast_exp
> ...
> tag=tirpc_rpc_broadcast_exp stime=1589957933
> cmdline="rpc_test.sh -s tirpc_svc_1 -c tirpc_rpc_broadcast_exp -e "1 2""
> ...
> rpc_test 1 TFAIL: tirpc_rpc_broadcast_exp 10.0.0.2 536875000 1 failed unexpectedly
> -------------------------------------------
> For extra client options, use comma as a delimiter in net.tirpc_tests
> and replace it with white space in rpc_test.sh

> Fixes: 3190368d2df8 ("rpc/rpc_test.sh: Rewrite into new shell API")
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>

Thanks a lot for a fix!

I replaced bashism in OPTARG handling with sed (otherwise it'd fail on dash) and
merged.

Kind regards,
Petr
