From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Fri, 12 Jul 2019 12:34:06 +0800
Subject: [LTP] [PATCH RESEND] syscalls/prctl06.c: New test for prctl()
 with PR_{SET, GET}_NO_NEW_PRIVS
In-Reply-To: <20190711113405.GA27889@rei.lan>
References: <20190709105303.GA4914@rei.lan>
 <1562366936-26456-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20190710105207.GC30934@rei.lan> <5D26EBEF.3090604@cn.fujitsu.com>
 <20190711113405.GA27889@rei.lan>
Message-ID: <5D280DBE.4010202@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> Hi!
>>> We are executing setuid binary that was created by root here so
>>> shouldn't we just check that getuid() and getgid() returns 0?
>>>
>> I try it.  whether we set or not set new privs, the getuid() or getgid() return nobody in
>> prctl06_execve.  Or, I misunderstand your advise?
> Looking closely into the manuals the setuid and setgid bits are supposed
> to set the effective ids, so I guess that the geteuid() and getegid()
> will return 0 when the process was executed without the prctl().
>

Hi Cyril

Yes. I will remove capeff and setuid,setgid check in my v3 patch.  For the prctl value
and check that it cannot be unset, I think it is a error test as manpage said
"prctl() fails with EINVAL when options is PR_SET_NO_NEW_PRIVS&  arg2 is not equal to 1 or arg3, arg4, or arg5 is nonzero."

I will add it into prctl02.c.  Also, there are many error conditions for prctl. So I think when my prctl07.c are merged into

ltp, I will increase prctl02.c together.

Thanks
Yang Xu



