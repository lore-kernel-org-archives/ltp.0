From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 31 May 2021 16:54:22 +0200
Subject: [LTP] [PATCH 1/1] doc: Drop uClinux support
In-Reply-To: <YLSkz6OUbgwuB7my@yuki>
References: <20210531032910.6739-1-pvorel@suse.cz>
 <YLSkz6OUbgwuB7my@yuki>
Message-ID: <YLT4nktvY1CT4Um7@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> Hi!
> > some shorter form could be added to 3. Test Contribution Checklist [1] as well.

> > Kind regards,
> > Petr

> > [1] https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#3-test-contribution-checklist

> >  doc/maintainer-patch-review-checklist.txt | 3 +++
> >  1 file changed, 3 insertions(+)

> > diff --git a/doc/maintainer-patch-review-checklist.txt b/doc/maintainer-patch-review-checklist.txt
> > index 5420fa933..81ed61ddf 100644
> > --- a/doc/maintainer-patch-review-checklist.txt
> > +++ b/doc/maintainer-patch-review-checklist.txt
> > @@ -44,6 +44,9 @@ New test should
> >  * Docparse documentation
> >  * If a test is a regression test it should include tags
> >    (more in https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#2238-test-tags[Test tags])
> > +* When rewritting old tests, https://en.wikipedia.org/wiki/%CE%9CClinux[uClinux
> > +  (??Clinux)] support should be removed (project has been discontinued).
>       ^
>       I would just use u instead of \textmu

> > +  E.g. `FORK_OR_VFORK()` should be replaced with simple `fork()` or `SAFE_FORK()`.

> + and all #ifdef UCLINUX should be removed as well.
Oh yes, ifdefs were the primary reason for me to document this.

If nobody objects, I'll merge this tomorrow with your Reviewed-by: tag.

Kind regards,
Petr
