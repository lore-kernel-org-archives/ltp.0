From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 11 May 2018 12:56:13 +0200
Subject: [LTP] network stress route-change-if test
In-Reply-To: <de6cbd3b-8c6e-4d48-5a92-7ec062a4bc17@oracle.com>
References: <20180510162714.c2hdgj3eamhcderg@dell5510>
 <de6cbd3b-8c6e-4d48-5a92-7ec062a4bc17@oracle.com>
Message-ID: <20180511105613.6pzrq3cmt6x7thvl@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> Hi Petr,

> > while working on cleaning & rewriting route stress tests (testcases/network/stress/route/)
> > into new API I come up again to problem that route-change-if tests require 2 local
> > interfaces, which we don't support for netns. We've been discussing this some time ago
> > (haven't found the post), I remember you didn't want to add support for more interfaces
> > into tst_net.sh. Is that correct?

> I think it would better if most of the tests could be run in parallel, so
> that we could run it on different interfaces as well. That would require,
> more work in the library, at least, removing 'pkill netstress', making
> the tests to be self-contained. There are also other options with using
> netns per test or a group of the tests.
+1. That would be a great improvement.
Not sure whether one netns per runtest file would be improvement and one netns per line in
runtest file is maybe too much. And not sure how to do other grouping.

'pkill netstress' replacement?
for pid in $(pgrep netstress); do
	if [ "$(ip netns identify $pid)" = "ltp_ns_ID" ]; then
		echo "kill -SIGTERM $pid"
	fi
done


> > I don't think it's a good idea to have test which TCONF on netns, as it's the default
> > setup. So I propose either of these:
> > * add support for adding and removing second interfaces on netns
> > in tst_net.sh (i.e. change init_ltp_netspace() allowing to add second namespace)
> > * remove the test entirely.

> Assuming those test are using different interfaces just to load the
> machine more, the tests should be rewritten to use a single interface.
route-change-if is about switching route between (at least) 2 interfaces.
Therefore it must have 2 interfaces available.
The test has similar scenario as if-route-adddel, but it's not the same.
So, delete the test as we don't support it?
I think it's valid scenario, but we don't have support which test requires.


Kind regards,
Petr
