From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 4 Apr 2018 16:57:17 +0200
Subject: [LTP] [RFC] tst_check_cmds to exit only current test
In-Reply-To: <20180404135150.GB28174@rei>
References: <20180329114536.vsmsjzatryu4h5dm@dell5510>
 <20180404131501.GH32109@rei>
 <20180404134401.acd5w52wcn2z42kv@dell5510>
 <20180404135150.GB28174@rei>
Message-ID: <20180404145717.soxvqdfqcowwtcu6@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> > I'll implement it regardless it's actually used in interface tests as it's handy (I'd like
> > to use it in ima tests).
> > I just don't like that new API doesn't have constants for TCONF, TPASS, etc (legacy API
> > has it).

> That is intentional as you are not supposed to exit the test yourself as
> the result is stored in the counters and the return value is composed
> based on that. That also means that the test without the tst_run()
> function has to call tst_do_exit() at the end if it uses tst_res() to
> report results.
If API users don't need to distinguish exit output (TCONF, TWARN), it's really no need to
export it. But there are other ways to use it than just exit.

Commit d5c80cb04 ("tst_netload: Exit with TCONF when netstress exit with CONF")
could have benefited from it. The point was that netstress binary which is using API is
called from network tests, we could use it's exit code (i.e. if netstress TCONF, we
shouldn't TFAIL, but also TCONF).

We use grep anyway, as tst_rhost_run() from library don't exit error int according to T*,
but just 1. Maybe I'm missing something and trying to use wrong approach.


> And actually in this case it does not matter what do we return here as
> the return value is not propagate anywhere, just doing return 1 would
> work as well.
Originally I was thinking about more use-cases, but there is really just one => I'll use 1
as error indicator.


Kind regards,
Petr
