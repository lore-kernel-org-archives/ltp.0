From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 3 Mar 2016 08:13:40 -0500 (EST)
Subject: [LTP] Test library API changes
In-Reply-To: <20160302144421.GC25763@rei>
References: <20160105111136.GA32659@rei.lan> <20160216211958.GC2515@rei.lan>
 <1799339064.21851637.1455719961718.JavaMail.zimbra@redhat.com>
 <20160217155406.GA12574@rei>
 <1752902661.22105327.1455786359593.JavaMail.zimbra@redhat.com>
 <20160218110752.GB19157@rei.lan>
 <1610317133.22142649.1455794774969.JavaMail.zimbra@redhat.com>
 <20160302144421.GC25763@rei>
Message-ID: <322891927.4705109.1457010820487.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it




----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: "Jan Stancek" <jstancek@redhat.com>, "Alexey Kodanev" <alexey.kodanev@oracle.com>
> Cc: ltp@lists.linux.it
> Sent: Wednesday, 2 March, 2016 3:44:21 PM
> Subject: Re: [LTP] Test library API changes
> 
> Hi!
> The up to date version is at usuall place at:
> 
> https://github.com/metan-ucw/ltp
> 
> 
> The changes are:
> 
> * acnt was removed completly
> 
> * the bitflags in struct tst_test were fixed to be 1 bit wide
> 
> * the headers were changed so that most of the old headers starts with
>   old_ prefix
> 
>   The safe_macros.h and test.h were left intact at the moment since
>   these are included in numerous testcases. We can rename them in a
>   separate patch if needed.
> 
> * Added macro TST_TEST_TCONF() to ease writing testcases that are
>   guarded by #ifdefs, see newly converted llistxattr testcases
> 
> * Few more converted testcases
> 
> * Started to update Test-Writing-Guidelines for new API
> 
> 
> The open issues:
> 
> * The SHM base file path propagation
>   - we will probably go with the env variable
> 
> * Finishing rewrite of Test Writing Guidelines
>   - needs just a bit more work
> 
> * Should we allow SAFE_MACROS() in cleanup?
> 
>   - we can easily do that since cleanup is executed from the test
>     library and we can change tst_brk() to return to the caller
>     if cleanup was entered

In that case, tst_vbrk_() should also call update_results(), so TBROK
during cleanup doesn't get lost/ignored.

> 
>   - plus point is that writing cleanup is bit easier
> 
>   - minus point is that tst_brk() can now return and as a side effect
>     tst_brkm() has to return as well (since tst_brkm() from safe macros
>     is redirected to tst_brk()) and because of that we have to drop
>     the __attribute__((noreturn)) since that causes gcc to optimize out
>     return statements from the function which generates compilation
>     warnings in some cases

I assume if we drop noreturn, we still have a different way to suppress
those warnings, right?

> 
> 
> Is there anything else?

I ran into number of compilation errors on RHEL5.6, but they will
likely happen on other distros too:

1. lib/ltp_priv.h and va_list
Adding "#include <stdarg.h>" fixed it.

2. preadv/preadv.h:27: undefined reference to `tst_brkm'
pread01 and pread02 share predv.h, which is using ltp_syscall

3. recvmsg02.c:68: error: ‘SOCK_CLOEXEC’ undeclared (first use in this function)
I'm guessing some old api header used to include also lapi/fcntl.h

Regards,
Jan

> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
