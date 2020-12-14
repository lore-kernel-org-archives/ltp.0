From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Mon, 14 Dec 2020 09:32:41 +0000
Subject: [LTP] [PATCH v2] pty04: Limit the number of packets sent to
 avoid timeout
In-Reply-To: <20201105155400.GA15701@yuki.lan>
References: <875z6m5rib.fsf@suse.de>
 <20201104163528.13833-1-rpalethorpe@suse.com>
 <20201105155400.GA15701@yuki.lan>
Message-ID: <87sg88hgw6.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
>> +static ssize_t try_async_write(int fd, const char *data, ssize_t size,
>> +			       ssize_t *done)
>>  {
>> -	ssize_t ret = write(fd, data, size);
>> +	ssize_t off = done ? *done : 0;
>> +	ssize_t ret = write(fd, data + off, size - off);
>>  
>>  	if (ret < 0)
>>  		return -(errno != EAGAIN);
>>  
>> -	return !written || (*written += ret) >= size;
>> +	if (!done)
>> +		return 1;
>> +
>> +	*done += ret;
>> +	return *done >= size;
>> +}
>> +
>> +static ssize_t try_async_read(int fd, char *data, ssize_t size,
>> +			      ssize_t *done)
>> +{
>> +	ssize_t off = done ? *done : 0;
>> +	ssize_t ret = read(fd, data + off, size - off);
>> +
>> +	if (ret < 0)
>> +		return -(errno != EAGAIN);
>> +
>> +	if (!done)
>> +		return 1;
>> +
>> +	*done += ret;
>> +	return *done >= size;
>>  }
>>  
>> -static void write_pty(const struct ldisc_info *ldisc)
>> +#define RETRY_ASYNC(fn) ({				      \
>> +	ssize_t done = 0;				      \
>> +	TST_RETRY_FUNC(try_async_##fn(ptmx, data, len, &done),\
>> +		       TST_RETVAL_NOTNULL);		      \
>> +})
>
> I do not like this macro that much. Maybe we can have two inline
> functions here one for read and one for write.

OK.

>
> So we do have one process that just reads and one that reads and writes
> right? I wonder if that is okay, maybe we should write twice as much as
> we read in the do_pty()?
>
> Other than that it looks fine.

They both read and write in the final loop. I will make this clearer in
the final while loop.

-- 
Thank you,
Richard.
