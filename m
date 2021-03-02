From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 2 Mar 2021 11:17:18 +0100
Subject: [LTP] [PATCH 5/7] tst_test.sh: Introduce
 tst_set_timeout(timeout)
In-Reply-To: <CAEemH2cr0TFvFiis_05Fh4bEe1ZUmFtMO5ysYFped5ZQYucvAg@mail.gmail.com>
References: <20210301220222.22705-1-pvorel@suse.cz>
 <20210301220222.22705-6-pvorel@suse.cz>
 <CAEemH2cr0TFvFiis_05Fh4bEe1ZUmFtMO5ysYFped5ZQYucvAg@mail.gmail.com>
Message-ID: <YD4QrlVCIJOYj0ze@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li,

...
> > +tst_set_timeout()
> > +{
> > +       TST_TIMEOUT="$1"


> Not sure if we should check "$1" is valid again before using it.
General check for int is done in _tst_setup_timer, but that's not what you mean.

> I guess in most scenarios, the function is invoked by tests, so
> just needs to guarantee $1 > $TST_TIMEOUT, otherwise, it
> looks meaningless to reset TST_TIMEOUT?
> (especially to avoid people set a smaller value by a typo)

I thought it's not necessary. TST_TIMEOUT is meant to be set in the test. But we
currently don't check for that (it can be wrongly set as environment variable)
and it'd be difficult to check that (I'd prefer not grep $TST_TEST_PATH, because
that would not work for shell libraries (e.g. zram_lib.sh).

The main reason for me is that C API allows to set lower value in the code, thus
I didn't want to prevent it in the shell => it'd be a diverse from C API.
We could add warning: "don't set TST_TIMEOUT" in docs and print warning/reset it
in runltp and runltp-ng, but that would not protect when running test itself.
It's really hard trying to have at least similar API with two fairly different
languages :).

Kind regards,
Petr
