From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 29 Jan 2020 10:50:56 +0100
Subject: [LTP] [PATCH V4 2/2] syscalls/io_pgetevents: New tests
In-Reply-To: <20200129004651.pdwhyxnnwluxewb6@vireshk-i7>
References: <2d23f3a542bbd04179aba828e28d37f5c7be7b45.1579859350.git.viresh.kumar@linaro.org>
 <cc9d0f47db41cad97c590cf7b58e8d662a437a91.1580180304.git.viresh.kumar@linaro.org>
 <20200128134037.GB26365@rei>
 <20200129004651.pdwhyxnnwluxewb6@vireshk-i7>
Message-ID: <20200129095055.GA21699@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Pushed with one minor adjustement, thanks.
> > 
> > I've removed the tst_test.h include from the lapi header and put it into
> > the two test sources. Since that is the main header the tests should
> > include it's better when they include it explicitely.
> 
> That was a very intentional change I kept because the header should
> also take care of its dependencies. An earlier version was using few
> tst_syscall() calls in lapi header and so it should have directly
> included tst_test.h file, which I did.

The tst_syscall() is defined in lapi/syscalls.h and I doubt that this
header is incldued from tst_test.h and even if it is we should include
the lapi/syscall.h instead.

> But the same got removed in the latest version and so the same isn't
> required. Though changing the order of lapi header and tst_test.h in
> the io_pgetevents0*.c files still generate compilation errors as
> definition of syscall() isn't found as well and the header should now
> explicitly include <unistd.h>.
> 
> I have a question now :)
> 
> In the pidfd_open() lapi header I used tst_syscall() and in
> io_pgetevents() lapi header I used syscall(). Should I use
> tst_syscall() in both of them ? If yes, then I will include tst_test.h
> as well in both of them and send you a patch.

The difference between plain syscall() and tst_syscall() is twofold, it
takes care of undefined __NR_foo as well as of ENOSYS return from
kernel, so generally tst_syscall() should be used instead.

-- 
Cyril Hrubis
chrubis@suse.cz
