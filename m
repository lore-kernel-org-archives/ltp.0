From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 12 Sep 2019 17:18:17 +0300
Subject: [LTP] [PATCH v4 0/7] net/route: rewrite route-change-{dst, gw,
 if} into new API
In-Reply-To: <20190912134826.GB22246@dell5510>
References: <20190903141610.28887-1-pvorel@suse.cz>
 <df197557-8f95-52d5-813e-a5abc73a1af6@oracle.com>
 <20190912134826.GB22246@dell5510>
Message-ID: <ed511992-8853-b7ca-9a8a-84c98f26887d@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 9/12/19 4:48 PM, Petr Vorel wrote:
> Hi Alexey,
> 
> first, thanks for your review.
> 
> ..
>>> this version address functionality problems you pointed out.
>>> But yet there might need to be another version as I'm not sure about
>>> tst_ipaddr_un() API changes.
> 
>>> Changes v3-v4:
>>> * enhanced tst_ipaddr_un() with -b, -h -l, -m, -n and -p options (-p was
>>> previous -m)
>>> * use tst_ipaddr_un() options to fix address clash on host_id, net_id clash fix
>>> by adjusting $1 in test (this is really inconsistent, see note at 3/7).
>>> * added tests for tst_ipaddr_un()
>>> * quiet EXPECT_PASS ping$TST_IPV6
> 
> 
>> The patch-set looks good, the only concerns are:
> 
>> * complicated tst_ipaddr_un(), may be add another high-level function
>>   to use raw tst_ipadd_un(), if -b, -f, -n options are really needed?
> Sure. I'll keep only -l and -m and drop -b, -f, -n and -h as not needed ATM.
> And add them via high-level function only if needed.
> 
> In that case I'd like to have -l and -m functionality also for NET_ID (already
> needed in route-change-dst.sh). But not sure which options would be for it
> (it'd be easy with long opts, but we don't want to depend on /usr/bin/getopt,
> nor to parse it manually although of course doable)
> 
> Another option is to have single option for adding both MAX and MIN:
> 
> -h MIN,MAX # for HOST_ID
> -n MIN,MAX # for NET_ID
> 
> (e.g. -n5,255 -h1,255)
>

It can be the best option,

 
> But it looks to me a bit uncomfortable having to always to add both min and max.

max "-n ,254" or min "-n 2"?


> 
>> * if NS_TIMES is large, there are a lot of messages in a test output
>>   (it seems NS_TIMES * 4), could we minimize the number of them?
> 
> I can add -q option to tst_add_ipaddr() which usage will make it NS_TIMES * 2. (1)
> If it's still too much I'll drop "testing route over ..." (2)
> Other option would be to print only even Nth iteration (I don't think it's a
> good idea) or even has only single TPASS/TFAIL.
> 
> BTW don't we want end testing on first failure?

Agree, why not.


> 
> 
> Kind regards,
> Petr
> 

