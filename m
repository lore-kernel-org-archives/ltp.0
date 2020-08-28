From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Fri, 28 Aug 2020 17:34:46 +0800
Subject: [LTP] [PATCH] tst_af_alg: fix build error when
 ALG_SET_AEAD_ASSOCLEN undefined
In-Reply-To: <20200828084818.GB1648@dell5510>
References: <1598005119-2147-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20200828084818.GB1648@dell5510>
Message-ID: <373798f7-d1e4-330a-0911-efcd6f1d1480@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr

> Hi,
> 
> ...
>> --- a/configure.ac
>> +++ b/configure.ac
>> @@ -193,6 +193,12 @@ AC_CHECK_TYPES([struct xt_entry_match, struct xt_entry_target],,,[
>>   #include <linux/netfilter_ipv4/ip_tables.h>
>>   ])
> 
>> +AC_CHECK_TYPES([struct sockaddr_alg, struct af_alg_iv],,,[
>> +#ifdef HAVE_LINUX_IF_ALG_H
>> +# include <linux/if_alg.h>
>> +#endif
> IMHO <linux/if_alg.h> does not need to be guarded.
> (as the definitions are in it it either fail because missing or fail because not
> loaded)
>> +])
Yes. Do you merge this patch with deleting this ifdef? Or I sent a v2 
patch for this.

Also, I think you can remove" #ifdef HAVE_LINUX_IF_PACKET_H" pair in 
configure.ac
AC_CHECK_TYPES([struct tpacket_req3],,,[
#ifdef HAVE_LINUX_IF_PACKET_H
# include <linux/if_packet.h>
#endif
])

Best Regards
Yang Xu

>> +
>>   # Tools knobs
> ...
> 
> Kind regards,
> Petr
> 
> 


