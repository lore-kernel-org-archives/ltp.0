From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Fri, 29 May 2020 13:39:00 +0800
Subject: [LTP] [PATCH 1/5] syscalls:ipc: Move libraries to libs/ director
In-Reply-To: <20200526030854.xocwohgiyg3p5edh@vireshk-i7>
References: <cover.1590057824.git.viresh.kumar@linaro.org>
 <3b3344651f2ba4bf2446b6730a76ebcd9f894dd0.1590057824.git.viresh.kumar@linaro.org>
 <20200522123903.GB2446@yuki.lan> <20200526030854.xocwohgiyg3p5edh@vireshk-i7>
Message-ID: <b11c6ca2-7b63-0c12-3491-8b76f9940d2e@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi  Cyril

> On 22-05-20, 14:39, Cyril Hrubis wrote:
>> Hi!
>>> Move the ipc libraries to libs/ directory. One of the reasons to do this
>>> was to add the capability of adding tests with both old and new test
>>> frameworks in the same ipc test directory.
>>
>> Pushed with following diff, thanks.
>>
>> 1) You cannot build two different libs in one directory
>> 2) Setting LTPLIBS instead of LDFLAGS generates proper build
>>     dependencies as well
>> 3) Limit the linker flags for the kill and mremap tests
> 
> I don't think you pushed the changes you made. I still see my original
> patch there. :)
It looks like you miss this change. It still uses
LDFLAGS instead of correct LTPLIBS.

Best Regards
Yang Xu
> 


