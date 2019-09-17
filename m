From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 17 Sep 2019 13:22:25 +0200
Subject: [LTP] [PATCH v2 0/3] LTP_TIMEOUT for shell API
In-Reply-To: <1568630275.3028.23.camel@suse.de>
References: <20190913125823.17314-1-pvorel@suse.cz>
 <1568630275.3028.23.camel@suse.de>
Message-ID: <20190917112225.GA12139@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> <snip>
> > Questions:
> > * I don't know how to detect TST_TIMEOUT settings made by user.
> > That's
> > the difference from C, where user cannot overwrite tst_test->test.
> > Am I missing something or it's not possible to detect whether
> > variable
> > was set in code or by user?
> > Maybe that was the reason TST_TIMEOUT wasn't set, but rather fixed.

> Maybe we could initialize all variables in tst_test.sh. So we overwrite
>  values given by user/environment.
But that's also overwrite setting in the test (in this patchset it's added in
memcg_stress_test.sh). I.e. library don't know whether variable is set by user
or a test.

> But I in general I think, if someone
> play with TST_* variables, it's up to him what happen.
> And you already added this WARNING!
Yep.

> > * Code allowing $LTP_TIMEOUT_MUL being also float making code a bit
> > complex. If you don't like it, I suggest to change $LTP_TIMEOUT_MUL
> > being for both C and shell integer, but I'd prefer the possibility to
> > be float.
> > (it's might be handy being able to set timeout 1.33x which is far
> > less
> > than 2x for int).

> I also don't see the need of such fine granular multiplier.
Then it should be unified, i.e. force to use int instead of float also in C API.

Kind regards,
Petr
