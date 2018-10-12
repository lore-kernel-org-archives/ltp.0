From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 12 Oct 2018 17:24:21 +0200
Subject: [LTP] [PATCH] fallocate04: continues after failure of front test
In-Reply-To: <20181012030008.GA26983@hptatwork>
References: <20181012030008.GA26983@hptatwork>
Message-ID: <20181012152420.GE5080@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> When run this case, a failure of test02 will prevent test03, test04, ...
> to be run. This patch replace tst_brk() with tst_res() and return after
> a failure in each sub-cases.

As far as I can tell these tests depends on each other, so if we failed
at one of them it does not make any sense to continue.

At least when I remove test02 from tcases the test03 fails because of
that. So unless the the test is redesigned so that the tests are
independed it does not make any sense to let it continue to run if
something has failed.

-- 
Cyril Hrubis
chrubis@suse.cz
