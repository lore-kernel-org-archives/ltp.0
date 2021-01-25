From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 25 Jan 2021 14:17:48 +0100
Subject: [LTP] [PATCH 1/1] lib: Add test for tst_check_driver()
In-Reply-To: <20210125095814.31741-1-pvorel@suse.cz>
References: <20210125095814.31741-1-pvorel@suse.cz>
Message-ID: <YA7E/Co4QS4fcv92@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Good test.

With a minor fix:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  lib/newlib_tests/shell/tst_check_driver.sh | 64 ++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
>  create mode 100755 lib/newlib_tests/shell/tst_check_driver.sh
> 
> diff --git a/lib/newlib_tests/shell/tst_check_driver.sh b/lib/newlib_tests/shell/tst_check_driver.sh
> new file mode 100755
> index 000000000..1d438700b
> --- /dev/null
> +++ b/lib/newlib_tests/shell/tst_check_driver.sh
> @@ -0,0 +1,64 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (c) 2021 Petr Vorel <pvorel@suse.cz>
> +
> +TST_TESTFUNC=test
> +TST_SETUP=setup
> +TST_CNT=3
> +TST_NEEDS_CMDS="tst_check_drivers find grep head sed"
> +. tst_test.sh
> +
> +MODULES_DIR="${MODULES_DIR:-/lib/modules/$(uname -r)}"
> +
> +setup()
> +{
> +	tst_res TINFO "using modules directory '$MODULES_DIR'"
> +
> +	[ -d "$MODULES_DIR" ] || \
> +		tst_brk TCONF "modules directory '$MODULES_DIR' missing"
> +}
> +
> +get_name()
> +{
> +	local path="$1"
> +	local drv
> +
> +	echo $path | sed 's/.*\/\([^/]\+\)\.ko.*/\1/'
> +}
> +
> +test1()
> +{
> +	local drv
> +
> +	for drv in $(find $MODULES_DIR | grep -E '_[^/]+\.ko' | head -3); do
> +		drv="$(get_name $drv)"
> +		EXPECT_PASS tst_check_drivers $drv
> +
> +		drv="$(echo $drv | sed 's/_/-/g')"
> +		EXPECT_PASS tst_check_drivers $drv
> +	done
> +}
> +
> +test2()
> +{
> +	tst_res TINFO "check non-existing module detection"
> +	EXPECT_FAIL tst_check_drivers not-existing-kernel-module
> +}
> +
> +test3()
> +{
> +	local f="$MODULES_DIR/modules.builtin"
> +	local drv
> +
> +	tst_res TINFO "check built-in module detection"
> +
> +	[ -f "$f" ] || \
> +		tst_brk TCONF "missing '$f'"
> +
> +	for drv in $(head -3 $f); do
> +		drv="$(get_name $drv)"
> +		EXPECT_PASS tst_check_drivers "$(get_name $drv)"
                                                  ^
						  Just $drv?
> +	done
> +}
> +
> +tst_run

-- 
Cyril Hrubis
chrubis@suse.cz
