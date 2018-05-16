From: Anton Smorodskyi <asmorodskyi@suse.de>
Date: Wed, 16 May 2018 15:05:16 +0200
Subject: [LTP] [PATCH v2 1/1] ipneigh : Use new API
In-Reply-To: <20180516090947.nkoa6lhtu2rj4x52@dell5510>
References: <20180514114930.9350-1-asmorodskyi@suse.com>
 <20180516090947.nkoa6lhtu2rj4x52@dell5510>
Message-ID: <dec4e6fc-4d4c-fa1d-34f6-e5dad515440c@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi Petr,

Thanks for review !


> I'm sorry to NACK your patch, there needs to be some changes to done.
>
> Some change I'd like to have is to pass this script command (-c [ arp | ip ]) and run test
> only once, i.e. TST_CNT=1 (then it does not need to be included).
> Then in runtest files it'd be:
>
> diff --git runtest/net.ipv6 runtest/net.ipv6
> -ipneigh601 ipneigh01.sh -6
> +ipneigh6_ip ipneigh01.sh -6 -c ip
> diff --git runtest/net.tcp_cmds runtest/net.tcp_cmds
> -ipneigh01 ipneigh01.sh
> +ipneigh01_arp ipneigh01.sh -c arp
> +ipneigh01_ip ipneigh01.sh -c ip
>
> By this test is 1) cleaner 2) we get rid of TCONF for IPv6.

ok , make sense .

>> +			tst_res TCONF "'arp cmd doesn't support IPv6, skipping test-case"
> You still do TCONF.
Yes and it make perfect sense now because I am doing exit just after 
this message , so it is ok
>
>>   		ping$TST_IPV6 -q -c1 $rhost > /dev/null
> It looks to me better using tst_ping() from tst_net.sh (API function, other tests use it).
> Then we could get rid of checking in do_setup:
> tst_check_cmds arp grep ping$TST_IPV6
ok , was not aware about that , will change this
-- 

Anton Smorodskyi <asmorodskyi@suse.com>
QA Engineer
SUSE Linux GmbH, Maxfeldstr. 5, D-90409 Nürnberg
Tel: +49-911-74053-0; Fax: +49-911-7417755;  https://www.suse.com/
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard,
Graham Norton, HRB 21284 (AG Nürnberg)

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180516/db2a3670/attachment.html>
