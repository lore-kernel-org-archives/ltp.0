From: Li Wang <liwang@redhat.com>
Date: Fri, 11 Oct 2019 21:28:46 +0800
Subject: [LTP] Rename tst_test_* to tst_require_*
In-Reply-To: <1570799029.4238.15.camel@suse.de>
References: <20191011090737.17997-1-lkml@jv-coder.de>
 <20191011100604.GA11441@dell5510>
 <1570799029.4238.15.camel@suse.de>
Message-ID: <CAEemH2fSuRR-7HFeLBMw_6zo2bhWW88ckq468S9XhgzAG_mPFw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Oct 11, 2019 at 9:03 PM Clemens Famulla-Conrad <
cfamullaconrad@suse.de> wrote:

> On Fri, 2019-10-11 at 12:06 +0200, Petr Vorel wrote:
> > Hi,
> >
> > Cc: Li and Clemens
> >
> > > these patches rename tst_test_* to tst_require_*, to better
> > > describe
> > > their use. There is also tst_require_root, that has the same
> > > behavior: It also calls tst_brk in case of a failing requirement.
> > > You can also get this patch from the following repo:
> > > https://github.com/MofX/ltp/commits/rename_tst_test-tst_require
> >
> > sorry for not thinking first, I wonder if we want to sync
> > tst_test_* (function name) vs $TST_NEEDS_* (test API variable name),
> > e.g.: tst_require_drivers $TST_NEEDS_DRIVERS
>
> I fully agree with Petr that we must be consistent in naming between
> variable- and function-name.
>

+1


>
> >
> > i.e. either of these:
> > s/tst_test_/tst_needs_/
> > s/TST_NEEDS_/TST_REQUIRE_/
> >
> > I consider *require* as more descriptive than *needs*,
> > but changing to *require* would require more work :).
>
> If we use needs or require ? Hard question - when I search for synonyms
> from one or the other, I don't see a big different. Without looking on
> the impact, require sounds also more descriptive.
>

Yes, I have the same feeling here.

FYI:
  needs: because it's important
  require: because it's a necessity

https://www.englishcurrent.com/grammar/difference-need-require-verbs/

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20191011/f0a81006/attachment-0001.htm>
