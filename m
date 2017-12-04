From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 4 Dec 2017 12:24:18 +0100
Subject: [LTP] [RFC PATCH v2 1/5] travis: Add build script and use it in
 travis
In-Reply-To: <CAEemH2e+BMzZwt+F6mAgezb1Ty=CboPuvWx2oGn2zhbkZqSz1g@mail.gmail.com>
References: <20171201154641.27407-1-pvorel@suse.cz>
 <20171201154641.27407-2-pvorel@suse.cz>
 <CAEemH2e+BMzZwt+F6mAgezb1Ty=CboPuvWx2oGn2zhbkZqSz1g@mail.gmail.com>
Message-ID: <20171204112418.654t7e4pg2j26r72@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi Li,

> > +PREFIX="$HOME/ltp"
> > +
> > +CONFIGURE_OPTS_IN_TREE="--with-open-posix-testsuite --with-realtime-testsuite --prefix=$PREFIX"

> Here you set --prefix to current ltp path, why not "/opt/ltp"?
Permissions (using containers => no sudo). We could have sudo, but it would be without
containers (=slow).
See
https://docs.travis-ci.com/user/reference/overview/

> And, I get some installing errors with this configuration for build in tree.

> # ./build.sh
> [...]
> install: ‘/root/ltp/testcases/realtime/perf/latency/disknoise.sh’ and
> ‘/root/ltp/testcases/realtime/perf/latency/disknoise.sh’ are the same
> file
> make[4]: *** [/root/ltp/testcases/realtime/perf/latency/cpunoise2000.sh] Error 1
> make[4]: *** [/root/ltp/testcases/realtime/perf/latency/pthread_cond_latency]
> Error 1
> make[4]: *** [/root/ltp/testcases/realtime/perf/latency/disknoise.sh] Error 1
> make[4]: *** [/root/ltp/testcases/realtime/perf/latency/cpunoise.sh] Error 1
> make[4]: Leaving directory `/root/ltp/testcases/realtime/perf/latency'
> make[3]: *** [install] Error 2
> make[3]: Leaving directory `/root/ltp/testcases/realtime/perf'
> make[2]: *** [install] Error 2
> make[2]: Leaving directory `/root/ltp/testcases/realtime'
> make[1]: *** [install] Error 2
> make[1]: Leaving directory `/root/ltp/testcases'
> make: *** [testcases-install] Error 2
> make: *** Waiting for unfinished jobs....
> [...]
Github clones into different directory:
git clone --depth=50 --branch=master https://github.com/linux-test-project/ltp.git linux-test-project/ltp
OK, you're building in the same directory as the prefix is set. I'll fix it so we can use
it for local builds as well.
BTW: I was thinking before using /tmp, but as whole directory has ~600MB, I'll use
different name under $HOME).

Thanks for reporting it!


Kind regards,
Petr
