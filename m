From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 14 Jul 2021 18:43:12 +0200
Subject: [LTP] [PATCH v5 0/4] Run tests in CI
In-Reply-To: <YO77+MmmxwMewgnQ@yuki>
References: <20210714142001.20566-1-pvorel@suse.cz> <YO70PiTdyxzTw0k2@pevik>
 <YO77+MmmxwMewgnQ@yuki>
Message-ID: <YO8UIP310jsAmq8I@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> Hi!
> > tested:
> > https://github.com/pevik/ltp/actions/runs/1030551185

> > One thing which bothers me is mangled output of several tests together:
> > https://github.com/pevik/ltp/runs/3067600696?check_suite_focus=true#step:11:554

> > runtest TINFO: * tst_res_hexd
> > /__w/ltp/ltp/lib/tst_test.c:1344: TINFO: Timeout per run is 0h 05m 00s
> > /__w/ltp/ltp/lib/newlib_tests/tst_res_hexd.c:13: TPASS: dump1
> > /__w/ltp/ltp/lib/newlib_tests/tst_res_hexd.c:13: TPASS: 48 65 6c 6c 6f 20 66 72 6f 6d 20 74 73 74 5f 72
> > /__w/ltp/ltp/lib/newlib_tests/tst_res_hexd.c:13: TPASS: 65 73 5f 68 65 78 64 00

> > runtest TINFO: * tst_strstatus
> > /__w/ltp/ltp/lib/tst_test.c:1344: TINFO: Timeout per run is 0h 05m 00s

> > Summary:
> > passed   35
> > failed   0
> > broken   0
> > skipped  0
> > warnings 0

> > Summary:
> > passed   1
> > failed   0
> > broken   0
> > skipped  0
> > warnings 0

> That is indeed strange, you are running these in a loop, the buffers
> should have been flushed once controll returns back to the shell from
> the test.

> I guess that this is a combination of:

> * The stdout and stderr are block buffered by the gitlab CI and flushed
>   at different times

> * The summary is written into stdout in contrast with the message
>   so we end up with summary printed later than the rest that goes into
>   stderr

Yep, it could be.

> I guess this should fix it:

> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index f4d9f8e3b..084a83c9e 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -734,12 +734,12 @@ static void do_exit(int ret)
>                 if (results->broken)
>                         ret |= TBROK;

> -               printf("\nSummary:\n");
> -               printf("passed   %d\n", results->passed);
> -               printf("failed   %d\n", results->failed);
> -               printf("broken   %d\n", results->broken);
> -               printf("skipped  %d\n", results->skipped);
> -               printf("warnings %d\n", results->warnings);
> +               fprintf(stderr, "\nSummary:\n");
> +               fprintf(stderr, "passed   %d\n", results->passed);
> +               fprintf(stderr, "failed   %d\n", results->failed);
> +               fprintf(stderr, "broken   %d\n", results->broken);
> +               fprintf(stderr, "skipped  %d\n", results->skipped);
> +               fprintf(stderr, "warnings %d\n", results->warnings);
>         }

Thanks! Testing it in https://github.com/pevik/ltp/actions/runs/1031005963

Kind regards,
Petr
