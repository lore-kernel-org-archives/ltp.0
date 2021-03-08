From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Mon, 08 Mar 2021 14:50:15 +0000
Subject: [LTP] [PATCH 2/6] fzsync: Reset delay bias
In-Reply-To: <YEYxwOr3tOJdnz+j@yuki.lan>
References: <20210305155123.18199-1-rpalethorpe@suse.com>
 <20210305155123.18199-3-rpalethorpe@suse.com> <YEYxwOr3tOJdnz+j@yuki.lan>
Message-ID: <87eegphf88.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
>> If the delay bias a preserved then it breaks tests which have multiple
>                     ^
> 		    is?

Yup, typo.

>
>> scenarios and/or use -i. The test author could reset it manually in
>> this case, but it's likely to be error prone.
>>
>> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
>
> Other than that this looks OK.
>
> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
>
>> ---
>>  include/tst_fuzzy_sync.h | 1 +
>>  1 file changed, 1 insertion(+)
>> 
>> diff --git a/include/tst_fuzzy_sync.h b/include/tst_fuzzy_sync.h
>> index 4141f5c64..b8841d96d 100644
>> --- a/include/tst_fuzzy_sync.h
>> +++ b/include/tst_fuzzy_sync.h
>> @@ -289,6 +289,7 @@ static void tst_fzsync_pair_reset(struct tst_fzsync_pair *pair,
>>  	tst_init_stat(&pair->diff_ab);
>>  	tst_init_stat(&pair->spins_avg);
>>  	pair->delay = 0;
>> +	pair->delay_bias = 0;
>>  	pair->sampling = pair->min_samples;
>>  
>>  	pair->exec_loop = 0;
>> -- 
>> 2.30.1
>> 
>> 
>> -- 
>> Mailing list info: https://lists.linux.it/listinfo/ltp


-- 
Thank you,
Richard.
