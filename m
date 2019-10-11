From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 11 Oct 2019 12:06:06 +0200
Subject: [LTP] Rename tst_test_* to tst_require_*
In-Reply-To: <20191011090737.17997-1-lkml@jv-coder.de>
References: <20191011090737.17997-1-lkml@jv-coder.de>
Message-ID: <20191011100604.GA11441@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

Cc: Li and Clemens

> these patches rename tst_test_* to tst_require_*, to better describe
> their use. There is also tst_require_root, that has the same
> behavior: It also calls tst_brk in case of a failing requirement.

> You can also get this patch from the following repo:
> https://github.com/MofX/ltp/commits/rename_tst_test-tst_require

sorry for not thinking first, I wonder if we want to sync
tst_test_* (function name) vs $TST_NEEDS_* (test API variable name),
e.g.: tst_require_drivers $TST_NEEDS_DRIVERS

i.e. either of these:
s/tst_test_/tst_needs_/
s/TST_NEEDS_/TST_REQUIRE_/

I consider *require* as more descriptive than *needs*,
but changing to *require* would require more work :).

Kind regards,
Petr
