From: Cristian Marussi <cristian.marussi@arm.com>
Date: Fri, 11 Jan 2019 16:16:47 +0000
Subject: [LTP] LTP Release
In-Reply-To: <20190111132504.GA32178@rei.lan>
References: <20181214150951.GA20724@rei> <20190102102830.GA13826@rei>
 <20190104154234.GB29238@rei> <20190111132504.GA32178@rei.lan>
Message-ID: <59f7de91-3175-8446-08e7-708a1ac27226@arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi

On 11/01/2019 13:25, Cyril Hrubis wrote:
> Hi!
> I've commited last patch that I found worth to be included in the
> release. With that I would like to tag the release early next week.
> 
> In other words now is your last chance to test the latest head and
> report regressions and unexpected failures that happened to slip in.
> 

I've just tested the tip of release candidate and spotted a regression
on cgroup (since test_5 failure was exactly what a previous patch of mine
should have fixed a few weeks ago :D)

It has been introduced probably by a typo while cleaning up the final commit for:

commit 3cac1f80d87fe7f1a6631034b82683666c80fc00
Author: Cristian Marussi <cristian.marussi@arm.com>
Date:   Fri Dec 21 18:25:16 2018 +0000

    cgroup: cgroup_regression_test.sh ported to newlib

This is the fix, which I've just pushed to the ML:

http://lists.linux.it/pipermail/ltp/2019-January/010518.html

if you could pick it up in time for release next week

Thanks

Regards

Cristian
