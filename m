From: Zouwei (Samuel) <zou_wei@huawei.com>
Date: Thu, 19 Mar 2020 01:26:13 +0000
Subject: [LTP] =?gb2312?b?tPC4tDogIFtQQVRDSF0gb3Blbl9wb3NpeF90ZXN0c3Vp?=
 =?gb2312?b?dGU6IEZpeCBjb21waWxhdGlvbiBpc3N1ZXM=?=
In-Reply-To: <20200317205205.GA23447@yuki.lan>
References: <1584430031-47227-1-git-send-email-zou_wei@huawei.com>
 <20200317205205.GA23447@yuki.lan>
Message-ID: <C3CD0DF8AD11A84CB25A1426DE537C61E5911584@dggeml524-mbx.china.huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

So we need to add -pthread to both CFLAGS and LDFLAGS to avoid the compilation and linking problem?

Best Regards
Zou Wei

-----????-----
???: Cyril Hrubis [mailto:chrubis@suse.cz] 
????: 2020?3?18? 4:52
???: Zouwei (Samuel) <zou_wei@huawei.com>
??: ltp@lists.linux.it
??: Re: [LTP] [PATCH] open_posix_testsuite: Fix compilation issues

Hi!
> Fix compilation issues:
> 1. Add the '-lpthread -lrt -lm' config into LDFLAGS

Just linking with -lpthread is not correct way how to compile pthread programs on Linux, we have to add -pthread to both CLFAGS and LDFLAGS.

I guess that we should also default to the output of getconf for pthread CFLAGS and LDFLAGS if available[1]. Unfortunately it looks like this is not implemented on Linux yet.

So if getconf fails we will have to probably fallback to per-OS table of CFLAGS and LDFLAGS.

[1] https://pubs.opengroup.org/onlinepubs/9699919799/utilities/c99.html#tagtcjh_25

--
Cyril Hrubis
chrubis@suse.cz
