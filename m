From: Xiao Yang <ice_yangxiao@163.com>
Date: Mon, 17 Aug 2020 23:00:57 +0800
Subject: [LTP] [PATCH 2/2] syscalls/sigsuspend01.c: Convert to the new
 API
In-Reply-To: <20200817143309.GD8445@yuki.lan>
References: <20200815051312.25002-1-yangx.jy@cn.fujitsu.com>
 <20200815051312.25002-2-yangx.jy@cn.fujitsu.com>
 <20200817143309.GD8445@yuki.lan>
Message-ID: <3d53b40a-5c4d-71c2-34e8-80f573662b42@163.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 8/17/20 10:33 PM, Cyril Hrubis wrote:
> Hi!
> Pushed with a few fixes, thanks.
>
>> +static void setup(void)
>>   {
>> +	struct sigaction sa_new;
>>   
>> +	SAFE_SIGEMPTYSET(&signalset);
>> +	SAFE_SIGEMPTYSET(&sigset1);
>> +	SAFE_SIGADDSET(&sigset1, SIGALRM);
>> +
>> +	sa_new.sa_handler = sig_handler;
>> +	SAFE_SIGACTION(SIGALRM, &sa_new, 0);
> Here you were passing random data to the sigaction() function, as the
> sa_new was created on a stack and only sa_handler was set.
>
> Which, for instance, breaks the test in a case of the -i 2 option, since
> if you were unlucky the SA_RESETHAND was set in the sa_new and the
> signal handler was uninstalled after the first signal was handled and
> the test process was killed by SIGALRM when the signal arrived for a
> second time.
>
> In short there was all kind of mess passed down the call, on strace it
> looked as:
>
> [pid 3245] rt_sigaction(SIGALRM, {sa_handler=0x557469b59c20, sa_mask=[HUP INT QUIT ILL ABRT USR1 ALRM TERM CHLD TSTP TTOU URG VTALRM PROF WINCH PWR SYS RT_1 RT_2 RT_3 RT_4 RT_6 RT_10 RT_12 RT_13 RT_14 RT_18 RT_20 RT_21 RT_22], sa_flags=SA_RESTORER|SA_ONSTACK|SA_RESTART|SA_NODEFER|SA_RESETHAND|0xe9e4e8, sa_restorer=0x7f26dc368b40}, NULL, 8) = 0
>
> So I changed it to:
>
> 	struct sigaction sa_new = {
> 		.sa_handler = sig_handler
> 	};
>
> Which will clears the rest of the structure.

Hi Cyril,

Got it, thanks a lot for the detailed explanation. :-)

Best Regards,

Xiao Yang

>
>> +	/* Block SIGALRM */
>> +	SAFE_SIGPROCMASK(SIG_SETMASK, &sigset1, NULL);
>>   }
>> +
>> +static struct tst_test test = {
>> +	.setup = setup,
>> +	.test_all = verify_sigsuspend,
>> +};

