From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 21 Apr 2020 11:44:22 +0200
Subject: [LTP] Purpose of clock_nanosleep2 tests ?
In-Reply-To: <20200421092616.lnktrr4e4pv7wemm@vireshk-i7>
References: <CAKohponWBU_pSDk6sjsMFBkJzwPDz71DcyC1_X6x1=0bZMb=aQ@mail.gmail.com>
 <20200421092045.GC6577@yuki.lan>
 <20200421092616.lnktrr4e4pv7wemm@vireshk-i7>
Message-ID: <20200421094422.GE6577@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > > While working on the time64 variants I stumbled upon
> > > testcases/kernel/syscalls/clock_nanosleep2/.
> > > 
> > > The commit  log says that we were trying to test clock_nanosleep2()
> > > syscall, which I am unable to find, but still this ends up calling the kernel
> > > variant directly for clock_nanosleep() only.
> > > 
> > > What am I missing ? Why is this stuff required ?
> > 
> > Hmm, I guess that there is no clock_nanosleep2() and the test is a
> > result of a confusion of some kind. Maybe the author just confused
> > clock_nanosleep(2) with clock_nanosleep2().
> > 
> > Looking at clock_nanosleep() tests, there does not seem to be a test
> > for ABSTIME so the best solution would be to move the test to
> > clock_nanosleep directory. What do you think?
> 
> clock_nanosleep03.c already tests ABSTIME. I think we can just drop
> clock_nanosleep2 directory completely. I will send a patch if that looks okay.

clock_nanosleep03 is testing that inside of a time namespace, I think
that there is still value of having the simpler test as well.

-- 
Cyril Hrubis
chrubis@suse.cz
