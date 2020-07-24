From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 24 Jul 2020 15:35:24 +0200
Subject: [LTP] [PATCH 4/4] libs: sigwait: Get rid of REPORT_SUCCESS()
 macro
In-Reply-To: <20200724123235.GA3539@yuki.lan>
References: <e51142a397858a2fe6a040563d3c0795a7d0bb05.1595511710.git.viresh.kumar@linaro.org>
 <a83166af3a2b432bb11a0876e18e15705479f32d.1595511710.git.viresh.kumar@linaro.org>
 <20200724123235.GA3539@yuki.lan>
Message-ID: <20200724133524.GA31265@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

...
> >  	TEST(sigwaitinfo(&sigs, &si, NULL));
> > -	REPORT_SUCCESS(-1, EINTR);
> > +	if (TST_RET == -1) {
> > +		if (TST_ERR == EINTR)
> > +			tst_res(TPASS, "%s: Test passed", __func__);
> > +		else
> > +			tst_res(TFAIL | TTERRNO, "%s: Unexpected failure", __func__);

> Can we please make the messages a bit more user friendly?

> - the tst_res() already prints line and filename the __func__ is a bit
>   redundant

> - it also prints PASS/FAIL so we can omit the "Test passed" we can print
>   something that describes the testcase instead e.g.
>   "Wait interrupted by a signal"

> - also in the "Unexpected failure" case we should print which error we
>   expected with someting as: tst_res(TFAIL | TTERRNO, "Expected to return EINTER, got");

+1, sorry for overlooking it.

Kind regards,
Petr
