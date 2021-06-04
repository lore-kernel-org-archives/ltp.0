From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 4 Jun 2021 20:49:21 +0200
Subject: [LTP] [RFC PATCH 1/3] make: Add make check{,-c,-shell} targets
In-Reply-To: <392BDC1B-F73E-411E-AE03-71DA0CBAB2D8@gmail.com>
References: <20210603183827.24339-1-pvorel@suse.cz>
 <20210603183827.24339-2-pvorel@suse.cz>
 <392BDC1B-F73E-411E-AE03-71DA0CBAB2D8@gmail.com>
Message-ID: <YLp1sSlda6bEncO8@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Enji,

> > On Jun 3, 2021, at 11:38 AM, Petr Vorel <pvorel@suse.cz> wrote:

> > For testing C and shell API.

> Why not just add a single ?make check? target that calls the C and shell targets to match what most open source projects do in terms of testing? Also, continuing on in light of errors seems like a good default behavior to have as it would prevent a single error/failure from gathering all other results.

Yes, the original approach in this patchset is make check,
which consists of two make-c and make-shell. One of tst_fuzzy_sync checks is
quite long and in longer term the number of tests for both C and shell API might
grow to prolong the testing. Thus one may appreciate to test for local
development just one of these two.

Or, if you mean how it has been implemented (adding tests into variables),
I plan to add docparse tests (into docparse/tests/) - i.e. into different
directory.

Also, result of Richie's Libclang based analyzer patchset [1],
where he also added make check, we decided to use make test here [2].

> My 2 cents,
Thanks, comments are always welcome.
> -Enji

Kind regards,
Petr

[1] https://lists.linux.it/pipermail/ltp/2021-June/023008.html
[2] https://lists.linux.it/pipermail/ltp/2021-June/023021.html

