From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 21 Jun 2021 10:48:38 +0200
Subject: [LTP] [RFC PATCH v2 1/1] make: Add make test{, -c, -c-run,
 -shell-run} targets
In-Reply-To: <87a6nj4njt.fsf@suse.de>
References: <20210618191252.12403-1-pvorel@suse.cz>
 <87a6nj4njt.fsf@suse.de>
Message-ID: <YNBSZrDdiXxfrVnl@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richie,

> Hello,

> Petr Vorel <pvorel@suse.cz> writes:

> > For testing C and shell API.

> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> > Hi all,

> > another attempt for make test target.

> > In a long term, I'd like to wrap the execution with some script, as I
> > suppose there will be some metadata in test, allowing to run tests which
> > don't TPASS or TBROK (we have quite a lot of them). Then the summary
> > would be even more useful.

> For each test you could have an tcl/expect (or equivalent Perl/shell if
> we don't already require tcl) script which matches the output including
> return value and stderr/stdout.
I'd prefer to avoid tcl/expect. FYI There was some effort [1], based on my
previous work [1], I plan to get back to it.

> For most tests it would just call a common function to check for
> TPASS/TBROK. For tests where we want to look for a given message, it
> could match the output. If we sometimes expect TCONF then it could
> perform a check to verify that it really should return TCONF.
As I noted in [2] today, I might create very simple library for these test
wrappers (small subset of things needed in test wrappers like
lib/newlib_tests/shell/test_timeout.sh).

> I guess you could just put some data in a comment. I think that is
> likely to be harder though. At least with the number of tests we current
> have.
Yep, that's what was used in [1].

Kind regards,
Petr

[1] https://patchwork.ozlabs.org/project/ltp/patch/ce675759672af52bea02c11d51bd7d10f0bcb5cb.1566500817.git.clanig@suse.com/
[2] https://lists.linux.it/pipermail/ltp/2021-June/023306.html
