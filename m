From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 15 Sep 2020 07:28:11 +0200
Subject: [LTP] LTP release
In-Reply-To: <CY4PR13MB117529F882F68FED2C60AD09FD230@CY4PR13MB1175.namprd13.prod.outlook.com>
References: <20200908073138.GB2475@yuki.lan> <20200910084554.GA21741@dell5510>
 <20200914111543.GE5524@yuki.lan>
 <CY4PR13MB117529F882F68FED2C60AD09FD230@CY4PR13MB1175.namprd13.prod.outlook.com>
Message-ID: <20200915052811.GA4719@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Tim, Cyril,

> I'm also open to suggestions for possible tests.  I'd like a shell script command
> to add to the list of binary programs.  Here is what I've chosen so far:
> access01 access01
> chdir01 chdir01
> fork01 fork01
> time01 time01
> wait02 wait02
> write01 write01
> symlink01 symlink01
> stat04 symlink01 -T stat04
> utime01A symlink01 -T utime01
> rename01A symlink01 -T rename01
> splice02 seq 1 20 | splice02
Could we please add at least one network test program?
e.g. route tests with netlink also uses shell API and it's really quick (real
time 0m0,687s):
route6-change-netlink-dst route-change-netlink-dst.sh -6


> This takes about 5 seconds on one of my test machines.
+1

>  -- Tim

> P.S. Maybe, if you're moving away from runltp and ltp-pan, it's a little late to be
> adding some selftests to make sure they work correctly.  But Fuego is using them.
> I don't know what other frameworks use when they invoke LTP to perform
> tests.

> P.P.S How come some tests produce TPASS and some produce just PASS?
Legacy C API and shell API (both legacy and new) add T (i.e. TPASS), new C API
don't add it (i.e. PASS). It's a minor detail we could fix that.

Kind regards,
Petr
