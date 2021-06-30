From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 30 Jun 2021 10:01:56 +0200
Subject: [LTP] ee
In-Reply-To: <87tulf3jyk.fsf@suse.de>
References: <YNuA/0J20mjiV+NC@pevik>
 <87tulf3jyk.fsf@suse.de>
Message-ID: <YNwk9EwTtqAnRWH6@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richie,

...
> > tst_fuzzy_sync01.c:224: TFAIL: acs:1  act:1  art:3  | =:3    -:2999996 +:1   

> It looks like the CI machines are too noisy/contended. The avg_dev is
> very high. Probably we could relax the dev_ratio threshold to 0.2 or
> 0.3. Although we would still get failures occassionally. As this is a
> probabalistic test.
Test is failing on my laptop, thus haven't enabled it in CI.
But maybe it'll be working on it more reliably than my busy machine.
But I'd prefer to wasting time with false positives, thus I guess we should
enable only tests which are working reliably.

> Could you change the script so that it passes so long as the test
> returns TPASS or TFAIL?
Well, accepting TFAIL sounds a bit strange to me :).
Also next effort will be (at least for shell tests) to compare actual test
output. Obviously that will not be straightforward for some tests, which aren't
reproducible (avg = 11729ns could be matched by regex, but having more variants
of results is kind of special case).

> We don't want TBROK, TCONF or no result.
FYI in my CI patchset is TCONF accepted. Motivation was to not require root for
make test as some tests needed it. Thus TCONF will be a special case, then I
guess we could add tst_fuzzy_sync01 accepting TFAIL as a special case.

Kind regards,
Petr
