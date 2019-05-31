From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 31 May 2019 11:25:38 +0200
Subject: [LTP] insmod01_sh test from commands test suite will make
 cve-2017-17053 test fail
In-Reply-To: <20190531083203.GA4224@rei.lan>
References: <CAMy_GT-kRs7_EZvrP-JdFc_wa8OMc3295N6FWUg7AxoY2O66fA@mail.gmail.com>
 <20190531083203.GA4224@rei.lan>
Message-ID: <20190531092538.GB4224@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > We found out that when running the LTP test suite directly (which uses
> > the "default" file in scenario_groups). The insmod01_sh will insert an
> > out-of-tree module and taints the kernel, and the following
> > cve-2017-17053 test in the cve test suite will check if the kernel is
> > tainted. Thus causing some false-positive in the test result.
> > 
> > Perhaps a workaround is to move the cve test suite to somewhere before
> > the commands test suite in the "default" scenario.
> > 
> > BugLink: https://bugs.launchpad.net/bugs/1830011
> 
> Looking at the bug the problem is that the module is missing license.
> 
> I guess that adding MODULE_LICENSE("GPL"); to the dummy module
> testcases/commands/insmod/ltp_insmod01.c should fix it.

Looking at the log closer there are three things that seem to tain the
kernel:

* Missing module license
* Out-of-tree module
* Missing signature

Now each of these should be setting very specific kernel taint flags.
i.e. (see ltp/include/tst_taint.h)

* Missing module license -> TST_TAINT_G
* Out-of-tree module -> TST_TAINT_O
* Missing signature -> TST_TAINT_E

While the CVE tests checks only presence of TST_TAINT_D and TST_TAINT_W
so in theory this should work fine.

If you look at the value of the taint flag for that bugreport:

14849 = 0011101000000001
          ^^^ ^        ^
	  EOI W	       G

Something has set the "warning" taint flag and also the "working around
firmware bug" flag, so it's quite possible that the insmod tests is not
the culprit here.

-- 
Cyril Hrubis
chrubis@suse.cz
