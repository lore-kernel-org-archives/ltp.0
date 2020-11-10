From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Tue, 10 Nov 2020 10:56:17 +0800
Subject: [LTP] [PATCH] pan/ltp-pan.c: fix file descriptors leaks
In-Reply-To: <5FA9ED44.7080909@cn.fujitsu.com>
References: <1604925271-4811-1-git-send-email-zhufy.jy@cn.fujitsu.com>
 <20201109125938.GC9991@yuki.lan> <5FA9ED44.7080909@cn.fujitsu.com>
Message-ID: <5FAA0151.3030002@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril
> Hi Cyril, Feiyu
>> Hi!
>>> ltp-pan will leak file descriptors of fopen() into the child process
>>> of the test case, fix this problem by using mode "e" for fopen().
>>
>> Looks good, however this is supported since glibc 2.7 and it does not
>> seem to be supported on musl libc either.
>>
> Yes, musl-libc doesn't support "e" mode for fopen[1].
Sorry, I ignore __fmodeflags function, musl libc supports "e" mode since 
0.9.7 after this commit 8582a6e9f ("add 'e' modifier (close-on-exec) to 
fopen and fdopen").

https://git.musl-libc.org/cgit/musl/commit/src?id=8582a6e9f25dd7b87d72961f58008052a4cac473

It is about 8 years since musl libc fopen() supports "e". glibc2.7 
fopen() supports "e" is about 13 years.  Maybe we can use "e" mode now?
>
> [1]https://git.musl-libc.org/cgit/musl/tree/src/stdio/fopen.c
>> I guess that it would be better just to close these files after a fork
>> in the runchild() function, but that would mean that we would have to
>> pass all these files as paramters to the function as well.
> +1
>>
>
>
>
>



