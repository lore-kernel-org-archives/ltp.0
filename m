From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 13 Mar 2020 15:14:58 +0100
Subject: [LTP] [RFC] Define minimal supported kernel and (g)libc version
Message-ID: <20200313141458.GB21248@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

I'm sorry, I've raised this question in the past, but it got lost.
I remember we talked about 2.6 something.

It'd be good to state publicly the oldest kernel and glibc (or even other libc
versions) we support.  This would allow us to remove some legacy code or force
support for legacy code.

This shouldn't require test to be functional (e.g. for some cases like module
drivers it could be hard), but LTP to be compiled and when difficult/impossible
to achieve this functionality, it could resulted in TCONF (skipped test).

I created github issue for this [1], where I put link to this thread, so we
don't loose it again.

Kind regards,
Petr

[1] https://github.com/linux-test-project/ltp/issues/657
