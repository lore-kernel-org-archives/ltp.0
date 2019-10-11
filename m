From: Joerg Vehlow <lkml@jv-coder.de>
Date: Fri, 11 Oct 2019 15:39:33 +0200
Subject: [LTP] Rename tst_test_* to tst_require_*
In-Reply-To: <1570799029.4238.15.camel@suse.de>
References: <20191011090737.17997-1-lkml@jv-coder.de>
 <20191011100604.GA11441@dell5510> <1570799029.4238.15.camel@suse.de>
Message-ID: <2dc10bff-8a64-0054-269a-d9d748f10943@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


> On Fri, 2019-10-11 at 12:06 +0200, Petr Vorel wrote:
>> Hi,
>>
>> Cc: Li and Clemens
>>
>>> these patches rename tst_test_* to tst_require_*, to better
>>> describe
>>> their use. There is also tst_require_root, that has the same
>>> behavior: It also calls tst_brk in case of a failing requirement.
>>> You can also get this patch from the following repo:
>>> https://github.com/MofX/ltp/commits/rename_tst_test-tst_require
>> sorry for not thinking first, I wonder if we want to sync
>> tst_test_* (function name) vs $TST_NEEDS_* (test API variable name),
>> e.g.: tst_require_drivers $TST_NEEDS_DRIVERS
> I fully agree with Petr that we must be consistent in naming between
> variable- and function-name.
Actually I am more with cyril's reasoning, that one is metadata and one 
is function call here.
It wasn't consistent in the past. The require is more like an imperative 
here and the needs is
descriptive.
I'm also no native speaker, but in my opinon needing a command sounds a 
bit strange.
One thing I found is that a need is required for living, while a 
requirement must be
fulfilled, for something to happen. With this definition requirement 
fits. There is also the term
requierement in software engineering and no term "needment"

But strangely I still have no problem with TST_NEEDS_*, but I would also 
be ok with
TST_REQUIRES_. Actually I'd propably chose it, if I was designing the 
library.

I do not really like renaming tst_test_* to test_needs_*. Needs does not 
sound
strong enough to me in that context.? But I just made a quick search for 
"needs_"
and there is so much needs in the c library as well, that touching all 
of this is maybe
to much.
