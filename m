From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 11 Mar 2016 08:57:08 -0500 (EST)
Subject: [LTP] Test library API changes
In-Reply-To: <20160310165721.GA6142@rei>
References: <20160105111136.GA32659@rei.lan>
 <1752902661.22105327.1455786359593.JavaMail.zimbra@redhat.com>
 <20160218110752.GB19157@rei.lan>
 <1610317133.22142649.1455794774969.JavaMail.zimbra@redhat.com>
 <20160302144421.GC25763@rei>
 <322891927.4705109.1457010820487.JavaMail.zimbra@redhat.com>
 <20160303140054.GB3055@rei.lan> <20160310165721.GA6142@rei>
Message-ID: <1172303351.8592023.1457704628083.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp@lists.linux.it
> Sent: Thursday, 10 March, 2016 5:57:21 PM
> Subject: Re: [LTP] Test library API changes
> 
> Hi!
> Up to date version is at usuall place:
> 
> https://github.com/metan-ucw/ltp
> 
> 
> Changes are:
> 
> * Now we use env variable for SHM path
> 
>   - I was thinking about setting it to the /proc path if proc is mounted
>     but that way we would have to keep the fd open (and it would occupy
>     fd=3) and I think that the less resources the library occupy the
>     better
> 
> * The rest of the default test options -I and -C are now working
> 
> * I've given up on SAFE_MACROS in cleaup for now
> 
>   - We may add them later, but I would like to get this merged ideally
>     before we do another release and doing this would take some time

I think we have this problem already. tst_brk() will call tst_vbrk_(),
which calls cleanup_ipc(), which is using SAFE_* macros. It looks like
we'll get infinite loop if any of those fail.

> 
> * All relevant parts of test-writing-guidelines should be now rewritten
> 
>   - There are couple of functions that still take cleanup as fist
>     parameter and that are not exported to the new library but that
>     should be all that is missing

"Child processes started via exec*, or any other processes must initialize the
checkpoint by calling 'TST_CHECKPOINT_INIT()' before usage."
This doesn't sound correct for newlib. We now have "tst_checkpoint_open()".

---

'To make sure cleanup() was called only once LTP has a helper
"TST_DECLARE_ONCE_FN"'
TST_DECLARE_ONCE_FN is declared in test.h, it doesn't look like newlib
can use it at the moment.

---

I'm not sure it is enough to make cleanup() call only once. It looks like
we still can get into situation where we call "do_cleanup();cleanup_ipc();"
more than once (if we hit tst_brk in multiple threads with newlib)

---

Can we remove "SAFE_CLOSE(ipc_fd);" from cleanup_ipc()? This fd
is already closed in setup_ipc().

---

Should "struct tst_test *tst_test" be initialized to NULL?
Some tst_res.c oldlib functions are using it, but it is initialized only
if you use newlib, at tst_run_tcases().

> 
> 
> Anything else that should be done before we can merge it?

I only made a compile test on some old/recent RHEL distros
and ran some newlib testcases by hand. This worked OK.

Have you tried running all of the (oldlib) tests on
various arches/releases to see if we haven't regressed?

I could run it against various RHEL majors, it
would take couple days.

Regards,
Jan

> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
