From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Mon, 21 Jun 2021 09:41:42 +0100
Subject: [LTP] [RFC PATCH v2 1/1] make: Add make test{, -c, -c-run,
 -shell-run} targets
In-Reply-To: <20210618191252.12403-1-pvorel@suse.cz>
References: <20210618191252.12403-1-pvorel@suse.cz>
Message-ID: <87a6nj4njt.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Petr Vorel <pvorel@suse.cz> writes:

> For testing C and shell API.
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Hi all,
>
> another attempt for make test target.
>
> In a long term, I'd like to wrap the execution with some script, as I
> suppose there will be some metadata in test, allowing to run tests which
> don't TPASS or TBROK (we have quite a lot of them). Then the summary
> would be even more useful.

For each test you could have an tcl/expect (or equivalent Perl/shell if
we don't already require tcl) script which matches the output including
return value and stderr/stdout.

For most tests it would just call a common function to check for
TPASS/TBROK. For tests where we want to look for a given message, it
could match the output. If we sometimes expect TCONF then it could
perform a check to verify that it really should return TCONF.

I guess you could just put some data in a comment. I think that is
likely to be harder though. At least with the number of tests we current
have.

-- 
Thank you,
Richard.
