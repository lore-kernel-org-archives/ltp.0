From: Petr Vorel <pvorel@suse.cz>
Date: Sat, 31 Mar 2018 01:59:43 +0200
Subject: [LTP] [RFC PATCH v2 0/3] Rewritting network tests into new
	shell API
In-Reply-To: <5df04eac-2ce5-7628-4bbf-8a34e51fc10e@oracle.com>
References: <20180329233134.24151-1-pvorel@suse.cz>
 <5df04eac-2ce5-7628-4bbf-8a34e51fc10e@oracle.com>
Message-ID: <20180330235943.GA17279@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

thanks for your comments!

> Hi Petr,

> A few questions about the changes to the new API:

> I think, you wrote about renaming test_net.sh to tst_net.sh, and the
> corresponded test_net_stress.sh, so why we can't keep the copy to the
> old API during migration and make the new one with the new name?
That's another option, but I thought, it'd be easier to have just one version of
test_net.sh which supports both APIs, than maintain two files (test_net.sh and
tst_net.sh). But I might be wrong.

> What is actually changing in the new API that require the changes
> in test_net.sh except tst_resm/tst_brkm renamed to tst_res/tst_brk?

> The new variables TST_NEEDS_ROOT and TST_SETUP, TST_TESTFUNC?
Yes (you list all or most of them in your reply below) + the need to call tst_run().

I did most of the changes with simple script using sed (manual fixes are still needed).

tst_run() is the biggest change in the behavior, which complicates migrating of
testscripts/network.sh. I haven't figured out, what would be an elegant way to move it and
I'd prefer to migrate it into new version. Not sure whether we'd like to add part of
"network_settings" execution to tst_run() for tst_net.sh and thus to be run twice (once
by testscripts/network.sh and then by test which is called by testscripts/network.sh).

Now I see the best would be move this "network_settings" stuff into new called function
tst_net_run() which would set it and at the end call tst_run() + remove sourcing
test_net.sh in testscripts/network.sh (only testing script would load it and call
tst_net_run() at the end instead of tst_run()).

> Can we run a test without them temporary, without tst_run(),
> e.g. define some stubs and old API with the new one in
> tst_net.sh?
Do you mean to move all network scripts to new API, using these "shim" in tst_net.sh?
I'd prefer tests were really using new API (to benefit from it), I just don't want to
migrate all tests at once. This can be dangerous trying to implement new API functions in
legacy one.
That's why I implemented in tst_net.sh functions starting with underscore which choose the
implementation via $TST_USE_LEGACY_API. I wanted to ony tst_net.sh itself using it.

> tst_exit()
> {
>    tst_do_exit()
> }
> etc.

> I remember that ROD function not using the script but tst_rod binary
> so may affect some scripts, like "ROD cd" for example... but may be it
> is already fixed, I need to check.
Git log shows it's not fixed. Good point. (s/ROD cd /cd /g)

> And we need to remove tst_rmdir() because it will be handled in the
> library as we already have TST_TMPDIR_RHOST there.
Yes, I handled it in test_net.sh and during rewrite.

> Best regards,
> Alexey


Kind regards,
Petr
