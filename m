From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 25 Jan 2018 17:16:54 +0100
Subject: [LTP] [PATCH v3] Add library support for
	/proc/sys/kernel/tainted
In-Reply-To: <20180125141325.15350-1-mmoese@suse.de>
References: <20180125141325.15350-1-mmoese@suse.de>
Message-ID: <20180125161654.GA21935@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Someteimes, it is important to detect if the kernel has issued a
  ^
  Typo.
> warning, died, or is tainted in another way. Linux provides this
> information in /proc/sys/kernel/tainted in the form of a bitfield.
> This patch provides library functions for testcases to detect, if
> it has tainted the kernel.
> 
> The following functions will be introduced:
> 
> - int tst_taint_init(unsigned int mask)
>   check if the flags supplied as mask are supported by the running
>   kernel, and if so, if they are not yet set.
> 
> - int tst_taint_check()
>   check if one or more of the bits specified in the mask provided
>   to tst_taint_init() before are set.
>   Returns 0 if those flags are not set, or the bitmask of set flags
> 
> These can be used in the following way:
> 
> First, during testcase setup:
> 
> void setup(void)
> {
> 	...
> 	tst_taint_init(TST_TAINT_W | TST_TAINT_D);
> }
> 
> Second, check if the test triggered a bug:
> 
> void run(void)
> {
> 	...
> 	. test code here
> 	...
> 	if (tst_taint_check() != 0)
> 		tst_res(TFAIL, "kernel has issues");
> 	 else
> 		tst_res(TPASS, "kernel seems to be fine");
> }
> 
> Signed-off-by: Michael Moese <mmoese@suse.de>
> ---
>  doc/test-writing-guidelines.txt |  44 +++++++++++++++++
>  include/tst_taint.h             | 104 +++++++++++++++++++++++++++++++++++++++
>  lib/tst_taint.c                 | 106 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 254 insertions(+)
>  create mode 100644 include/tst_taint.h
>  create mode 100644 lib/tst_taint.c
> 
> diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
> index 739b295b8..bfd0d9892 100644
> --- a/doc/test-writing-guidelines.txt
> +++ b/doc/test-writing-guidelines.txt
> @@ -1312,6 +1312,50 @@ common.h:9: FAIL: check failed
>  test.c:8: INFO: do_action(arg) failed
>  -------------------------------------------------------------------------------
>  
> +2.2.24 Tainted kernels
> +^^^^^^^^^^^^^^^^^^^^^^
> +
> +If you need to detect, if the testcase triggers the kernel to be tained,
                                                        ^
							We should
							probably say
							here something
							as:

							"triggers kernel
							warning, bug or
							oops"

							Since tainted
							kernel can mean
							much more than
							bug.
> +just do the following to detect TAINT_W or TAINT_D:
> +
> +[source,c]
> +-------------------------------------------------------------------------------
> +#include "tst_test.h"
> +#include "tst_taint.h"
> +
> +void setup(void)
> +{
> +	...
> +	tst_taint_init(TST_TAINT_W | TST_TAINT_D);
> +	...
> +}
> +...
> +void run(void)
> +{
> +	...
> +	if (tst_taint_check() == 0)
> +		tst_res(TPASS, "kernel is not tainted");
> +	else
> +		tst_res(TFAIL, "kernel is tainted");
> +}
> +-------------------------------------------------------------------------------
> +
> +You have to call tst_taint_init() with non-zero flags first, preferably during
> +setup(). The function will generate a TCONF if the requested flags are not
> +fully supported on the running kernel, and TBROK if either a zero mask was
> +supplied or if the kernel is already tainted before executing the test.
> +
> +You then can call tst_taint_check() during run(), which generates TBROK if
      ^
      Then you can

> you try to call it before tst_taint_init().

The second part of the sentence only describes safety measure, I
wouldn't have included it here at all, it only confuses the reader.

> Oherwise, 0 is returned if the
> +kernel is not tainted with the mask supplied earlier, otherwise the taint
> +flags are set in the return value.

Also let's drop the Otherwise here it's making the whole sentece a bit
confusing as well.


I can update the documentation and fix the typos upon pushing the patch,
if you do not mind.

Also I would like to push this along with actual test that uses the
interface.

-- 
Cyril Hrubis
chrubis@suse.cz
