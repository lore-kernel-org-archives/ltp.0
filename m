From: Clemens Famulla-Conrad <cfamullaconrad@suse.de>
Date: Fri, 11 Oct 2019 15:03:49 +0200
Subject: [LTP] Rename tst_test_* to tst_require_*
In-Reply-To: <20191011100604.GA11441@dell5510>
References: <20191011090737.17997-1-lkml@jv-coder.de>
 <20191011100604.GA11441@dell5510>
Message-ID: <1570799029.4238.15.camel@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, 2019-10-11 at 12:06 +0200, Petr Vorel wrote:
> Hi,
> 
> Cc: Li and Clemens
> 
> > these patches rename tst_test_* to tst_require_*, to better
> > describe
> > their use. There is also tst_require_root, that has the same
> > behavior: It also calls tst_brk in case of a failing requirement.
> > You can also get this patch from the following repo:
> > https://github.com/MofX/ltp/commits/rename_tst_test-tst_require
> 
> sorry for not thinking first, I wonder if we want to sync
> tst_test_* (function name) vs $TST_NEEDS_* (test API variable name),
> e.g.: tst_require_drivers $TST_NEEDS_DRIVERS

I fully agree with Petr that we must be consistent in naming between
variable- and function-name.

> 
> i.e. either of these:
> s/tst_test_/tst_needs_/
> s/TST_NEEDS_/TST_REQUIRE_/
> 
> I consider *require* as more descriptive than *needs*,
> but changing to *require* would require more work :).

If we use needs or require ? Hard question - when I search for synonyms
from one or the other, I don't see a big different. Without looking on
the impact, require sounds also more descriptive.

thx, Clemens
