From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 15 Jul 2021 09:48:47 +0200
Subject: [LTP] [PATCH v5 0/4] Run tests in CI
In-Reply-To: <YO/l6yni/AAOGhn9@pevik>
References: <20210714142001.20566-1-pvorel@suse.cz> <YO70PiTdyxzTw0k2@pevik>
 <YO77+MmmxwMewgnQ@yuki> <YO8UIP310jsAmq8I@pevik>
 <YO/l6yni/AAOGhn9@pevik>
Message-ID: <YO/oX6ZvrbvR4Xrx@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

...
> > Thanks! Testing it in https://github.com/pevik/ltp/actions/runs/1031005963

> The result is much better but still not correct:
> https://github.com/pevik/ltp/runs/3068932859?check_suite_focus=true#step:11:707

> runtest TINFO: * shell/net/tst_ipaddr_un.sh

> Summary:
> passed   0
> failed   0
> broken   0
> skipped  1
> warnings 0
> tst_ipaddr_un 1 TINFO: timeout per run is 0h 5m 0s

> Could you please merge your fix? And I'll try sync after each test.
> https://github.com/pevik/ltp/actions/runs/1033070696

There is still some output printed later, at least
In RPN: A B | C ! ! &
In RPN: A B | C ! ! &
which is from tst_bool_expr.c, but printed after tst_strstatus
https://github.com/pevik/ltp/runs/3074335940?check_suite_focus=true#step:11:587
But it's much better.

I also found a bug in final evaluation on one of my VM:

tst_test.c:1313: TBROK: Test killed by SIGSEGV!
...
runtest TINFO: 1x TBROK: tst_bool_expr
...
runtest TINFO: === FINAL TEST RESULTS ===
runtest TPASS: All C tests TCONF/TPASS <- THIS IS WRONG
runtest TPASS: All shell tests TCONF/TPASS

Kind regards,
Petr
