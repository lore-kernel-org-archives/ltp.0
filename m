From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 14 Jul 2021 16:30:00 +0200
Subject: [LTP] [PATCH v2 4/8] doc: Remind authors and maintainers to run
 make check
In-Reply-To: <87pmvlnhnh.fsf@suse.de>
References: <20210714071158.15868-1-rpalethorpe@suse.com>
 <20210714071158.15868-5-rpalethorpe@suse.com>
 <YO7C0DgkpaUSf4Nw@pevik> <87pmvlnhnh.fsf@suse.de>
Message-ID: <YO706MRTx0m8r5au@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> Hello Petr,

> Petr Vorel <pvorel@suse.cz> writes:

> > Hi Richie,

> >> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> >> ---
> >>  doc/maintainer-patch-review-checklist.txt | 2 +-
> >>  doc/test-writing-guidelines.txt           | 1 +
> >>  2 files changed, 2 insertions(+), 1 deletion(-)

> >> diff --git a/doc/maintainer-patch-review-checklist.txt b/doc/maintainer-patch-review-checklist.txt
> >> index f6682b574..970779acc 100644
> >> --- a/doc/maintainer-patch-review-checklist.txt
> >> +++ b/doc/maintainer-patch-review-checklist.txt
> >> @@ -39,7 +39,7 @@ New test should
> >>  * Use new https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#22-writing-a-test-in-c[C API]
> >>  * Test binaries are added into corresponding '.gitignore' files
> >>  * Check coding style with
> >> -  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plain/scripts/checkpatch.pl[checkpatch.pl]
> >> +  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plain/scripts/checkpatch.pl[checkpatch.pl] and `make check`
> >>    (more in https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#131-c-coding-style[C coding style])
> > +1

> > "131" would mean section 1.3.1. If you put it into "2.1 C coding style" the link
> > should be #21-c-coding-style.

> You may want to do a quick-fix commit for that, because it is not part
> of my patch. Although I can add it ofcourse.
I'm sorry, I overlooked that it does not have ^+. Thanks for info!

Kind regards,
Petr
