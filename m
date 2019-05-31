From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 31 May 2019 10:32:03 +0200
Subject: [LTP] insmod01_sh test from commands test suite will make
 cve-2017-17053 test fail
In-Reply-To: <CAMy_GT-kRs7_EZvrP-JdFc_wa8OMc3295N6FWUg7AxoY2O66fA@mail.gmail.com>
References: <CAMy_GT-kRs7_EZvrP-JdFc_wa8OMc3295N6FWUg7AxoY2O66fA@mail.gmail.com>
Message-ID: <20190531083203.GA4224@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> We found out that when running the LTP test suite directly (which uses
> the "default" file in scenario_groups). The insmod01_sh will insert an
> out-of-tree module and taints the kernel, and the following
> cve-2017-17053 test in the cve test suite will check if the kernel is
> tainted. Thus causing some false-positive in the test result.
> 
> Perhaps a workaround is to move the cve test suite to somewhere before
> the commands test suite in the "default" scenario.
> 
> BugLink: https://bugs.launchpad.net/bugs/1830011

Looking at the bug the problem is that the module is missing license.

I guess that adding MODULE_LICENSE("GPL"); to the dummy module
testcases/commands/insmod/ltp_insmod01.c should fix it.

-- 
Cyril Hrubis
chrubis@suse.cz
