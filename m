From: Li Wang <liwang@redhat.com>
Date: Thu, 22 Feb 2018 12:05:23 +0800
Subject: [LTP] [RFC] [PATCH] shell: ROD_SILENT: Print std{out,
	err} on failure
In-Reply-To: <87efle670i.fsf@rpws.prws.suse.cz>
References: <20180212150302.23347-1-chrubis@suse.cz>
 <87efle670i.fsf@rpws.prws.suse.cz>
Message-ID: <CAEemH2eg80VEZOVeb1xgg_DeODxQaV5TOutW86gF0jHhtF=agw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

On Wed, Feb 21, 2018 at 5:12 PM, Richard Palethorpe <rpalethorpe@suse.de>
wrote:

> Hello,
>
> Cyril Hrubis writes:
>
> > Recently we had a problem when openQA (test automation framework) passed
> > wrong device path as LTP_BIG_DEV. It has been much more complicated to
> > debug because the error message from mkfs was not shown at all, since
> > the tst_mkfs uses ROD_SILENT to execute the mkfs command.
> >
> > The best solution for ROD_SILENT is to store the command output into a
> > variable and print it only on failure which is done by this patch.
> >
> > Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> > ---
> >  testcases/lib/test.sh     | 3 ++-
> >  testcases/lib/tst_test.sh | 3 ++-
> >  2 files changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/testcases/lib/test.sh b/testcases/lib/test.sh
> > index 341c1f0f4..bce9893a9 100644
> > --- a/testcases/lib/test.sh
> > +++ b/testcases/lib/test.sh
> > @@ -225,8 +225,9 @@ tst_timeout()
> >
> >  ROD_SILENT()
> >  {
> > -     $@ > /dev/null 2>&1
> > +     local tst_out=$($@ 2>&1)
> >       if [ $? -ne 0 ]; then
> > +             echo "$tst_out"
> >               tst_brkm TBROK "$@ failed"
> >       fi
> >  }
> > diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
> > index d6b638549..48afb9cc4 100644
> > --- a/testcases/lib/tst_test.sh
> > +++ b/testcases/lib/tst_test.sh
> > @@ -118,8 +118,9 @@ tst_brk()
> >
> >  ROD_SILENT()
> >  {
> > -     tst_rod $@ > /dev/null 2>&1
> > +     local tst_out=$(tst_rod $@ 2>&1)
> >       if [ $? -ne 0 ]; then
> > +             echo "$tst_out"
> >               tst_brk TBROK "$@ failed"
> >       fi
> >  }
> > --
> > 2.13.6
>
> LGTM except that you could maybe use ${ } instead of $( ) as a small
> optimisation.
>

​For ​
what optimisation?

$(command) runs the command and captures its output in separate shell.
${parameter} the value of parameter is substituted.


​Here the purpose is to hide the output in sub shell I guess, shouldn't use
$()?


-- 
Li Wang
liwang@redhat.com
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180222/36cdf716/attachment.html>
