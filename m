From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 15 Jul 2021 09:38:19 +0200
Subject: [LTP] [PATCH v5 0/4] Run tests in CI
In-Reply-To: <YO8UIP310jsAmq8I@pevik>
References: <20210714142001.20566-1-pvorel@suse.cz> <YO70PiTdyxzTw0k2@pevik>
 <YO77+MmmxwMewgnQ@yuki> <YO8UIP310jsAmq8I@pevik>
Message-ID: <YO/l6yni/AAOGhn9@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

...
> > I guess this should fix it:

> > diff --git a/lib/tst_test.c b/lib/tst_test.c
> > index f4d9f8e3b..084a83c9e 100644
> > --- a/lib/tst_test.c
> > +++ b/lib/tst_test.c
> > @@ -734,12 +734,12 @@ static void do_exit(int ret)
> >                 if (results->broken)
> >                         ret |= TBROK;

> > -               printf("\nSummary:\n");
> > -               printf("passed   %d\n", results->passed);
> > -               printf("failed   %d\n", results->failed);
> > -               printf("broken   %d\n", results->broken);
> > -               printf("skipped  %d\n", results->skipped);
> > -               printf("warnings %d\n", results->warnings);
> > +               fprintf(stderr, "\nSummary:\n");
> > +               fprintf(stderr, "passed   %d\n", results->passed);
> > +               fprintf(stderr, "failed   %d\n", results->failed);
> > +               fprintf(stderr, "broken   %d\n", results->broken);
> > +               fprintf(stderr, "skipped  %d\n", results->skipped);
> > +               fprintf(stderr, "warnings %d\n", results->warnings);
> >         }

> Thanks! Testing it in https://github.com/pevik/ltp/actions/runs/1031005963

The result is much better but still not correct:
https://github.com/pevik/ltp/runs/3068932859?check_suite_focus=true#step:11:707

runtest TINFO: * shell/net/tst_ipaddr_un.sh

Summary:
passed   0
failed   0
broken   0
skipped  1
warnings 0
tst_ipaddr_un 1 TINFO: timeout per run is 0h 5m 0s

Could you please merge your fix? And I'll try sync after each test.
https://github.com/pevik/ltp/actions/runs/1033070696

What is worse is that tests are green, but I see TBROK and TWARN which are not
reflected by results:

tst_check_driver 1 TBROK: Test still running, sending SIGKILL
...
tst_rhost_run 1 TCONF: (null)      0  TWARN  :  tst_kernel.c:105: expected file /lib/modules/5.8.0-1036-azure/modules.dep does not exist or not a file

veth(null)      0  TWARN  :  tst_kernel.c:105: expected file /lib/modules/5.8.0-1036-azure/modules.builtin does not exist or not a file driver not available
Summary:
passed   0
failed   0
broken   0
skipped  1
warnings 0

runtest TINFO: === SHELL TEST RESULTS ===
runtest TINFO: 1x TPASS: shell/net/tst_ipaddr_un.sh
runtest TINFO: 0x TFAIL:
runtest TINFO: 0x TBROK:
runtest TINFO: 0x TWARN:
runtest TINFO: 2x TCONF: shell/tst_check_driver.sh shell/net/tst_rhost_run.sh

Kind regards,
Petr

> Kind regards,
> Petr
