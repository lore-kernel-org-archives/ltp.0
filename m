From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 19 Mar 2021 11:05:23 +0100
Subject: [LTP] [PATCH v2 2/2] doc: Add Maintainer Patch Review Checklist
In-Reply-To: <YFRtoRtRFVFYeXkn@yuki.lan>
References: <20210318181641.2062-1-pvorel@suse.cz>
 <20210318181641.2062-3-pvorel@suse.cz> <YFRtoRtRFVFYeXkn@yuki.lan>
Message-ID: <YFR3Y2yln5y8EDKc@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> > +* Author's `Signed-off-by` tag
> > +* Committer's `Reviewed-by` or `Signed-off-by` tag
> > +* Check also mailing lists for other reviewers / testers
> > +* `Fixes: hash` if it fixes particular commit
>                                          ^
> 					 LTP

> Let's add this here so that is clear what we mean.

> > +* `Fixes: #N` if it fixes N github issue, so it's automatically closed
>                               ^
> 			 This wording is not clear it should be:

> 	... if it fixes github issue number N ...

> Or just:

> 	.. if it fixed github issue N ...

+1

> > +After patch is accepted or rejected, set correct state and archive in
> > +https://patchwork.ozlabs.org/project/ltp/list/[LTP patchwork instance].
> > +
> > +Also update LTP WIKI (git URL https://github.com/linux-test-project/ltp.wiki.git)
> > +if touch 'doc/*.txt'.
> > +
> > +## New tests
> > +New test should
> > +
> > +* Have a record in runtest file
> > +* Test should work fine with more than one iteration
> > +  (e.g. run with `-i 100`)
> > +* Have a brief description
> > +
> > +### C tests
> > +* Use new https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#22-writing-a-test-in-c[C API]
> > +* Test files are added into corresponding '.gitignore' files
>           ^
> 	  binaries?

+1 (copy pasted from Test Writing Guidelines, thus fixed it also there as you
suggest in next mail).

Kind regards,
Petr
