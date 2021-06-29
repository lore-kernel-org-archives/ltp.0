From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 30 Jun 2021 00:20:12 +0200
Subject: [LTP] [PATCH v3 0/5] Run tests in CI
In-Reply-To: <20210629214808.18760-1-pvorel@suse.cz>
References: <20210629214808.18760-1-pvorel@suse.cz>
Message-ID: <YNucnE+N98zmKmWN@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> Hi all,

> changes v2->v3:
> * going back to simplest changes in make
> * adding lib/newlib_tests/runtest.sh (instead fighting with our build
>   system I concentrated on runtest.sh)
> * removing tst_fuzzy_sync01 as it sporadically fails

> Tested:
> https://github.com/pevik/ltp/actions/runs/984224611

> TODO: Not what's wrong with PATH on CentOS 7:
> /__w/ltp/ltp/lib/newlib_tests/runtest.sh: line 78: ./test05: No such file or directory
> ./shell/net/../../../../testcases/lib/tst_test.sh: line 149: tst_rod: command not found

> Maybe it's in different directory?
> It uses old make 3.82, there is something incompatible.
OK, whole out-of-tree build is broken. There are 2 issues:

1) probably PATH ../../testcases/lib/ points to srcdir instead of build dir).
It's just older make exit properly with 2, newer don't, not sure why.

2) The same issue with non-zero exit not being propagated on newer make
is also when runtest.sh quits with:
runtest TFAIL: shell/net/tst_ipaddr_un.sh failed with TFAIL

I guess I need to use @set -e; in Makefile (I didn't want to use set -e in the
runtest.sh itself, it would break printing printing what failed).

Kind regards,
Petr
