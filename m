From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Wed, 25 Jan 2017 12:02:50 +0800
Subject: [LTP] [PATCH 2/2] ltp-aiodio/dio_sparse: Fix usleep in
	read_sparse()
In-Reply-To: <20170124134351.GD29054@rei.lan>
References: <1484818349-30539-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
 <1484818349-30539-2-git-send-email-fenggw-fnst@cn.fujitsu.com>
 <20170124134351.GD29054@rei.lan>
Message-ID: <5888236A.1010702@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

Thanks for your review.

On 01/24/2017 09:43 PM, Cyril Hrubis wrote:
> Hi!
>> diff --git a/testcases/kernel/io/ltp-aiodio/common_sparse.h b/testcases/kernel/io/ltp-aiodio/common_sparse.h
>> index f7f4ef4..a7f5035 100644
>> --- a/testcases/kernel/io/ltp-aiodio/common_sparse.h
>> +++ b/testcases/kernel/io/ltp-aiodio/common_sparse.h
>> @@ -123,7 +123,7 @@ static void read_sparse(char *filename, int filesize)
>>  			fprintf(stderr, "Child %i waits for '%s' to appear\n",
>>  			        getpid(), filename);
>>  
>> -		usleep(100000);
>> +		usleep(10);
> 
> Isn't 10us too small? Also we really should increase the number of the
> loop iterations if we reduce the sleep as much.
> 

Most of the time child works well by usleep(100), but there is still
a small chance that it misses the test on my system...

OK, I will also increase the loop number and send a V2.
Thanks.

Best Regards,
Guangwen Feng

>>  	}
>>  
>>  	if (fd == -1) {
>> -- 
>> 1.8.4.2
>>
>>
>>
>>
>> -- 
>> Mailing list info: https://lists.linux.it/listinfo/ltp
> 


