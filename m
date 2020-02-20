From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 20 Feb 2020 09:51:29 +0100
Subject: [LTP] [PATCH V2 04/10] syscalls/fsopen: New tests
In-Reply-To: <CAEemH2f7eezS27odRq9qvAN=BCskpvvELECr7+Nsdd+Z_7sofA@mail.gmail.com>
References: <cover.1582104018.git.viresh.kumar@linaro.org>
 <aab7ae7e324c40e8e995ff381384a402d2aba8f5.1582104018.git.viresh.kumar@linaro.org>
 <CAEemH2f7eezS27odRq9qvAN=BCskpvvELECr7+Nsdd+Z_7sofA@mail.gmail.com>
Message-ID: <20200220085129.GA11465@gacrux.arch.suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> > +static struct tcase {
> > +       char *name;
> > +       unsigned int flags;
> > +} tcases[] = {
> > +       {"Flag 0", 0},
> > +       {"Flag FSOPEN_CLOEXEC", FSOPEN_CLOEXEC},


> Maybe better to remove the 'Flag' keywords from here and add it to the
> print sentence.
+1. BTW if you remove bogus text, you can use macro to not repeat the flag,
see testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c
#define TYPE_NAME(x) .ttype = x, .desc = #x
(just a suggestion, nothing really important)

> > +static void run(unsigned int n)
> > +{
> > ...
> > +
> > +       if (!tst_ismount(MNTPOINT))
> > +               tst_res(TPASS, "%s: fsopen() passed", tc->name);


> tst_res(TPASS, "Flag %s: fsopen() passed", tc->name);

Kind regards,
Petr
