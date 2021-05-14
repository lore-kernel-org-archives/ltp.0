From: Li Wang <liwang@redhat.com>
Date: Fri, 14 May 2021 17:10:27 +0800
Subject: [LTP] [PATCH v3 3/4] lib: ignore SIGINT in _tst_kill_test
In-Reply-To: <YJ4sh7zBOZxQy1S0@pevik>
References: <20210508055109.16914-4-liwang@redhat.com>
 <dfdd8e9a-90ca-642d-1c21-da169ca3878f@jv-coder.de>
 <CAEemH2et8_SXWJTsofdt7gc0NRV=91rPe0RtAMt1BX=SbAzhig@mail.gmail.com>
 <YJvkFTUWS2iuZ00H@pevik>
 <CAEemH2fRLqipQWTxVsakYNGsmQT+2X8_xzgepCiAY1O8YWtKFA@mail.gmail.com>
 <YJ4sh7zBOZxQy1S0@pevik>
Message-ID: <CAEemH2dOg0JN6XrptGZ6WN3C1SOYpWKgSTdXtpcjSZzBjsnOMQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Petr Vorel <pvorel@suse.cz> wrote:

> > Does this below (rough solution in my mind) work for you?
> LGTM, but Joerg, Metan, could you please have a look?

Thanks, I wouldn't send a patch until Joerg/Cyril has a review.
(Maybe Joerg will have another better solution:)

> > diff --git a/lib/newlib_tests/shell/timeout03.sh
> > b/lib/newlib_tests/shell/timeout03.sh
> > index cd548d9a2..f39f5712a 100755
> > --- a/lib/newlib_tests/shell/timeout03.sh
> > +++ b/lib/newlib_tests/shell/timeout03.sh
> > @@ -30,6 +30,7 @@ TST_TIMEOUT=1
>
> >  do_test()
> >  {
> > +       trap "echo 'Sorry, timeout03 is still alive'" TERM
> Any reason why not use tst_res TINFO? (working on bash).

+1
I just use echo for a quick test, but surely we can replace it with tst_res.


> > -       while kill -0 $pid 2>&1 > /dev/null && [ $i -gt 0 ]; do
> > +       while kill -0 $pid &>/dev/null && [ $i -gt 0 ]; do
> FYI: &> is a bashism (we need to keep the original).

I just want the error does not to redirect to standard output.
Because with SIGTERM sending, it seems easier to kill all
processes, so 'kill -0 $pid' returns "No such process" errors often.

Mayby I should go with: kill -0 $pid >/dev/null 2>&1

e.g.

# ./timeout04.sh
timeout04 1 TINFO: timeout per run is 0h 0m 1s
timeout04 1 TINFO: Start
timeout04 1 TBROK: Test timeouted, sending SIGTERM! If you are running
on slow machine, try exporting LTP_TIMEOUT_MUL > 1
Terminated
./../../../testcases/lib/tst_test.sh: line 448: kill: (74911) - No such process
./../../../testcases/lib/tst_test.sh: line 454: kill: (74911) - No such process


-- 
Regards,
Li Wang

