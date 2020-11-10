From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Tue, 10 Nov 2020 09:30:44 +0800
Subject: [LTP] [PATCH] pan/ltp-pan.c: fix file descriptors leaks
In-Reply-To: <20201109125938.GC9991@yuki.lan>
References: <1604925271-4811-1-git-send-email-zhufy.jy@cn.fujitsu.com>
 <20201109125938.GC9991@yuki.lan>
Message-ID: <5FA9ED44.7080909@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril, Feiyu
> Hi!
>> ltp-pan will leak file descriptors of fopen() into the child process
>> of the test case, fix this problem by using mode "e" for fopen().
>
> Looks good, however this is supported since glibc 2.7 and it does not
> seem to be supported on musl libc either.
>
Yes, musl-libc doesn't support "e" mode for fopen[1].

[1]https://git.musl-libc.org/cgit/musl/tree/src/stdio/fopen.c
> I guess that it would be better just to close these files after a fork
> in the runchild() function, but that would mean that we would have to
> pass all these files as paramters to the function as well.
+1
>



