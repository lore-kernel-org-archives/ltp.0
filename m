From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 31 May 2019 11:43:56 +0200
Subject: [LTP] insmod01_sh test from commands test suite will make
 cve-2017-17053 test fail
In-Reply-To: <20190531083203.GA4224@rei.lan>
References: <CAMy_GT-kRs7_EZvrP-JdFc_wa8OMc3295N6FWUg7AxoY2O66fA@mail.gmail.com>
 <20190531083203.GA4224@rei.lan>
Message-ID: <20190531094356.GC4224@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > BugLink: https://bugs.launchpad.net/bugs/1830011
> 
> Looking at the bug the problem is that the module is missing license.
> 
> I guess that adding MODULE_LICENSE("GPL"); to the dummy module
> testcases/commands/insmod/ltp_insmod01.c should fix it.

Just FYI, the licence taint flag is now fixed in:

https://github.com/linux-test-project/ltp/commit/3015d592301ef37afe2dee2ddb03be126cffd6f8

-- 
Cyril Hrubis
chrubis@suse.cz
