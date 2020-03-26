From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Thu, 26 Mar 2020 16:03:23 +0800
Subject: [LTP] [PATCH 2/2] Use SAFE_RUNCMD()
In-Reply-To: <20200325155624.GC21800@dell5510>
References: <CAEemH2fhRYefq_9LmSmDvujS1OQa7rCeF7V=mJQrLhz0bwpo0A@mail.gmail.com>
 <CAEemH2e4sRwZ8HRm-w5CD=Wm8-SW+LaA5XHDnXdqrOL1t4FdtA@mail.gmail.com>
 <20200323160415.GC15673@dell5510> <20200324235150.GC4521@yuki.lan>
 <20200324172102.GA1307@dell5510> <20200325015324.GA15127@yuki.lan>
 <CAEemH2doL4m4-TLBBWTHygTRPSTa68dkoAFjZJrDmzrkmgUrSQ@mail.gmail.com>
 <20200325170739.GA2461@yuki.lan> <20200325093427.GA23023@dell5510>
 <1dea6ff2-f32d-c797-b52d-716efe73d4a6@cn.fujitsu.com>
 <20200325155624.GC21800@dell5510>
Message-ID: <88ebe7aa-58f8-0c83-2d13-7836198827af@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr

> Hi Xu,
> 
>> I have seen the history about this problem. We have few C cases to use many
>> commands(copy_file_range02.c is a specify case, I ported it from xfstest to
>> increase coverage), do we really want to implement need_cmd or
>> want_cmds(Usually, we seldom use command in c case and  we should avoid this
>> for reduce unnecessary dependencies, except user level command such as mkfs
>> or makeswap or useradd)? It will give user a mislead.
> 
>> ps:copy_file_range02.c should use swapon and swapoff syscall instead of
>> command.
> Yes, rewriting to C would be an improvement for non-standard linux platforms
> (but then you need to deal with other exceptions: e.g. whether
> swapon()/swapoff() is even supported on platforms like Android and you might
> endup with 1) much more code 2) TCONF anyway for these platforms.
> And there is also chattr and mkswap.
> 
I missed non-standard linux platforms.
> Besides this IMHO there will always be a need for running some command via
> tst_run_cmd() in the test instead of reimplementing a wheel.
Yes, we can not avoid using command.
> Some of other
> dependencies:
> 
> cat (testcases/cve/stack_clash.c this one could be using C code),
> mpdprobe, make, mkswap, quotacheck,
> useradd/userdel (I plan to put these into the library, but still it's much
> easier to use them than reimplement code in C).
Yes, it is fast and efficient.

Also as Li said, we can write code firstly(add_key05 can use library a 
api int the future as your issue#468 mentioned).

Best Regards
Yang Xu
> 
> Also library itself (these will not use the flag): insmod, modprobe, rmmod,  mkfs.*,
> systemd-detect-virt (this one is not a hard dependency).
> 
> Kind regards,
> Petr
> 
> 


