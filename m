From: Xiao Yang <ice_yangxiao@163.com>
Date: Sat, 7 Nov 2020 00:14:22 +0800
Subject: [LTP] [PATCH 1/4] syscalls/sync01: Remove it
In-Reply-To: <20201106123604.GA30097@yuki.lan>
References: <1603691317-22811-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <5FA21AA9.9020208@cn.fujitsu.com> <20201106123604.GA30097@yuki.lan>
Message-ID: <0bc685ce-1983-b900-787f-3d89e75ca48d@163.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 11/6/20 8:36 PM, Cyril Hrubis wrote:
> Hi!
>> Ping. I think this patchset is simple.
> Great cleanup, pushed, thanks.

Hi Cyril, Petr


I have a doubt after reading Xu's patch[1] and Martin's patch[2]:

1) Xu removed sync01 because sync() always return 0.

2) On error, normal syscall always return -1 but Martin added a check 
for undefined return value(i.e. negative value except -1).

Is it necessary to check undefined return value?


Patches:

[1]: [PATCH 1/4] syscalls/sync01: Remove it

[2]: [PATCH 03/19] Unify error handling in lib/tst_safe_timerfd.c


Best Regards,

Xiao Yang

>

