From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 5 Sep 2017 11:20:22 +0200
Subject: [LTP] Same tests running twice by default takes more time
In-Reply-To: <6e3d5368-dc91-4dcc-659f-2c0586bd9448@cn.fujitsu.com>
References: <6e3d5368-dc91-4dcc-659f-2c0586bd9448@cn.fujitsu.com>
Message-ID: <20170905092022.GB15674@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Recently some existing tests or new tests that belong to specific
> category were added to runtest/cve, it is reasonable to do so indeed
> as they were designed to do the regression test, but I think it is not
> good to run the exactly same test twice by default, for now there are
> only 8, but this is growing, and it will take more time to finish.
> 
> what do you think? Is it necessary to make them just run once actually?

I'm aware of that but do not have a good solution at hand. The current
system simply does not scale well, the problem is that when we want to
have a specific subgroup of the test we have to create a new file. We
have a number of runtest files that have non-empty intersection but so
far we managed to run only one of these in the default scenario.

In the long term I would like to get rid of the runtest files and rather
add something as tags to the testcases so that we can filter them by tag
when we want to run a specific subset rather than listing them
explicitly in the runtest file. But I haven't even tried to implement
something like that yet.

-- 
Cyril Hrubis
chrubis@suse.cz
