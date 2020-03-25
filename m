From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Wed, 25 Mar 2020 18:42:51 +0800
Subject: [LTP] [PATCH 2/2] Use SAFE_RUNCMD()
In-Reply-To: <20200325093427.GA23023@dell5510>
References: <303d1019-f836-b2ae-ce51-d2c46dd7fb1e@cn.fujitsu.com>
 <20200323113738.GA4807@dell5510>
 <CAEemH2fhRYefq_9LmSmDvujS1OQa7rCeF7V=mJQrLhz0bwpo0A@mail.gmail.com>
 <CAEemH2e4sRwZ8HRm-w5CD=Wm8-SW+LaA5XHDnXdqrOL1t4FdtA@mail.gmail.com>
 <20200323160415.GC15673@dell5510> <20200324235150.GC4521@yuki.lan>
 <20200324172102.GA1307@dell5510> <20200325015324.GA15127@yuki.lan>
 <CAEemH2doL4m4-TLBBWTHygTRPSTa68dkoAFjZJrDmzrkmgUrSQ@mail.gmail.com>
 <20200325170739.GA2461@yuki.lan> <20200325093427.GA23023@dell5510>
Message-ID: <1dea6ff2-f32d-c797-b52d-716efe73d4a6@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,Li, Cyril

> Hi Li, Metan,
> 
>>> And this makes me think more of the '.request_hugepages' story. The
>>> needs_foo flags require the foo to be present on the system as hard
>>> requirements. In some situations(i.e copy_file_range02.c), we probably need
>>> to handle the soft situation, which means, the commands are only part of
>>> the test requirement. So if it writing with .needs_cmds="xxx", it might
>>> skip the whole test in setup() phase.
> +1. This is similar to a general problem how to structure tests when you want to
> use tst_brk() and cleanup function (having more unrelated tests in single C file
> means one should try to avoid using tst_brk() when not needed).
> 
>> Indeed, there are couple of solutions for that, one of them would have
>> all the arrays doubled and one of them would list hard requirement while
>> the other soft requirements. Then we will end up with something as
>> "need_cmds" and "wants_cmds". The second one would be more or less
>> informative, the test may print a message "Missing foo command test
>> coverage will be limited".
> I was thinking about it and thought that would be too rich API (given there is
> not that much external dependencies for C tests). But ok, sounds reasonable.
> 
> Also similar use case from shell tests: mostly $TST_NEEDS_CMDS is used,
> which stop whole testing. But rarely (only in 3 tests and tst_net.sh) is used
> tst_require_cmds() directly - it's a hard requirement, but it tries to run some
> test before (or require it only when it's needed - tst_net.sh).
> But that's bad from metadata point of view (you concentrate on metadata in C,
> but sooner or later we'll need to handle shell as well).
I have seen the history about this problem. We have few C cases to use 
many commands(copy_file_range02.c is a specify case, I ported it from 
xfstest to increase coverage), do we really want to implement need_cmd 
or want_cmds(Usually, we seldom use command in c case and  we should 
avoid this for reduce unnecessary dependencies, except user level 
command such as mkfs or makeswap or useradd)? It will give user a mislead.

ps:copy_file_range02.c should use swapon and swapoff syscall instead of 
command.

Best Regards
Yang Xu
> 
> Kind regards,
> Petr
> 
> 


