From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 12 Sep 2019 16:55:39 +0200
Subject: [LTP] [PATCH v2 1/3] tst_test.sh: Use LTP_TIMEOUT_MUL in
 TST_RETRY_FN()
In-Reply-To: <1568278363.3621.6.camel@suse.de>
References: <20190911085536.25546-1-cfamullaconrad@suse.de>
 <20190911165225.2122-1-cfamullaconrad@suse.de>
 <CAEemH2fy0hQc0yXJY0BXf8-9nnzkDW9LEsydyhtHC3Jboc_tFA@mail.gmail.com>
 <1568278363.3621.6.camel@suse.de>
Message-ID: <20190912145539.GC22246@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Clemens,

> On Thu, 2019-09-12 at 13:42 +0800, Li Wang wrote:
> > On Thu, Sep 12, 2019 at 12:52 AM Clemens Famulla-Conrad <
> > cfamullaconrad@suse.de> wrote:

> > > Because of timeout problems when using TST_RETRY_FN() we do now use
> > > LTP_TIMEOUT_MUL to adopt the timeout value.

> > > Introduced tst_adjut_timeout function to have a generic place to
> > > adopt timeout values.


> > What about using tst_multipy_timeout as the function name? Since it
> > only
> > raises the timeout value with a multiplier.
+1.

> I had a this patchset [1] in my mind. 
> Maybe we will also apply a minimum. But we would still just multiply :)
> so Sure we can name it tst_multiply_timeout().

> [1]https://patchwork.ozlabs.org/patch/1155460



> > > Signed-off-by: Clemens Famulla-Conrad <cfamullaconrad@suse.de>
> > > ---
> > >  testcases/lib/tst_test.sh | 12 ++++++++----
> > >  1 file changed, 8 insertions(+), 4 deletions(-)

> > > diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
> > > index e0b24c6b9..03692e503 100644
> > > --- a/testcases/lib/tst_test.sh
> > > +++ b/testcases/lib/tst_test.sh
> > > @@ -164,7 +164,7 @@ TST_RETRY_FN_EXP_BACKOFF()
> > >  {
> > >         local tst_fun="$1"
> > >         local tst_exp=$2
> > > -       local tst_sec=$(expr $3 \* 1000000)
> > > +       local tst_sec=$(tst_adjust_timeout $(expr $3 \* 1000000))
> > >         local tst_delay=1

> > >         if [ $# -ne 3 ]; then
> > > @@ -371,12 +371,16 @@ _tst_rescmp()
> > >         fi
> > >  }

> > > -
> > > -_tst_setup_timer()
> > > +tst_adjust_timeout()
> > >  {
> > >         LTP_TIMEOUT_MUL=${LTP_TIMEOUT_MUL:-1}
> > > +       local timeout=$1
> > > +       echo $(( timeout * LTP_TIMEOUT_MUL))

> > Shouldn't we check the LTP_TIMEOUT_MUL > 1 before using it?
Also timeout should be checked.
I'd tst_brk TBROK if either of them is < 0.

> Yes, thx for the hint.

BTW: I haven't finish patchset doing the same [1]. Feel free to include docs
from [2].

I'll also sent tonight LTP_TIMEOUT_MUL_MIN (as part of v2 for [3]).
But it should be trivial to rebase changes of the later commit (whoever gets merged first).


Kind regards,
Petr

[1] https://patchwork.ozlabs.org/project/ltp/list/?series=120151&state=*
[2] https://patchwork.ozlabs.org/patch/1133627/
[3] https://patchwork.ozlabs.org/patch/1155460/
