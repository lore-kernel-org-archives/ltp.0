From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 18 Sep 2019 11:40:39 +0200
Subject: [LTP] [PATCH v2 2/3] shell: Introduce TST_TIMEOUT variable
In-Reply-To: <1568629595.3028.13.camel@suse.de>
References: <20190913125823.17314-1-pvorel@suse.cz>
 <20190913125823.17314-3-pvorel@suse.cz>
 <1568629595.3028.13.camel@suse.de>
Message-ID: <20190918094039.GB11711@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Clements,

> Hi Petr,
> only some small comments below.

> On Fri, 2019-09-13 at 14:58 +0200, Petr Vorel wrote:
> > <snip>
> > -2.3.2 Library variables
> > -^^^^^^^^^^^^^^^^^^^^^^^
> > +2.3.2 Library environment variables for shell
> > +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

> >  Similarily to the C library various checks and preparations can be
> > requested
> >  simply by setting right '$TST_NEEDS_FOO'.
> > @@ -2047,6 +2058,14 @@ simply by setting right '$TST_NEEDS_FOO'.
> >                         the test (see below).
> >  | 'TST_NEEDS_MODULE' | Test module name needed for the test (see
> > below).
> >  | 'TST_NEEDS_DRIVERS'| Checks kernel drivers support for the test.
> > +| 'TST_TIMEOUT'      | Maximum timeout set for the test in sec. Must
> > be float

>       ^
> I think TST_TIMEOUT isn't evaluated in c at all. There we have `(struct
> tst_test*)->timeout` which is `int`,
> tst_test*)->timeout (BTW it's *unsigned* int).
Correct, thanks!
This is a proposed description, which I'll post to v3.
(using tst_test.timeout to be short enough, is that ok?):
| 'TST_TIMEOUT'      | Maximum timeout set for the test in sec. Must be int >= 1,
                       or -1 (special value to disable timeout), default is 300.
                       Variable is meant be set in tests, not by user.
                       It's equivalent of `tst_test.timeout` in C.
| 'LTP_TIMEOUT_MUL'  | Multiply timeout, must be number >= 1 (> 1 is useful for
                       slow machines to avoid unexpected timeout).
                       Variable is also used in C tests.
                       It's meant to be set by user, not in tests.
...
> > +	local sec
> > +	if [ "$is_float" ]; then
> > +		sec=`echo |awk '{printf("%d\n", '$TST_TIMEOUT' * 

>                           ^
>                           nit, space after |
Sure :).

> > '$LTP_TIMEOUT_MUL')}'`

>                    ^
>                    + 0.5
> In C implementation we round up. Maybe we should do the same in shell.
Correct, thanks!


Kind regards,
Petr
