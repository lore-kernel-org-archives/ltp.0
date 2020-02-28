From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 28 Feb 2020 09:58:59 +0100
Subject: [LTP] Query: Adding support for clone3()
In-Reply-To: <CAKohponuu3zpsQCv0v1_Yqb_tmqy5yyUejMoS1_M_UFf5FU2Mw@mail.gmail.com>
References: <CAKohponuu3zpsQCv0v1_Yqb_tmqy5yyUejMoS1_M_UFf5FU2Mw@mail.gmail.com>
Message-ID: <20200228085859.GA31181@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I was looking to start implementation of clone3() syscall in LTP
> and am a bit confused here and need your help in doing the same.
> 
> LTP abstracts the call to clone() syscall in lib/cloner.c and the current
> prototype of it looks like this.
> 
>        int clone(int (*fn)(void *), void *stack, int flags, void *arg, ...
>                  /* pid_t *parent_tid, void *tls, pid_t *child_tid */ );

This function is there mostly for implementation of container testscases
so that they does not need to deal with the clone() syscall complexity.

> One of the challenges with the implementation of clone3() is that
> there is no glibc wrapper available. And in case of clone() glibc
> wrapper isn't ordinary as it takes care of calling fn() and handling
> few stack related things, apart from calling the real syscall.
> 
> I am confused now on how should I write support for clone3().
> 
> Any suggestions will be appreciated. Thanks.

Let's just add the code into lapi/clone.h, would that work for you?

-- 
Cyril Hrubis
chrubis@suse.cz
