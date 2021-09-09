From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 9 Sep 2021 12:21:30 +0200
Subject: [LTP] [PATCH 1/2] runtest/smoketest: Remove intermittent failed
 test case route4-change-dst
In-Reply-To: <20210906083444.82394-1-naresh.kamboju@linaro.org>
References: <20210906083444.82394-1-naresh.kamboju@linaro.org>
Message-ID: <YTngKohBcpQK7l5r@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Naresh,

> The test case route4-change-dst fails intermittently creating
> the problem for smoketest results verdict. route4-change-dst
> is a stress test should not be a part of smoketest. because of
> these issues removing route4-change-dst from the smoketest.
Could you please be more specific about the failure?

I'm not against adding ping tests into smoketest runtest file,
although just on might be enough. ping02.sh is the fastest from all 3 tests,
maybe add it. Also -6 for IPv6 would be good (to detect problems with IPv6 setup).


But route-change-dst.sh is quick (actually 2 times faster than ping01) that it's
not really a stress test in the default configuration, thus I'd prefer to keep it.

Kind regards,
Petr
