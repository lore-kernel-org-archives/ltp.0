From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 20 May 2020 22:17:01 +0800
Subject: [LTP] [PATCH] tirpc: Pass all extra client options to client
 program
In-Reply-To: <20200520132501.GA22418@dell5510>
References: <20200520072605.12614-1-yangx.jy@cn.fujitsu.com>
 <20200520132501.GA22418@dell5510>
Message-ID: <5EC53BDD.9050400@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

ON 2020/5/20 21:25, Petr Vorel wrote:
> Hi Yang,
>
>> New rpc_test.sh only passes the first extra client option to
>> client program if extra client options are two or more.
>> For example, only "1" is passed into tirpc_rpc_broadcast_exp:
>> -------------------------------------------
>> ./runltp -f net.tirpc_tests -s tirpc_rpc_broadcast_exp
>> ...
>> tag=tirpc_rpc_broadcast_exp stime=1589957933
>> cmdline="rpc_test.sh -s tirpc_svc_1 -c tirpc_rpc_broadcast_exp -e "1 2""
>> ...
>> rpc_test 1 TFAIL: tirpc_rpc_broadcast_exp 10.0.0.2 536875000 1 failed unexpectedly
>> -------------------------------------------
>> For extra client options, use comma as a delimiter in net.tirpc_tests
>> and replace it with white space in rpc_test.sh
>
>> Fixes: 3190368d2df8 ("rpc/rpc_test.sh: Rewrite into new shell API")
>> Signed-off-by: Xiao Yang<yangx.jy@cn.fujitsu.com>
>
> Thanks a lot for a fix!
>
> I replaced bashism in OPTARG handling with sed (otherwise it'd fail on dash) and
> merged.
Hi Petr,

Thanks for your change.
I will avoid bashism next time.

Best Regards,
Xiao Yang
>
> Kind regards,
> Petr
>
>
> .
>



