From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 18 Jul 2017 15:00:30 +0300
Subject: [LTP] [PATCH v2 1/2] clone08: convert to new LTP API
In-Reply-To: <20170622150117.GB28231@rei.lan>
References: <1496915851-5222-1-git-send-email-alexey.kodanev@oracle.com>
 <20170622150117.GB28231@rei.lan>
Message-ID: <0bbc797e-5691-6964-3ed3-e971b48c7ff5@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 06/22/2017 06:01 PM, Cyril Hrubis wrote:
> Hi!
>>  
>> -	stopped_flag = 0;
>> -	child = clone_child(&test_cases[t], 1);
>> +	child = clone_child(&test_cases[t]);
>>  
>>  	/* give the kernel scheduler chance to run the CLONE_STOPPED thread*/
>>  	for (i = 0; i < 100; i++) {
>> @@ -246,23 +178,22 @@ static void test_clone_stopped(int t)
>>  		usleep(1000);
>>  	}
> Can't we check the /proc/$pid/state here to assert that the child is in
> 'T' state here? We do have PROCESS_STATE_WAIT() for that.

Hi Cyril,

Sure, changed the loop to the macro and applied.

Thanks,
Alexey

> Otherwise this looks good.
>

