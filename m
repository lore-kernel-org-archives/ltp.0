From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Mon, 12 Feb 2018 15:29:25 +0300
Subject: [LTP] [PATCH] openposix: mmap/21-1: adjust the test to work
 with MAP_SHARED_VALIDATE
In-Reply-To: <20180208163453.GA2049@rei>
References: <1518105323-12867-1-git-send-email-stanislav.kholmanskikh@oracle.com>
 <20180208163453.GA2049@rei>
Message-ID: <a6a0ea9a-6552-bdf3-3b31-64e85cb09cbc@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi.

On 02/08/2018 07:34 PM, Cyril Hrubis wrote:
> Hi!
>> +int is_valid(int flag)
>> +{
>> +	if (flag == MAP_SHARED || flag == MAP_PRIVATE || flag == MAP_FIXED)
>> +		return 1;
>> +
>> +#ifdef __linux__
>> +
>> +#ifndef MAP_SHARED_VALIDATE
>> +#define MAP_SHARED_VALIDATE 0x03
>> +#endif
>> +
>> +	if (flag == MAP_SHARED_VALIDATE)
>> +		return 1;
>> +#endif
>> +
>> +	return 0;
>> +}
> 
> Hmm, this probably does not scale up, what about setting the flag to
> have all its bits set (i.e. passing ~0 to the mmap()) from the start
> instead?
> 

In main() we search for the first value of 'flag' for which the
following statement is not true:

flag == MAP_SHARED || flag == MAP_PRIVATE || flag == MAP_FIXED || flag
== MAP_SHARED_VALIDATE

where the last part is Linux-specific and likely needs an #ifdef.

We are not interested if flag has MAP_SHARED or other bits set, but we
are interested when flag _equals_ MAP_SHARED or other values.

In order to make the code more readable (IMHO) I decided to move this
check into a separate function.

I don't fully understand your proposal. Could you, please, elaborate a
bit more?

Thanks.
