From: Li Wang <liwang@redhat.com>
Date: Thu, 17 May 2018 13:11:10 +0800
Subject: [LTP] Fwd: [PATCH v2] tst_test.sh: achieve TST_RETRY_FUNC function
	in shell
In-Reply-To: <CAEemH2ccJR4aiowoogZ5nmOdQFvcCzUbE0k4A+5h=mW=XVgVnQ@mail.gmail.com>
References: <20180503033414.5601-1-liwang@redhat.com>
 <20180516104437.kgun7upb4sbrwsfj@dell5510>
 <CAEemH2ccJR4aiowoogZ5nmOdQFvcCzUbE0k4A+5h=mW=XVgVnQ@mail.gmail.com>
Message-ID: <CAEemH2fHfAkjuSgAFcHyrs0Ga5JP91Eg11kbJ6D2jESKTbAOfw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Ah, forgot to CC' LTP list.

---------- Forwarded message ----------
From: Li Wang <liwang@redhat.com>
Date: Thu, May 17, 2018 at 1:03 PM
Subject: Re: [LTP] [PATCH v2] tst_test.sh: achieve TST_RETRY_FUNC function
in shell
To: Petr Vorel <pvorel@suse.cz>


Hi Petr,

On Wed, May 16, 2018 at 6:44 PM, Petr Vorel <pvorel@suse.cz> wrote:

> Hi Li,
>
> > The commit c2ce4df67d(include: add an exponential backoff macro for
> > function retry) involves a new MACRO for function retry in C code,
> > here achieve it in shell lib and gives a introduction in LTP documents.
>
> > Signed-off-by: Li Wang <liwang@redhat.com>
> > Tested-by: Petr Vorel <pvorel@suse.cz>
> > ---
> ...
> > +++ b/testcases/lib/tst_test.sh
> > @@ -154,6 +154,40 @@ EXPECT_FAIL()
> >       fi
> >  }
>
> > +TST_RETRY_FN_EXP_BACKOFF()
> > +{
> > +     local tst_fun=$1
> > +     local tst_exp=$2
>
> Maybe add check for int, something like this?
>         if ! tst_is_int "$tst_sec"; then
>                 tst_brk TBROK "TST_RETRY_FN_EXP_BACKOFF: tst_sec must be
> integer ('$tst_sec')"
>         fi
>

​Sounds good. If do this, I'd put the check after tst_sec assignment.
​

> > +     local tst_sec=$(expr $3 \* 1000000)
> > +     local tst_delay=1
> > +
> > +     if [ $# -ne 3 ]; then
> > +             tst_brk TBROK "TST_RETRY_FN_EXP_BACKOFF expects three
> parameters"
> I'd personally use number than word, but feel free to ignore that.
>                 tst_brk TBROK "TST_RETRY_FN_EXP_BACKOFF expects 3
> parameters"
> I'm not sure if checking
> ...
>

​Ok, fine.
​

>
> > +TST_RETRY_FUNC()
> > +{
> TST_RETRY_FUNC needs check for number of params as well:
>
>         if [ $# -ne 2 ]; then
>                 tst_brk TBROK "TST_RETRY_FUNC expects 2 parameters"
>         fi
> > +     TST_RETRY_FN_EXP_BACKOFF "$1" "$2" 1
>
> Otherwise you run TST_RETRY_FUNC without params and didn't get check.
> some-test 1 TBROK: "" failed
>

​Agree.
​

>
>
> Kind regards,
> Petr
>



-- 
Regards,
Li Wang



-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180517/ece73c9a/attachment-0001.html>
