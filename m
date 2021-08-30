From: Xie Ziyao <ziyaoxie@outlook.com>
Date: Mon, 30 Aug 2021 23:34:23 +0800
Subject: [LTP] [PATCH] epoll_creat01: Replace TST_PASS with TST_RET
In-Reply-To: <YSzwIwm7q533tlpD@yuki>
References: <OSZP286MB087168E8DE5E0E49C9F90E27CCC89@OSZP286MB0871.JPNP286.PROD.OUTLOOK.COM>
 <YSzwIwm7q533tlpD@yuki>
Message-ID: <OSZP286MB0871D6BC61046333773018F1CCCB9@OSZP286MB0871.JPNP286.PROD.OUTLOOK.COM>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi, Cyril,

> Hi!
>> diff --git a/testcases/kernel/syscalls/epoll_create/epoll_create01.c b/testcases/kernel/syscalls/epoll_create/epoll_create01.c
>> index 54fd0810d..29ac3763e 100644
>> --- a/testcases/kernel/syscalls/epoll_create/epoll_create01.c
>> +++ b/testcases/kernel/syscalls/epoll_create/epoll_create01.c
>> @@ -26,9 +26,8 @@ static void run(unsigned int n)
>>   {
>>   	TST_EXP_FD(tst_syscall(__NR_epoll_create, tc[n]), "epoll_create(%d)", tc[n]);
>>
>> -	if (!TST_PASS)
>> -		return;
>> -	SAFE_CLOSE(TST_PASS);
>> +	if (TST_RET)
>> +		SAFE_CLOSE(TST_RET);
>>   }
> Isn't this broken as well?
>
> As far as I can tell the if (!TST_PASS) part in the test is correct and
> we only have to change the TST_PASS to TST_RET in the SAFE_CLOSE().

Agree with you. By the way, would you mind helping to modify it?

Thanks a lot.

>
> So we should apply:
>
> diff --git a/testcases/kernel/syscalls/epoll_create/epoll_create01.c b/testcases/kernel/syscalls/epoll_create/epoll_create01.c
> index 54fd0810d..3ef5b5cac 100644
> --- a/testcases/kernel/syscalls/epoll_create/epoll_create01.c
> +++ b/testcases/kernel/syscalls/epoll_create/epoll_create01.c
> @@ -28,7 +28,7 @@ static void run(unsigned int n)
>
>          if (!TST_PASS)
>                  return;
> -       SAFE_CLOSE(TST_PASS);
> +       SAFE_CLOSE(TST_RET);
>   }
>
>   static struct tst_test test = {
>
>
-- 
Best Regards,
Xie Ziyao
E-mail: ziyaoxie@outlook.com

