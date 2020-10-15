From: John Ogness <john.ogness@linutronix.de>
Date: Thu, 15 Oct 2020 12:05:42 +0206
Subject: [LTP] [PATCH] printk: ringbuffer: Wrong data pointer when
 appending small string
In-Reply-To: <20201015063137.GA3668@jagdpanzerIV.localdomain>
References: <CA+G9fYt46oC7-BKryNDaaXPJ9GztvS2cs_7GjYRjanRi4+ryCQ@mail.gmail.com>
 <20201014140514.GB17231@alley> <20201014151311.GB13775@alley>
 <20201014175051.GC13775@alley>
 <20201015063137.GA3668@jagdpanzerIV.localdomain>
Message-ID: <875z7bhks1.fsf@jogness.linutronix.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2020-10-15, Sergey Senozhatsky <sergey.senozhatsky@gmail.com> wrote:
>> diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
>> index 2493348a1631..24a960a89aa8 100644
>> --- a/kernel/printk/printk_ringbuffer.c
>> +++ b/kernel/printk/printk_ringbuffer.c
>> @@ -1125,7 +1125,10 @@ static char *data_realloc(struct printk_ringbuffer *rb,
>>  
>>  	/* If the data block does not increase, there is nothing to do. */
>>  	if (head_lpos - next_lpos < DATA_SIZE(data_ring)) {
>> -		blk = to_block(data_ring, blk_lpos->begin);
>> +		if (wrapped)
>> +			blk = to_block(data_ring, 0);
>> +		else
>> +			blk = to_block(data_ring, blk_lpos->begin);
>>  		return &blk->data[0];
>>  	}
>
> Great catch.

Indeed. I don't know how we missed that one. :-/

Reviewed-by: John Ogness <john.ogness@linutronix.de>
