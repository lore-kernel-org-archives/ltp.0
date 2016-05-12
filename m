From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Thu, 12 May 2016 14:09:50 +0300
Subject: [LTP] [PATCH 2/4] memcg_process_stress: allocate memory not in
 the signal handler
In-Reply-To: <20160511143913.GH24701@rei.lan>
References: <1461338590-1309-1-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1461338590-1309-2-git-send-email-stanislav.kholmanskikh@oracle.com>
 <20160511143913.GH24701@rei.lan>
Message-ID: <5734647E.2040801@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!

On 05/11/2016 05:39 PM, Cyril Hrubis wrote:
> Hi!
>> -static void sigusr_handler(int __attribute__ ((unused)) signo)
>> +static void alloc_memory(void)
>>   {
>>   	int i;
>>   	int pagesize;
>>
>>   	pagesize = sysconf(_SC_PAGE_SIZE);
>>
>> -	nr_page = ceil((double)memsize / pagesize);
>> +	nr_page = memsize / pagesize;
>
> This will cause to allocate one less page than the previous code in case
> that memsize % pagesize != 0.
>
> ceil((double)memsize/pagesize) == (memsize + pagesize - 1)/pagesize
>
> In case that you want to avoid floating point.
>
>>   	pages = calloc(nr_page, sizeof(char *));
>>   	if (pages == NULL)
>> @@ -62,7 +54,18 @@ static void sigusr_handler(int __attribute__ ((unused)) signo)
>>   		if (pages[i] == MAP_FAILED)
>>   			err(1, "mmap");
>>   	}
>> +}
>>
>> +static void touch_memory(void)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < nr_page; i++)
>> +		pages[i][0] = 0xef;
>> +}
>> +
>> +static void sigusr_handler(int __attribute__ ((unused)) signo)
>> +{
>>   	flag_ready = 1;
>>   }
>>
>> @@ -76,6 +79,7 @@ int main(int argc, char *argv[])
>>   	char *end;
>>   	struct sigaction sigint_action;
>>   	struct sigaction sigusr_action;
>> +	int allocated = 0;
>>
>>   	if (argc != 3)
>>   		errx(1, "wrong argument num");
>> @@ -102,8 +106,14 @@ int main(int argc, char *argv[])
>>   	while (!flag_exit) {
>>   		sleep(interval);
>>
>> -		if (flag_ready)
>> +		if (flag_ready) {
>> +			if (!allocated) {
>> +				alloc_memory();
>> +				allocated = 1;
>> +			}
>> +
>>   			touch_memory();
>> +		}
>>   	}
>
>
> We can do even better if we change the sleep() for pause().

Thank you for the review. I agree with all other comments to this 
series, except this one.

I'd keep sleep() here, because it allows the process to perform a series 
of touch_memory() invocations before it receives the final SIGINT signal.



>
>>   	return 0;
>
> Otherwise it looks good.
>
