From: vichy <vichy.kuo@gmail.com>
Date: Sun, 8 Nov 2015 17:56:31 +0800
Subject: [LTP] how to cross compile linux test project?
In-Reply-To: <20151022121307.GB7192@rei.suse.cz>
References: <CAOVJa8FYtVzST_sEkeWxaEVFCC1FBo_ASgDjncAy50AaYiFGhA@mail.gmail.com>
 <20151022105504.GA7192@rei.suse.cz>
 <CAOVJa8E1YNg5a2ZeTHY_vpDPJkntpXsys9usaHQNYvBAxDWYcg@mail.gmail.com>
 <20151022121307.GB7192@rei.suse.cz>
Message-ID: <CAOVJa8EfpYnYXriEa9XeDxH=6vwrprqT2FE+qNugyzw4oY6skg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

hi all:

2015-10-22 20:13 GMT+08:00 Cyril Hrubis <chrubis@suse.cz>:
> Hi!
>> > Hi!
>> > FYI this list has been abandoned, all discussion now happens on
>> > ltp@lists.linux.it
>> if so, would you mind to let me know how to register that mail list?
>> thanks a lot,
>
> It's a mailman at lists.linux.it: http://lists.linux.it/listinfo/ltp
>
> I've updated all LTP documentation to point to this list so if you, for
> instance look at README in the LTP git repo it will point you this
> page as well...
I can successfully configure the LTP for arm cross-compiling.
But I found even if I enable posix-testsuites with below configs:
./configure AR=arm-buildroot-linux-gnueabi-ar
CC=arm-buildroot-linux-gnueabi-gcc
RANLIB=arm-buildroot-linux-gnueabi-ranlib
STRIP=arm-buildroot-linux-gnueabi-strip --host=arm-linux
--target=arm-buildroot-linux LDFLAGS=-pthread
--with-open-posix-testsuite

the test binary located in testcases/open_posix_testsuite/conformance/
are sill for X86, Not for the host, arm, I configure.

Is there anything I need to take care for cross compiling
--with-open-posix-testsuite?
or --with-open-posix-testsuite so far not support cross compile ?

appreciate your kind help in advance,
