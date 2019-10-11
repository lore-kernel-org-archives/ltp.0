From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 11 Oct 2019 14:36:15 +0200
Subject: [LTP] Rename tst_test_* to tst_require_*
In-Reply-To: <20191011100604.GA11441@dell5510>
References: <20191011090737.17997-1-lkml@jv-coder.de>
 <20191011100604.GA11441@dell5510>
Message-ID: <20191011123614.GD2591@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > these patches rename tst_test_* to tst_require_*, to better describe
> > their use. There is also tst_require_root, that has the same
> > behavior: It also calls tst_brk in case of a failing requirement.
> 
> > You can also get this patch from the following repo:
> > https://github.com/MofX/ltp/commits/rename_tst_test-tst_require
> 
> sorry for not thinking first, I wonder if we want to sync
> tst_test_* (function name) vs $TST_NEEDS_* (test API variable name),
> e.g.: tst_require_drivers $TST_NEEDS_DRIVERS
> 
> i.e. either of these:
> s/tst_test_/tst_needs_/
> s/TST_NEEDS_/TST_REQUIRE_/

I guess that I started bike-shedding here, I should have been silent I
guess...

I do consider this names to mean something different in the contexts,
i.e. "needs" is something that is expressed in metadata, while "require"
is part of a function name. But hey I'm by no means native speaker, so
who know, and also I would prefer to work on the actual code, which is
more fruitful than API renames.

-- 
Cyril Hrubis
chrubis@suse.cz
