From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 13 Jan 2021 01:40:54 +0100
Subject: [LTP] [PATCH v3 3/3] network/stress/route-change: Convert to
 new API
In-Reply-To: <20201125053459.3314021-3-lkml@jv-coder.de>
References: <20201125053459.3314021-1-lkml@jv-coder.de>
 <20201125053459.3314021-3-lkml@jv-coder.de>
Message-ID: <X/5BlpO5QU7mhyEP@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Joerg,

> +++ b/testcases/network/stress/route/route-redirect.sh
...
> +do_cleanup()
> +{
> +	# Kill the redirector utility
> +	tst_rhost_run -c "killall -SIGHUP ns-icmp_redirector"
FYI: route_cleanup is required (from route-lib.sh) otherwise next test in the
runtest file (route6-change-dst) is broken:
route-change-dst 1 TFAIL: ping6 -c1 -I fd00:1:1:1::2 fd00:23:1::1 >/dev/null failed unexpectedly

But anyway, I've fixed everything and tested:
https://github.com/pevik/ltp/commits/joerg/multicast.v3.fixes

It might be merged before the release, or immediately after the release.

Kind regards,
Petr

