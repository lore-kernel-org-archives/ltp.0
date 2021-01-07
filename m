From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 7 Jan 2021 12:32:46 +0100
Subject: [LTP] [PATCH v4 1/3] tst_test.sh: Call cleanup function after
 test start
In-Reply-To: <X/bc+ZGQ6JPsg4YY@yuki.lan>
References: <20201217144424.19414-1-pvorel@suse.cz>
 <20201217144424.19414-2-pvorel@suse.cz> <X/bc+ZGQ6JPsg4YY@yuki.lan>
Message-ID: <X/bxXpNIbMeal+Wj@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

...
> This still possibly break tests that would call tst_brk() in the middle
> of setup and expect the cleanup() to be executed, right?

> I guess that we would need TST_DO_CLEANUP that would be set in both
> cases i.e. before we run setup and also before we execute the tests.

> What about this:

Whole patchset merged with your credit.
Thanks!

Kind regards,
Petr
