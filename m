From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 17 May 2018 10:24:17 +0200
Subject: [LTP] [PATCH v2] tst_test.sh: achieve TST_RETRY_FUNC function
 in shell
In-Reply-To: <CAEemH2faFjQaYqUqaMg+FEeFBPDVoKBkKDc4+0nCbR5UWw469A@mail.gmail.com>
References: <20180503033414.5601-1-liwang@redhat.com>
 <20180516104437.kgun7upb4sbrwsfj@dell5510>
 <CAEemH2ccJR4aiowoogZ5nmOdQFvcCzUbE0k4A+5h=mW=XVgVnQ@mail.gmail.com>
 <CAEemH2fHfAkjuSgAFcHyrs0Ga5JP91Eg11kbJ6D2jESKTbAOfw@mail.gmail.com>
 <CAEemH2faFjQaYqUqaMg+FEeFBPDVoKBkKDc4+0nCbR5UWw469A@mail.gmail.com>
Message-ID: <20180517082417.kxkzmskh6tijv4mh@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li,

> Hi Petr,

> And also, we'd better skip the TST_ prefix name check in test library,
> otherwise we will get LTP warnings like:

> <<<test_output>>>
> numa01 1 TWARN: Reserved variable TST_RETRY_FUNC used!
I'm sorry I've noticed it but forget to report it.
...
> @@ -255,6 +297,7 @@ tst_run()
>                         OPTS|USAGE|PARSE_ARGS|POS_ARGS);;
>                         NEEDS_ROOT|NEEDS_TMPDIR|NEEDS_DEVICE|DEVICE);;
>                         NEEDS_CMDS|NEEDS_MODULE|MODPATH|DATAROOT);;
> +                       RETRY_FUNC|RETRY_FN_EXP_BACKOFF);;
>                         IPV6);;

> I prefer to merge this change along with your suggestions in PATCH v3 as
> well.

Sure!

> Thanks,
> Li Wang


Kind regards,
Petr
